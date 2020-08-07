import com.saydesign.File;
import com.saydesign.Board;
import com.saydesign.PieceType;
import com.saydesign.Color;
import com.saydesign.Square;
import com.saydesign.Move;
import com.saydesign.Check;
import com.saydesign.Engine;

class com.saydesign.ChessGUI
{
	private var _depth:Number;
	private var _color:Number;
	private var _clicked:Boolean;
	private var _board:Board;
	private var _origin:Number;
	
	public function ChessGUI(board:Board) {
		_depth = 0;
		_color = Color.WHITE;
		_clicked = false;
		_board = board;
	}
	
	private function DelegateToEngine(square:Number):Void 
	{
		_clicked = false;
		var moves:Array = new Array();
		
		_board.GenerateMovesAt(_origin, moves);

		for(var i:Number = 0; i < moves.length; i++)
			if(moves[i]._target == square) {
				var move:Move = moves[i];
				break;
			}						
		
		if(move.Piece != _board.PieceAt(_origin)) {
			//ask user which piece they want to promote to
			// for now we just assign queen
			move.Piece = (move.Piece % 4 == Color.WHITE) ? PieceType.WQ : PieceType.BQ;
		}
		
		DoIt(move);
		delete move;
		delete moves;
		_root.GetBestMoveAndDoIt(_board, _color);
	}
	
	public function SetUpBoard() {
		var s:Number;
		var r:Number;
		
		_depth = -65;
		for(s = Square.A1; s <= Square.H1; s++) {
			for(r = 0; r < 8; r++) {
				_root[("sq"+(10*r+s))].removeMovieClip();
				if((s % 2) == (r % 2))
					_root.attachMovie("WhiteSquare", ("sq"+(10*r+s)), _depth);
				else
					_root.attachMovie("BlackSquare", ("sq"+(10*r+s)), _depth);
				
				_root[("sq"+(10*r+s))]._x = (s % 10) * 50;
				_root[("sq"+(10*r+s))]._y = (8 - r) * 50;
				_root[("sq"+(10*r+s))].onRelease = function() 
				{
					_root._GUI.btnClick();
				}
				_depth++;
			}
		}
		_depth = 0;
		Refresh();
	}
	
	public function btnClick() {
		var square:Number;
		
		square = (Math.floor(_xmouse / 50)) + ((9 - Math.floor(_ymouse / 50)) * 10);
	
		if(!_clicked) {
			if(IsColorToMoveAt(square)) {
				HighlightLegalMoves(square);
				_clicked = true
			}
		}
		else if(_root[("ol"+square)] != undefined) {
			ClearClips("ol");
			ClearClips("hl");
			_clicked = false;
		}			
		else if(_clicked) {
			if(LegalMove(square))
				DelegateToEngine(square);
			else if(IsColorToMoveAt(square))
				HighlightLegalMoves(square);				
		}		
	}
	
	public function DoIt(move:Move):Void
	{		
		ClearClips("ol");
		ClearClips("hl");
		OutlineSquare(move.Origin);
		OutlineSquare(move.Target);
		_root.invalidate();
		move.Do(_board);
		_color = (_color == Color.WHITE) ? Color.BLACK : Color.WHITE;
		Refresh();
	}
	
	private function HighlightLegalMoves(square:Number):Void {
		var moves:Array = new Array();
		
		ClearClips("hl");
		ClearClips("ol");
		OutlineSquare(square);
		_origin = square;
		_board.GenerateMovesAt(_origin, moves);
		
		var upper:Number = moves.length;
		var i:Number;
		for(i = 0; i < upper; i++) {
			if(Check.InCheck2(_board, _color, moves[i]))
				continue;
			if(_root[("hl"+moves[i].Target)] != undefined)
				continue; 
				
			_root.attachMovie("HIGHLIGHT", 
							  "hl"+moves[i].Target,
							  _depth);
			_depth = (_depth == 500) ? 0 : _depth + 1;
			_root[("hl"+moves[i].Target)]._x 
			 = (moves[i].Target % 10) * 50;
			_root[("hl"+moves[i].Target)]._y 
			 = (9 - Math.floor(moves[i].Target/10)) * 50;
			_root[("hl"+moves[i].Target)]._alpha = 35;			 
		}
		delete moves;
	}
	
	private function LegalMove(square:Number):Boolean {
		if(_root[("hl"+square)] != undefined)
			return true;
	}
	
	private function OutlineSquare(square:Number) {
		_root.attachMovie("OUTLINE", ("ol"+square), _depth);
		_depth = (_depth == 500) ? 0 : _depth + 1;
		_root[("ol"+square)]._x = (square % 10) * 50;
		_root[("ol"+square)]._y = (9 - Math.floor(square/10)) * 50;
	}
	
	public function ClearClips(type:String) {
		var s:Number;
		var r:Number;
		
		for(s = Square.A1; s <= Square.H1; s++)
			for(r = 0; r < 8; r++)
				_root[(type+(10*r+s))].removeMovieClip();
	}
	
	public function setColor(value:Number):Void {
		_color = value;
	}
	
	private function IsColorToMoveAt(square:Number):Boolean {
		return _root[(String(_color)+square)] != undefined;
	}

	public function Refresh():Void
	{
		var s:Number;
		var r:Number;
		
		for(s = Square.A1; s <= Square.H1; s++) {
			for(r = 0; r < 8; r++) {
				ClearPieceAt(10*r+s);
				if(_board.PieceAt(10*r+s) == PieceType.EMPTY)
					continue;				
				_root.attachMovie(_board.PieceNameAt(10*r+s), 
				 (_board.PieceColorAt(10*r+s)+(10*r+s)), _depth);
				_root[(_board.PieceColorAt(10*r+s)+(10*r+s))]._x = (s % 10) * 50;
				_root[(_board.PieceColorAt(10*r+s)+(10*r+s))]._y = (8 - r) * 50;
				_depth = (_depth == 500) ? 0 : _depth + 1;
			}
		}
	}
	
	private function ClearPieceAt(square:Number):Void {
		_root[("1"+square)].removeMovieClip();
		_root[("2"+square)].removeMovieClip();
	}
}