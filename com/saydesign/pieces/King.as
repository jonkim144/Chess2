import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.Rook;
import com.saydesign.Castle;
import com.saydesign.Check;

class com.saydesign.pieces.King
{
	private function King() 
	{ }
	
	public static function GenerateMovesAt(board:Board, square:Number, 
										   moves:Array):Void
	{
		GenerateMovesNoCastling(board, moves, square);

		var color:Number = board._board[square] % 4;
		if(color == Color.WHITE) {
			var QSideCastlingOn:Number = Castle.WQSide & board.Castling;
			var KSideCastlingOn:Number = Castle.WKSide & board.Castling;
		}
		else {
			var QSideCastlingOn:Number = Castle.BQSide & board.Castling;
			var KSideCastlingOn:Number = Castle.BKSide & board.Castling;
		}
		if(square == Square.E1 + 10*HomeRank(color)) {
			if(QSideCastlingOn)
				AddCastling(-1, board, moves, square);
			if(KSideCastlingOn)
				AddCastling(1, board, moves, square);
		}
	}
	
	public static function GenerateMovesNoCastling(board:Board, moves:Array, 
												   origin:Number):Void
	{
		//var t = getTimer();
		AddMove(board, moves, origin, origin+10);
		AddMove(board, moves, origin, origin+11);
		AddMove(board, moves, origin, origin+1);
		AddMove(board, moves, origin, origin-9);
		AddMove(board, moves, origin, origin-10);
		AddMove(board, moves, origin, origin-11);
		AddMove(board, moves, origin, origin-1);
		AddMove(board, moves, origin, origin+9);
		//trace("King GenerateMoves: " + (getTimer() - t));	
	}
	
	private static function AddMove(board:Board, moves:Array,
									origin:Number, target:Number):Void
	{
		if(board._board[target] != PieceType.BOGUS)
		if((board._board[origin] % 4) != (board._board[target] % 4)) {
			moves.push(new Move(board._board[origin], origin+(target<<7)));
			moves[moves.length-1].CapturedPiece = board._board[target];
		}
	}
	
	private static function AddCastling(inc:Number, board:Board, 
										moves:Array, origin:Number):Void
	{
		var myPiece:Number = board._board[origin];
		
		if(board._board[origin+inc] == PieceType.EMPTY)
		if(board._board[origin+2*inc] == PieceType.EMPTY) 
		if(!Check.InCheck(board, myPiece % 4)) {
			var m:Number = origin+((origin+inc)<<7);
			var move:Move = new Move(myPiece, m);
			
			move.Do(board);
			if(!Check.InCheck(board, myPiece % 4))
				moves.push(new Move(myPiece, origin+((origin+2*inc)<<7)));
			move.Undo(board);
			delete move;
		}
	}
	
	public static function InCheckBy(board:Board, color:Number, 
									 kingPos:Number):Boolean
	{
		var hisKing:Number = (color==Color.WHITE) ? PieceType.BK : PieceType.WK;
		if(board._board[kingPos+10] == hisKing)
			return true;
		if(board._board[kingPos+11] == hisKing)
			return true;
		if(board._board[kingPos+1] == hisKing)
			return true;
		if(board._board[kingPos-9] == hisKing)
			return true;
		if(board._board[kingPos-10] == hisKing)
			return true;
		if(board._board[kingPos-11] == hisKing)
			return true;
		if(board._board[kingPos-1] == hisKing)
			return true;
		if(board._board[kingPos+9] == hisKing)
			return true;
		return false;
	}
	
	private static function HomeRank(color:Number):Number {
		return (color == Color.WHITE) ? 0 : 7;
	}
}
												