import com.saydesign.Board;
import com.saydesign.Color;
import com.saydesign.Move;
import com.saydesign.pieces.*;
import com.saydesign.PieceType;
import com.saydesign.Square;

class com.saydesign.Check
{
	private function Check()
	{ }

	public static function InCheck2(board:Board, color:Number, move:Move):Boolean
	{
		var chk:Boolean;
		
		move.Do(board);
		chk = InCheck(board, color);
		move.Undo(board);		
		
		return chk;
	}
	
	public static function InCheck(board:Board, color:Number):Boolean {
		var kingPos:Number = board.KingPosition(color);
		
		var target:Number = kingPos+11;
		if(board._board[target] == PieceType.EMPTY) {
			target+=11;
			if(board._board[target] == PieceType.EMPTY) {
				target+=11;
			if(board._board[target] == PieceType.EMPTY) {
				target+=11;
			if(board._board[target] == PieceType.EMPTY) {
				target+=11;
			if(board._board[target] == PieceType.EMPTY) {
				target+=11;
			if(board._board[target] == PieceType.EMPTY) {
				target+=11;
			}
			}
			}
			}
			}
		}
		if((board._board[target] == HisBishop(color))
		|| (board._board[target] == HisQueen(color)))
			return true;
		
		target = kingPos-9;
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
			
		target = kingPos + 9;
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
			
		target = kingPos - 11;
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
		
		// begin rook in check
		target = kingPos+1;
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
		
		target = kingPos - 1;
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
			
		target = kingPos + 10;
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
			
		target = kingPos - 10;
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
			
		//return Bishop.InCheckBy(board, color, square) || 
			//return Rook.InCheckBy(board, color, kingPos) ||
			return Pawn.InCheckBy(board, color, kingPos) ||
			  Knight.InCheckBy(board, color, kingPos) ||
			  King.InCheckBy(board, color, kingPos);
	}
	
	private static function MyKing(color:Number):Number {
		return (color == Color.WHITE) ? PieceType.WK : PieceType.BK;
	}
	
	private static function HisBishop(color:Number):Number {
		return (color == Color.WHITE) ? PieceType.BB : PieceType.WB;
	}
	
	private static function HisQueen(color:Number):Number {
		return color == Color.WHITE ? PieceType.BQ : PieceType.WQ
	}

}