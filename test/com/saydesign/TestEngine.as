import com.saydesign.Engine;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Color;
import as2unit.framework.TestCase;

class test.com.saydesign.TestEngine extends TestCase
{	
	private var board:Board;
	
	public function TestEngine(methodName:String) {
		super(methodName);
	}
	
	public function setUp()
	{
		board = new Board();
	}
	
	public function testEngineGetBestMoveWKA1AndBQB3() 
	{
		board.ClearBoard();
		board.PlacePiece(PieceType.WK, Square.A1);
		board.PlacePiece(PieceType.BQ, Square.B4);

		var move:Move = Engine.GetBestMove(board, Color.WHITE);
		assertEquals("Should be move from A1", Square.A1, move.Origin);
		assertEquals("Should be move from A2", Square.A2, move.Target);
		delete move;
	}
	
	public function testEngineMovesProperlyUndone()
	{
		var PLY:Number = 1;
		board.ClearBoard();
		board.PlacePiece(PieceType.WK, Square.G1);
		board.PlacePiece(PieceType.BQ, Square.A8);
		
		Engine.GetBestMove(board, Color.WHITE, PLY);
		
		// board should be unchanged
		for(var f:Number = Square.A1; f <= Square.H1; f++)
			for(var r:Number = 0; r < 8; r++) {
				if(10*r+f == Square.G1) {
					assertEquals("Should be WK on G1", PieceType.WK, board._board[10*r+f]);
					continue;
				}
				if(10*r+f == Square.A8) {
					assertEquals("Should be BQ on A8", PieceType.BQ, board._board[10*r+f]);
					continue;
				}
				assertEquals("Should be empty on "+(10*r+f), PieceType.EMPTY, board._board[10*r+f]);
			}
	}
	
	public function testEngineMovesProperlyUndoneAtTwoPly()
	{
		var PLY:Number = 2;
		board.ClearBoard();
		board.Castling = 0;
		board.PlacePiece(PieceType.WK, Square.E1);
		board.PlacePiece(PieceType.BQ, Square.A8);
		
		Engine.GetBestMove(board, Color.WHITE, PLY);
		
		// board should be unchanged
		for(var f:Number = Square.A1; f <= Square.H1; f++)
			for(var r:Number = 0; r < 8; r++) {
				if(10*r+f == Square.E1) {
					assertEquals("Should be WK on E1", PieceType.WK, board._board[10*r+f]);
					continue;
				}
				if(10*r+f == Square.A8) {
					assertEquals("Should be BQ on A8", PieceType.BQ, board._board[10*r+f]);
					continue;
				}
				assertEquals("Should be empty on "+(10*r+f), PieceType.EMPTY, board._board[10*r+f]);
			}
	}
	
	public function testEngineCheckmate() 
	{
		board.ClearBoard();
		board.Castling = 0;
		board.PlacePiece(PieceType.BR, Square.G1);
		board.PlacePiece(PieceType.BK, Square.F1);
		board.PlacePiece(PieceType.BP, Square.E1);
		board.PlacePiece(PieceType.BP, Square.E2);
		board.PlacePiece(PieceType.BP, Square.F2);
		board.PlacePiece(PieceType.BP, Square.G2);
		board.PlacePiece(PieceType.WK, Square.H8);
		board.PlacePiece(PieceType.WR, Square.G8);
		board.PlacePiece(PieceType.WP, Square.G7);
		board.BRC = 1;
		board.BPC = 4;
		board.WRC = 1;
		board.WPC = 1;
		board.BKPosition = Square.F1;
		board.WKPosition = Square.H8;
		
		var caught:Boolean = false;
		
		try {
			Engine.GetBestMove(board, Color.BLACK);
		} catch (e:com.saydesign.EndGameException) {
			assertEquals("Checkmate! Computer wins!", e.Message());
			caught = true;
		} finally {
			if(!caught)
				fail("exception not caught");
		}		
	}
}