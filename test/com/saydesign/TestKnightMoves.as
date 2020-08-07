import com.saydesign.Board;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.PieceType;
import as2unit.framework.TestCase;

class test.com.saydesign.TestKnightMoves extends TestCase
{
	private var _board:Board;
	private var _moves:Array;
	
	public function TestKnightMoves(methodName:String) {
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
		_board.PlacePiece(PieceType.WN, s);
		_board.PlacePiece(PieceType.WP, s+21);
		_board.PlacePiece(PieceType.WP, s+12);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);		
	}	
	
	public function testOffBoardMovesFromA8()
	{
		var s:Number = Square.A8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WN, s);
		_board.PlacePiece(PieceType.WP, s-19);
		_board.PlacePiece(PieceType.WP, s-8);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);		
	}	
	
	public function testOffBoardMovesFromH1()
	{
		var s:Number = Square.H1;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WN, s);
		_board.PlacePiece(PieceType.WP, s+19);
		_board.PlacePiece(PieceType.WP, s+8);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);		
	}	
	
	public function testOffBoardMovesFromH8()
	{
		var s:Number = Square.H8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WN, s);
		_board.PlacePiece(PieceType.WP, s-21);
		_board.PlacePiece(PieceType.WP, s-12);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 0 moves", 0, _moves.length);		
	}	
	
	public function testWhiteKnightCaptureMove() {
		var s:Number = Square.H8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WN, s);
		_board.PlacePiece(PieceType.BP, s-21);
		_board.PlacePiece(PieceType.WP, s-12);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 1 move", 1, _moves.length);
		assertEquals("Move should be from H8", Square.H8, _moves[0].Origin);
		assertEquals("Move should be to G6",   Square.G6, _moves[0].Target);
	}
	
	public function testBlackKnightCaptureMove() {
		var s:Number = Square.H8;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.BN, s);
		_board.PlacePiece(PieceType.WP, s-21);
		_board.PlacePiece(PieceType.BP, s-12);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be 1 move", 1, _moves.length);
		assertEquals("Move should be from H8", Square.H8, _moves[0].Origin);
		assertEquals("Move should be to G6",   Square.G6, _moves[0].Target);
	}
}