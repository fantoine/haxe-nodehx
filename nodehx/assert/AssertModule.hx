package nodehx.assert;

/**
 * This module is used for writing unit tests for your applications, you can
 * access it with require("assert").
 */
extern class AssertModule implements nodehx.Node.NodeModule<"assert", "", ""> {
	/**
	 * Tests for deep equality.
	 */
	public function deepEqual(actual : Dynamic, expected : Dynamic, ?message : String) : Void;

	/**
	 * Tests strict non-equality, as determined by the strict not equal operator ( !== )
	 */
	public function notStrictEqual(actual : Dynamic, expected : Dynamic, ?message : String) : Void;

	/**
	 * Expects block not to throw an error, see assert.throws for details.
	 */
	public function doesNotThrow(block : Dynamic, ?message : Dynamic) : Void;

	/**
	 * Tests if value is not a false value, throws if it is a true value. Useful when
	 * testing the first argument, error in callbacks.
	 */
	public function ifError(value : Dynamic) : Void;

	/**
	 * Throws an exception that displays the values for actual and expected separated by the provided operator.
	 */
	public function fail(actual : Dynamic, expected : Dynamic, message : String, operator : Dynamic) : Void;

	/**
	 * Tests shallow, coercive non-equality with the not equal comparison operator ( != ).
	 */
	public function notEqual(actual : Dynamic, expected : Dynamic, ?message : String) : Void;

	/**
	 * Tests for any deep inequality.
	 */
	public function notDeepEqual(actual : Dynamic, expected : Dynamic, ?message : String) : Void;

	/**
	 * Expects block to throw an error. error can be constructor, regexp or 
	 * validation function.
	 * Validate instanceof using constructor:
	 * assert.throws(
	 *   function() {
	 *     throw new Error('Wrong value');
	 *   },
	 *   Error
	 * );
	 * Validate error message using RegExp:
	 * assert.throws(
	 *   function() {
	 *     throw new Error('Wrong value');
	 *   },
	 *   /value/
	 * );
	 * Custom error validation:
	 * assert.throws(
	 *   function() {
	 *     throw new Error('Wrong value');
	 *   },
	 *   function(err) {
	 *     if ( (err instanceof Error) && /value/.test(err) ) {
	 *       return true;
	 *     }
	 *   },
	 *   'unexpected error'
	 * );
	 */
	public function throws(block : Dynamic, ?error : Dynamic, ?message : String) : Void;

	/**
	 * Tests if value is truthy, it is equivalent to assert.equal(true, !!value, message);
	 */
	public function ok(value : Dynamic, message : String) : Void;

	/**
	 * Tests shallow, coercive equality with the equal comparison operator ( == ).
	 */
	public function equal(actual : Dynamic, expected : Dynamic, ?message : String) : Void;

	/**
	 * Tests strict equality, as determined by the strict equality operator ( === )
	 */
	public function strictEqual(actual : Dynamic, expected : Dynamic, ?message : String) : Void;

}
