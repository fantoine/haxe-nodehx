package nodehx.fs;
import nodehx.Buffer;
import nodehx.Error;

/**
 * File I/O is provided by simple wrappers around standard POSIX functions.  To
 * use this module do require("fs"). All the methods have asynchronous and
 * synchronous forms.
 * The asynchronous form always take a completion callback as its last argument.
 * The arguments passed to the completion callback depend on the method, but the
 * first argument is always reserved for an exception. If the operation was
 * completed successfully, then the first argument will be null or undefined.
 * When using the synchronous form any exceptions are immediately thrown.
 * You can use try/catch to handle exceptions or allow them to bubble up.
 * Here is an example of the asynchronous version:
 * var fs = require("fs");
 * fs.unlink("/tmp/hello", function (err) {
 *   if (err) throw err;
 *   console.log("successfully deleted /tmp/hello");
 * });
 * Here is the synchronous version:
 * var fs = require("fs");
 * fs.unlinkSync("/tmp/hello")
 * console.log("successfully deleted /tmp/hello");
 * With the asynchronous methods there is no guaranteed ordering. So the
 * following is prone to error:
 * fs.rename("/tmp/hello", "/tmp/world", function (err) {
 *   if (err) throw err;
 *   console.log("renamed complete");
 * });
 * fs.stat("/tmp/world", function (err, stats) {
 *   if (err) throw err;
 *   console.log("stats: " + JSON.stringify(stats));
 * });
 * It could be that fs.stat is executed before fs.rename.
 * The correct way to do this is to chain the callbacks.
 * fs.rename("/tmp/hello", "/tmp/world", function (err) {
 *   if (err) throw err;
 *   fs.stat("/tmp/world", function (err, stats) {
 *     if (err) throw err;
 *     console.log("stats: " + JSON.stringify(stats));
 *   });
 * });
 * In busy processes, the programmer is strongly encouraged to use the
 * asynchronous versions of these calls. The synchronous versions will block
 * the entire process until they complete--halting all connections.
 * Relative path to filename can be used, remember however that this path will be
 * relative to process.cwd().
 * Most fs functions let you omit the callback argument. If you do, a default
 * callback is used that ignores errors, but prints a deprecation
 * warning.
 * IMPORTANT: Omitting the callback is deprecated.  v0.12 will throw the
 * errors as exceptions.
 */
