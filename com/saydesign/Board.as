import com.saydesign.Square;
import com.saydesign.Piece;
import com.saydesign.PieceType;
import com.saydesign.Color;
import com.saydesign.File;
import com.saydesign.Castle;
import com.saydesign.pieces.*;

class com.saydesign.Board
{
	public var _board:Array;
	private var _enPassant:Number;
	private var _castling:Number;
	private var _BKPosition:Number;
	private var _WKPosition:Number;
	private var _wpc:Number;
	private var _bpc:Number;
	private var _wnc:Number;
	private var _bnc:Number;
	private var _wbc:Number;
	private var _bbc:Number;
	private var _wrc:Number;
	private var _brc:Number;
	private var _wqc:Number;
	private var _bqc:Number;

	public function Board()
	{
		_board = new Array(100);
		ResetBoard();
	}
	
	public function ResetBoard():Void { 
		var i:Number;
		
		for(i = 0; i < 10; i++) {
			_board[i] = PieceType.BOGUS;
			_board[i+90] = PieceType.BOGUS;
		}
		for(i = 10; i < 90; i+=10) {
			_board[i] = PieceType.BOGUS;
			_board[i+9] = PieceType.BOGUS;
		}
		_board[Square.A1] = PieceType.WR;
		_board[Square.B1] = PieceType.WN;
		_board[Square.C1] = PieceType.WB;
		_board[Square.D1] = PieceType.WQ;
		_board[Square.E1] = PieceType.WK;
		_board[Square.F1] = PieceType.WB;
		_board[Square.G1] = PieceType.WN;
		_board[Square.H1] = PieceType.WR;
		
		_board[Square.A8] = PieceType.BR;
		_board[Square.B8] = PieceType.BN;
		_board[Square.C8] = PieceType.BB;
		_board[Square.D8] = PieceType.BQ;
		_board[Square.E8] = PieceType.BK;
		_board[Square.F8] = PieceType.BB;
		_board[Square.G8] = PieceType.BN;
		_board[Square.H8] = PieceType.BR;
		
		for(i = Square.A2; i <= Square.H2; i++) {
			_board[i] = PieceType.WP;
			_board[i+50] = PieceType.BP;
		}
		
		for(i = Square.A3; i <= Square.H3; i++) {
			_board[i] = PieceType.EMPTY;
			_board[i+10] = PieceType.EMPTY;
			_board[i+20] = PieceType.EMPTY;
			_board[i+30] = PieceType.EMPTY;
		}
		
		_enPassant = null;
		_castling = Castle.All;
		_BKPosition = Square.E8;
		_WKPosition = Square.E1;
		_wpc = 8;
		_bpc = 8;
		_wnc = 2;
		_bnc = 2;
		_wbc = 2;
		_bbc = 2;
		_wrc = 2;
		_brc = 2;
		_wqc = 1;
		_bqc = 1;
	}
	
	public function PieceAt(square:Number):Number {
		return _board[square];
	}
	
	public function PieceColorAt(square:Number):String {
		return String(_board[square] % 4);
	}
	public function PieceNameAt(square:Number):String {
		switch(_board[square])
		{
			case PieceType.WP:
				return "WP";
			case PieceType.WN:
				return "WN";
			case PieceType.WB:
				return "WB";
			case PieceType.WR:
				return "WR";
			case PieceType.WQ:
				return "WQ";
			case PieceType.WK:
				return "WK";
			case PieceType.BP:
				return "BP";
			case PieceType.BN:
				return "BN";
			case PieceType.BB:
				return "BB";
			case PieceType.BR:
				return "BR";
			case PieceType.BQ:
				return "BQ";
			case PieceType.BK:
				return "BK";
			case PieceType.EMPTY:
				return "EMPTY";
			default:
				throw("Invalid piece name type!");
		}
		return "BLAH";
	}	
	
	public function get Castling():Number {
		return _castling;
	}
	
	public function set Castling(value:Number) {
		_castling = value;
	}
	
	public function get EnPassant():Number {
		return _enPassant;
	}

	public function set EnPassant(value:Number):Void {
		_enPassant = value;
	}
	
	public function ClearBoard():Void { 
		var s:Number;
		var r:Number;
		
		for(s = Square.A1; s <= Square.H1; s++) {
			for(r = 0; r < 8; r++) {
				ClearAt(10*r+s);
			}
		}
		_wpc=_bpc=_wnc=_bnc=_wbc=_bbc=_wrc=_brc=_wqc=_bqc=0;
	}
	
	public function GenerateAllMoves(color:Number, moves:Array):Void {
		var s:Number;
		
		for(s = Square.A1; s <= Square.H8; s++)
			if(_board[s] % 4 == color)
				GenerateMovesAt(s, moves);
	}
	
