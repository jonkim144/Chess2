import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;

class com.saydesign.pieces.Bishop
{
	private function Bishop() 
	{ }
	
	public static function GenerateMovesAt(board:Board, origin:Number, moves:Array)
	{
		//var t = getTimer();
		AddMove(board, moves, origin,  11);
		AddMove(board, moves, origin,  -9);
		AddMove(board, moves, origin,   9);
		AddMove(board, moves, origin, -11);
		//_root.TIMER += (getTimer() - t);
	}
	
	private static function AddMove(board:Board, moves:Array,
									origin:Number, inc:Number)
	{
		var target:Number = origin+inc;
		var type:Number = board._board[origin];
		
		if(board._board[target] == PieceType.EMPTY) {
			moves.push(new Move(type, origin+(target<<7)));
			target += inc; 
			if(board._board[target] == PieceType.EMPTY) {
				moves.push(new Move(type, origin+(target<<7)));
				target += inc; 
				if(board._board[target] == PieceType.EMPTY) {
					moves.push(new Move(type, origin+(target<<7)));
					target += inc; 
					if(board._board[target] == PieceType.EMPTY) {
						moves.push(new Move(type, origin+(target<<7)));
						target += inc; 
						if(board._board[target] == PieceType.EMPTY) {
							moves.push(new Move(type, origin+(target<<7)));
							target += inc; 
							if(board._board[target] == PieceType.EMPTY) {
								moves.push(new Move(type, origin+(target<<7)));
								target += inc; 
							}
						}
					}
				}
			}			
		}		
		if(board._board[target] != PieceType.BOGUS)
		if((board._board[target] % 4) != (type % 4)) {
			moves.push(new Move(type, origin+(target<<7)));
			moves[moves.length-1].CapturedPiece = board._board[target];
		}
	}
	
	public static function InCheckBy(board:Board, color:Number,
									 origin:Number):Boolean
	{
		//_root._bishopInCheckCalled++;
		var target:Number = origin + 11;
		
		if(board._board[target] == PieceType.EMPTY) {
			target += 11; 
			if(board._board[target] == PieceType.EMPTY) {
				target += 11; 
			if(board._board[target] == PieceType.EMPTY) {
				target += 11; 
			if(board._board[target] == PieceType.EMPTY) {
				target += 11; 
			if(board._board[target] == PieceType.EMPTY) {
				target += 11; 
			if(board._board[target] == PieceType.EMPTY) {
				target += 11; 
			}
			}
			}
			}
			}
		}
		if((board._board[target] == HisBishop(color))
		|| (board._board[target] == HisQueen(color)))
			return true;
		
		target = origin - 9;
		if(board._board[target] == PieceType.EMPTY) {
			target -= 9;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 9;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 9;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 9;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 9;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 9;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == HisBishop(color))
		|| (board._board[target] == HisQueen(color)))
			return true;
			
		target = origin + 9;
		if(board._board[target] == PieceType.EMPTY) {
			target += 9;
			if(board._board[target] == PieceType.EMPTY) {
				target += 9;
			if(board._board[target] == PieceType.EMPTY) {
				target += 9;
			if(board._board[target] == PieceType.EMPTY) {
				target += 9;
			if(board._board[target] == PieceType.EMPTY) {
				target += 9;
			if(board._board[target] == PieceType.EMPTY) {
				target += 9;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == HisBishop(color))
		|| (board._board[target] == HisQueen(color)))
			return true;
			
		target = origin - 11;
		if(board._board[target] == PieceType.EMPTY) {
			target -= 11;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 11;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 11;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 11;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 11;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 11;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == HisBishop(color))
		|| (board._board[target] == HisQueen(color)))
			return true;
	}
	
	private static function HisBishop(color:Number):Number {
		return (color == Color.WHITE) ? PieceType.BB : PieceType.WB;
	}
	
	private static function HisQueen(color:Number):Number {
		return color == Color.WHITE ? PieceType.BQ : PieceType.WQ
	}
}
		