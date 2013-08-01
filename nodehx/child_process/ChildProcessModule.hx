package nodehx.child_process;

import nodehx.Buffer;
import nodehx.Error;

/**
 * Node provides a tri-directional popen(3) facility through the
 * child_process module.
 * It is possible to stream data through a child"s stdin, stdout, and
 * stderr in a fully non-blocking way.  (Note that some programs use
 * line-buffered I/O internally.  That doesn"t affect node.js but it means
 * data you send to the child process is not immediately consumed.)
 * To create a child process use require("child_process").spawn() or
 * require("child_process").fork().  The semantics of each are slightly
 * different, and explained below.
 */
extern class ChildProcessModule implements nodehx.Node.NodeModule<"child_process", "events,net,stream", "ChildProcess"> {
	/**
	 * Runs a command in a shell and buffers the output.
	 * var exec = require("child_process").exec,
	 *     child;
	 * child = exec("cat *.js bad_file | wc -l",
	 *   function (error, stdout, stderr) {
	 *     console.log("stdout: " + stdout);
	 *     console.log("stderr: " + stderr);
	 *     if (error !== null) {
	 *       console.log("exec error: " + error);
	 *     }
	 * });
	 * The callback gets the arguments (error, stdout, stderr). On success, error
	 * will be null.  On error, error will be an instance of Error and err.code
	 * will be the exit code of the child process, and err.signal will be set to the
	 * signal that terminated the process.
	 * There is a second optional argument to specify several options. The
	 * default options are
	 * { encoding: "utf8",
	 *   timeout: 0,
	 *   maxBuffer: 200*1024,
	 *   killSignal: "SIGTERM",
	 *   cwd: null,
	 *   env: null }
	 * If timeout is greater than 0, then it will kill the child process
	 * if it runs longer than timeout milliseconds. The child process is killed with
	 * killSignal (default: "SIGTERM"). maxBuffer specifies the largest
	 * amount of data allowed on stdout or stderr - if this value is exceeded then
	 * the child process is killed.
	 */
	@:overload(function(comment : String, callback : Error -> Buffer -> Buffer) : Null<ChildProcess> {})
	public function exec(command : String, options : Dynamic, callback : Error -> Buffer -> Buffer) : Null<ChildProcess>;

	/**
	 * This is a special case of the spawn() functionality for spawning Node
	 * processes. In addition to having all the methods in a normal ChildProcess
	 * instance, the returned object has a communication channel built-in. See
	 * child.send(message, [sendHandle]) for details.
	 * By default the spawned Node process will have the stdout, stderr associated
	 * with the parent"s. To change this behavior set the silent property in the
	 * options object to true.
	 * The child process does not automatically exit once it"s done, you need to call
	 * process.exit() explicitly. This limitation may be lifted in the future.
	 * These child Nodes are still whole new instances of V8. Assume at least 30ms
	 * startup and 10mb memory for each new Node. That is, you cannot create many
	 * thousands of them.
	 * The execPath property in the options object allows for a process to be
	 * created for the child rather than the current node executable. This should be
	 * done with care and by default will talk over the fd represented an
	 * environmental variable NODE_CHANNEL_FD on the child process. The input and
	 * output on this fd is expected to be line delimited JSON objects.
	 */
	public function fork(modulePath : String, ?args : Array<String>, ?options : Dynamic) : Null<ChildProcess>;

	/**
	 * This is similar to child_process.exec() except it does not execute a
	 * subshell but rather the specified file directly. This makes it slightly
	 * leaner than child_process.exec. It has the same options.
	 */
	public function execFile(file : String, args : Array<String>, options : Dynamic, callback : Dynamic -> Buffer -> Buffer) : Null<ChildProcess>;

	/**
	 * Launches a new process with the given command, with  command line arguments in args.
	 * If omitted, args defaults to an empty Array.
	 * The third argument is used to specify additional options, which defaults to:
	 * { cwd: undefined,
	 *   env: process.env
	 * }
	 * cwd allows you to specify the working directory from which the process is spawned.
	 * Use env to specify environment variables that will be visible to the new process.
	 * Example of running ls -lh /usr, capturing stdout, stderr, and the exit code:
	 * var spawn = require("child_process").spawn,
	 *     ls    = spawn("ls", ["-lh", "/usr"]);
	 * ls.stdout.on("data", function (data) {
	 *   console.log("stdout: " + data);
	 * });
	 * ls.stderr.on("data", function (data) {
	 *   console.log("stderr: " + data);
	 * });
	 * ls.on("close", function (code) {
	 *   console.log("child process exited with code " + code);
	 * });
	 * Example: A very elaborate way to run "ps ax | grep ssh"
	 * var spawn = require("child_process").spawn,
	 *     ps    = spawn("ps", ["ax"]),
	 *     grep  = spawn("grep", ["ssh"]);
	 * ps.stdout.on("data", function (data) {
	 *   grep.stdin.write(data);
	 * });
	 * ps.stderr.on("data", function (data) {
	 *   console.log("ps stderr: " + data);
	 * });
	 * ps.on("close", function (code) {
	 *   if (code !== 0) {
	 *     console.log("ps process exited with code " + code);
	 *   }
	 *   grep.stdin.end();
	 * });
	 * grep.stdout.on("data", function (data) {
	 *   console.log("" + data);
	 * });
	 * grep.stderr.on("data", function (data) {
	 *   console.log("grep stderr: " + data);
	 * });
	 * grep.on("close", function (code) {
	 *   if (code !== 0) {
	 *     console.log("grep process exited with code " + code);
	 *   }
	 * });
	 * Example of checking for failed exec:
	 * var spawn = require("child_process").spawn,
	 *     child = spawn("bad_command");
	 * child.stderr.setEncoding("utf8");
	 * child.stderr.on("data", function (data) {
	 *   if (/^execvp\(\)/.test(data)) {
	 *     console.log("Failed to start child process.");
	 *   }
	 * });
	 * Note that if spawn receives an empty options object, it will result in
	 * spawning the process with an empty environment rather than using
	 * process.env. This due to backwards compatibility issues with a deprecated
	 * API.
	 * The "stdio" option to child_process.spawn() is an array where each
	 * index corresponds to a fd in the child.  The value is one of the following:
	 * "pipe" - Create a pipe between the child process and the parent process.
	 * The parent end of the pipe is exposed to the parent as a property on the
	 * child_process object as ChildProcess.stdio[fd]. Pipes created for
	 * fds 0 - 2 are also available as ChildProcess.stdin, ChildProcess.stdout
	 * and ChildProcess.stderr, respectively.
	 * "ipc" - Create an IPC channel for passing messages/file descriptors
	 * between parent and child. A ChildProcess may have at most one IPC stdio
	 * file descriptor. Setting this option enables the ChildProcess.send() method.
	 * If the child writes JSON messages to this file descriptor, then this will
	 * trigger ChildProcess.on("message").  If the child is a Node.js program, then
	 * the presence of an IPC channel will enable process.send() and
	 * process.on("message").
	 * "ignore" - Do not set this file descriptor in the child. Note that Node
	 * will always open fd 0 - 2 for the processes it spawns. When any of these is
	 * ignored node will open /dev/null and attach it to the child"s fd.
	 * Stream object - Share a readable or writable stream that refers to a tty,
	 * file, socket, or a pipe with the child process. The stream"s underlying
	 * file descriptor is duplicated in the child process to the fd that 
	 * corresponds to the index in the stdio array.
	 * Positive integer - The integer value is interpreted as a file descriptor 
	 * that is is currently open in the parent process. It is shared with the child
	 * process, similar to how Stream objects can be shared.
	 * null, undefined - Use default value. For stdio fds 0, 1 and 2 (in other
	 * words, stdin, stdout, and stderr) a pipe is created. For fd 3 and up, the
	 * default is "ignore".
	 * As a shorthand, the stdio argument may also be one of the following
	 * strings, rather than an array:
	 * ignore - ["ignore", "ignore", "ignore"]
	 * pipe - ["pipe", "pipe", "pipe"]
	 * inherit - [process.stdin, process.stdout, process.stderr] or [0,1,2]
	 * Example:
	 * var spawn = require("child_process").spawn;
	 * // Child will use parent"s stdios
	 * spawn("prg", [], { stdio: "inherit" });
	 * // Spawn child sharing only stderr
	 * spawn("prg", [], { stdio: ["pipe", "pipe", process.stderr] });
	 * // Open an extra fd=4, to interact with programs present a
	 * // startd-style interface.
	 * spawn("prg", [], { stdio: ["pipe", null, null, null, "pipe"] });
	 * If the detached option is set, the child process will be made the leader of a
	 * new process group.  This makes it possible for the child to continue running 
	 * after the parent exits.
	 * By default, the parent will wait for the detached child to exit.  To prevent
	 * the parent from waiting for a given child, use the child.unref() method,
	 * and the parent"s event loop will not include the child in its reference count.
	 * Example of detaching a long-running process and redirecting its output to a
	 * file:
	 *  var fs = require("fs"),
	 *      spawn = require("child_process").spawn,
	 *      out = fs.openSync("./out.log", "a"),
	 *      err = fs.openSync("./out.log", "a");
	 *  var child = spawn("prg", [], {
	 *    detached: true,
	 *    stdio: [ "ignore", out, err ]
	 *  });
	 *  child.unref();
	 * When using the detached option to start a long-running process, the process
	 * will not stay running in the background unless it is provided with a stdio
	 * configuration that is not connected to the parent.  If the parent"s stdio is
	 * inherited, the child will remain attached to the controlling terminal.
	 * There is a deprecated option called customFds which allows one to specify
	 * specific file descriptors for the stdio of the child process. This API was
	 * not portable to all platforms and therefore removed.
	 * With customFds it was possible to hook up the new process" [stdin, stdout,
	 * stderr] to existing streams; -1 meant that a new stream should be created.
	 * Use at your own risk.
	 * There are several internal options. In particular stdinStream,
	 * stdoutStream, stderrStream. They are for INTERNAL USE ONLY. As with all
	 * undocumented APIs in Node, they should not be used.
	 * See also: child_process.exec() and child_process.fork()
	 */
	public function spawn(command : String, ?args : Array<String>, ?options : Dynamic) : ChildProcess;

}
