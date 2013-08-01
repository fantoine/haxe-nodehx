package nodehx;

import nodehx.events.EventEmitter;
import nodehx.stream.Readable;
import nodehx.stream.Writable;

extern class Process extends EventEmitter {
	/**
	 * A Writable Stream to stdout.
	 * Example: the definition of console.log
	 * console.log = function(d) {
	 *   process.stdout.write(d + '\n');
	 * };
	 * process.stderr and process.stdout are unlike other streams in Node in that writes 
	 * to them are usually blocking. They are blocking in the case that they refer to 
	 * regular files or TTY file descriptors. In the case they refer to pipes, they are non-blocking 
	 * like other streams.
	 * To check if Node is being run in a TTY context, read the isTTY property on 
	 * process.stderr, process.stdout, or process.stdin:
	 * $ node -p "Boolean(process.stdin.isTTY)"
	 * true
	 * $ echo "foo" | node -p "Boolean(process.stdin.isTTY)"
	 * false
	 * $ node -p "Boolean(process.stdout.isTTY)"
	 * true
	 * $ node -p "Boolean(process.stdout.isTTY)" | cat
	 * false
	 * See the tty docs for more information.
	 */
	public var stdout(default, null) : Writable;
	
	/**
	 * A writable stream to stderr.
	 * process.stderr and process.stdout are unlike other streams in Node in that writes 
	 * to them are usually blocking. They are blocking in the case that they refer to regular 
	 * files or TTY file descriptors. In the case they refer to pipes, they are non-blocking like other streams.
	 */
	public var stderr(default, null) : Writable;
	
	/**
	 * A Readable Stream for stdin. The stdin stream is paused by default, so one must call process.stdin.resume() to read from it.
	 * Example of opening standard input and listening for both events:
	 * process.stdin.resume();
	 * process.stdin.setEncoding('utf8');
	 * process.stdin.on('data', function(chunk) {
	 *   process.stdout.write('data: ' + chunk);
	 * });
	 * process.stdin.on('end', function() {
	 *   process.stdout.write('end');
	 * });
	 */
	public var stdin(default, null) : Readable;
	
	/**
	 * An array containing the command line arguments. The first element will be 'node', 
	 * the second element will be the name of the JavaScript file. The next elements will 
	 * be any additional command line arguments.
	 * // print process.argv
	 * process.argv.forEach(function(val, index, array) {
	 *   console.log(index + ': ' + val);
	 * });
	 * This will generate:
	 * $ node process-2.js one two=three four
	 * 0: node
	 * 1: /Users/mjr/work/node/process-2.js
	 * 2: one
	 * 3: two=three
	 * 4: four
	 */
	public var argv(default, null) : Array<String>;
	
	/**
	 * This is the absolute pathname of the executable that started the process.
	 * Example:
	 * /usr/local/bin/node
	 */
	public var execPath(default, null) : String;
	
	/**
	 * An object containing the user environment. See environ(7).
	 */
	public var env(default, null) : Dynamic;
	
	/**
	 * A compiled-in property that exposes NODE_VERSION.
	 * console.log('Version: ' + process.version);
	 */
	public var version(default, null) : String;
	
	/**
	 * A property exposing version strings of node and its dependencies.
	 * console.log(process.versions);
	 * Will print something like:
	 * { http_parser: '1.0',
	 *   node: '0.10.4',
	 *   v8: '3.14.5.8',
	 *   ares: '1.9.0-DEV',
	 *   uv: '0.10.3',
	 *   zlib: '1.2.3',
	 *   modules: '11',
	 *   openssl: '1.0.1e' }
	 */
	public var versions(default, null) : Dynamic<String>;
	
	/**
	 * An Object containing the JavaScript representation of the configure options that were used to compile the current node executable. This is the same as the "config.gypi" file that was produced when running the ./configure script.
	 * An example of the possible output looks like:
	 * { target_defaults:
	 *    { cflags: [],
	 *      default_configuration: 'Release',
	 *      defines: [],
	 *      include_dirs: [],
	 *      libraries: [] },
	 *   variables:
	 *    { host_arch: 'x64',
	 *      node_install_npm: 'true',
	 *      node_prefix: '',
	 *      node_shared_cares: 'false',
	 *      node_shared_http_parser: 'false',
	 *      node_shared_libuv: 'false',
	 *      node_shared_v8: 'false',
	 *      node_shared_zlib: 'false',
	 *      node_use_dtrace: 'false',
	 *      node_use_openssl: 'true',
	 *      node_shared_openssl: 'false',
	 *      strict_aliasing: 'true',
	 *      target_arch: 'x64',
	 *      v8_use_snapshot: 'true' } }
	 */
	public var config(default, null) : Dynamic;
	
	/**
	 * The PID of the process.
	 * console.log('This process is pid ' + process.pid);
	 */
	public var pid(default, null) : String;
	
	/**
	 * Getter/setter to set what is displayed in 'ps'.
	 * When used as a setter, the maximum length is platform-specific and probably short.
	 * On Linux and OS X, it's limited to the size of the binary name plus the length 
	 * of the command line arguments because it overwrites the argv memory.
	 * v0.8 allowed for longer process title strings by also overwriting the environ memory 
	 * but that was potentially insecure/confusing in some (rather obscure) cases.
	 */
	public var title : String;
	
	/**
	 * What processor architecture you're running on: 'arm', 'ia32', or 'x64'.
	 * console.log('This processor architecture is ' + process.arch);
	 */
	public var arch(default, null) : String;
	
	/**
	 * What platform you're running on: 'darwin', 'freebsd', 'linux', 'sunos' or 'win32'
	 * console.log('This platform is ' + process.platform);
	 */
	public var platform(default, null) : String;
	
	/**
	 * Callbacks passed to process.nextTick will usually be called at the end of the current 
	 * flow of execution, and are thus approximately as fast as calling a function synchronously. 
	 * Left unchecked, this would starve the event loop, preventing any I/O from occurring.
	 * Consider this code:
	 * process.nextTick(function foo() {
	 *   process.nextTick(foo);
	 * });
	 * In order to avoid the situation where Node is blocked by an infinite loop of recursive 
	 * series of nextTick calls, it defers to allow some I/O to be done every so often.
	 * The process.maxTickDepth value is the maximum depth of nextTick-calling nextTick-callbacks 
	 * that will be evaluated before allowing other forms of I/O to occur.
	 */
	public var maxTickDepth : Int;
	
	/**
	 * This causes node to emit an abort. This will cause node to exit and generate a core file.
	 */
	public function abort() : Void;
	
	/**
	 * Changes the current working directory of the process or throws an exception if that fails.
	 * console.log('Starting directory: ' + process.cwd());
	 * try {
	 *   process.chdir('/tmp');
	 *   console.log('New directory: ' + process.cwd());
	 * }
	 * catch (err) {
	 *   console.log('chdir: ' + err);
	 * }
	 */
	public function chdir(directory : String) : Void;
	
	/**
	 * Returns the current working directory of the process.
	 * console.log('Current directory: ' + process.cwd());
	 */
	public function cwd() : Void;
	
	/**
	 * Ends the process with the specified code. If omitted, exit uses the 'success' code 0.
	 * To exit with a 'failure' code:
	 * process.exit(1);
	 * The shell that executed node should see the exit code as 1.
	 */
	public function exit(?code : Int) : Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Gets the group identity of the process. (See getgid(2).) This is the numerical group id, not the group name.
	 * if (process.getgid) {
	 *   console.log('Current gid: ' + process.getgid());
	 * }
	 */
	public function getgid() : String;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Sets the group identity of the process. (See setgid(2).) This accepts either a numerical ID or a groupname string. If a groupname is specified, this method blocks while resolving it to a numerical ID.
	 * if (process.getgid && process.setgid) {
	 *   console.log('Current gid: ' + process.getgid());
	 *   try {
	 *     process.setgid(501);
	 *     console.log('New gid: ' + process.getgid());
	 *   }
	 *   catch (err) {
	 *     console.log('Failed to set gid: ' + err);
	 *   }
	 * }
	 */
	public function setgid(id : Dynamic) : Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Gets the user identity of the process. (See getuid(2).) This is the numerical userid, not the username.
	 * if (process.getuid) {
	 *   console.log('Current uid: ' + process.getuid());
	 * }
	 */
	public function getuid() : String;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Sets the user identity of the process. (See setuid(2).) This accepts either 
	 * a numerical ID or a username string. If a username is specified, this method 
	 * blocks while resolving it to a numerical ID.
	 * if (process.getuid && process.setuid) {
	 *   console.log('Current uid: ' + process.getuid());
	 *   try {
	 *     process.setuid(501);
	 *     console.log('New uid: ' + process.getuid());
	 *   }
	 *   catch (err) {
	 *     console.log('Failed to set uid: ' + err);
	 *   }
	 * }
	 */
	public function setuid(id : Dynamic) : Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Returns an array with the supplementary group IDs. POSIX leaves it unspecified 
	 * if the effective group ID is included but node.js ensures it always is.
	 */
	public function getgroups() : Array<String>;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Sets the supplementary group IDs. This is a privileged operation, meaning you 
	 * need to be root or have the CAP_SETGID capability.
	 * The list can contain group IDs, group names or both.
	 */
	public function setgroups(groups : Array<String>) : Void;
	
	/**
	 * Note: this function is only available on POSIX platforms (i.e. not Windows)
	 * Reads /etc/group and initializes the group access list, using all groups of 
	 * which the user is a member. This is a privileged operation, meaning you need 
	 * to be root or have the CAP_SETGID capability.
	 * user is a user name or user ID. extra_group is a group name or group ID.
	 * Some care needs to be taken when dropping privileges. Example:
	 */
	public function initgroups(user : String, extra_groups : String) : Void;
	
	/**
	 * Send a signal to a process. pid is the process id and signal is the string describing the signal to send. Signal names are strings like 'SIGINT' or 'SIGUSR1'. If omitted, the signal will be 'SIGTERM'. See kill(2) for more information.
	 * Note that just because the name of this function is process.kill, it is really just a signal sender, like the kill system call. The signal sent may do something other than kill the target process.
	 * Example of sending a signal to yourself:
	 * process.on('SIGHUP', function() {
	 *   console.log('Got SIGHUP signal.');
	 * });
	 * setTimeout(function() {
	 *   console.log('Exiting.');
	 *   process.exit(0);
	 * }, 100);
	 * process.kill(process.pid, 'SIGHUP');
	 */
	public function kill(pid : String, ?signal : String) : Void;
	
	/**
	 * Returns an object describing the memory usage of the Node process measured in bytes.
	 * var util = require('util');
	 * console.log(util.inspect(process.memoryUsage()));
	 * This will generate:
	 * { rss: 4935680,
	 *   heapTotal: 1826816,
	 *   heapUsed: 650472 }
	 * heapTotal and heapUsed refer to V8's memory usage.
	 */
	public function memoryUsage() : Dynamic;
	
	/**
	 * On the next loop around the event loop call this callback. This is not a simple alias to setTimeout(fn, 0), it's much more efficient. It typically runs before any other I/O events fire, but there are some exceptions. See process.maxTickDepth below.
	 * process.nextTick(function() {
	 *   console.log('nextTick callback');
	 * });
	 * This is important in developing APIs where you want to give the user the chance to assign event handlers after an object has been constructed, but before any I/O has occurred.
	 * function MyThing(options) {
	 *   this.setupOptions(options);
	 *   process.nextTick(function() {
	 *     this.startDoingStuff();
	 *   }.bind(this));
	 * }
	 * var thing = new MyThing();
	 * thing.getReadyForStuff();
	 * // thing.startDoingStuff() gets called now, not before.
	 * It is very important for APIs to be either 100% synchronous or 100% asynchronous. Consider this example:
	 * // WARNING!  DO NOT USE!  BAD UNSAFE HAZARD!
	 * function maybeSync(arg, cb) {
	 *   if (arg) {
	 *     cb();
	 *     return;
	 *   }
	 *   fs.stat('file', cb);
	 * }
	 * This API is hazardous. If you do this:
	 * maybeSync(true, function() {
	 *   foo();
	 * });
	 * bar();
	 * then it's not clear whether foo() or bar() will be called first.
	 * This approach is much better:
	 * function definitelyAsync(arg, cb) {
	 *   if (arg) {
	 *     process.nextTick(cb);
	 *     return;
	 *   }
	 *   fs.stat('file', cb);
	 * }
	 */
	public function nextTick(callback : Void -> Void) : Void;
	
	/**
	 * Sets or reads the process's file mode creation mask. Child processes inherit 
	 * the mask from the parent process. Returns the old mask if mask argument is given, 
	 * otherwise returns the current mask.
	 * var oldmask, newmask = 0644;
	 * oldmask = process.umask(newmask);
	 * console.log('Changed umask from: ' + oldmask.toString(8) +
	 *             ' to ' + newmask.toString(8));
	 */
	public function umask(?mask : Int) : Int;
	
	/**
	 * Number of seconds Node has been running.
	 */
	public function uptime() : Int;
	
	/**
	 * Returns the current high-resolution real time in a [seconds, nanoseconds] tuple Array. 
	 * It is relative to an arbitrary time in the past. It is not related to the time of day 
	 * and therefore not subject to clock drift. The primary use is for measuring performance 
	 * between intervals.
	 * You may pass in the result of a previous call to process.hrtime() to get a diff reading, 
	 * useful for benchmarks and measuring intervals:
	 * var time = process.hrtime();
	 * // [ 1800216, 25 ]
	 * setTimeout(function() {
	 *   var diff = process.hrtime(time);
	 *   // [ 1, 552 ]
	 *   console.log('benchmark took %d nanoseconds', diff[0] * 1e9 + diff[1]);
	 *   // benchmark took 1000000527 nanoseconds
	 * }, 1000);
	 */
	public function hrtime() : Array<Int>;
}