@:NodehxModule("fs")
extern class FsModule implements nodehx.Node.NodeModule<"fs", "stream", "FSWatcher,ReadStream,Stats,WriteStream"> {
	/**
	 * Synchronous version of fs.readFile. Returns the contents of the filename.
	 * If the encoding option is specified then this function returns a
	 * string. Otherwise it returns a buffer.
	 */
	public function readFileSync(filename : String, ?options : Dynamic) : Buffer;

	/**
	 * Asynchronous symlink(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 * type argument can be either "dir", "file", or "junction" (default is "file").  It is only 
	 * used on Windows (ignored on other platforms).
	 * Note that Windows junction points require the destination path to be absolute.  When using
	 * "junction", the destination argument will automatically be normalized to absolute path.
	 */
	@:overload(function(srcpath : String, dstpath : String, callback : Error -> Void) : Void {})
	public function symlink(srcpath : String, dstpath : String, type : String, callback : Error -> Void) : Void;

	/**
	 * Change file timestamps of the file referenced by the supplied path.
	 */
	public function utimesSync(path : String, atime : Date, mtime : Date) : Void;

	/**
	 * Watch for changes on filename. The callback listener will be called each
	 * time the file is accessed.
	 * The second argument is optional. The options if provided should be an object
	 * containing two members a boolean, persistent, and interval. persistent
	 * indicates whether the process should continue to run as long as files are
	 * being watched. interval indicates how often the target should be polled,
	 * in milliseconds. The default is { persistent: true, interval: 5007 }.
	 * The listener gets two arguments the current stat object and the previous
	 * stat object:
	 * fs.watchFile("message.text", function (curr, prev) {
	 *   console.log("the current mtime is: " + curr.mtime);
	 *   console.log("the previous mtime was: " + prev.mtime);
	 * });
	 * These stat objects are instances of fs.Stat.
	 * If you want to be notified when the file was modified, not just accessed
	 * you need to compare curr.mtime and prev.mtime.
	 */
	@:overload(function(filename : String, listener : Stats -> Stats -> Void) : Void {})
	public function watchFile(filename : String, options : Dynamic, listener : Stats -> Stats -> Void) : Void;

	/**
	 * Synchronous realpath(2). Returns the resolved path.
	 */
	public function realpathSync(path : String, ?cache : Dynamic) : String;

	/**
	 * The synchronous version of fs.writeFile.
	 */
	@:overload(function(filename : String, data : Buffer, ?options : Dynamic) : Void {})
	public function writeFileSync(filename : String, data : String, ?options : Dynamic) : Void;

	/**
	 * Synchronous lstat(2). Returns an instance of fs.Stats.
	 */
	public function lstatSync(path : String) : Stats;

	/**
	 * Asynchronous mkdir(2). No arguments other than a possible exception are given
	 * to the completion callback. mode defaults to 0777.
	 */
	@:overload(function(path : String, callback : Error -> Void) : Void {})
	public function mkdir(path : String, mode : Int, callback : Error -> Void) : Void;

	/**
	 * Asynchronous readdir(3).  Reads the contents of a directory.
	 * The callback gets two arguments (err, files) where files is an array of
	 * the names of the files in the directory excluding "." and "..".
	 */
	public function readdir(path : String, callback : Error -> Array<String> -> Void) : Void;

	/**
	 * Write buffer to the file specified by fd.
	 * offset and length determine the part of the buffer to be written.
	 * position refers to the offset from the beginning of the file where this data
	 * should be written. If position is null, the data will be written at the
	 * current position.
	 * See pwrite(2).
	 * The callback will be given three arguments (err, written, buffer) where written
	 * specifies how many bytes were written from buffer.
	 * Note that it is unsafe to use fs.write multiple times on the same file
	 * without waiting for the callback. For this scenario,
	 * fs.createWriteStream is strongly recommended.
	 * On Linux, positional writes don"t work when the file is opened in append mode.
	 * The kernel ignores the position argument and always appends the data to
	 * the end of the file.
	 */
	public function write(fd : Int, buffer : Buffer, offset : Int, length : Int, position : Int, callback : Error -> Int -> Buffer -> Void) : Void;

	/**
	 * Read data from the file specified by fd.
	 * buffer is the buffer that the data will be written to.
	 * offset is offset within the buffer where reading will start.
	 * length is an integer specifying the number of bytes to read.
	 * position is an integer specifying where to begin reading from in the file.
	 * If position is null, data will be read from the current file position.
	 * The callback is given the three arguments, (err, bytesRead, buffer).
	 */
	public function read(fd : Int, buffer : Buffer, offset : Int, length : Int, position : Int, callback : Error -> Int -> Buffer) : Void;

	/**
	 * Asynchronous fsync(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function fsync(fd : Int, callback : Error -> Void) : Void;

	/**
	 * Synchronous rename(2).
	 */
	public function renameSync(oldPath : String, newPath : String) : Void;

	/**
	 * Synchronous version of fs.read. Returns the number of bytesRead.
	 */
	public function readSync(fd : Int, buffer : Buffer, offset : Int, length : Int, position : Int) : Int;

	/**
	 * Asynchronous truncate(2). No arguments other than a possible exception are
	 * given to the completion callback.
	 */
	public function truncate(path : String, len : Int, callback : Error -> Void) : Void;

	/**
	 * Change the file timestamps of a file referenced by the supplied file
	 * descriptor.
	 */
	public function futimesSync(fd : Int, atime : Date, mtime : Date) : Void;

	/**
	 * Synchronous fstat(2). Returns an instance of fs.Stats.
	 */
	public function fstatSync(fd : Int) : Stats;

	/**
	 * Asynchronous lchmod(2). No arguments other than a possible exception
	 * are given to the completion callback.
	 * Only available on Mac OS X.
	 */
	public function lchmod(path : String, mode : Int, callback : Error -> Void) : Void;

	/**
	 * Asynchronous chown(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function chown(path : String, uid : Int, gid : Int, callback : Error -> Void) : Void;

	/**
	 * Asynchronous unlink(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function unlink(path : String, callback : Error -> Void) : Void;

	/**
	 * Asynchronous stat(2). The callback gets two arguments (err, stats) where
	 * stats is a fs.Stats object.  See the fs.Stats
	 * section below for more information.
	 */
	public function stat(path : String, callback : Error -> Stats -> Void) : Void;

	/**
	 * Asynchronous readlink(2). The callback gets two arguments (err,
	 * linkString).
	 */
	public function readlink(path : String, callback : Error -> Void) : Void;

	/**
	 * Asynchronous close(2).  No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function close(fd : Int, callback : Error -> Void) : Void;

	/**
	 * Test whether or not the given path exists by checking with the file system.
	 * Then call the callback argument with either true or false.  Example:
	 * fs.exists("/etc/passwd", function (exists) {
	 *   util.debug(exists ? 'it"s there' : 'no passwd!');
	 * });
	 */
	public function exists(path : String, callback : Bool -> Void) : Void;

	/**
	 * Asynchronous rmdir(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function rmdir(path : String, callback : Error -> Void) : Void;

	/**
	 * Asynchronous fchmod(2). No arguments other than a possible exception
	 * are given to the completion callback.
	 */
	public function fchmod(fd : Int, mode : Int, callback : Error -> Void) : Void;

	/**
	 * Synchronous stat(2). Returns an instance of fs.Stats.
	 */
	public function statSync(path : String) : Stats;

	/**
	 * Synchronous truncate(2).
	 */
	public function truncateSync(path : String, len : Int) : Void;

	/**
	 * Synchronous mkdir(2).
	 */
	public function mkdirSync(path : String, ?mode : Int) : Void;

	/**
	 * Synchronous version of fs.write(). Returns the number of bytes written.
	 */
	public function writeSync(fd : Int, buffer : Buffer, offset : Int, length : Int, position : Int) : Int;

	/**
	 * Synchronous symlink(2).
	 */
	public function symlinkSync(srcpath : String, dstpath : String, ?type : String) : Void;

	/**
	 * Synchronous fsync(2).
	 */
	public function fsyncSync(fd : Int) : Void;

	/**
	 * Synchronous ftruncate(2).
	 */
	public function ftruncateSync(fd : Int, len : Int) : Void;

	/**
	 * Asynchronous lchown(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function lchown(path : String, uid : Int, gid : Int, callback : Error -> Void) : Void;

	/**
	 * Asynchronously writes data to a file, replacing the file if it already exists.
	 * data can be a string or a buffer.
	 * The encoding option is ignored if data is a buffer. It defaults
	 * to "utf8".
	 * Example:
	 * fs.writeFile("message.txt", "Hello Node", function (err) {
	 *   if (err) throw err;
	 *   console.log("It\"s saved!");
	 * });
	 */
	@:overload(function(filename : String, data : Buffer, callback : Error -> Void) : Void {})
	@:overload(function(filename : String, data : String, callback : Error -> Void) : Void {})
	@:overload(function(filename : String, data : Buffer, options : Dynamic, callback : Error -> Void) : Void {})
	public function writeFile(filename : String, data : String, options : Dynamic, callback : Error -> Void) : Void;

	/**
	 * Synchronous readlink(2). Returns the symbolic link"s string value.
	 */
	public function readlinkSync(path : String) : Void;

	/**
	 * Synchronous readdir(3). Returns an array of filenames excluding "." and
	 * "..".
	 */
	public function readdirSync(path : String) : Array<String>;

	/**
	 * Asynchronous fchown(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function fchown(fd : Int, uid : Int, gid : Int, callback : Error -> Void) : Void;

	/**
	 * Synchronous chown(2).
	 */
	public function chownSync(path : String, uid : Int, gid : Int) : Void;

	/**
	 * Synchronous lchmod(2).
	 */
	public function lchmodSync(path : String, mode : Int) : Void;

	/**
	 * Synchronous close(2).
	 */
	public function closeSync(fd : Int) : Void;

	/**
	 * Returns a new WriteStream object (See Writable Stream).
	 * options is an object with the following defaults:
	 * { flags: "w",
	 *   encoding: null,
	 *   mode: 0666 }
	 * options may also include a start option to allow writing data at
	 * some position past the beginning of the file.  Modifying a file rather
	 * than replacing it may require a flags mode of r+ rather than the
	 * default mode w.
	 */
	public function createWriteStream(path : String, ?options : Dynamic) : WriteStream;

	/**
	 * Synchronous unlink(2).
	 */
	public function unlinkSync(path : String) : Void;

	/**
	 * Asynchronous chmod(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function chmod(path : String, mode : Int, callback : Error -> Void) : Void;

	/**
	 * Synchronous rmdir(2).
	 */
	public function rmdirSync(path : String) : Void;

	/**
	 * Synchronous version of fs.exists.
	 */
	public function existsSync(path : String) : Bool;

	/**
	 * Change file timestamps of the file referenced by the supplied path.
	 */
	public function utimes(path : String, atime : Date, mtime : Date, callback : Error -> Void) : String;

	/**
	 * Watch for changes on filename, where filename is either a file or a
	 * directory.  The returned object is a fs.FSWatcher.
	 * The second argument is optional. The options if provided should be an object
	 * containing a boolean member persistent, which indicates whether the process
	 * should continue to run as long as files are being watched. The default is
	 * { persistent: true }.
	 * The listener callback gets two arguments (event, filename).  event is either
	 * "rename" or "change", and filename is the name of the file which triggered
	 * the event.
	 */
	public function watch(filename : String, ?options : Dynamic, ?listener : String -> String -> Void) : FSWatcher;

	/**
	 * Synchronous fchmod(2).
	 */
	public function fchmodSync(fd : Int, mode : Int) : Void;

	/**
	 * Asynchronous link(2). No arguments other than a possible exception are given to
	 * the completion callback.
	 */
	public function link(srcpath : String, dstpath : String, callback : Error -> Void) : Void;

	/**
	 * Asynchronous realpath(2). The callback gets two arguments (err,
	 * resolvedPath). May use process.cwd to resolve relative paths. cache is an
	 * object literal of mapped paths that can be used to force a specific path
	 * resolution or avoid additional fs.stat calls for known real paths.
	 * Example:
	 * var cache = {"/etc":"/private/etc"};
	 * fs.realpath("/etc/passwd", cache, function (err, resolvedPath) {
	 *   if (err) throw err;
	 *   console.log(resolvedPath);
	 * });
	 */
	@:overload(function(path : String, callback : Error -> String -> Void) : Void {})
	public function realpath(path : String, cache : Dynamic, callback : Error -> String -> Void) : Void;

	/**
	 * Synchronous link(2).
	 */
	public function linkSync(srcpath : String, dstpath : String) : Void;

	/**
	 * Change the file timestamps of a file referenced by the supplied file
	 * descriptor.
	 */
	public function futimes(fd : Int, atime : Date, mtime : Date, callback : Error -> Void) : Void;

	/**
	 * Asynchronously reads the entire contents of a file. Example:
	 * fs.readFile("/etc/passwd", function (err, data) {
	 *   if (err) throw err;
	 *   console.log(data);
	 * });
	 * The callback is passed two arguments (err, data), where data is the
	 * contents of the file.
	 * If no encoding is specified, then the raw buffer is returned.
	 */
	@:overload(function(filename : String, callback : Error -> Buffer -> Void) : Void {})
	public function readFile(filename : String, options : Dynamic, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Returns a new ReadStream object (See Readable Stream).
	 * options is an object with the following defaults:
	 * { flags: "r",
	 *   encoding: null,
	 *   fd: null,
	 *   mode: 0666,
	 *   autoClose: true
	 * }
	 * options can include start and end values to read a range of bytes from
	 * the file instead of the entire file.  Both start and end are inclusive and
	 * start at 0. The encoding can be "utf8", "ascii", or "base64".
	 * If autoClose is false, then the file descriptor won"t be closed, even if
	 * there"s an error.  It is your responsiblity to close it and make sure
	 * there"s no file descriptor leak.  If autoClose is set to true (default
	 * behavior), on error or end the file descriptor will be closed
	 * automatically.
	 * An example to read the last 10 bytes of a file which is 100 bytes long:
	 * fs.createReadStream("sample.txt", {start: 90, end: 99});
	 */
	public function createReadStream(path : String, ?options : Dynamic) : ReadStream;

	/**
	 * Synchronous lchown(2).
	 */
	public function lchownSync(path : String, uid : Int, gid : Int) : Void;

	/**
	 * Asynchronous lstat(2). The callback gets two arguments (err, stats) where
	 * stats is a fs.Stats object. lstat() is identical to stat(), except that if
	 * path is a symbolic link, then the link itself is stat-ed, not the file that it
	 * refers to.
	 */
	public function lstat(path : String, callback : Error -> Stats -> Void) : Void;

	/**
	 * Asynchronous rename(2). No arguments other than a possible exception are given
	 * to the completion callback.
	 */
	public function rename(oldPath : String, newPath : String, callback : Error -> Void) : Void;

	/**
	 * Asynchronous file open. See open(2). flags can be:
	 * "r" - Open file for reading.
	 * An exception occurs if the file does not exist.
	 * "r+" - Open file for reading and writing.
	 * An exception occurs if the file does not exist.
	 * "rs" - Open file for reading in synchronous mode. Instructs the operating
	 * system to bypass the local file system cache.
	 * This is primarily useful for opening files on NFS mounts as it allows you to
	 * skip the potentially stale local cache. It has a very real impact on I/O
	 * performance so don"t use this mode unless you need it.
	 * Note that this doesn"t turn fs.open() into a synchronous blocking call.
	 * If that"s what you want then you should be using fs.openSync()
	 * "rs+" - Open file for reading and writing, telling the OS to open it
	 * synchronously. See notes for "rs" about using this with caution.
	 * "w" - Open file for writing.
	 * The file is created (if it does not exist) or truncated (if it exists).
	 * "wx" - Like "w" but opens the file in exclusive mode.
	 * "w+" - Open file for reading and writing.
	 * The file is created (if it does not exist) or truncated (if it exists).
	 * "wx+" - Like "w+" but opens the file in exclusive mode.
	 * "a" - Open file for appending.
	 * The file is created if it does not exist.
	 * "ax" - Like "a" but opens the file in exclusive mode.
	 * "a+" - Open file for reading and appending.
	 * The file is created if it does not exist.
	 * "ax+" - Like "a+" but opens the file in exclusive mode.
	 * mode defaults to 0666. The callback gets two arguments (err, fd).
	 * Exclusive mode (O_EXCL) ensures that path is newly created. fs.open()
	 * fails if a file by that name already exists. On POSIX systems, symlinks are
	 * not followed. Exclusive mode may or may not work with network file systems.
	 * On Linux, positional writes don"t work when the file is opened in append mode.
	 * The kernel ignores the position argument and always appends the data to
	 * the end of the file.
	 */
	@:overload(function(path : String, flags : String, callback : Error -> Int -> Void) : Void {})
	public function open(path : String, flags : String, mode : Int, callback : Error -> Int -> Void) : Void;

	/**
	 * Asynchronously append data to a file, creating the file if it not yet exists.
	 * data can be a string or a buffer.
	 * Example:
	 * fs.appendFile("message.txt", "data to append", function (err) {
	 *   if (err) throw err;
	 *   console.log("The 'data to append' was appended to file!");
	 * });
	 */
	@:overload(function(filename : String, data : Buffer, callback : Error -> Void) : Void {})
	@:overload(function(filename : String, data : String, callback : Error -> Void) : Void {})
	@:overload(function(filename : String, data : Buffer, options : Dynamic, callback : Error -> Void) : Void {})
	public function appendFile(filename : String, data : String, options : Dynamic, callback : Error -> Void) : Void;

	/**
	 * Asynchronous ftruncate(2). No arguments other than a possible exception are
	 * given to the completion callback.
	 */
	public function ftruncate(fd : Int, len : Int, callback : Error -> Void) : Void;

	/**
	 * Synchronous open(2).
	 */
	public function openSync(path : String, flags : String, ?mode : Int) : Int;

	/**
	 * The synchronous version of fs.appendFile.
	 */
	@:overload(function(filename : String, data : Buffer, ?options : Dynamic) : Void {})
	public function appendFileSync(filename : Dynamic, data : String, ?options : Dynamic) : Void;

	/**
	 * Synchronous fchown(2).
	 */
	public function fchownSync(fd : Int, uid : Int, gid : Int) : Void;

	/**
	 * Asynchronous fstat(2). The callback gets two arguments (err, stats) where
	 * stats is a fs.Stats object. fstat() is identical to stat(), except that
	 * the file to be stat-ed is specified by the file descriptor fd.
	 */
	public function fstat(fd : Int, callback : Error -> Stats -> Void) : Void;

	/**
	 * Stop watching for changes on filename. If listener is specified, only that
	 * particular listener is removed. Otherwise, all listeners are removed and you
	 * have effectively stopped watching filename.
	 * Calling fs.unwatchFile() with a filename that is not being watched is a
	 * no-op, not an error.
	 */
	public function unwatchFile(filename : String, ?listener : Stats -> Stats -> Void) : Void;

	/**
	 * Synchronous chmod(2).
	 */
	public function chmodSync(path : String, mode : Int) : Void;

}
