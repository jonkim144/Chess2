import com.saydesign.Board;
import com.saydesign.PieceType;
import com.saydesign.Color;
import com.saydesign.Square;
import com.saydesign.Check;
import com.saydesign.Move;
import as2unit.framework.TestCase;

class test.com.saydesign.TestKingMoves extends TestCase
{
	private var _board:Board;
	private var _moves:Array;
	
	public function TestKingMoves(methodName:String) {
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
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WP, s+10);
		_board.PlacePiece(PieceType.WP, s+11);
		_board.PlacePiece(PieceType.WP, s+1);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testOffBoardMovesFromH1()
	{
		var s:Number = Square.H1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WP, s-1);
		_board.PlacePiece(PieceType.WP, s+9);
		_board.PlacePiece(PieceType.WP, s+10);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testOffBoardMovesFromA8()
	{
		var s:Number = Square.A8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WP, s-10);
		_board.PlacePiece(PieceType.WP, s-9);
		_board.PlacePiece(PieceType.WP, s+1);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testOffBoardMovesFromH8()
	{
		var s:Number = Square.H8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WP, s-1);
		_board.PlacePiece(PieceType.WP, s-11);
		_board.PlacePiece(PieceType.WP, s-10);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testCaptureMoveA1B2()
	{
		var s:Number = Square.A1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WP, s+1);
		_board.PlacePiece(PieceType.BP, s+11);
		_board.PlacePiece(PieceType.WP, s+10);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 1 move", 1, _moves.length);
		assertEquals("Should be from A1", Square.A1, _moves[0].Origin);
		assertEquals("Should be from B2", Square.B2, _moves[0].Target);
	}	
	
	public function testAddCastlingAfterMovingKing()
	{
		var s:Number = Square.E1;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WR, Square.H1);
		
		new Move(PieceType.WK, Square.E1+(Square.E2<<7)).Do(_board);
		new Move(PieceType.WK, Square.E2+(Square.E1<<7)).Do(_board);
		
		_board.GenerateMovesAt(s, _moves);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Target == Square.G1)
				fail("Should not find castling move");
			if(_moves[i].Target == Square.C1)
				fail("Should not find castling move");
		}
		
		assertEquals("Should be EMPTY on C1", PieceType.EMPTY, _board.PieceAt(Square.C1));
		assertEquals("Should be EMPTY on D1", PieceType.EMPTY, _board.PieceAt(Square.D1));
		assertEquals("Should be WK on E1", PieceType.WK, _board.PieceAt(Square.E1));
		assertEquals("Should be EMPTY on F1", PieceType.EMPTY, _board.PieceAt(Square.F1));
		assertEquals("Should be EMPTY on G1", PieceType.EMPTY, _board.PieceAt(Square.G1));
		assertEquals("Should be WR on H1", PieceType.WR, _board.PieceAt(Square.H1));
	}
	
	public function testCastlingOutOfCheck()
	{
		var s:Number = Square.E1;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WR, Square.H1);
		_board.PlacePiece(PieceType.BB, Square.B4);
		
		_board.GenerateMovesAt(s, _moves);
		
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Target == Square.G1)
				fail("Should not find castling move");
		
		assertEquals("Should be EMPTY on C1", PieceType.EMPTY, _board.PieceAt(Square.C1));
		assertEquals("Should be EMPTY on D1", PieceType.EMPTY, _board.PieceAt(Square.D1));
		assertEquals("Should be WK on E1", PieceType.WK, _board.PieceAt(Square.E1));
		assertEquals("Should be EMPTY on F1", PieceType.EMPTY, _board.PieceAt(Square.F1));
		assertEquals("Should be EMPTY on G1", PieceType.EMPTY, _board.PieceAt(Square.G1));
		assertEquals("Should be WR on H1", PieceType.WR, _board.PieceAt(Square.H1));
	}
	
	public function testCastlingThruCheck()
	{
		var s:Number = Square.E1;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WR, Square.H1);
		_board.PlacePiece(PieceType.BR, Square.F4);
		
		_board.GenerateMovesAt(s, _moves);
		
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Target == Square.G1)
				fail("Should not find castling move");
					
		assertEquals("Should be EMPTY on C1", PieceType.EMPTY, _board.PieceAt(Square.C1));
		assertEquals("Should be EMPTY on D1", PieceType.EMPTY, _board.PieceAt(Square.D1));
		assertEquals("Should be WK on E1", PieceType.WK, _board.PieceAt(Square.E1));
		assertEquals("Should be EMPTY on F1", PieceType.EMPTY, _board.PieceAt(Square.F1));
		assertEquals("Should be EMPTY on G1", PieceType.EMPTY, _board.PieceAt(Square.G1));
		assertEquals("Should be WR on H1", PieceType.WR, _board.PieceAt(Square.H1));
	}
	
	public function testDoCastlingKingSide() {
		var s:Number = Square.E1;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WR, Square.H1);
		_board.PlacePiece(PieceType.WR, Square.A1);

		_board.GenerateMovesAt(s, _moves);
		
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Target == Square.G1)
				_moves[i].Do(_board);
					
		assertEquals("Should be WR on A1", PieceType.WR, _board.PieceAt(Square.A1));
		assertEquals("Should be EMPTY on B1", PieceType.EMPTY, _board.PieceAt(Square.B1));
		assertEquals("Should be EMPTY on C1", PieceType.EMPTY, _board.PieceAt(Square.C1));
		assertEquals("Should be EMPTY on D1", PieceType.EMPTY, _board.PieceAt(Square.D1));
		assertEquals("Should be EMPTY on E1", PieceType.EMPTY, _board.PieceAt(s));
		assertEquals("Should be WR on F1", PieceType.WR, _board.PieceAt(Square.F1));
		assertEquals("Should be WK on G1", PieceType.WK, _board.PieceAt(Square.G1));
		assertEquals("Should be EMPTY on H1", PieceType.EMPTY, _board.PieceAt(Square.H1));
	}
	
	public function testDoCastlingQueenSide() {
		var s:Number = Square.E1;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WK, s);
		_board.PlacePiece(PieceType.WR, Square.H1);
		_board.PlacePiece(PieceType.WR, Square.A1);

		_board.GenerateMovesAt(s, _moves);
		
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Target == Square.C1)
				_moves[i].Do(_board);
					
		assertEquals("Should be EMPTY on A1", PieceType.EMPTY, _board.PieceAt(Square.A1));
		assertEquals("Should be EMPTY on B1", PieceType.EMPTY, _board.PieceAt(Square.B1));
		assertEquals("Should be WK on C1", PieceType.WK, _board.PieceAt(Square.C1));
		assertEquals("Should be WR on D1", PieceType.WR, _board.PieceAt(Square.D1));
		assertEquals("Should be EMPTY on E1", PieceType.EMPTY, _board.PieceAt(s));
		assertEquals("Should be EMPTY on F1", PieceType.EMPTY, _board.PieceAt(Square.F1));
		assertEquals("Should be EMPTY on G1", PieceType.EMPTY, _board.PieceAt(Square.G1));
		assertEquals("Should be WR on H1", PieceType.WR, _board.PieceAt(Square.H1));
	}
}
