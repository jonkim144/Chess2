import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Square;
import com.saydesign.File;
import com.saydesign.Color;
import as2unit.framework.TestCase;

class test.com.saydesign.TestPieceType extends TestCase
{
	private var b:Board;
	private var m:Array;
	
	public function TestPieceType(methodName:String)
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
	
	public function testPieceTypeStaticVars()
	{
		assertEquals("Should be White", Color.WHITE, PieceType.WP % 4);
		assertEquals("Should be White", Color.WHITE, PieceType.WN % 4);
		assertEquals("Should be White", Color.WHITE, PieceType.WB % 4);
		assertEquals("Should be White", Color.WHITE, PieceType.WR % 4);
		assertEquals("Should be White", Color.WHITE, PieceType.WQ % 4);
		assertEquals("Should be White", Color.WHITE, PieceType.WK % 4);

		assertEquals("Should be Black", Color.BLACK, PieceType.BP % 4);
		assertEquals("Should be Black", Color.BLACK, PieceType.BN % 4);
		assertEquals("Should be Black", Color.BLACK, PieceType.BB % 4);
		assertEquals("Should be Black", Color.BLACK, PieceType.BR % 4);
		assertEquals("Should be Black", Color.BLACK, PieceType.BQ % 4);
		assertEquals("Should be Black", Color.BLACK, PieceType.BK % 4);
		
		assertTrue("Should not be White", PieceType.EMPTY % 4 != Color.WHITE);
		assertTrue("Should not be Black", PieceType.EMPTY % 4 != Color.BLACK);
		assertTrue("Should not be White", PieceType.BOGUS % 4 != Color.WHITE);
		assertTrue("Should not be Black", PieceType.BOGUS % 4 != Color.BLACK);
	}
}