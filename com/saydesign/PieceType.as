import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Piece;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.Pawn;
import com.saydesign.Knight;
import com.saydesign.Bishop;
import com.saydesign.Rook;
import com.saydesign.Queen;
import com.saydesign.King;
import com.saydesign.Bogus;
import com.saydesign.Empty;

class com.saydesign.PieceType
{
	public static var WP:Number = 1;
	public static var BP:Number = 2;
	public static var WN:Number = 5;
	public static var BN:Number = 6;
	public static var WB:Number = 9;
	public static var BB:Number = 10;
	public static var WR:Number = 13;
	public static var BR:Number = 14;
	public static var WQ:Number = 17;
	public static var BQ:Number = 18;
	public static var WK:Number = 21;
	public static var BK:Number = 22;
	
	public static var EMPTY:Number  = 0;
	public static var BOGUS:Number  = 23;
	
	private function PieceType() 
	{ }
}