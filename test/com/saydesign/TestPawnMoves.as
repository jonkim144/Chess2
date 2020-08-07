import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;
import com.saydesign.PieceType;
import as2unit.framework.TestCase;

class test.com.saydesign.TestPawnMoves extends TestCase
{
	private var _board:Board;
	private var _moves:Array;
	
	public function TestPawnMoves(methodName:String) {
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
	
	public function testFindWPMoveA3A4()
	{
		var s:Number = Square.A3;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, s);
		
		_board.GenerateMovesAt(s, _moves);
					
		assertEquals("Should be only one move", 1, _moves.length);
		assertEquals("Move origin should be on A3", Square.A3, _moves[0].Origin);
		assertEquals("Move target should be on A4", Square.A4, _moves[0].Target);
	}
	
	public function testFindBPMoveA6A5() 
	{
		var s:Number = Square.A6;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.BP, s);
		
		_board.GenerateMovesAt(s, _moves);
				
		assertEquals("Should be only one move", 1, _moves.length);
		assertEquals("Move origin should be on A6", Square.A6, _moves[0].Origin);
		assertEquals("Move target should be on A5", Square.A5, _moves[0].Target);
	}
	
	public function testFailToFindWPMoveA2A3WithBPOnA3() {
		var s:Number = Square.A2;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, Square.A2);
		_board.PlacePiece(PieceType.BP, Square.A3);
		
		_board.GenerateMovesAt(s, _moves);
		
		assertEquals("Should be no _moves", 0, _moves.length);
	}
	
	public function testFailToFindBPMoveA7A6WithWPOnA6() {
		var s:Number = Square.A7;

		_board.ClearBoard();
		_board.PlacePiece(PieceType.BP, Square.A7);
		_board.PlacePiece(PieceType.WP, Square.A6);
		
		_board.GenerateMovesAt(s, _moves);
		
		assertEquals("Should be no _moves", 0, _moves.length);
	}
	
	public function testFindPawnMoveA2A4() {
		var s:Number = Square.A2;
		var found:Boolean = false;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, Square.A2);
	
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++) 
			if(_moves[i].Origin == Square.A2)
			if(_moves[i].Target == Square.A4)
				found = true;							
		
		assertEquals("two-square WP advance not found", true, found);
	}
	
	public function testFindPawnMoveA7A5() {
		var s:Number = Square.A7;
		var found:Boolean = false;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.BP, s);
			
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++) 
			if(_moves[i].Origin == Square.A7)
			if(_moves[i].Target == Square.A5)
				found = true;							
		
		assertEquals("two-square BP advance not found", true, found);
	}
	
	public function testPawnMoveA2A4IntoNonEmptySquareAtA4() {
		var s:Number = Square.A2;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, Square.A2);
		_board.PlacePiece(PieceType.BP, Square.A4);
		
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A2)
			if(_moves[i].Target == Square.A4)
				fail("Should not find move at A4");		
	}
	
	public function testPawnMoveA7A5IntoNonEmptySquareAtA5() {
		var s:Number = Square.A7;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.BP, Square.A7);
		_board.PlacePiece(PieceType.WP, Square.A5);

		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A7)
			if(_moves[i].Target == Square.A5)
				fail("Should not find move at A5");
	}
	
	public function testPawnMoveA2A4ThruNonEmptySquareAtA3() {
		var s:Number = Square.A2;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, Square.A2);
		_board.PlacePiece(PieceType.BP, Square.A3);
		
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A2)
			if(_moves[i].Target == Square.A4)
				fail("Should not find move at A4");		
	}
	
	public function testPawnMoveA7A5ThruNonEmptySquareAtA6() {
		var s:Number = Square.A7;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.BP, Square.A7);
		_board.PlacePiece(PieceType.WP, Square.A6);
		
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A7)
			if(_moves[i].Target == Square.A5)
				fail("Should not find move at A5");
	}
	
	public function testWhitePawnTwoSquareMoveFromNonHomeRankA3() {
		var s:Number = Square.A3;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, Square.A3);
		
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A3)
			if(_moves[i].Target == Square.A5)
				fail("Should not find move at A5");		
	}
	
	public function testBlackPawnTwoSquareMoveFromNonHomeRankA6() {
		var s:Number = Square.A6;
		
		_board.ClearBoard();
		_board.PlacePiece(PieceType.BP, Square.A6);
		
		_board.GenerateMovesAt(s, _moves);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A6)
			if(_moves[i].Target == Square.A4)
				fail("Should not find move at A4");
	}
	
	public function testWhitePawnAttackMoveLeftE4D5() {
		var found:Boolean = false;
		_board.ClearBoard();
		_board.PlacePiece(PieceType.WP, Square.E4);
		_board.PlacePiece(PieceType.BP, Square.D5);
		_board.PlacePiece(PieceType.BP, Square.E5);
		
		_board.GenerateMovesAt(Square.E4, _moves);
		
		assertEquals("Should be exactly 1 move", 1, _moves.length);
		if(_moves[0].Origin == Square.E4)
		if(_moves[0].Target == Square.D5)
			found = true;
			
		if(!found)
			fail("Move E4D5 not found");
	}
	
	public function testWhitePawnAttackMoveLeftOffBoardFromA4() {
		var found:Boolean = false;
		_board.ClearBoard();

		for(var s:Number = Square.A1; s <= Square.H1; s++) 
			for(var r:Number = 0; r < 8; r++)
				_board.PlacePiece(PieceType.BQ, 10*r+s);
				
		_board.PlacePiece(PieceType.WP, Square.A4);
				
		_board.GenerateMovesAt(Square.A4, _moves);

		assertEquals("Should be exactly 1 move", 1, _moves.length);
		if(_moves[0].Origin == Square.A4)
		if(_moves[0].Target == Square.B5)
			found = true;
			
		if(!found)
			fail("Move A4B5 not found");
	}
	
	public function testBlackPawnAttackMoveLeftOffBoardFromA5() {
		var found:Boolean = false;
		_board.ClearBoard();

		for(var s:Number = Square.A1; s <= Square.H1; s++) 
			for(var r:Number = 0; r < 8; r++)
				_board.PlacePiece(PieceType.WQ, 10*r+s);
				
		_board.PlacePiece(PieceType.BP, Square.A5);
		
		_board.GenerateMovesAt(Square.A5, _moves);

		assertEquals("Should be exactly 1 move", 1, _moves.length);
		if(_moves[0].Origin == Square.A5)
		if(_moves[0].Target == Square.B4)
			found = true;
			
		if(!found)
			fail("Move A5B4 not found");
	}
	
	public function testWhitePawnAttackMoveRightOffBoardFromH4() {
		var found:Boolean = false;
		_board.ClearBoard();

		for(var s:Number = Square.A1; s <= Square.H1; s++) 
			for(var r:Number = 0; r < 8; r++)
				_board.PlacePiece(PieceType.BQ, 10*r+s);
				
		_board.PlacePiece(PieceType.WP, Square.H4);
		_board.GenerateMovesAt(Square.H4, _moves);
		
		assertEquals("Should only be one move", 1, _moves.length);
		if(_moves[0].Origin == Square.H4)
		if(_moves[0].Target == Square.G5)
			found = true;
			
		if(!found)
			fail("Move H4G5 not found");	
	}
	
	public function testBlackPawnAttackMoveRightOffBoardFromH4() {
		var found:Boolean = false;
		_board.ClearBoard();

		var s:Number;
		var r:Number;
		for(var s:Number = Square.A1; s <= Square.H1; s++) 
			for(var r:Number = 0; r < 8; r++)
				_board.PlacePiece(PieceType.WQ, 10*r+s);
				
		_board.PlacePiece(PieceType.BP, Square.H4);
		_board.GenerateMovesAt(Square.H4, _moves);
		
		assertEquals("Should only be one move", 1, _moves.length);
		if(_moves[0].Origin == Square.H4)
		if(_moves[0].Target == Square.G3)
			found = true;
			
		if(!found)
			fail("Move H4G3 not found");
	}
	
	public function testWhiteEnPassantG5H6() {
		var found:Boolean = false;
		_board.ClearBoard();

		_board.PlacePiece(PieceType.BP, Square.H7);
		_board.PlacePiece(PieceType.BP, Square.G6);
		_board.PlacePiece(PieceType.WP, Square.G5);

		// G  H
		//       8
		//    BP 7
		// BP    6
		// WP    5

		// make move H7H5 to set up en passant
		var move:Number = Square.H7+(Square.H5<<7);
		var m:Move = new Move(PieceType.BP, move);
		m.Do(_board);
		assertEquals("Should be en passant on H6",
					 Square.H6, _board.EnPassant);
		
		// G  H
		//       8
		//       7
		// BP    6
		// WP BP 5

		_board.GenerateMovesAt(Square.G5, _moves);
	
		assertEquals("Should be exactly 1 move", 1, _moves.length);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.G5)
			if(_moves[i].Target == Square.H6)
				found = true;
				
		if(!found)
			fail("En passant G5H6 not found");
	}	
	
	public function testBlackEnPassantA4B3() {
		var found:Boolean = false;
		_board.ClearBoard();

		_board.PlacePiece(PieceType.BP, Square.A4);
		_board.PlacePiece(PieceType.WP, Square.A3);
		_board.PlacePiece(PieceType.WP, Square.B2);

		// 4 BP     
		// 3 WP    
		// 2    WP 
		// 1     
		//   A  B 
		
		// make move B2B4 to set up en passant
		var move:Number = Square.B2+(Square.B4<<7);
		var m:Move = new Move(PieceType.WP, move);
		m.Do(_board);
		assertEquals("Should be en passant on B3",
					 Square.B3, _board.EnPassant);
		
		// 4 BP WP    
		// 3 WP    
		// 2    
		// 1     
		//   A  B 

		_board.GenerateMovesAt(Square.A4, _moves);
	
		assertEquals("Should be exactly 1 move", 1, _moves.length);
		for(var i:Number = 0; i < _moves.length; i++)
			if(_moves[i].Origin == Square.A4)
			if(_moves[i].Target == Square.B3)
				found = true;
				
		if(!found)
			fail("En passant A4B3 not found");
	}
	
	public function testFindWhitePawnPromtionMoves() {
		var WQFound:Boolean = false;
		var WRFound:Boolean = false;
		var WBFound:Boolean = false;
		var WNFound:Boolean = false;
		
		_board.ClearBoard();
		
		_board.PlacePiece(PieceType.WP, Square.H7);
		_board.GenerateMovesAt(Square.H7, _moves);
		assertEquals("Should be 4 _moves", 4, _moves.length);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Piece == PieceType.WQ)
				WQFound = true;
			else if(_moves[i].Piece == PieceType.WR)
				WRFound = true;
			else if(_moves[i].Piece == PieceType.WB)
				WBFound = true;
			else if(_moves[i].Piece == PieceType.WN)
				WNFound = true;
			
			if(_moves[i].Origin == Square.H7)
			if(_moves[i].Target == Square.H8)
				continue;
			fail("Wrong move: should be H7H8");
		}
		assertTrue("WQ not found", WQFound);
		assertTrue("WR not found", WRFound);
		assertTrue("WB not found", WBFound);
		assertTrue("WN not found", WNFound);
	}
	
	public function testFindBlackPawnPromtionMoves() {
		var BQFound:Boolean = false;
		var BRFound:Boolean = false;
		var BBFound:Boolean = false;
		var BNFound:Boolean = false;
		
		_board.ClearBoard();
		
		_board.PlacePiece(PieceType.BP, Square.A2);
		_board.GenerateMovesAt(Square.A2, _moves);
		assertEquals("Should be 4 _moves", 4, _moves.length);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Piece == PieceType.BQ)
				BQFound = true;
			else if(_moves[i].Piece == PieceType.BR)
				BRFound = true;
			else if(_moves[i].Piece == PieceType.BB)
				BBFound = true;
			else if(_moves[i].Piece == PieceType.BN)
				BNFound = true;
			
			if(_moves[i].Origin == Square.A2)
			if(_moves[i].Target == Square.A1)
				continue;
			fail("Wrong move: should be A2A1");
		}
		assertTrue("BQ not found", BQFound);
		assertTrue("BR not found", BRFound);
		assertTrue("BB not found", BBFound);
		assertTrue("BN not found", BNFound);
	}
	
	public function testFindWhitePawnPromtionAttackRight() {
		var WQFound:Boolean = false;
		var WRFound:Boolean = false;
		var WBFound:Boolean = false;
		var WNFound:Boolean = false;
		
		_board.ClearBoard();
		
		_board.PlacePiece(PieceType.WP, Square.G7);
		_board.PlacePiece(PieceType.WQ, Square.G8);
		_board.PlacePiece(PieceType.BQ, Square.H8);
		
		_board.GenerateMovesAt(Square.G7, _moves);
		assertEquals("Should be 4 _moves", 4, _moves.length);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Piece == PieceType.WQ)
				WQFound = true;
			else if(_moves[i].Piece == PieceType.WR)
				WRFound = true;
			else if(_moves[i].Piece == PieceType.WB)
				WBFound = true;
			else if(_moves[i].Piece == PieceType.WN)
				WNFound = true;
			
			if(_moves[i].Origin == Square.G7)
			if(_moves[i].Target == Square.H8)
				continue;
			fail("Wrong move: should be G7H8");
		}
		assertTrue("WQ not found", WQFound);
		assertTrue("WR not found", WRFound);
		assertTrue("WB not found", WBFound);
		assertTrue("WN not found", WNFound);
	}
	
	public function testFindBlackPawnPromtionAttackRight() {
		var BQFound:Boolean = false;
		var BRFound:Boolean = false;
		var BBFound:Boolean = false;
		var BNFound:Boolean = false;
		
		_board.ClearBoard();
		
		_board.PlacePiece(PieceType.BP, Square.A2);
		_board.PlacePiece(PieceType.BQ, Square.A1);
		_board.PlacePiece(PieceType.WQ, Square.B1);
		
		_board.GenerateMovesAt(Square.A2, _moves);
		assertEquals("Should be 4 _moves", 4, _moves.length);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Piece == PieceType.BQ)
				BQFound = true;
			else if(_moves[i].Piece == PieceType.BR)
				BRFound = true;
			else if(_moves[i].Piece == PieceType.BB)
				BBFound = true;
			else if(_moves[i].Piece == PieceType.BN)
				BNFound = true;
			
			if(_moves[i].Origin == Square.A2)
			if(_moves[i].Target == Square.B1)
				continue;
			fail("Wrong move: should be A2B1");
		}
		assertTrue("BQ not found", BQFound);
		assertTrue("BR not found", BRFound);
		assertTrue("BB not found", BBFound);
		assertTrue("BN not found", BNFound);
	}
	
	public function testFindWhitePawnPromtionAttackLeft() {
		var WQFound:Boolean = false;
		var WRFound:Boolean = false;
		var WBFound:Boolean = false;
		var WNFound:Boolean = false;
		
		_board.ClearBoard();
		
		_board.PlacePiece(PieceType.WP, Square.H7);
		_board.PlacePiece(PieceType.WQ, Square.H8);
		_board.PlacePiece(PieceType.BQ, Square.G8);
		
		_board.GenerateMovesAt(Square.H7, _moves);
		assertEquals("Should be 4 _moves", 4, _moves.length);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Piece == PieceType.WQ)
				WQFound = true;
			else if(_moves[i].Piece == PieceType.WR)
				WRFound = true;
			else if(_moves[i].Piece == PieceType.WB)
				WBFound = true;
			else if(_moves[i].Piece == PieceType.WN)
				WNFound = true;
			
			if(_moves[i].Origin == Square.H7)
			if(_moves[i].Target == Square.G8)
				continue;
			fail("Wrong move: should be H7G8");
		}
		assertTrue("WQ not found", WQFound);
		assertTrue("WR not found", WRFound);
		assertTrue("WB not found", WBFound);
		assertTrue("WN not found", WNFound);
	}
	
	public function testFindBlackPawnPromtionAttackLeft() {
		var BQFound:Boolean = false;
		var BRFound:Boolean = false;
		var BBFound:Boolean = false;
		var BNFound:Boolean = false;
		
		_board.ClearBoard();
		
		_board.PlacePiece(PieceType.BP, Square.B2);
		_board.PlacePiece(PieceType.BQ, Square.B1);
		_board.PlacePiece(PieceType.WQ, Square.A1);
		
		_board.GenerateMovesAt(Square.B2, _moves);
		assertEquals("Should be 4 _moves", 4, _moves.length);
		
		for(var i:Number = 0; i < _moves.length; i++) {
			if(_moves[i].Piece == PieceType.BQ)
				BQFound = true;
			else if(_moves[i].Piece == PieceType.BR)
				BRFound = true;
			else if(_moves[i].Piece == PieceType.BB)
				BBFound = true;
			else if(_moves[i].Piece == PieceType.BN)
				BNFound = true;
			
			if(_moves[i].Origin == Square.B2)
			if(_moves[i].Target == Square.A1)
				continue;
			fail("Wrong move: should be B2A1");
		}
		assertTrue("BQ not found", BQFound);
		assertTrue("BR not found", BRFound);
		assertTrue("BB not found", BBFound);
		assertTrue("BN not found", BNFound);
	}
}