	public function GenerateMovesAt(square:Number, moves:Array):Void {
		switch(_board[square])
		{
			case PieceType.WP:
			case PieceType.BP:
				Pawn.GenerateMovesAt(this, square, moves);
				break;
			case PieceType.WN:
			case PieceType.BN:
				Knight.GenerateMovesAt(this, square, moves);
				break;
			case PieceType.WB:
			case PieceType.BB:
				Bishop.GenerateMovesAt(this, square, moves);
				break;
			case PieceType.WR:
			case PieceType.BR:
				Rook.GenerateMovesAt(this, square, moves);
				break;
			case PieceType.WQ:
			case PieceType.BQ:
				Queen.GenerateMovesAt(this, square, moves);
				break;
			case PieceType.WK:
			case PieceType.BK:
				King.GenerateMovesAt(this, square, moves);
				break;
			case PieceType.EMPTY:
			case PieceType.BOGUS:
				break;
			default:
				throw("Invalid piece type!");
		}
	}	
	
	public function ClearAt(square:Number):Void {
		_board[square] = PieceType.EMPTY;
	}

	public function PlacePiece(type:Number, square:Number):Void {
		_board[square] = type;
	}
	
	public function get BKPosition():Number
	{
		return _BKPosition;
	}
	public function set BKPosition(target:Number):Void
	{
		_BKPosition = target;
	}
	
	public function get WKPosition():Number
	{
		return _WKPosition;
	}
	public function set WKPosition(target:Number)
	{
		_WKPosition = target;
	}
	
	public function KingPosition(color:Number):Number
	{
		return (color == Color.WHITE) ? _WKPosition : _BKPosition;
	}
	public function setKingPosition(color:Number, target:Number):Void
	{
		if(color == Color.WHITE)
			_WKPosition = target;
		else 
			_BKPosition = target;		
	}
	
	public function AddPieceCount(piece:Number, promotion:Boolean):Void {
		if(promotion == true) {
			if(piece % 4 == Color.WHITE)
				SubtractPieceCount(PieceType.WP);
			else
				SubtractPieceCount(PieceType.BP);
		}
		switch(piece) {
			case PieceType.WP:
				_wpc++;
				break;
			case PieceType.BP:
				_bpc++;
				break;
			case PieceType.WN:
				_wnc++;
				break;
			case PieceType.BN:
				_bnc++;
				break;
			case PieceType.WB:
				_wbc++;
				break;
			case PieceType.BB:
				_bbc++;
				break;
			case PieceType.WR:
				_wrc++;
				break;
			case PieceType.BR:
				_brc++;
				break;
			case PieceType.WQ:
				_wqc++;
				break;
			case PieceType.BQ:
				_bqc++;
				break;
			default:
		}
	}
	
	public function SubtractPieceCount(piece:Number, promotion:Boolean):Void {
		if(promotion == true) {
			if(piece % 4 == Color.WHITE)
				AddPieceCount(PieceType.WP);
			else
				AddPieceCount(PieceType.BP);
		}
		switch(piece) {
			case PieceType.WP:
				_wpc--;
				break;
			case PieceType.BP:
				_bpc--;
				break;
			case PieceType.WN:
				_wnc--;
				break;
			case PieceType.BN:
				_bnc--;
				break;
			case PieceType.WB:
				_wbc--;
				break;
			case PieceType.BB:
				_bbc--;
				break;
			case PieceType.WR:
				_wrc--;
				break;
			case PieceType.BR:
				_brc--;
				break;
			case PieceType.WQ:
				_wqc--;
				break;
			case PieceType.BQ:
				_bqc--;
				break;
			default:
		}
	}
	
	public function get WPC():Number {
		return _wpc;
	}
	public function get BPC():Number {
		return _bpc;
	}
	public function get WNC():Number {
		return _wnc;
	}
	public function get BNC():Number {
		return _bnc;
	}
	public function get WBC():Number {
		return _wbc;
	}
	public function get BBC():Number {
		return _bbc;
	}
	public function get WRC():Number {
		return _wrc;
	}
	public function get BRC():Number {
		return _brc;
	}
	public function get WQC():Number {
		return _wqc;
	}
	public function get BQC():Number {
		return _bqc;
	}
	public function set WPC(value:Number):Void {
		_wpc = value;
	}
	public function set BPC(value:Number):Void {
		_bpc = value;
	}
	public function set WNC(value:Number):Void {
		_wnc = value;
	}
	public function set BNC(value:Number):Void {
		_bnc = value;
	}
	public function set WBC(value:Number):Void {
		_wbc = value;
	}
	public function set BBC(value:Number):Void {
		_bbc = value;
	}
	public function set WRC(value:Number):Void {
		_wrc = value;
	}
	public function set BRC(value:Number):Void {
		_brc = value;
	}
	public function set WQC(value:Number):Void {
		_wqc = value;
	}
	public function set BQC(value:Number):Void {
		_bqc = value;
	}
}