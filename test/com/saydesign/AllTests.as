import test.com.saydesign.*;
import as2unit.framework.*;
import as2unit.utils.*;

class test.com.saydesign.AllTests
{	
	private var TestPieceTypeRef:TestPieceType;
	private var TestPawnMovesRef:TestPawnMoves;
	private var TestKnightMovesRef:TestKnightMoves;
	private var TestBishopMovesRef:TestBishopMoves;
	private var TestRookMovesRef:TestRookMoves;
	private var TestQueenMovesRef:TestQueenMoves;
	private var TestKingMovesRef:TestKingMoves;
	private var TestBoardRef:TestBoard;
	private var TestMoveRef:TestMove;
	private var TestCheckRef:TestCheck;
	private var TestEngineRef:TestEngine;
	private var TestEndGameExceptionRef:TestEndGameException;
	//private var TestPerformanceRef:TestPerformance;	
	
	public function test():TestSuite
	{
		var testSuite:TestSuite = new TestSuite();
		addTest(testSuite, "test.com.saydesign.TestPieceType");
		addTest(testSuite, "test.com.saydesign.TestPawnMoves");
		addTest(testSuite, "test.com.saydesign.TestKnightMoves");
		addTest(testSuite, "test.com.saydesign.TestBishopMoves");
		addTest(testSuite, "test.com.saydesign.TestRookMoves");
		addTest(testSuite, "test.com.saydesign.TestQueenMoves");
		addTest(testSuite, "test.com.saydesign.TestKingMoves");
		addTest(testSuite, "test.com.saydesign.TestBoard");
		addTest(testSuite, "test.com.saydesign.TestMove");
		addTest(testSuite, "test.com.saydesign.TestCheck");
		addTest(testSuite, "test.com.saydesign.TestEngine");
		addTest(testSuite, "test.com.saydesign.TestEndGameException");
		//addTest(testSuite, "test.com.saydesign.TestPerformance");
		return testSuite;
	}	
	
	private function addTest(testSuite:TestSuite, className:String)
	{
		var theClass = Runtime.findClass(className);
		testSuite.addTest(new TestSuite(theClass));
	}
}