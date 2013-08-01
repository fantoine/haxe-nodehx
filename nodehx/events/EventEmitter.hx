package nodehx.events;

/**
 * To access the EventEmitter class, require("events").EventEmitter.
 * When an EventEmitter instance experiences an error, the typical action is
 * to emit an "error" event.  Error events are treated as a special case in node.
 * If there is no listener for it, then the default action is to print a stack
 * trace and exit the program.
 * All EventEmitters emit the event "newListener" when new listeners are
 * added and "removeListener" when a listener is removed.
 */
extern class EventEmitter {
	/**
	 * Adds a listener to the end of the listeners array for the specified event.
	 * server.on("connection", function (stream) {
	 *   console.log("someone connected!");
	 * });
	 * Returns emitter, so calls can be chained.
	 */
	public function addListener(event : String, listener : Dynamic) : EventEmitter;

	/**
	 * Execute each of the listeners in order with the supplied arguments.
	 * Returns true if event had listeners, false otherwise.
	 */
	@:overload(function(event : String) : Bool {})
	@:overload(function(event : String, arg1 : Dynamic) : Bool {})
	@:overload(function(event : String, arg1 : Dynamic, arg2 : Dynamic) : Bool {})
	@:overload(function(event : String, arg1 : Dynamic, arg2 : Dynamic, argument1 : Dynamic) : Bool {})
	@:overload(function(event : String, arg1 : Dynamic, arg2 : Dynamic, argument1 : Dynamic, argument2 : Dynamic) : Bool {})
	@:overload(function(event : String, arg1 : Dynamic, arg2 : Dynamic, argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic) : Bool {})
	@:overload(function(event : String, arg1 : Dynamic, arg2 : Dynamic, argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic) : Bool {})
	public function emit(event : String, arg1 : Dynamic, arg2 : Dynamic, argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic, argument5 : Dynamic) : Bool;

	/**
	 * Adds a one time listener for the event. This listener is
	 * invoked only the next time the event is fired, after which
	 * it is removed.
	 * server.once("connection", function (stream) {
	 *   console.log("Ah, we have our first user!");
	 * });
	 * Returns emitter, so calls can be chained.
	 */
	public function once(event : String, listener : Dynamic) : EventEmitter;

	/**
	 * Adds a listener to the end of the listeners array for the specified event.
	 * server.on("connection", function (stream) {
	 *   console.log("someone connected!");
	 * });
	 * Returns emitter, so calls can be chained.
	 */
	public function on(event : String, listener : Dynamic) : EventEmitter;

	/**
	 * Removes all listeners, or those of the specified event.
	 * Returns emitter, so calls can be chained.
	 */
	public function removeAllListeners(?event : String) : EventEmitter;

	/**
	 * Remove a listener from the listener array for the specified event.
	 * Caution: changes array indices in the listener array behind the listener.
	 * var callback = function(stream) {
	 *   console.log("someone connected!");
	 * };
	 * server.on("connection", callback);
	 * // ...
	 * server.removeListener("connection", callback);
	 * Returns emitter, so calls can be chained.
	 */
	public function removeListener(event : String, listener : Dynamic) : EventEmitter;

	/**
	 * Returns an array of listeners for the specified event.
	 * server.on("connection", function (stream) {
	 *   console.log("someone connected!");
	 * });
	 * console.log(util.inspect(server.listeners("connection"))); // [ [Function] ]
	 */
	public function listeners(event : String) : Array<Dynamic>;

	/**
	 * By default EventEmitters will print a warning if more than 10 listeners are
	 * added for a particular event. This is a useful default which helps finding memory leaks.
	 * Obviously not all Emitters should be limited to 10. This function allows
	 * that to be increased. Set to zero for unlimited.
	 */
	public function setMaxListeners(n : Int) : Void;

	/**
	 * Return the number of listeners for a given event.
	 */
	public static function listenerCount(emitter : EventEmitter, event : String) : Int;
}
