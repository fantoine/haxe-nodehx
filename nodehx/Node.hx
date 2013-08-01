package nodehx;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;

using Lambda;
using StringTools;
using haxe.macro.Tools;
#end

#if !macro @:build(nodehx.Node.build()) #end
class Node {
	/* Globals properties */

	/**
	 * To require modules. See the Modules section. require isn't actually 
	 * a global but rather local to each module.
	 */
	public static var require(default, null) : String -> Dynamic;
	
	/**
	 * Use the internal require() machinery to look up the location of a module, 
	 * but rather than loading the module, just return the resolved filename.
	 */
	public static var resolve(default, null) : String -> String;
	
	/**
	 * Modules are cached in this object when they are required. By deleting 
	 * a key value from this object, the next require will reload the module.
	 */
	public static var cache(get, set) : Dynamic;
	private static inline function get_cache() : Dynamic { return untyped __js__('require.cache'); }
	private static inline function set_cache(c : Dynamic) : Dynamic { return untyped __js__('require.cache = c'); }
	
	/**
	 * Instruct require on how to handle certain file extensions.
	 * Process files with the extension .sjs as .js:
	 * require.extensions['.sjs'] = require.extensions['.js'];
	 * *Deprecated* In the past, this list has been used to load non-JavaScript 
	 * modules into Node by compiling them on-demand. However, in practice, 
	 * there are much better ways to do this, such as loading modules via some other Node program, 
	 * or compiling them to JavaScript ahead of time.
	 * Since the Module system is locked, this feature will probably never go away. 
	 * However, it may have subtle bugs and complexities that are best left untouched.
	 */
	public static var extensions(get, set) : Dynamic;
	private static inline function get_extensions() : Dynamic { return untyped __js__('require.extensions'); }
	private static inline function set_extensions(e : Dynamic) : Dynamic { return untyped __js__('require.extensions = e'); }
	
	/**
	 * In browsers, the top-level scope is the global scope. 
	 * That means that in browsers if you're in the global scope 
	 * var something will define a global variable. In Node this is different. 
	 * The top-level scope is not the global scope; var something inside a Node 
	 * module will be local to that module.
	 */
	public static var global(default, null) : Dynamic;
	
	/**
	 * Used to print to stdout and stderr. See the console section.
	 */
	public static var console(default, null) : Console;
	
	/**
	 * The process object. See the process object section.
	 */
	public static var process(default, null) : Process;
	
	/**
	 * A reference to the current module. In particular module.exports is the same 
	 * as the exports object. module isn't actually a global but rather local to each module.
	 * See the module system documentation for more information.
	 */
	public static var module(default, null) : Module;
	
	/**
	 * A reference to the module.exports object which is shared between all instances 
	 * of the current module and made accessible through require(). See module system 
	 * documentation for details on when to use exports and when to use module.exports. 
	 * exports isn't actually a global but rather local to each module.
	 * See the module system documentation for more information.
	 * See the module section for more information.
	 */
	public static var exports(get, set) : Dynamic;
	private static inline function get_exports() : Dynamic { return untyped __js__('module.exports'); }
	private static inline function set_exports(e : Dynamic) : Dynamic { return untyped __js__('module.exports = e'); }
	
	/**
	 * The filename of the code being executed. This is the resolved absolute path of this code file. 
	 * For a main program this is not necessarily the same filename used in the command line. 
	 * The value inside a module is the path to that module file.
	 * Example: running node example.js from /Users/mjr
	 * console.log(__filename);
	 * // /Users/mjr/example.js
	 * __filename isn't actually a global but rather local to each module.
	 */
	public static var __filename(get, never) : String;
	private static inline function get___filename() : String { return untyped __js__('__filename'); }
	
	/**
	 * The name of the directory that the currently executing script resides in.
	 * Example: running node example.js from /Users/mjr
	 * console.log(__dirname);
	 * // /Users/mjr
	 * __dirname isn't actually a global but rather local to each module.
	 */
	public static var __dirname(get, never) : String;
	private static inline function get___dirname() : String { return untyped __js__('__dirname'); }
	
