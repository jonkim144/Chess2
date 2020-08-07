import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.pieces.Rook;
import com.saydesign.pieces.Bishop;

class com.saydesign.pieces.Queen
{
	private function Queen() 
	{ }
	
	public static function GenerateMovesAt(board:Board, square:Number, 
										   moves:Array):Void
	{
		//var t = getTimer();
		Rook.GenerateMovesAt(board, square, moves);
		Bishop.GenerateMovesAt(board, square, moves);
		
		//trace("Queen GenerateMoves: " + (getTimer() - t));
	}
	
	
}