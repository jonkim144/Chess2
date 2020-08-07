import com.saydesign.Move;
import com.saydesign.File;
import com.saydesign.Check;
import com.saydesign.Board;
import com.saydesign.Color;
import com.saydesign.Square;
import com.saydesign.PieceType;

class com.saydesign.Engine
{
	private var _goal:Number;
	private var _startTime:Number;
	
	public function Engine(goal:Number)
	{ 
		_goal = goal;
	}
	
	public function GetBestMove(board:Board, color:Number, PLY:Number, startTime:Number):Move
	{		
		_startTime = startTime;
		
		var i:Number;
		var move:Move = new Move();
		var moves:Array = new Array();
		//var bLine:Array = new Array();
		//var cLine:Array = new Array();
		var score:Number;
		var bestScore:Number;
		var bestMove:Move = null;
		var depth:Number = 0;
		if(PLY == null)
			PLY = 1;
		var sortedMoves:Array = new Array();
		
		board.GenerateAllMoves(color, moves);

		try {
			for(depth = 0; depth < PLY; depth++) {
				bestScore = -999999;
				/*
				if(bLine.length) {
					moves = cLine.concat(bLine);
					moves.reverse();
				}
				*/
				
				sortedMoves.length = 0;
		
				for(i = 0; i < moves.length; i++) {
					if(moves[i].CapturedPiece == null)
						moves[i].CapturedPiece = 0;
					sortedMoves.push({piece: moves[i].CapturedPiece, index: i});
				}
			
				sortedMoves.sortOn("piece", 2);
				
				//bLine.length = 0;
				//bLine.length = 0;
				
				for(i = 0; i < sortedMoves.length; i++) {
					move = moves[sortedMoves[i].index];
					move.Do(board);
					if(Check.InCheck(board, color)) {
						move.Undo(board);
						continue;
					}
					move.Undo(board);

					try {
						score = FindBestReply(board, color, move, depth, bestScore);
					} catch (n:Number) {
						throw n;
					}				
					if(score > bestScore)
					{
						bestScore = score;
						bestMove = move;
						//bLine.push(move);
					}
					//else cLine.push(move);
				}
			}
		} catch (n:Number) {
		}
		
		delete move;
		delete moves;
		//delete bLine;
		//delete cLine;
		delete sortedMoves;

		// end game scnearios
		if(bestMove == null) {
			if(Check.InCheck(board, color)) {				
				throw com.saydesign.EndGameException.CheckmateYouWin();
			}
			else {
				throw com.saydesign.EndGameException.StalemateCausedByHuman();
			}
		}
		else {
			try {
				EndState(bestMove, board);
			} catch (e:com.saydesign.EndGameException) {
				delete bestMove;
				throw e;
			}
		}
		
		return bestMove;
	}
	
	private function FindBestReply(board:Board, color:Number,
										  move:Move, depth:Number,
										  beta:Number):Number
	{
		if(depth == 0)
			return EvaluatePosition(board, color, move);
			
		move.Do(board);
		
		var nextMove:Move;
		var score:Number;
		var bestScore:Number = -999999;
		var moves:Array = new Array();
		
		color = Opposite(color);
		
		board.GenerateAllMoves(color, moves);
		
		var sortedMoves:Array = new Array();
		
		for(i = 0; i < moves.length; i++) {
			if(moves[i].CapturedPiece == null)
				moves[i].CapturedPiece = 0;
			sortedMoves.push({piece: moves[i].CapturedPiece, index: i});
		}
		
		sortedMoves.sortOn("piece", 2);
		
		var i:Number;
		for(i = 0; i < sortedMoves.length; i++) {
			nextMove = moves[sortedMoves[i].index];
			nextMove.Do(board);
			
			if(Check.InCheck(board, color)) {
				nextMove.Undo(board);
				continue;
			}
			nextMove.Undo(board);
			
			try {
				score = FindBestReply(board, color, nextMove, depth-1, bestScore);
			} catch (n:Number) {
				move.Undo(board);
				delete nextMove;
				delete moves;
				delete sortedMoves;
				throw n;
			}
			
			if((getTimer() - _startTime) > _goal) {
				move.Undo(board);
				delete nextMove;
				delete moves;
				delete sortedMoves;
				throw new Number(144);
			}

			if(score > bestScore) {
				if(-score-5 <= beta) {
					move.Undo(board);
					delete nextMove;
					delete moves;
					delete sortedMoves;					
					return -999998;
				}
				bestScore = score;
			}
		}

		move.Undo(board);
		delete nextMove;
		delete moves;
		delete sortedMoves;
		return -bestScore;
	}
	
