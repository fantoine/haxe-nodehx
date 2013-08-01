package nodehx;

/**
 * For printing to stdout and stderr. Similar to the console object functions provided 
 * by most web browsers, here the output is sent to stdout or stderr.
 * The console functions are synchronous when the destination is a terminal or a file 
 * (to avoid lost messages in case of premature exit) and asynchronous when it's a pipe 
 * (to avoid blocking for long periods of time).
 * That is, in the following example, stdout is non-blocking while stderr is blocking:
 * $ node script.js 2> error.log | tee info.log
 * In daily use, the blocking/non-blocking dichotomy is not something you should worry 
 * about unless you log huge amounts of data.
 */
extern class Console {
	/**
	 * Prints to stdout with newline. This function can take multiple arguments in 
	 * a printf()-like way. Example:
	 * console.log('count: %d', count);
	 * If formatting elements are not found in the first string then util.inspect is used 
	 * on each argument. See util.format() for more information.
	 */
	@:overload(function(data : String) : Void {})
	@:overload(function(data : String, a1 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic) : Void {})
	public function log(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic, a5 : Dynamic) : Void;
	
	/**
	 * Same as console.log.
	 */
	@:overload(function(data : String) : Void {})
	@:overload(function(data : String, a1 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic) : Void {})
	public function info(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic, a5 : Dynamic) : Void;
	
	/**
	 * Same as console.log but prints to stderr.
	 */
	@:overload(function(data : String) : Void {})
	@:overload(function(data : String, a1 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic) : Void {})
	public function error(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic, a5 : Dynamic) : Void;
	
	/**
	 * Same as console.error.
	 */
	@:overload(function(data : String) : Void {})
	@:overload(function(data : String, a1 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic) : Void {})
	@:overload(function(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic) : Void {})
	public function warn(data : String, a1 : Dynamic, a2 : Dynamic, a3 : Dynamic, a4 : Dynamic, a5 : Dynamic) : Void;
	
	/**
	 * Mark a time.
	 */
	public function time(label : String) : Void;
	
	/**
	 * Finish timer, record output. Example:
	 * console.time('100-elements');
	 * for (var i = 0; i < 100; i++) {
	 *   ;
	 * }
	 * console.timeEnd('100-elements');
	 */
	public function timeEnd(label : String) : Void;
	
	/**
	 * Uses util.inspect on obj and prints resulting string to stdout.
	 */
	public function dir(obj : Dynamic) : Void;
	
	/**
	 * Print a stack trace to stderr of the current position.
	 */
	public function trace(label : String) : Void;
	
	/**
	 * Same as assert.ok() where if the expression evaluates 
	 * as false throw an AssertionError with message.
	 */
	public function assert(expression : Dynamic, ?message : String) : Void;
}