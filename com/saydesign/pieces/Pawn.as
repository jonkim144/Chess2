import com.saydesign.PieceType;
import com.saydesign.Board;
import com.saydesign.Move;
import com.saydesign.Square;
import com.saydesign.Color;

class com.saydesign.pieces.Pawn
{
	private function Pawn()
	{ }
		
	public static function UndoPromotion(board:Board, move:Move):Void
	{
		var color:Number = move.Piece % 4;
		board._board[move.Origin] = MyPawn(color);
		board._board[move.Target] = move.CapturedPiece;
	}
	
	public static function GenerateMovesAt(board:Board, origin:Number, 
										   moves:Array):Void 
	{
		//var t = getTimer();
		
		var myPiece:Number = board._board[origin];
		var myColor:Number = myPiece % 4;
		var inc:Number = (myColor == Color.WHITE) ? 1 : -1;
		var homeRank:Number = (myColor == Color.WHITE) ? 2 : 7;
		
		if(board._board[origin+10*inc] == PieceType.EMPTY) {
			var forwardOne:Number = origin+((10*inc+origin)<<7);
			
			if(Math.floor(origin/10) != homeRank + 5*inc) {
				moves.push(new Move(myPiece, forwardOne));
				if(Math.floor(origin/10) == homeRank) {
					if(board._board[origin+20*inc] == PieceType.EMPTY)
						moves.push(new Move(myPiece, origin+((20*inc+origin)<<7)));  
				}			
			}
			else
				AddPromotionMoves(moves, forwardOne, myColor);
		}
		
		AddAttackMoves(board, moves, origin, origin+11*inc, homeRank, inc);
		AddAttackMoves(board, moves, origin, origin+9*inc, homeRank, inc);
		if(board.EnPassant != null)
			AddEnPassantMoves(board, moves, inc);
			
		//trace("Pawn GenerateMoves: " + (getTimer() - t));
	}
	
	private static function AddAttackMoves(board:Board, moves:Array, 
										   origin:Number, target:Number,
										   homeRank:Number, inc:Number) 
	{		
		var myPiece = board._board[origin];
		var targetPiece = board._board[target];
		if(targetPiece != PieceType.BOGUS)
		if(targetPiece != PieceType.EMPTY)
		if((myPiece % 4) != (targetPiece % 4)) 
		{
			var moveCode:Number = origin+(target<<7);
			
			if(Math.floor(origin/10) != homeRank + 5*inc) {
				moves.push(new Move(myPiece, moveCode)); 
				moves[moves.length-1].CapturedPiece = board._board[target];
			}
			else
				AddPromotionMoves(moves, moveCode, myPiece % 4);
		}
	}
	
	private static function AddPromotionMoves(moves:Array, moveCode:Number, 
											  color:Number):Void
	{		
		if(color == Color.WHITE) {
			moves.push(new Move(PieceType.WQ, moveCode, true));
			moves.push(new Move(PieceType.WR, moveCode, true));
			moves.push(new Move(PieceType.WB, moveCode, true));
			moves.push(new Move(PieceType.WN, moveCode, true));
		} else {
			moves.push(new Move(PieceType.BQ, moveCode, true));
			moves.push(new Move(PieceType.BR, moveCode, true));
			moves.push(new Move(PieceType.BB, moveCode, true));
			moves.push(new Move(PieceType.BN, moveCode, true));
		}
	}
	
	private static function AddEnPassantMoves(board:Board, moves:Array, 
											  inc:Number):Void
	{
		var piece:Number = board._board[board.EnPassant-11*inc];
		var hisPiece:Number = board._board[board.EnPassant-10*inc];
		
		if(piece == Opposite(hisPiece))
		{
			var m:Number = (board.EnPassant-11*inc)+(board.EnPassant<<7);
			moves.push(new Move(piece, m));
			moves[moves.length-1].CapturedPiece = hisPiece;
		}
		
		piece = board._board[board.EnPassant-9*inc];
		if(piece == Opposite(hisPiece))
		{
			var m:Number = (board.EnPassant-9*inc)+(board.EnPassant<<7);
			moves.push(new Move(piece, m));
			moves[moves.length-1].CapturedPiece = hisPiece;
		}
	}
	
	public static function InCheckBy(board:Board, color:Number, 
									 kingPos:Number):Boolean
	{		
		var inc:Number = (color == Color.WHITE) ? 1 : -1;
		if(board._board[kingPos+11*inc] == Opposite(MyPawn(color)))
			return true;
		if(board._board[kingPos+9*inc] == Opposite(MyPawn(color)))
			return true;
		return false;
	}
	
	private static function MyPawn(color:Number):Number {
		return (color == Color.WHITE) ? PieceType.WP : PieceType.BP;
	}
	
	private static function Opposite(piece:Number):Number {
		return piece % 4 == Color.WHITE ? ++piece : --piece;
	}
}