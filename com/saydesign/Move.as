import com.saydesign.Square;
import com.saydesign.Piece;
import com.saydesign.Board;
import com.saydesign.Color;
import com.saydesign.Castle;
import com.saydesign.PieceType;
import com.saydesign.pieces.*;

class com.saydesign.Move
{
	private var _origin:Number;
	private var _target:Number;
	private var _piece:Number;
	private var _captured:Number;
	private var _lastEnPassant:Number;
	private var _lastCastling:Number;
	private var _lastKingPosition:Number;
	private var _promotion:Boolean;
	
	public function Move(piece:Number, move:Number, promotion:Boolean)
	{
		_origin = move&127;
		_target = move>>7;
		_piece = piece;
		_captured = null;
		_lastEnPassant = null;
		_lastCastling = null;
		_lastKingPosition = null;
		_promotion = promotion;
	}
	
	public function Do(board:Board):Void {
		_lastEnPassant = board.EnPassant;
		_lastCastling = board.Castling;
		_lastKingPosition = board.KingPosition(_piece % 4);
		
		//var capture:Boolean = false;
		board.EnPassant = null;
		
		//capture = (board._board[Target.File][Target.Rank] != PieceType.EMPTY)
		_captured = board._board[_target];
		
		switch(_piece)
		{
			case PieceType.WP:
				board._board[_origin] = PieceType.EMPTY;

				if(_target - _origin == 20)
				if(board._board[_target-1] == PieceType.BP
				|| board._board[_target+1] == PieceType.BP)
					board.EnPassant = _target - 10;
		
				if(_origin % 10 != _target % 10) {
					if(board._board[_target] == PieceType.EMPTY) {
						board._board[_target - 10] = PieceType.EMPTY;
						board.BPC--;
						//capture = true;
					}
				}
		
				board._board[_target] = _piece;
				
				break;
			case PieceType.BP:
				//capture = Pawn.Do(board, this);
				
				board._board[_origin] = PieceType.EMPTY;

				if(_origin - _target == 20)
				if(board._board[_target-1] == PieceType.WP
				|| board._board[_target+1] == PieceType.WP)
					board.EnPassant = _target + 10;
		
				if(_origin % 10 != _target % 10) {
					if(board._board[_target] == PieceType.EMPTY) {
						board._board[_target + 10] = PieceType.EMPTY;
						board.WPC--;
						//capture = true;
					}
				}
		
				board._board[_target] = _piece;
				
				break;
			case PieceType.WR:
				board._board[_origin] = PieceType.EMPTY;
				board._board[_target] = _piece;
				if(_origin == Square.A1)
					board.Castling &= ~Castle.WQSide;
				else if(_origin == Square.H1)
					board.Castling &= ~Castle.WKSide;
				break;
			case PieceType.BR:
				board._board[_origin] = PieceType.EMPTY;
				board._board[_target] = _piece;
				if(_origin == Square.A8)
					board.Castling &= ~Castle.BQSide;
				else if(_origin == Square.H8)
					board.Castling &= ~Castle.BKSide;
				break;
			case PieceType.WK:
				board._board[_origin] = PieceType.EMPTY;
				if(Math.abs(_origin - _target) == 2) {
					
					board._board[(_origin+_target)/2] = PieceType.WR;
					
					if(_origin - _target > 0)
						board._board[Square.A1] = PieceType.EMPTY;
					else
						board._board[Square.H1] = PieceType.EMPTY;
				}
		
				board._board[_target] = _piece;
				board.Castling &= ~Castle.White;
				board.setKingPosition(Color.WHITE, _target);
				break;
			case PieceType.BK:
				board._board[_origin] = PieceType.EMPTY;
				if(Math.abs(_origin - _target) == 2) {
					
					board._board[(_origin+_target)/2] = PieceType.BR;
					
					if(_origin - _target > 0)
						board._board[Square.A8] = PieceType.EMPTY;
					else
						board._board[Square.H8] = PieceType.EMPTY;
				}
		
				board._board[_target] = _piece;
				board.Castling &= ~Castle.Black;
				board.setKingPosition(Color.BLACK, _target);
				break;
			default:
				board._board[_origin] = PieceType.EMPTY;
				board._board[_target] = _piece;
		}
		
		board.SubtractPieceCount(_captured);
		if(_promotion)
			board.AddPieceCount(_piece, _promotion);
			
		//return capture;
	}
	
	public function Undo(board:Board):Void {
		board.EnPassant = _lastEnPassant;
		board.Castling = _lastCastling;
		board.setKingPosition(_piece % 4, _lastKingPosition);
		
		switch(_piece)
		{
			case PieceType.WP:
				board._board[_origin] = _piece;
				if(board.EnPassant != null) 
				if(_target % 10 != _origin % 10)
				if(_captured == PieceType.EMPTY) {
					board._board[board.EnPassant-10] = PieceType.BP;
					board.BPC++;
				}
				board._board[_target] = _captured;
				break;
			case PieceType.BP:
				board._board[_origin] = _piece;
				if(board.EnPassant != null) 
				if(_target % 10 != _origin % 10)
				if(_captured == PieceType.EMPTY) {
					board._board[board.EnPassant+10] = PieceType.WP;
					board.WPC++;
				}
				board._board[_target] = _captured;
				break;
			case PieceType.WK:
			
				board._board[_origin] = _piece;
				board._board[_target] = _captured;
		
				// remove and place Rook (undo castling)
				if(Math.abs(_origin - _target) == 2) {
					if(_target == Square.G1) {
						board._board[Square.H1] = PieceType.WR;
						board._board[Square.F1] = PieceType.EMPTY;
					}
					else { // target file is C
						board._board[Square.A1] = PieceType.WR;
						board._board[Square.D1] = PieceType.EMPTY;
					}				
				}
				break;
			case PieceType.BK:
			
				board._board[_origin] = _piece;
				board._board[_target] = _captured;
		
				// remove and place Rook (undo castling)
				if(Math.abs(_origin - _target) == 2) {
					if(_target == Square.G8) {
						board._board[Square.H8] = PieceType.BR;
						board._board[Square.F8] = PieceType.EMPTY;
					}
					else { // target file is C
						board._board[Square.A8] = PieceType.BR;
						board._board[Square.D8] = PieceType.EMPTY;
					}				
				}
				break;
			default:
				if(_promotion == true) {
					Pawn.UndoPromotion(board, this)
					break;
				}
				board._board[_origin] = _piece;
				board._board[_target] = _captured;
		}
		
		board.AddPieceCount(_captured);
		if(_promotion)
			board.SubtractPieceCount(_piece, _promotion);
	}
	
	public function get Origin():Number {
		return _origin;
	}
	
	public function get Target():Number {
		return _target;
	}
	
	public function get Piece():Number {
		return _piece;
	}
	
	public function set Piece(value:Number):Void {
		_piece = value;
	}
	
	public function get CapturedPiece():Number {
		return _captured;
	}
	
	public function set CapturedPiece(value:Number):Void {
		_captured = value;
	}
	
	private function Opposite(piece:Number):Number {
		return piece % 4 == Color.WHITE ? ++piece : --piece;
	}
}