	/* Timers module */
	
	/**
	 * To schedule execution of a one-time callback after delay milliseconds. 
	 * Returns a timeoutId for possible use with clearTimeout(). 
	 * Optionally you can also pass arguments to the callback.
	 * It is important to note that your callback will probably not be called in exactly 
	 * delay milliseconds - Node.js makes no guarantees about the exact timing of when 
	 * the callback will fire, nor of the ordering things will fire in. The callback will be 
	 * called as close as possible to the time specified.
	 */
	public static var setTimeout(default, null) : Dynamic -> Int -> ?Array<Dynamic> -> Int;
	
	/**
	 * Prevents a timeout from triggering.
	 */
	public static var clearTimeout(default, null) : Int -> Void;
	
	/**
	 * To schedule the repeated execution of callback every delay milliseconds. 
	 * Returns a intervalId for possible use with clearInterval(). 
	 * Optionally you can also pass arguments to the callback.
	 */
	public static var setInterval(default, null) : Dynamic -> Int -> ?Array<Dynamic> -> Int;
	
	/**
	 * Stops a interval from triggering.
	 */
	public static var clearInterval(default, null) : Int -> Void;
	
	/**
	 * To schedule the "immediate" execution of callback after I/O events callbacks and 
	 * before setTimeout and setInterval . Returns an immediateId for possible use with clearImmediate(). 
	 * Optionally you can also pass arguments to the callback.
	 * Immediates are queued in the order created, and are popped off the queue once per loop iteration. 
	 * This is different from process.nextTick which will execute process.maxTickDepth queued callbacks 
	 * per iteration. setImmediate will yield to the event loop after firing a queued callback to make 
	 * sure I/O is not being starved. While order is preserved for execution, other I/O events may fire 
	 * between any two scheduled immediate callbacks.
	 */
	public static var setImmediate(default, null) : Dynamic -> ?Array<Dynamic> -> Int;
	
	/**
	 * Stops an immediate from triggering.
	 */
	public static var clearImmediate(default, null) : Int -> Void;
	
	
	
	#if !macro
	public static inline function __initNode__() {
		require = untyped __js__('require');
		resolve = untyped __js__('require.resolve');
		global = untyped __js__('global');
		console = untyped __js__('console');
		module = untyped __js__('module');
		process = untyped __js__('process');
		
		setTimeout = untyped __js__('setTimeout');
		clearTimeout = untyped __js__('clearTimeout');
		setInterval = untyped __js__('setInterval');
		clearInterval = untyped __js__('clearInterval');
		setImmediate = untyped __js__('setImmediate');
		clearImmediate = untyped __js__('clearImmediate');
	}
	#end
	
	
	#if macro
	public static var NODE_LIBS : Array<String> = [];
	public static function build() : Array<Field> {
		var fields = Context.getBuildFields();
		
		// Load libs
		var jsonFile = Context.defined("nodehx:require") ? Context.definedValue("nodehx:require") : "nodehx.json";
		var configFile = try Context.resolvePath(jsonFile) catch(e : Dynamic) null;
		if(configFile == null) {
			// Load all available libs in nodehx/*
			for(cp in Context.getClassPath()) {
				var dir = cp + "nodehx";
				if(FileSystem.exists(dir)) {
					for(path in FileSystem.readDirectory(dir)) {
						if(FileSystem.isDirectory(dir + "/" + path))
							NODE_LIBS.push(path);
					}
				}
			}
		} else {
			// Register dependency
			Context.registerModuleDependency("nodehx.Node", configFile);
			
			// Load all specified libs
			try {
				var content = sys.io.File.getContent(configFile);
				var json = haxe.Json.parse(content);
				if(Std.is(json, Array))
					for(entry in cast(json, Array<Dynamic>))
						NODE_LIBS.push(Std.string(entry));
			} catch(e : Dynamic) {
				Context.error("Invalid JSON file : " + Std.string(e), Context.makePosition({ min : 0, max : 0, file : configFile }));
			}
		}
		
		
		// Get modules in specified modules
		var i = 0, done = [];
		while(i < NODE_LIBS.length) {
			var lib = NODE_LIBS[i]; i++;
			if(lib =="" || done.has(lib)) continue;
			done.push(lib);
			
			var path = "nodehx/" + lib;
			for(cp in Context.getClassPath()) {
				if(FileSystem.exists(cp + path)) {
					for(file in FileSystem.readDirectory(cp + path)) {
						if(file.endsWith(".hx")) {
							var types = Context.getModule("nodehx." + lib + "." + file.substr(0, file.length - 3));
							for(type in types) {
								switch(type) {
									case TInst(t, params):
										for(i in t.get().interfaces) {
											if(i.t.get().name == "NodeModule" && i.t.get().pack.join(".") == "nodehx") {
												var newFields = registerModule(type, t.get(), i.params);
												if(newFields != null)
													fields = fields.concat(newFields);
											}
										}
									default: // Nothing to do
								}
							}
						}
					}
				}
			}
		}
		
		// Add init expr if required
		if(_initExprs.length > 0) {
			fields.push({
				name		: "__init__",
				access		: [ APublic, AStatic ],
				kind		: FFun({
					args		: [],
					ret			: macro : Void,
					expr		: macro { __initNode__(); {$a{_initExprs}} },
					params		: [],
				}),
				pos			: Context.currentPos(),
			});
		}
		
		return fields;
	}
	
