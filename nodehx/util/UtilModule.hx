package nodehx.util;
import nodehx.Error;
import nodehx.stream.Readable;
import nodehx.stream.Writable;

/**
 * These functions are in the module "util". Use require("util") to access
 * them.
 */
extern class UtilModule implements nodehx.Node.NodeModule<"util", "stream", ""> {
	/**
	 * Returns a formatted string using the first argument as a printf-like format.
	 * The first argument is a string that contains zero or more placeholders.
	 * Each placeholder is replaced with the converted value from its corresponding
	 * argument. Supported placeholders are:
	 * %s - String.
	 * %d - Number (both integer and float).
	 * %j - JSON.
	 * % - single percent sign ("%"). This does not consume an argument.
	 * If the placeholder does not have a corresponding argument, the placeholder is
	 * not replaced.
	 * util.format("%s:%s", "foo"); // "foo:%s"
	 * If there are more arguments than placeholders, the extra arguments are
	 * converted to strings with util.inspect() and these strings are concatenated,
	 * delimited by a space.
	 * util.format("%s:%s", "foo", "bar", "baz"); // "foo:bar baz"
	 * If the first argument is not a format string then util.format() returns
	 * a string that is the concatenation of all its arguments separated by spaces.
	 * Each argument is converted to a string with util.inspect().
	 * util.format(1, 2, 3); // "1 2 3"
	 */
	@:overload(function(format : String) : Void {})
	@:overload(function(format : String, argument1 : Dynamic) : Void {})
	@:overload(function(format : String, argument1 : Dynamic, argument2 : Dynamic) : Void {})
	@:overload(function(format : String, argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic) : Void {})
	@:overload(function(format : String, argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic) : Void {})
	public function format(format : String, argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic, argument5 : Dynamic) : Void;

	/**
	 * A synchronous output function. Will block the process, cast each argument to a
	 * string then output to stdout. Does not place newlines after each argument.
	 */
	@:overload(function() : Void {})
	@:overload(function(argument1 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic) : Void {})
	public function print(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic, argument5 : Dynamic) : Void;

	/**
	 * Read the data from readableStream and send it to the writableStream.
	 * When writableStream.write(data) returns false readableStream will be
	 * paused until the drain event occurs on the writableStream. callback gets
	 * an error as its only argument and is called when writableStream is closed or
	 * when an error occurs.
	 */
	public function pump(readableStream : Readable, writableStream : Writable, ?callback : Error -> Void) : Void;

	/**
	 * Same as util.debug() except this will output all arguments immediately to
	 * stderr.
	 */
	@:overload(function() : Void {})
	@:overload(function(argument1 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic) : Void {})
	public function error(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic, argument5 : Dynamic) : Void;

	/**
	 * Returns true if the given 'object' is an Array. false otherwise.
	 * var util = require("util");
	 * util.isArray([])
	 *   // true
	 * util.isArray(new Array)
	 *   // true
	 * util.isArray({})
	 *   // false
	 */
	public function isArray(object : Dynamic) : Bool;

	/**
	 * Returns true if the given 'object' is a RegExp. false otherwise.
	 * var util = require("util");
	 * util.isRegExp(/some regexp/)
	 *   // true
	 * util.isRegExp(new RegExp("another regexp"))
	 *   // true
	 * util.isRegExp({})
	 *   // false
	 */
	public function isRegExp(object : Dynamic) : Bool;

	/**
	 * Output with timestamp on stdout.
	 * require("util").log("Timestamped message.");
	 */
	public function log(string : String) : Void;

	/**
	 * Returns true if the given 'object' is a Date. false otherwise.
	 * var util = require("util");
	 * util.isDate(new Date())
	 *   // true
	 * util.isDate(Date())
	 *   // false (without "new" returns a String)
	 * util.isDate({})
	 *   // false
	 */
	public function isDate(object : Dynamic) : Bool;

	/**
	 * A synchronous output function. Will block the process and output all arguments
	 * to stdout with newlines after each argument.
	 */
	@:overload(function() : Void {})
	@:overload(function(argument1 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic) : Void {})
	@:overload(function(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic) : Void {})
	public function puts(argument1 : Dynamic, argument2 : Dynamic, argument3 : Dynamic, argument4 : Dynamic, argument5 : Dynamic) : Void;

	/**
	 * Return a string representation of object, which is useful for debugging.
	 * An optional options object may be passed that alters certain aspects of the
	 * formatted string:
	 * showHidden - if true then the object"s non-enumerable properties will be
	 * shown too. Defaults to false.
	 * depth - tells inspect how many times to recurse while formatting the
	 * object. This is useful for inspecting large complicated objects. Defaults to
	 * 2. To make it recurse indefinitely pass null.
	 * colors - if true, then the output will be styled with ANSI color codes.
	 * Defaults to false. Colors are customizable, see below.
	 * customInspect - if false, then custom inspect() functions defined on the
	 * objects being inspected won"t be called. Defaults to true.
	 * Example of inspecting all properties of the util object:
	 * var util = require("util");
	 * console.log(util.inspect(util, { showHidden: true, depth: null }));
	 */
	public function inspect(object : Dynamic, ?options : Dynamic) : String;

	/**
	 * Inherit the prototype methods from one
	 * constructor
	 * into another.  The prototype of constructor will be set to a new
	 * object created from superConstructor.
	 * As an additional convenience, superConstructor will be accessible
	 * through the constructor.super_ property.
	 * var util = require('util');
	 * var events = require('events');
	 * function MyStream() {
	 *     events.EventEmitter.call(this);
	 * }
	 * util.inherits(MyStream, events.EventEmitter);
	 * MyStream.prototype.write = function(data) {
	 *     this.emit('data', data);
	 * }
	 * var stream = new MyStream();
	 * console.log(stream instanceof events.EventEmitter); // true
	 * console.log(MyStream.super_ === events.EventEmitter); // true
	 * stream.on('data', function(data) {
	 *     console.log("Received data: '" + data + "'");
	 * })
	 * stream.write('It works!'); // Received data: 'It works!'
	 */
	public function inherits(constructor : Dynamic, superConstructor : Dynamic) : Void;

	/**
	 * A synchronous output function. Will block the process and
	 * output string immediately to stderr.
	 * require("util").debug("message on stderr");
	 */
	public function debug(string : String) : Void;

	/**
	 * Returns true if the given 'object' is an Error. false otherwise.
	 * var util = require("util");
	 * util.isError(new Error())
	 *   // true
	 * util.isError(new TypeError())
	 *   // true
	 * util.isError({ name: "Error", message: "an error occurred" })
	 *   // false
	 */
	public function isError(object : Dynamic) : Bool;

}
