import com.saydesign.Check;
import com.saydesign.Board;
import com.saydesign.Color;
import com.saydesign.PieceType;
import com.saydesign.Move;
import com.saydesign.Square;
import as2unit.framework.TestCase;

class test.com.saydesign.TestCheck extends TestCase
{
	private var b:Board;
	private var m:Array;
	
	public function TestCheck(methodName:String)
	{
		super(methodName);
	}
	
	public function setUp()
	{
		b = new Board();
		m = new Array();
	}
	
	public function tearDown()
	{
		b = null;
		m = null;
	}
	
	public function testInCheckByKnight()
	{
		b.ClearBoard();
		b.PlacePiece(PieceType.BN, Square.F3);
		b.PlacePiece(PieceType.WK, Square.E1);
		b.PlacePiece(PieceType.WP, Square.A2);
		b.GenerateMovesAt(Square.A2, m);
		
		for(var i:Number = 0; i < m.length; i++)
			if(!Check.InCheck2(b, Color.WHITE, m[i]))
				fail("Should be no moves at A2");
				
	}
	
	public function testInCheckByKing()
	{
		b.ClearBoard();
		b.PlacePiece(PieceType.BK, Square.F3);
		b.PlacePiece(PieceType.WK, Square.E1);
		
		var move:Number = Square.E1+(Square.F2<<7);
		var theMove:Move = new Move(PieceType.WK, move);
		assertTrue("Should be in check at F2", Check.InCheck2(b, Color.WHITE, theMove));
		
		for(var f:Number = Square.A1; f <= Square.H1; f++)
			for(var r:Number = 0; r < 8; r++) {
				if((10*r+f == Square.F3)
				|| (10*r+f == Square.E1))
					continue;
				assertEquals("Should be EMPTY on "+(10*r+f), PieceType.EMPTY, b.PieceAt(10*r+f));
			}
			
		delete theMove;
	}
}