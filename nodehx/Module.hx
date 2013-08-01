package nodehx;

/**
 * In each module, the module free variable is a reference to the object representing the current module. 
 * In particular module.exports is accessible via the exports module-global. module isn't actually a global 
 * but rather local to each module.
 */
extern class Module {
	/**
	 * The module.exports object is created by the Module system. Sometimes this is not acceptable, 
	 * many want their module to be an instance of some class. To do this assign the desired export 
	 * object to module.exports. For example suppose we were making a module called a.js
	 * var EventEmitter = require('events').EventEmitter;
	 * module.exports = new EventEmitter();
	 * // Do some work, and after some time emit
	 * // the 'ready' event from the module itself.
	 * setTimeout(function() {
	 *   module.exports.emit('ready');
	 * }, 1000);
	 * Then in another file we could do
	 * var a = require('./a');
	 * a.on('ready', function() {
	 *   console.log('module a is ready');
	 * });
	 * Note that assignment to module.exports must be done immediately. It cannot be done in any callbacks. 
	 * This does not work:
	 * x.js:
	 * setTimeout(function() {
	 *   module.exports = { a: "hello" };
	 * }, 0);
	 * y.js:
	 * var x = require('./x');
	 * console.log(x.a);
	 */
	public var exports(default, null) : Dynamic;
	
	/**
	 * The identifier for the module. Typically this is the fully resolved filename.
	 */
	public var id(default, null) : String;
	
	/**
	 * The fully resolved filename to the module.
	 */
	public var filename(default, null) : String;
	
	/**
	 * Whether or not the module is done loading, or is in the process of loading.
	 */
	public var module(default, null) : Bool;
	
	/**
	 * The module that required this one.
	 */
	public var parent(default, null) : Module;
	
	/**
	 * The module objects required by this one.
	 */
	public var children(default, null) : Array<Module>;
	
	/**
	 * The module.require method provides a way to load a module as if require() was called from the original module.
	 * Note that in order to do this, you must get a reference to the module object. 
	 * Since require() returns the module.exports, and the module is typically only available within a specific module's code, 
	 * it must be explicitly exported in order to be used.
	 */
	public function require(id : String) : Dynamic;
}