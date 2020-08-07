import com.saydesign.Board;
import com.saydesign.File;
import com.saydesign.PieceType;
import com.saydesign.Color;
import com.saydesign.Castle;
import as2unit.framework.TestCase;

class test.com.saydesign.TestBoard extends TestCase
{
	public function TestBoard(methodName:String) {
		super(methodName);
	}
	
	private var b:Board;
	
	public function setUp() {
		b = new Board();
	}
	
	public function tearDown() {
		b = null;
	}
	
	public function testBoardConstructor() {
		var f:Number;
		
		assertNotNull(b);
		assertNotUndefined(b);
	}	
	
	public function testBoardGenerateMovesAt() {
		var moves:Array = new Array();
		
		b.GenerateAllMoves(Color.WHITE, moves);
		assertEquals("Should be 20 moves", 20, moves.length);
		
		delete moves;
	}				
}