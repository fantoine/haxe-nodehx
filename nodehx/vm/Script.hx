package nodehx.vm;

/**
 * A class for running scripts.  Returned by vm.createScript.
 */
extern class Script {
	/**
	 * Similar to vm.runInThisContext but a method of a precompiled Script object.
	 * script.runInThisContext runs the code of script and returns the result.
	 * Running code does not have access to local scope, but does have access to the global object
	 * (v8: in actual context).
	 * Example of using script.runInThisContext to compile code once and run it multiple times:
	 * var vm = require("vm");
	 * globalVar = 0;
	 * var script = vm.createScript("globalVar += 1", "myfile.vm");
	 * for (var i = 0; i < 1000 ; i += 1) {
	 *   script.runInThisContext();
	 * }
	 * console.log(globalVar);
	 * // 1000
	 */
	public function runInThisContext() : Dynamic;

	/**
	 * Similar to vm.runInNewContext a method of a precompiled Script object.
	 * script.runInNewContext runs the code of script with sandbox as the global object and returns the result.
	 * Running code does not have access to local scope. sandbox is optional.
	 * Example: compile code that increments a global variable and sets one, then execute this code multiple times.
	 * These globals are contained in the sandbox.
	 * var util = require("util"),
	 *     vm = require("vm"),
	 *     sandbox = {
	 *       animal: "cat",
	 *       count: 2
	 *     };
	 * var script = vm.createScript("count += 1; name = 'kitty'", "myfile.vm");
	 * for (var i = 0; i < 10 ; i += 1) {
	 *   script.runInNewContext(sandbox);
	 * }
	 * console.log(util.inspect(sandbox));
	 * // { animal: "cat", count: 12, name: "kitty" }
	 * Note that running untrusted code is a tricky business requiring great care.  To prevent accidental
	 * global variable leakage, script.runInNewContext is quite useful, but safely running untrusted code
	 * requires a separate process.
	 */
	public function runInNewContext(?sandbox : Dynamic) : Dynamic;

}
