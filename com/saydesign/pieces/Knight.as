import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;

class com.saydesign.pieces.Knight
{
	private function Knight() 
	{ }
	
	public static function GenerateMovesAt(board:Board, origin:Number, 
										   moves:Array):Void
	{
		//var t = getTimer();
		
		AddMove(board, moves, origin, origin+21);
		AddMove(board, moves, origin, origin+12);
		AddMove(board, moves, origin, origin-8);
		AddMove(board, moves, origin, origin-19);
		AddMove(board, moves, origin, origin-21);
		AddMove(board, moves, origin, origin-12);
		AddMove(board, moves, origin, origin+8);
		AddMove(board, moves, origin, origin+19);
		//trace("Knight GenerateMoves: " + (getTimer() - t));
	}	
	
	private static function AddMove(board:Board, moves:Array, 
									origin:Number, target:Number):Void				 
	{
		if(board._board[target] != undefined)
		if(board._board[target] != PieceType.BOGUS)
		if((board._board[origin] % 4) != (board._board[target] % 4)) {
			moves.push(new Move(board._board[origin], origin+(target<<7)));
			moves[moves.length - 1].CapturedPiece = board._board[target];
		}
	}
	
	public static function InCheckBy(board:Board, color:Number, 
									 kingPos:Number):Boolean
	{		
		var hisKnight:Number = (color==Color.WHITE) ? PieceType.BN : PieceType.WN;
		if(board._board[kingPos+8] == hisKnight)
			return true;
		if(board._board[kingPos+12] == hisKnight)
			return true;
		if(board._board[kingPos+19] == hisKnight)
			return true;
		if(board._board[kingPos+21] == hisKnight)
			return true;
		if(board._board[kingPos-8] == hisKnight)
			return true;
		if(board._board[kingPos-12] == hisKnight)
			return true;
		if(board._board[kingPos-19] == hisKnight)
			return true;
		if(board._board[kingPos-21] == hisKnight)
			return true;
		return false;
	}
}

		