	private static var _registeredModules = [];
	private static var _initExprs = [];
	private static function registerModule(module : Type, type : ClassType, params : Array<Type>) : Array<Field> {
		var require = switch(params[0]) {
			case TInst(t, p) if (t.toString().charAt(0) == "S"):
				t.toString().substr(1);
			default:
				type.name;
		}
		var name = new EReg("[^a-zA-Z_]", "g").replace(require, "");
		
		if(_registeredModules.has(name)) return null;
		_registeredModules.push(name);
		
		// Get dependencies
		var dependencies = switch(params[1]) {
			case TInst(t, p) if (t.toString().charAt(0) == "S"):
				t.toString().substr(1).split(",");
			default:
				[];
		}
		NODE_LIBS = NODE_LIBS.concat(dependencies);
		
		// Get init exprs
		var types = switch(params[2]) {
			case TInst(t, p) if (t.toString().charAt(0) == "S"):
				t.toString().substr(1).split(",");
			default:
				[];
		}
		var getter = 'get_$name';
		var subtypes = [
			for(sub in types.map(function(s) return s.trim()))
				if(sub.length > 0)
					macro untyped nodehx.$name.$sub = nodehx.Node.$getter().$sub
		];
		if(subtypes.length > 0) {
			subtypes.unshift(macro untyped if(nodehx.$name == null) nodehx.$name = {});
			_initExprs = _initExprs.concat(subtypes);
		}
		
		// Define module constant
		Compiler.define('nodehx_$name');
		
		// Add fast require getter
		var mname = Context.makeExpr(require, Context.currentPos());
		return [
			{
				name		: name,
				access		: [ APublic, AStatic ],
				kind		: FProp("get", "null", module.toComplexType(), macro null),
				pos			: Context.currentPos(),
				meta		: [ { name : ":isVar", params: [], pos : Context.currentPos() } ],
			},
			{
				name		: 'get_$name',
				access		: [ APrivate, AStatic ],
				kind		: FFun({
					args		: [],
					ret 		: module.toComplexType(),
					expr		: macro { 
						if($i{name} == null) $i{name} = Node.require($mname); 
						return $i{name}; 
					},
					params		: [],
				}),
				pos			: Context.currentPos(),
			},
		];
	}
	#end
}

/**
 * Node module interface
 */
extern interface NodeModule<Const, Const, Const> {}