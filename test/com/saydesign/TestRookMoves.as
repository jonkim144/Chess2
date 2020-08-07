import com.saydesign.Board;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.PieceType;
import as2unit.framework.TestCase;

class test.com.saydesign.TestRookMoves extends TestCase
{
	private var _board:Board;
	private var _moves:Array;
	
	public function TestRookMoves(methodName:String) {
		super(methodName);
	}
	
	public function setUp() {
		_board = new Board();
		_moves = new Array();
	}
	
	public function tearDown() { 
		_board = null;
		_moves = null;
	}
	
	public function testOffBoardMovesFromA1()
	{
		var s:Number = Square.A1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WR, s);
		_board.PlacePiece(PieceType.WP, s+1);
		_board.PlacePiece(PieceType.WP, s+10);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
}