	private function EvaluatePosition(board:Board, color:Number, move:Move):Number
	{
		var score:Number = Math.random();
		move.Do(board);		
		
		if(board.WNC+board.WBC+board.WRC+board.WQC == 0) {
			if(color == Color.BLACK) {
				score -= (Math.abs(4.5 - (board.WKPosition % 10)) * 3); 
				score -= (Math.abs(4.5 - Math.floor(board.WKPosition / 10)) * 3);
				
				// king in proximity of own king
				score -= (3 * (4.5 - Math.abs((board.WKPosition % 10) - (board.BKPosition % 10))));
				score -= (3 * (4.5 - Math.abs(Math.floor(board.WKPosition / 10) - Math.floor(board.BKPosition / 10))));
				
				// number of possible enemy king moves (less == better)
				var moves:Array = new Array();
				board.GenerateMovesAt(board.BKPosition, moves);

				var m:Move;
				var i:Number;
				var legalMovesCount:Number = 0;
				for(i = 0; i < moves.length; i++) {
					m = moves[i];
					if(!Check.InCheck2(board, Color.BLACK, m))
						continue;
					
					legalMovesCount++;
				}					
				score -= ((8 - legalMovesCount) * 5);		
				delete m;
				delete moves;
			}					
			if(Check.InCheck(board, color))
				score -= 10;
		}
		else if(board.BNC+board.BBC+board.BRC+board.BQC == 0) {
			if(color == Color.WHITE) {
				score += (Math.abs(4.5 - (board.BKPosition % 10)) * 3); 
				score += (Math.abs(4.5 - Math.floor(board.BKPosition / 10)) * 3);
				
				// king in proximity of own king
				score += (3 * (4.5 - Math.abs((board.BKPosition % 10) - (board.WKPosition % 10))));
				score += (3 * (4.5 - Math.abs(Math.floor(board.BKPosition / 10) - Math.floor(board.WKPosition / 10))));
				
				// number of possible enemy king moves (less == better)
				var moves:Array = new Array();
				board.GenerateMovesAt(board.WKPosition, moves);

				var m:Move;
				var i:Number;
				var legalMovesCount:Number = 0;
				for(i = 0; i < moves.length; i++) {
					m = moves[i];
					if(!Check.InCheck2(board, Color.WHITE, m))
						continue;
					
					legalMovesCount++;
				}					
				score += ((8 - legalMovesCount) * 5);		
				delete m;
				delete moves;
			}
			if(Check.InCheck(board, color))
				score += 10;
		}
		
		score += (board.WPC*100)-(board.BPC*100)
				+(board.WNC*300)-(board.BNC*300)
				+(board.WBC*325)-(board.BBC*325)
				+(board.WRC*500)-(board.BRC*500)
				+(board.WQC*900)-(board.BQC*900);

		if(board.WPC+board.BPC > 12) {
			if(board._board[Square.E4] == PieceType.WP)
				score += 5;
			if(board._board[Square.E5] == PieceType.BP)
				score -= 5;
			if(board._board[Square.D4] == PieceType.WP)
				score += 5;
			if(board._board[Square.D5] == PieceType.BP)
				score -= 5;
			
			if(board._board[Square.C3] == PieceType.WN)
				score += 7;
			if(board._board[Square.C6] == PieceType.BN)
				score -= 7;
			if(board._board[Square.G3] == PieceType.WN)
				score += 7;
			if(board._board[Square.G6] == PieceType.BN)
				score -= 7;
		}
		
		move.Undo(board);

		return (color == Color.WHITE) ? score : -score;
	}
	
	private function EndState(move:Move, board:Board):Void
	{
		move.Do(board);
		var hisColor:Number = (move.Piece % 4 == Color.WHITE) ? Color.BLACK : Color.WHITE;
		var moves:Array = new Array();
		board.GenerateAllMoves(hisColor, moves)
		while(moves.length) {
			if(Check.InCheck2(board, hisColor, moves[0])) {
				moves.splice(0, 1);
				continue;
			}
			break;
		}
		move.Undo(board);
		delete moves;
		if(moves.length == 0) {
			if(Check.InCheck2(board, hisColor, move)) {
				throw com.saydesign.EndGameException.CheckmateComputerWins(move);
			}
			else {
				throw com.saydesign.EndGameException.StalemateCausedByComputer(move);
			}
		}		
	}
	
	private function Opposite(color:Number):Number {
		return (color == Color.WHITE) ? Color.BLACK : Color.WHITE;
	}
}