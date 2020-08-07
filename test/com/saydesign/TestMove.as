import com.saydesign.Move;
import com.saydesign.Board;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.PieceType;
import com.saydesign.Castle;
import as2unit.framework.TestCase;

class test.com.saydesign.TestMove extends TestCase
{
	public function TestMove(methodName:String)
	{
		super(methodName);
	}
	
	public function testCreateMoveA2A4() {
		var move:Number = Square.A2+(Square.A4<<7);
		var m:Move = new Move(PieceType.WP, move);
		assertEquals("Piece should be WP", PieceType.WP, m.Piece);
		assertEquals("Origin should be on A2", Square.A2, m.Origin);
		assertEquals("Target should be on A4", Square.A4, m.Target);
		delete m;
	}
	
	public function testCreateMoveH2H4() {
		var move:Number = Square.H2+(Square.H4<<7);
		var m:Move = new Move(PieceType.WP, move);

		assertEquals("Piece should be WP", PieceType.WP, m.Piece);
		assertEquals("Origin should be on H2", Square.H2, m.Origin);
		assertEquals("Target should be on H4", Square.H4, m.Target);
		delete m;
	}	
	
	public function testMoveDoPawnA3A4() {
		var board:Board = new Board();
		
		board.ClearBoard();
		board.EnPassant = Square.A3; // to test reset of en passant value
		board.PlacePiece(PieceType.WP, Square.A3);
		board.WPC++;
		
		var move:Number = Square.A3+(Square.A4<<7);
		var m:Move = new Move(PieceType.WP, move);
		var capture:Boolean = m.Do(board);
		
		assertEquals("Should be pawn on A4", PieceType.WP, board.PieceAt(Square.A4));
		assertEquals("Should be EMPTY on A3", PieceType.EMPTY, board.PieceAt(Square.A3));
		assertEquals("EnPassant should be null", null, board.EnPassant);
		assertEquals("WPC should be 1", 1, board.WPC);
		
		delete m;
		delete board;
	}
	
	public function testMoveDoWhiteEnPassantB5A6() {
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.WP, Square.B5);
		board.WPC++;
		board.PlacePiece(PieceType.BP, Square.A5);
		board.BPC++;
		var move:Number = Square.B5+(Square.A6<<7);
		var m:Move = new Move(PieceType.WP, move);
		m.Do(board);
		assertEquals("Should be EMPTY at A5", PieceType.EMPTY, board.PieceAt(Square.A5));
		assertEquals("Should be WP at A6", PieceType.WP, board.PieceAt(Square.A6));
		assertEquals("WPC should be 1", 1, board.WPC);
		assertEquals("BPC should be 0", 0, board.BPC);
		
