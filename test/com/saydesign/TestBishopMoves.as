import com.saydesign.Board;
import com.saydesign.File;
import com.saydesign.Color;
import com.saydesign.PieceType;
import com.saydesign.Square;
import as2unit.framework.TestCase;

class test.com.saydesign.TestBishopMoves extends TestCase
{
	private var _board:Board;
	private var _moves:Array;
	
	public function TestBishopMoves(methodName:String) {
		super(methodName);
	}
	
	public function setUp() {
		_board = new Board();
		_moves = new Array();
	}
	
	public function tearDown() { 
		delete _board;
		delete _moves;
	}
	
	public function testOffBoardMovesFromA1()
	{
		var s:Number = Square.A1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.WP, s+11);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testOffBoardMovesFromH1()
	{
		var s:Number = Square.H1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.WP, s+9);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testOffBoardMovesFromA8()
	{
		var s:Number = Square.A8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.WP, s-9);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testOffBoardMovesFromH8()
	{
		var s:Number = Square.H8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.WP, s-11);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);
	}	
	
	public function testCaptureMoveA1H8()
	{
		var s:Number = Square.A1;
		var t:Number = Square.H8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.BP, t);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 7 moves", 7, _moves.length);
	}	
	
	public function testCaptureMoveH8A1()
	{
		var s:Number = Square.H8;
		var t:Number = Square.A1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.BP, t);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 7 moves", 7, _moves.length);
	}	
	
	public function testCaptureMoveA8H1()
	{
		var s:Number = Square.A8;
		var t:Number = Square.H1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.BP, t);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 7 moves", 7, _moves.length);
	}	
	
	public function testCaptureMoveH1A8()
	{
		var s:Number = Square.H1;
		var t:Number = Square.A8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.BP, t);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 7 moves", 7, _moves.length);
	}	
	
	public function testCaptureThruPieceH8A1()
	{
		var s:Number = Square.H8;
		var t:Number = Square.A1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.WP, Square.B2);
		_board.PlacePiece(PieceType.BP, t);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 5 moves", 5, _moves.length);
	}	
	
	public function testCaptureCloseB2A1()
	{
		var s:Number = Square.B2;
		var t:Number = Square.A1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WB, s);
		_board.PlacePiece(PieceType.BP, t);
		
		_board.PlacePiece(PieceType.WP, s+11);
		_board.PlacePiece(PieceType.WP, s+9);
		_board.PlacePiece(PieceType.WP, s-9);
				
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 1 moves", 1, _moves.length);
		assertEquals("Should be from B2", Square.B2, _moves[0].Origin);
		assertEquals("Should be from A1", Square.A1, _moves[0].Target);
	}	
}