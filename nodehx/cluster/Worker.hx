package nodehx.cluster;

import nodehx.child_process.ChildProcess;
import nodehx.events.EventEmitter;
import nodehx.net.Server;
import nodehx.net.Socket;

/**
 * A Worker object contains all public information and method about a worker.
 * In the master it can be obtained using cluster.workers. In a worker
 * it can be obtained using cluster.worker.
 */
extern class Worker extends EventEmitter {
	/**
	 * Each new worker is given its own unique id, this id is stored in the id.
	 * While a worker is alive, this is the key that indexes it in cluster.workers
	 */
	public var id(default, null) : String;
	
	/**
	 * All workers are created using child_process.fork(), the returned object 
	 * from this function is stored in process.
	 */
	public var process(default, null) : ChildProcess;
	
	/**
	 * This property is a boolean. It is set when a worker dies after calling .kill() 
	 * or immediately after calling the .disconnect() method. Until then it is undefined.
	 */
	public var suicide(default, null) : Null<Bool>;
	
	/**
	 * This function will kill the worker, and inform the master to not spawn a
	 * new worker.  The boolean suicide lets you distinguish between voluntary
	 * and accidental exit.
	 * cluster.on("exit", function(worker, code, signal) {
	 *   if (worker.suicide === true) {
	 *     console.log("Oh, it was just suicide\" – no need to worry").
	 *   }
	 * });
	 * // kill worker
	 * worker.kill();
	 * This method is aliased as worker.destroy() for backwards
	 * compatibility.
	 */
	public function kill(?signal : String) : Void;

	/**
	 * This function is equal to the send methods provided by
	 * child_process.fork().  In the master you should use this function to
	 * send a message to a specific worker.  However in a worker you can also use
	 * process.send(message), since this is the same function.
	 * This example will echo back all messages from the master:
	 * if (cluster.isMaster) {
	 *   var worker = cluster.fork();
	 *   worker.send("hi there");
	 * } else if (cluster.isWorker) {
	 *   process.on("message", function(msg) {
	 *     process.send(msg);
	 *   });
	 * }
	 */
	 @:overload(function(message : Dynamic, ?sendHandle : Server) : Void {})
	public function send(message : Dynamic, ?sendHandle: Socket) : Void;

	/**
	 * When calling this function the worker will no longer accept new connections, but
	 * they will be handled by any other listening worker. Existing connection will be
	 * allowed to exit as usual. When no more connections exist, the IPC channel to the worker
	 * will close allowing it to die graceful. When the IPC channel is closed the disconnect
	 * event will emit, this is then followed by the exit event, there is emitted when
	 * the worker finally die.
	 * Because there might be long living connections, it is useful to implement a timeout.
	 * This example ask the worker to disconnect and after 2 seconds it will destroy the
	 * server. An alternative would be to execute worker.kill() after 2 seconds, but
	 * that would normally not allow the worker to do any cleanup if needed.
	 * if (cluster.isMaster) {
	 *   var worker = cluster.fork();
	 *   var timeout;
	 *   worker.on("listening", function(address) {
	 *     worker.disconnect();
	 *     timeout = setTimeout(function() {
	 *       worker.send("force kill");
	 *     }, 2000);
	 *   });
	 *   worker.on("disconnect", function() {
	 *     clearTimeout(timeout);
	 *   });
	 * } else if (cluster.isWorker) {
	 *   var net = require("net");
	 *   var server = net.createServer(function(socket) {
	 *     // connection never end
	 *   });
	 *   server.listen(8000);
	 *   server.on("close", function() {
	 *     // cleanup
	 *   });
	 *   process.on("message", function(msg) {
	 *     if (msg === "force kill") {
	 *       server.close();
	 *     }
	 *   });
	 * }
	 */
	public function disconnect() : Void;

}