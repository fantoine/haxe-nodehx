package nodehx.path;

/**
 * This module contains utilities for handling and transforming file
 * paths.  Almost all these methods perform only string transformations.
 * The file system is not consulted to check whether paths are valid.
 * Use require("path") to use this module.  The following methods are provided:
 */
extern class PathModule implements nodehx.Node.NodeModule<"path", "", ""> {
	/**
	 * The platform-specific file separator. '\\' or '/'.
	 * An example on *nix:
	 * 'foo/bar/baz'.split(path.sep)
	 * // returns
	 * ['foo', 'bar', 'baz']
	 * An example on Windows:
	 * 'foo\\bar\\baz'.split(path.sep)
	 * // returns
	 * ['foo', 'bar', 'baz']
	 */
	public var sep(default, null) : String;
	
	/**
	 * The platform-specific path delimiter, ; or ':'.
	 * An example on *nix:
	 * console.log(process.env.PATH)
	 * // '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin'
	 * process.env.PATH.split(path.delimiter)
	 * // returns
	 * ['/usr/bin', '/bin', '/usr/sbin', '/sbin', '/usr/local/bin']
	 * An example on Windows:
	 * console.log(process.env.PATH)
	 * // 'C:\Windows\system32;C:\Windows;C:\Program Files\nodejs\'
	 * process.env.PATH.split(path.delimiter)
	 * // returns
	 * ['C:\Windows\system32', 'C:\Windows', 'C:\Program Files\nodejs\']
	 */
	public var delimiter(default, null) : String;
	
	/**
	 * Join all arguments together and normalize the resulting path.
	 * Arguments must be strings.  In v0.8, non-string arguments were
	 * silently ignored.  In v0.10 and up, an exception is thrown.
	 * Example:
	 * path.join("/foo", "bar", "baz/asdf", "quux", "..")
	 * // returns
	 * "/foo/bar/baz/asdf"
	 * path.join("foo", {}, "bar")
	 * // throws exception
	 * TypeError: Arguments to path.join must be strings
	 */
	public function join(?path1 : String, ?path2 : String, ?argument1 : String, ?argument2 : String, ?argument3 : String, ?argument4 : String, ?argument5 : String) : String;

	/**
	 * Solve the relative path from from to to.
	 * At times we have two absolute paths, and we need to derive the relative
	 * path from one to the other.  This is actually the reverse transform of
	 * path.resolve, which means we see that:
	 * path.resolve(from, path.relative(from, to)) == path.resolve(to)
	 * Examples:
	 * path.relative("C:\\orandea\\test\\aaa", "C:\\orandea\\impl\\bbb")
	 * // returns
	 * "..\\..\\impl\\bbb"
	 * path.relative("/data/orandea/test/aaa", "/data/orandea/impl/bbb")
	 * // returns
	 * "../../impl/bbb"
	 */
	@:overload(function(to : String) : String {})
	@:overload(function(from1 : String, to : String) : String {})
	@:overload(function(from1 : String, from2 : String, to : String) : String {})
	@:overload(function(from1 : String, from2 : String, from3 : String, to : String) : String {})
	@:overload(function(from1 : String, from2 : String, from3 : String, from4 : String, to : String) : String {})
	public function relative(from1 : String, from2 : String, from3 : String, from4 : String, from5 : String, to : String) : String;

	/**
	 * Resolves to to an absolute path.
	 * If to isn"t already absolute from arguments are prepended in right to left
	 * order, until an absolute path is found. If after using all from paths still
	 * no absolute path is found, the current working directory is used as well. The
	 * resulting path is normalized, and trailing slashes are removed unless the path
	 * gets resolved to the root directory. Non-string arguments are ignored.
	 * Another way to think of it is as a sequence of cd commands in a shell.
	 * path.resolve("foo/bar", "/tmp/file/", "..", "a/../subfile")
	 * Is similar to:
	 * cd foo/bar
	 * cd /tmp/file/
	 * cd ..
	 * cd a/../subfile
	 * pwd
	 * The difference is that the different paths don"t need to exist and may also be
	 * files.
	 * Examples:
	 * path.resolve("/foo/bar", "./baz")
	 * // returns
	 * "/foo/bar/baz"
	 * path.resolve("/foo/bar", "/tmp/file/")
	 * // returns
	 * "/tmp/file"
	 * path.resolve("wwwroot", "static_files/png/", "../gif/image.gif")
	 * // if currently in /home/myself/node, it returns
	 * "/home/myself/node/wwwroot/static_files/gif/image.gif"
	 */
	@:overload(function(to : String) : String {})
	@:overload(function(from1 : String, to : String) : String {})
	@:overload(function(from1 : String, from2 : String, to : String) : String {})
	@:overload(function(from1 : String, from2 : String, from3 : String, to : String) : String {})
	@:overload(function(from1 : String, from2 : String, from3 : String, from4 : String, to : String) : String {})
	public function resolve(from1 : String, from2 : String, from3 : String, from4 : String, from5 : String, to : String) : String;

	/**
	 * Return the last portion of a path.  Similar to the Unix basename command.
	 * Example:
	 * path.basename("/foo/bar/baz/asdf/quux.html")
	 * // returns
	 * "quux.html"
	 * path.basename("/foo/bar/baz/asdf/quux.html", ".html")
	 * // returns
	 * "quux"
	 */
	public function basename(p : String, ?ext : String) : String;

	/**
	 * Normalize a string path, taking care of ".." and "." parts.
	 * When multiple slashes are found, they"re replaced by a single one;
	 * when the path contains a trailing slash, it is preserved.
	 * On Windows backslashes are used.
	 * Example:
	 * path.normalize("/foo/bar//baz/asdf/quux/..")
	 * // returns
	 * "/foo/bar/baz/asdf"
	 */
	public function normalize(p : String) : String;

	/**
	 * Return the directory name of a path.  Similar to the Unix dirname command.
	 * Example:
	 * path.dirname("/foo/bar/baz/asdf/quux")
	 * // returns
	 * "/foo/bar/baz/asdf"
	 */
	public function dirname(p : String) : String;

	/**
	 * Return the extension of the path, from the last "." to end of string
	 * in the last portion of the path.  If there is no "." in the last portion
	 * of the path or the first character of it is ".", then it returns
	 * an empty string.  Examples:
	 * path.extname("index.html")
	 * // returns
	 * ".html"
	 * path.extname("index.")
	 * // returns
	 * "."
	 * path.extname("index")
	 * // returns
	 * ""
	 */
	public function extname(p : String) : String;

}
