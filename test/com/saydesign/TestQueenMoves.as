import com.saydesign.Board;
import com.saydesign.Color;
import com.saydesign.Square;
import com.saydesign.PieceType;
import as2unit.framework.TestCase;

class test.com.saydesign.TestQueenMoves extends TestCase
{
	private var _board:Board;
	private var _moves:Array;
	
	public function TestQueenMoves(methodName:String) {
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
		_board.PlacePiece(PieceType.WQ, s);
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
		_board.PlacePiece(PieceType.WQ, s);
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
		_board.PlacePiece(PieceType.WQ, s);
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
		_board.PlacePiece(PieceType.WQ, s);
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
		_board.PlacePiece(PieceType.WQ, s);
		_board.PlacePiece(PieceType.WP, s+10);
		_board.PlacePiece(PieceType.BP, s+11);
		_board.PlacePiece(PieceType.WP, s+1);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 1 move", 1, _moves.length);
		assertEquals("Should be from A1", Square.A1, _moves[0].Origin);
		assertEquals("Should be from B2", Square.B2, _moves[0].Target);
	}	
	
	public function testQueenGenerateMoves() {		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WQ, Square.A1);
		_board.GenerateMovesAt(Square.A1, _moves);
		
		for(var i:Number = 0; i < _moves.length; i++)
			assertEquals("Should be WQ", PieceType.WQ, _moves[i].Piece);
	}
}