package nodehx.repl;
import nodehx.events.EventEmitter;

/**
 * A Read-Eval-Print-Loop (REPL) is available both as a standalone program and
 * easily includable in other programs. The REPL provides a way to interactively
 * run JavaScript and see the results.  It can be used for debugging, testing, or
 * just trying things out.
 * By executing node without any arguments from the command-line you will be
 * dropped into the REPL. It has simplistic emacs line-editing.
 * mjr:~$ node
 * Type ".help" for options.
 * > a = [ 1, 2, 3];
 * [ 1, 2, 3 ]
 * > a.forEach(function (v) {
 * ...   console.log(v);
 * ...   });
 * 1
 * 2
 * 3
 * For advanced line-editors, start node with the environmental variable
 * NODE_NO_READLINE=1. This will start the main and debugger REPL in canonical
 * terminal settings which will allow you to use with rlwrap.
 * For example, you could add this to your bashrc file:
 * alias node='env NODE_NO_READLINE=1 rlwrap node'
 */
extern class ReplModule extends EventEmitter implements nodehx.Node.NodeModule<"repl", "events", ""> {
	/**
	 * Returns and starts a REPLServer instance. Accepts an 'options' Object that
	 * takes the following values:
	 * prompt - the prompt and stream for all I/O. Defaults to > .
	 * input - the readable stream to listen to. Defaults to process.stdin.
	 * output - the writable stream to write readline data to. Defaults to
	 * process.stdout.
	 * terminal - pass true if the stream should be treated like a TTY, and
	 * have ANSI/VT100 escape codes written to it. Defaults to checking isTTY
	 * on the output stream upon instantiation.
	 * eval - function that will be used to eval each given line. Defaults to
	 * an async wrapper for eval(). See below for an example of a custom eval.
	 * useColors - a boolean which specifies whether or not the writer function
	 * should output colors. If a different writer function is set then this does
	 * nothing. Defaults to the repl"s terminal value.
	 * useGlobal - if set to true, then the repl will use the global object,
	 * instead of running scripts in a separate context. Defaults to false.
	 * ignoreUndefined - if set to true, then the repl will not output the
	 * return value of command if it"s undefined. Defaults to false.
	 * writer - the function to invoke for each command that gets evaluated which
	 * returns the formatting (including coloring) to display. Defaults to
	 * util.inspect.
	 * You can use your own eval function if it has following signature:
	 * function eval(cmd, context, filename, callback) {
	 *   callback(null, result);
	 * }
	 * Multiple REPLs may be started against the same running instance of node.  Each
	 * will share the same global object but will have unique I/O.
	 * Here is an example that starts a REPL on stdin, a Unix socket, and a TCP socket:
	 * var net = require('net'),
	 *     repl = require('repl');
	 * connections = 0;
	 * repl.start({
	 *   prompt: 'node via stdin> ',
	 *   input: process.stdin,
	 *   output: process.stdout
	 * });
	 * net.createServer(function (socket) {
	 *   connections += 1;
	 *   repl.start({
	 *     prompt: 'node via Unix socket> ',
	 *     input: socket,
	 *     output: socket
	 *   }).on("exit", function() {
	 *     socket.end();
	 *   })
	 * }).listen('/tmp/node-repl-sock');
	 * net.createServer(function (socket) {
	 *   connections += 1;
	 *   repl.start({
	 *     prompt: 'node via TCP socket> ',
	 *     input: socket,
	 *     output: socket
	 *   }).on("exit", function() {
	 *     socket.end();
	 *   });
	 * }).listen(5001);
	 * Running this program from the command line will start a REPL on stdin.  Other
	 * REPL clients may connect through the Unix socket or TCP socket. telnet is useful
	 * for connecting to TCP sockets, and socat can be used to connect to both Unix and
	 * TCP sockets.
	 * By starting a REPL from a Unix socket-based server instead of stdin, you can
	 * connect to a long-running node process without restarting it.
	 * For an example of running a 'full-featured' (terminal) REPL over
	 * a net.Server and net.Socket instance, see: https://gist.github.com/2209310
	 * For an example of running a REPL instance over curl(1),
	 * see: https://gist.github.com/2053342
	 */
	public function start(options : Dynamic) : Dynamic;

}
