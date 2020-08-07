import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.File;
import com.saydesign.Castle;

class com.saydesign.pieces.Rook
{
	private function Rook()
	{ }

	public static function GenerateMovesAt(board:Board, origin:Number, 
										   moves:Array):Void
	{
		//var t = getTimer();
		AddMove(board, moves, origin,   1);
		AddMove(board, moves, origin,  10);
		AddMove(board, moves, origin,  -1);
		AddMove(board, moves, origin, -10);
		//trace("Rook GenerateMoves: " + (getTimer() - t));
	}
	
	// PERF: this is exactly the same as Bishop::AddMove
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
		if((type % 4) != (board._board[target] % 4)) {
			moves.push(new Move(type, origin+(target<<7)));
			moves[moves.length - 1].CapturedPiece = board._board[target];
		}
	}
	
	public static function InCheckBy(board:Board, color:Number,
									 origin:Number):Boolean
	{
		var target:Number = origin+1;
		var hisRook:Number = color==Color.WHITE ? PieceType.BR : PieceType.WR;
		var hisQueen:Number = color==Color.WHITE ? PieceType.BQ : PieceType.WQ;
		
		if(board._board[target] == PieceType.EMPTY) {
			target++;
			if(board._board[target] == PieceType.EMPTY) {
				target++;
			if(board._board[target] == PieceType.EMPTY) {
				target++;
			if(board._board[target] == PieceType.EMPTY) {
				target++;
			if(board._board[target] == PieceType.EMPTY) {
				target++;
			if(board._board[target] == PieceType.EMPTY) {
				target++;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == hisRook)
		|| (board._board[target] == hisQueen))
			return true;
		
		target = origin - 1;
		if(board._board[target] == PieceType.EMPTY) {
			target--;
			if(board._board[target] == PieceType.EMPTY) {
				target--;
			if(board._board[target] == PieceType.EMPTY) {
				target--;
			if(board._board[target] == PieceType.EMPTY) {
				target--;
			if(board._board[target] == PieceType.EMPTY) {
				target--;
			if(board._board[target] == PieceType.EMPTY) {
				target--;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == hisRook)
		|| (board._board[target] == hisQueen))
			return true;
			
		target = origin + 10;
		if(board._board[target] == PieceType.EMPTY) {
			target += 10;
			if(board._board[target] == PieceType.EMPTY) {
				target += 10;
			if(board._board[target] == PieceType.EMPTY) {
				target += 10;
			if(board._board[target] == PieceType.EMPTY) {
				target += 10;
			if(board._board[target] == PieceType.EMPTY) {
				target += 10;
			if(board._board[target] == PieceType.EMPTY) {
				target += 10;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == hisRook)
		|| (board._board[target] == hisQueen))
			return true;
			
		target = origin - 10;
		if(board._board[target] == PieceType.EMPTY) {
			target -= 10;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 10;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 10;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 10;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 10;
			if(board._board[target] == PieceType.EMPTY) {
				target -= 10;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == hisRook)
		|| (board._board[target] == hisQueen))
			return true;
		
		return false;
	}
}
		