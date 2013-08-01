package nodehx;

@:native("Error")
extern class Error implements Dynamic {
	public var stack(default, null) : Array<Dynamic>;
	public var arguments(default, null) : Array<Dynamic>;
	public var type(default, null) : Dynamic;
	public var message(default, null) : String;
   
	public function new(?msg : String) : Void;
	
	public static function captureStackTrace(o : Dynamic, c : Dynamic) : Void;
}