import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.PieceType;
import as2unit.framework.TestCase;

class test.com.saydesign.TestEndGameException extends TestCase
{
	private var e:com.saydesign.EndGameException;
	public function TestEndGameException(methodName:String) {
		super(methodName);
	}
	
	public function testCheckmateComputerWins() {
		var move:Move = new Move(PieceType.WP, Square.A1+(Square.A2<<7));
		e = com.saydesign.EndGameException.CheckmateComputerWins(move);
		assertEquals("Checkmate! Computer wins!", e.Message());
		assertTrue("Should have a move", e.HasMove());
		assertEquals("Move origin should be A1", Square.A1, e.Move().Origin);
		assertEquals("Move target should be A2", Square.A2, e.Move().Target);
		delete move;
		delete e;
	}
	
	public function testCheckmateYouWin() {
		e = com.saydesign.EndGameException.CheckmateYouWin();
		assertEquals("Checkmate! You win!", e.Message());
		assertFalse("Should not have a move", e.HasMove());
		delete e;
	}
	public function testStalemateCausedByComputer() {
		var move:Move = new Move(PieceType.WP, Square.A1+(Square.A2<<7));
		e = com.saydesign.EndGameException.StalemateCausedByComputer(move);
		assertEquals("Stalemate!", e.Message());
		assertTrue("Should have a move", e.HasMove());
		assertEquals("Move origin should be A1", Square.A1, e.Move().Origin);
		assertEquals("Move target should be A2", Square.A2, e.Move().Target);
		delete move;
		delete e;
	}
	public function testStalemateCausedByHuman() {
		e = com.saydesign.EndGameException.StalemateCausedByHuman();
		assertEquals("Stalemate!", e.Message());
		assertFalse("Should not have a move", e.HasMove());
		delete e;
	}	
}