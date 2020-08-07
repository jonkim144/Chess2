import com.saydesign.Move;

class com.saydesign.EndGameException
{
	private var _move:Move;
	private var _message:String;
	
	private function EndGameException(move:Move, message:String)
	{ 
		_move = move;
		_message = message;
	}

	public static function CheckmateYouWin():EndGameException {
		return new EndGameException(null, "Checkmate! You win!");
	}
	
	public static function CheckmateComputerWins(move:Move):EndGameException {
		if(move == null)
			throw("Move is null for checkmate computer wins!");
		return new EndGameException(move, "Checkmate! Computer wins!");
	}
	
	public static function StalemateCausedByHuman():EndGameException {
		return new EndGameException(null, "Stalemate!");
	}
	
	public static function StalemateCausedByComputer(move:Move):EndGameException {
		if(move == null)
			throw("Move is null for stalemate caused by computer!");
		return new EndGameException(move, "Stalemate!");
	}
	
	public function Message():String {
		if(_message == null)
			throw("Message is null");
		return _message;
	}
	
	public function HasMove():Boolean {
		return (_move != null);
	}
	
	public function Move():Move {
		if(_move == null)
			throw("Move is null");
		return _move;
	}
}
	