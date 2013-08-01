package nodehx.querystring;

/**
 * This module provides utilities for dealing with query strings.
 * It provides the following methods:
 */
@:NodehxModule("querystring")
extern class QuerystringModule implements nodehx.Node.NodeModule<"querystring", "", ""> {
	/**
	 * The escape function used by querystring.stringify, provided so that
	 * it could be overridden if necessary.
	 */
	public var escape : Dynamic -> ?String -> ?String -> String;
	
	/**
	 * The escape function used by querystring.stringify, provided so that
	 * it could be overridden if necessary.
	 */
	public var unescape : String -> ?String -> ?String -> ?Dynamic -> Dynamic;
	
	/**
	 * Serialize an object to a query string.
	 * Optionally override the default separator ("&") and assignment ("=")
	 * characters.
	 * Example:
	 * querystring.stringify({ foo: "bar", baz: ["qux", "quux"], corge: "" })
	 * // returns
	 * "foo=bar&baz=qux&baz=quux&corge="
	 * querystring.stringify({foo: "bar", baz: "qux"}, ";", ":")
	 * // returns
	 * "foo:bar;baz:qux"
	 */
	public function stringify(obj : Dynamic, ?sep : String, ?eq : String) : String;

	/**
	 * Deserialize a query string to an object.
	 * Optionally override the default separator ("&") and assignment ("=")
	 * characters.
	 * Options object may contain maxKeys property (equal to 1000 by default), it"ll
	 * be used to limit processed keys. Set it to 0 to remove key count limitation.
	 * Example:
	 * querystring.parse("foo=bar&baz=qux&baz=quux&corge")
	 * // returns
	 * { foo: "bar", baz: ["qux", "quux"], corge: "" }
	 */
	public function parse(str : String, ?sep : String, ?eq : String, ?options : Dynamic) : Dynamic;

}