		delete board;
		delete m;
	}
	
	public function testMoveDoBlackEnPassantG4H3() {
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.BP, Square.G4);
		board.BPC++;
		board.PlacePiece(PieceType.WP, Square.H4);
		board.WPC++;
		var move:Number = Square.G4+(Square.H3<<7);
		var m:Move = new Move(PieceType.BP, move);
		m.Do(board);
		assertEquals("Should be EMPTY at H4", PieceType.EMPTY, board.PieceAt(Square.H4));
		assertEquals("Should be BP at H3", PieceType.BP, board.PieceAt(Square.H3));
		assertEquals("WPC should be 0", 0, board.WPC);
		assertEquals("BPC should be 1", 1, board.BPC);
		
		delete board;
		delete m;
	}
	
	public function testDoWhitePawnPromotionToQueenAtD8() 
	{
		var board:Board = new Board();
		var moves:Array = new Array();
		board.ClearBoard();
		board.PlacePiece(PieceType.WP, Square.D7);
		board.WPC++;
		board.GenerateMovesAt(Square.D7, moves);

		moves[0].Do(board);
		
		assertEquals("Should be WQ on D8", PieceType.WQ, board.PieceAt(Square.D8));
		assertEquals("Should be EMPTY on D7", PieceType.EMPTY, board.PieceAt(Square.D7));
		assertEquals("WPC should be 0", 0, board.WPC);
		assertEquals("WQC should be 1", 1, board.WQC);
		
		delete board;
		delete moves;
	}
	
	public function testDoBlackPawnPromotionToQueenAtH1() 
	{
		var board:Board = new Board();
		var moves:Array = new Array();
		board.ClearBoard();
		board.PlacePiece(PieceType.BP, Square.H2);
		board.BPC++;
		board.GenerateMovesAt(Square.H2, moves);

		moves[0].Do(board);
		
		assertEquals("Should be BQ on H1", PieceType.BQ, board.PieceAt(Square.H1));
		assertEquals("Should be EMPTY on H2", PieceType.EMPTY, board.PieceAt(Square.H2));
		assertEquals("BPC should be 0", 0, board.BPC);
		assertEquals("BQC should be 1", 1, board.BQC);
		
		delete board;
		delete moves;
	}
	
	public function testDoWhiteKingSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.WK, Square.E1);
		board.PlacePiece(PieceType.WR, Square.H1);
		board.WRC++;
		
		var move:Number = Square.E1+(Square.G1<<7);
		var m:Move = new Move(PieceType.WK, move);
		
		m.Do(board);
	
		assertEquals("Should be WR on F1", PieceType.WR, board.PieceAt(Square.F1));
		assertEquals("Should be EMPTY on H1", PieceType.EMPTY, board.PieceAt(Square.H1));
		assertEquals("Should be WK on G1", PieceType.WK, board.PieceAt(Square.G1));
		assertEquals("Castling should be off for White", 
					 Castle.BKSide | Castle.BQSide,
					 board.Castling);
		assertEquals("WRC should be 1", 1, board.WRC);
		
		delete board;
		delete m;
	}
	
	public function testDoWhiteQueenSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.WK, Square.E1);
		board.PlacePiece(PieceType.WR, Square.A1);
		board.WRC++;
		
		var move:Number = Square.E1+(Square.C1<<7);
		var m:Move = new Move(PieceType.WK, move);
		
		m.Do(board);
		
		assertEquals("Should be WR on D1", PieceType.WR, board.PieceAt(Square.D1));
		assertEquals("Should be EMPTY on A1", PieceType.EMPTY, board.PieceAt(Square.A1));
		assertEquals("Should be WK on C1", PieceType.WK, board.PieceAt(Square.C1));
		assertEquals("Castling should be off for White", 
					 Castle.BKSide | Castle.BQSide,
					 board.Castling);
		assertEquals("WRC should be 1", 1, board.WRC);
		
		delete board;
		delete m;
	}
	
	public function testDoBlackKingSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.BK, Square.E8);
		board.PlacePiece(PieceType.BR, Square.H8);
		board.BRC++;
		
		var move:Number = Square.E8+(Square.G8<<7);
		var m:Move = new Move(PieceType.BK, move);
		
		m.Do(board);
		
		assertEquals("Should be BR on F8", PieceType.BR, board.PieceAt(Square.F8));
		assertEquals("Should be EMPTY on H8", PieceType.EMPTY, board.PieceAt(Square.H8));
		assertEquals("Should be BK on G8", PieceType.BK, board.PieceAt(Square.G8));
		assertEquals("Castling should be off for Black", 
					 Castle.WKSide | Castle.WQSide,
					 board.Castling);
		assertEquals("BRC should be 1", 1, board.BRC);

		delete board;
		delete m;
	}
	
	public function testDoBlackQueenSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.BK, Square.E8);
		board.PlacePiece(PieceType.BR, Square.A8);
		board.BRC++;
		
		var move:Number = Square.E8+(Square.C8<<7);
		var m:Move = new Move(PieceType.BK, move);
		
		m.Do(board);
		
		assertEquals("Should be BR on D8", PieceType.BR, board.PieceAt(Square.D8));
		assertEquals("Should be EMPTY on A8", PieceType.EMPTY, board.PieceAt(Square.A8));
		assertEquals("Should be BK on C8", PieceType.BK, board.PieceAt(Square.C8));
		assertEquals("Castling should be off for Black", 
					 Castle.WKSide | Castle.WQSide,
					 board.Castling);
		assertEquals("BRC should be 1", 1, board.BRC);
		
		delete board;
		delete m;
	}
	
	public function testDoUpdateKingPosition()
	{
		var board:Board = new Board();
		board.ClearAt(Square.F8);
		board.BBC--;
		board.ClearAt(Square.G8);
		board.BNC--;
		
		assertEquals("Black King should be on E8", 
					 Square.E8, board.BKPosition);
		
		var move:Number = Square.E8+(Square.G8<<7);
		var m:Move = new Move(PieceType.BK, move);
		m.Do(board);
		
		assertEquals("Black King should be on G8", 
					 Square.G8, board.BKPosition);

		assertEquals("BBC should be 1", 1, board.BBC);
		assertEquals("BNC should be 1", 1, board.BNC);
		assertEquals("BRC should be 2", 2, board.BRC);
		
		delete board;
		delete m;
	}
	
	public function testMoveCapturedPiece()
	{
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.WP, Square.A2);
		board.WPC++;
		board.PlacePiece(PieceType.BP, Square.B3);
		board.BPC++;
		var move:Number = Square.A2+(Square.B3<<7);
		var m:Move = new Move(PieceType.WP, move);
		
		m.Do(board);
		
		assertEquals("Should be BP", PieceType.BP, m.CapturedPiece);
		assertEquals("WPC should be 1", 1, board.WPC);
		assertEquals("BPC should be 0", 0, board.BPC);
		
		delete m;
		delete board;
	}
	
	public function testCapturePawnWithKnight()
	{
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.WN, Square.F6);
		board.WNC++;
		board.PlacePiece(PieceType.BP, Square.E4);
		board.BPC++;
		var move:Number = Square.F6+(Square.E4<<7);
		var m:Move = new Move(PieceType.WN, move);
		
		m.Do(board);
		
		assertEquals("Should be WN @ E4", PieceType.WN, board.PieceAt(Square.E4));
		assertEquals("Should be EMPTY @ F6", PieceType.EMPTY, board.PieceAt(Square.F6));
		assertEquals("WNC should be 1", 1, board.WNC);
		assertEquals("BPC should be 0", 0, board.BPC);
		
		delete m;
		delete board;
	}
	
	public function testUndoWhiteEnPassantB5A6() {
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.WP, Square.B5);
		board.WPC++;
		board.PlacePiece(PieceType.BP, Square.A7);
		board.BPC++;
		
		var move:Number = Square.A7+(Square.A5<<7);
		var m:Move = new Move(PieceType.BP, move);
		m.Do(board);
		
		var moves:Array = new Array();
		board.GenerateMovesAt(Square.B5, moves);
		
		for(var i:Number = 0; i < moves.length; i++) {
			moves[i].Do(board);
			moves[i].Undo(board);
		}
		
		assertEquals("Should be WP at B5", PieceType.WP, board.PieceAt(Square.B5));
		assertEquals("Should be BP at A5", PieceType.BP, board.PieceAt(Square.A5));
		assertEquals("BPC should be 1", 1, board.BPC);
		assertEquals("WPC should be 1", 1, board.WPC);
		
		delete board;
		delete m;
	}
	
	public function testUndoBlackEnPassantG4H3() {
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.BP, Square.G4);
		board.BPC++;
		board.PlacePiece(PieceType.WP, Square.H2);
		board.WPC++;
		
		var move:Number = Square.H2+(Square.H4<<7);
		var m:Move = new Move(PieceType.WP, move);
		m.Do(board);
		
		var moves:Array = new Array();
		board.GenerateMovesAt(Square.G4, moves);
		
		for(var i:Number = 0; i < moves.length; i++) {
			moves[i].Do(board);
			moves[i].Undo(board);
		}
		
		assertEquals("Should be BP at G4", PieceType.BP, board.PieceAt(Square.G4));
		assertEquals("Should be WP at H4", PieceType.WP, board.PieceAt(Square.H4));
		assertEquals("BPC should be 1", 1, board.BPC);
		assertEquals("WPC should be 1", 1, board.WPC);
		
		delete board;
		delete m;
	}
	
	public function testUndoWhitePawnPromotionToQueenAtD8() 
	{
		var board:Board = new Board();
		var moves:Array = new Array();
		board.ClearBoard();
		board.PlacePiece(PieceType.WP, Square.D7);
		board.WPC++;
		board.GenerateMovesAt(Square.D7, moves);

		moves[0].Do(board);
		moves[0].Undo(board);
		
		assertEquals("Should be EMPTY on D8", PieceType.EMPTY, board.PieceAt(Square.D8));
		assertEquals("Should be WP on D7", PieceType.WP, board.PieceAt(Square.D7));
		assertEquals("WPC should be 1", 1, board.WPC);
		
		delete board;
		delete moves;
	}
	
	public function testUndoBlackPawnPromotionToQueenAtH1() 
	{
		var board:Board = new Board();
		var moves:Array = new Array();
		board.ClearBoard();
		board.PlacePiece(PieceType.BP, Square.H2);
		board.BPC++;
		board.GenerateMovesAt(Square.H2, moves);

		moves[0].Do(board);
		moves[0].Undo(board);
		
		assertEquals("Should be EMPTY on H1", PieceType.EMPTY, board.PieceAt(Square.H1));
		assertEquals("Should be BP on H2", PieceType.BP, board.PieceAt(Square.H2));
		assertEquals("BPC should be 1", 1, board.BPC);
		
		delete board;
		delete moves;
	}
	
	public function testUndoWhiteKingSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.WK, Square.E1);
		board.PlacePiece(PieceType.WR, Square.H1);
		board.WRC++;
		
		var move:Number = Square.E1+(Square.G1<<7);
		var m:Move = new Move(PieceType.WK, move);
		
		m.Do(board);
		m.Undo(board);
	
		assertEquals("Should be WK on E1", PieceType.WK, board.PieceAt(Square.E1));
		assertEquals("Should be EMPTY on F1", PieceType.EMPTY, board.PieceAt(Square.F1));
		assertEquals("Should be EMPTY on G1", PieceType.EMPTY, board.PieceAt(Square.G1));
		assertEquals("Should be WR on H1", PieceType.WR, board.PieceAt(Square.H1));
		assertEquals("Castling should be on for White", 
					 Castle.All,
					 board.Castling);
		assertEquals("WRC should be 1", 1, board.WRC);
		
		delete board;
		delete m;
	}
	
	public function testUndoWhiteQueenSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.WK, Square.E1);
		board.PlacePiece(PieceType.WR, Square.A1);
		board.WRC++;
		
		var move:Number = Square.E1+(Square.C1<<7);
		var m:Move = new Move(PieceType.WK, move);
		
		m.Do(board);
		m.Undo(board);
		
		assertEquals("Should be WR on A1", PieceType.WR, board.PieceAt(Square.A1));
		assertEquals("Should be EMPTY on B1", PieceType.EMPTY, board.PieceAt(Square.B1));
		assertEquals("Should be EMPTY on C1", PieceType.EMPTY, board.PieceAt(Square.C1));
		assertEquals("Should be EMPTY on D1", PieceType.EMPTY, board.PieceAt(Square.D1));
		assertEquals("Should be WK on E1", PieceType.WK, board.PieceAt(Square.E1));
		assertEquals("Castling should be on for White", 
					 Castle.All,
					 board.Castling);
		assertEquals("WRC should be 1", 1, board.WRC);
		
		delete board;
		delete m;
	}
	
	public function testUndoBlackKingSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.BK, Square.E8);
		board.PlacePiece(PieceType.BR, Square.H8);
		board.BRC++;
		
		var move:Number = Square.E8+(Square.G8<<7);
		var m:Move = new Move(PieceType.BK, move);
		
		m.Do(board);
		m.Undo(board);
		
		assertEquals("Should be BK on E8", PieceType.BK, board.PieceAt(Square.E8));
		assertEquals("Should be EMPTY on F8", PieceType.EMPTY, board.PieceAt(Square.F8));
		assertEquals("Should be EMPTY on G8", PieceType.EMPTY, board.PieceAt(Square.G8));
		assertEquals("Should be BR on H8", PieceType.BR, board.PieceAt(Square.H8));
		assertEquals("Castling should be on for Black", 
					 Castle.All,
					 board.Castling);
		assertEquals("BRC should be 1", 1, board.BRC);
		
		delete board;
		delete m;
	}
	
	public function testUndoBlackQueenSideCastling() {
		var board:Board = new Board();
		board.ClearBoard();
		board.PlacePiece(PieceType.BK, Square.E8);
		board.PlacePiece(PieceType.BR, Square.A8);
		board.BRC++;
		
		var move:Number = Square.E8+(Square.C8<<7);
		var m:Move = new Move(PieceType.BK, move);
		
		m.Do(board);
		m.Undo(board);
		
		assertEquals("Should be BR on A8", PieceType.BR, board.PieceAt(Square.A8));
		assertEquals("Should be EMPTY on B8", PieceType.EMPTY, board.PieceAt(Square.B8));
		assertEquals("Should be EMPTY on C8", PieceType.EMPTY, board.PieceAt(Square.C8));
		assertEquals("Should be EMPTY on D8", PieceType.EMPTY, board.PieceAt(Square.D8));
		assertEquals("Should be BK on E8", PieceType.BK, board.PieceAt(Square.E8));
		assertEquals("Castling should be on for Black", 
					 Castle.All,
					 board.Castling);
		assertEquals("BRC should be 1", 1, board.BRC);
		
		delete board;
		delete m;
	}
	
	public function testUndoCapturedPiece()
	{
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.WP, Square.A2);
		board.WPC++;
		board.PlacePiece(PieceType.BP, Square.B3);
		board.BPC++;
		var move:Number = Square.A2+(Square.B3<<7);
		var m:Move = new Move(PieceType.WP, move);
		
		m.Do(board);
		m.Undo(board);
		
		assertEquals("Should be WP on A2", PieceType.WP, board.PieceAt(Square.A2));
		assertEquals("Should be BP on B3", PieceType.BP, board.PieceAt(Square.B3));
		assertEquals("BPC should be 1", 1, board.BPC);
		assertEquals("WPC should be 1", 1, board.WPC);
		
		delete m;
		delete board;
	}
	
	public function testUndoCapturePawnWithKnight()
	{
		var board:Board = new Board();
		
		board.ClearBoard();
		board.PlacePiece(PieceType.WN, Square.F6);
		board.WNC++;
		board.PlacePiece(PieceType.BP, Square.E4);
		board.BPC++;
		var move:Number = Square.F6+(Square.E4<<7);
		var m:Move = new Move(PieceType.WN, move);
		
		m.Do(board);
		m.Undo(board);
		
		assertEquals("Should be BP @ E4", PieceType.BP, board.PieceAt(Square.E4));
		assertEquals("Should be WN @ F6", PieceType.WN, board.PieceAt(Square.F6));
		assertEquals("BPC should be 1", 1, board.BPC);
		assertEquals("WNC should be 1", 1, board.WNC);
		
		delete m;
		delete board;
	}
}
