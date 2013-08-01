package nodehx.child_process;

import nodehx.events.EventEmitter;
import nodehx.net.Server;
import nodehx.net.Socket;
import nodehx.stream.Readable;
import nodehx.stream.Writable;

/**
 * ChildProcess is an [EventEmitter][].
 * Child processes always have three streams associated with them. child.stdin,
 * child.stdout, and child.stderr.  These may be shared with the stdio
 * streams of the parent process, or they may be separate stream objects
 * which can be piped to and from.
 * The ChildProcess class is not intended to be used directly.  Use the
 * spawn() or fork() methods to create a Child Process instance.
 */
extern class ChildProcess extends EventEmitter {
	/**
	 * A Writable Stream that represents the child process's stdin. Closing 
	 * this stream via end() often causes the child process to terminate.
	 * If the child stdio streams are shared with the parent, then this will not be set.
	 */
	public var stdin(default, null) : Writable;
	
	/**
	 * A Readable Stream that represents the child process's stdout.
	 * If the child stdio streams are shared with the parent, then this will not be set.
	 */
	public var stdout(default, null) : Readable;
	
	/**
	 * A Readable Stream that represents the child process's stderr.
	 * If the child stdio streams are shared with the parent, then this will not be set.
	 */
	public var stderr(default, null) : Readable;
	
	/**
	 * The PID of the child process.
	 * Example:
	 * var spawn = require('child_process').spawn,
	 * 		grep  = spawn('grep', ['ssh']);
	 * console.log('Spawned child pid: ' + grep.pid);
	 * grep.stdin.end();
	 */
	public var pid(default, null) : Int;
	
	/**
	 * Send a signal to the child process. If no argument is given, the process will
	 * be sent "SIGTERM". See signal(7) for a list of available signals.
	 * var spawn = require("child_process").spawn,
	 *     grep  = spawn("grep", ["ssh"]);
	 * grep.on("close", function (code, signal) {
	 *   console.log("child process terminated due to receipt of signal "+signal);
	 * });
	 * // send SIGHUP to process
	 * grep.kill("SIGHUP");
	 * May emit an "error" event when the signal cannot be delivered. Sending a
	 * signal to a child process that has already exited is not an error but may
	 * have unforeseen consequences: if the PID (the process ID) has been reassigned
	 * to another process, the signal will be delivered to that process instead.
	 * What happens next is anyone"s guess.
	 * Note that while the function is called kill, the signal delivered to the
	 * child process may not actually kill it.  kill really just sends a signal
	 * to a process.
	 * See kill(2)
	 */
	public function kill(?signal : String) : Void;

	/**
	 * When using child_process.fork() you can write to the child using
	 * child.send(message, [sendHandle]) and messages are received by
	 * a "message" event on the child.
	 * For example:
	 * var cp = require("child_process");
	 * var n = cp.fork(__dirname + "/sub.js");
	 * n.on("message", function(m) {
	 *   console.log("PARENT got message:", m);
	 * });
	 * n.send({ hello: "world" });
	 * And then the child script, "sub.js" might look like this:
	 * process.on("message", function(m) {
	 *   console.log("CHILD got message:", m);
	 * });
	 * process.send({ foo: "bar" });
	 * In the child the process object will have a send() method, and process
	 * will emit objects each time it receives a message on its channel.
	 * There is a special case when sending a {cmd: "NODE_foo"} message. All messages
	 * containing a NODE_ prefix in its cmd property will not be emitted in
	 * the message event, since they are internal messages used by node core.
	 * Messages containing the prefix are emitted in the internalMessage event, you
	 * should by all means avoid using this feature, it is subject to change without notice.
	 * The sendHandle option to child.send() is for sending a TCP server or
	 * socket object to another process. The child will receive the object as its
	 * second argument to the message event.
	 * Emits an "error" event if the message cannot be sent, for example because
	 * the child process has already exited.
	 * Example: sending server object
	 * Here is an example of sending a server:
	 * var child = require("child_process").fork("child.js");
	 * // Open up the server object and send the handle.
	 * var server = require("net").createServer();
	 * server.on("connection", function (socket) {
	 *   socket.end("handled by parent");
	 * });
	 * server.listen(1337, function() {
	 *   child.send("server", server);
	 * });
	 * And the child would the receive the server object as:
	 * process.on("message", function(m, server) {
	 *   if (m === "server") {
	 *     server.on("connection", function (socket) {
	 *       socket.end("handled by child");
	 *     });
	 *   }
	 * });
	 * Note that the server is now shared between the parent and child, this means
	 * that some connections will be handled by the parent and some by the child.
	 * For dgram servers the workflow is exactly the same.  Here you listen on
	 * a message event instead of connection and use server.bind instead of
	 * server.listen.  (Currently only supported on UNIX platforms.)
	 * Example: sending socket object
	 * Here is an example of sending a socket. It will spawn two children and handle
	 * connections with the remote address 74.125.127.100 as VIP by sending the
	 * socket to a 'special' child process. Other sockets will go to a 'normal' process.
	 * var normal = require("child_process").fork("child.js", ["normal"]);
	 * var special = require("child_process").fork("child.js", ["special"]);
	 * // Open up the server and send sockets to child
	 * var server = require("net").createServer();
	 * server.on("connection", function (socket) {
	 *   // if this is a VIP
	 *   if (socket.remoteAddress === "74.125.127.100") {
	 *     special.send("socket", socket);
	 *     return;
	 *   }
	 *   // just the usual dudes
	 *   normal.send("socket", socket);
	 * });
	 * server.listen(1337);
	 * The child.js could look like this:
	 * process.on("message", function(m, socket) {
	 *   if (m === "socket") {
	 *     socket.end("You were handled as a " + process.argv[2] + " person");
	 *   }
	 * });
	 * Note that once a single socket has been sent to a child the parent can no
	 * longer keep track of when the socket is destroyed. To indicate this condition
	 * the .connections property becomes null.
	 * It is also recommended not to use .maxConnections in this condition.
	 */
	 @:overload(function(message : Dynamic, ?sendhandle : Socket) : Void {})
	public function send(message : Dynamic, ?sendHandle : Server) : Void;

	/**
	 * To close the IPC connection between parent and child use the
	 * child.disconnect() method. This allows the child to exit gracefully since
	 * there is no IPC channel keeping it alive. When calling this method the
	 * disconnect event will be emitted in both parent and child, and the
	 * connected flag will be set to false. Please note that you can also call
	 * process.disconnect() in the child process.
	 */
	public function disconnect() : Void;

}