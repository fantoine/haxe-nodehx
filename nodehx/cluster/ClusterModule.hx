package nodehx.cluster;

import nodehx.events.EventEmitter;

/**
 * A single instance of Node runs in a single thread. To take advantage of
 * multi-core systems the user will sometimes want to launch a cluster of Node
 * processes to handle the load.
 * The cluster module allows you to easily create a network of processes that
 * all share server ports.
 * var cluster = require("cluster");
 * var http = require("http");
 * var numCPUs = require("os").cpus().length;
 * if (cluster.isMaster) {
 *   // Fork workers.
 *   for (var i = 0; i < numCPUs; i++) {
 *     cluster.fork();
 *   }
 *   cluster.on("exit", function(worker, code, signal) {
 *     console.log("worker " + worker.process.pid + " died");
 *   });
 * } else {
 *   // Workers can share any TCP connection
 *   // In this case its a HTTP server
 *   http.createServer(function(req, res) {
 *     res.writeHead(200);
 *     res.end('hello world\n');
 *   }).listen(8000);
 * }
 * Running node will now share port 8000 between the workers:
 * % NODE_DEBUG=cluster node server.js
 * 23521,Master Worker 23524 online
 * 23521,Master Worker 23526 online
 * 23521,Master Worker 23523 online
 * 23521,Master Worker 23528 online
 * This feature was introduced recently, and may change in future versions.
 * Please try it out and provide feedback.
 * Also note that, on Windows, it is not yet possible to set up a named pipe
 * server in a worker.
 */
extern class ClusterModule extends EventEmitter implements nodehx.Node.NodeModule<"cluster", "child_process,events,net", "Worker"> {
	/**
	 * All settings set by the .setupMaster is stored in this settings object. 
	 * This object is not supposed to be changed or set manually, by you.
	 */
	public var settings(default, null) : Dynamic;
	
	/**
	 * True if the process is a master. This is determined by the process.env.NODE_UNIQUE_ID. 
	 * If process.env.NODE_UNIQUE_ID is undefined, then isMaster is true.
	 */
	public var isMaster(default, null) : Bool;
	
	/**
	 * This boolean flag is true if the process is a worker forked from a master. 
	 * If the process.env.NODE_UNIQUE_ID is set to a value, then isWorker is true.
	 */
	public var isWorker(default, null) : Bool;
	
	/**
	 * A reference to the current worker object. Not available in the master process.
	 * var cluster = require('cluster');
	 * if (cluster.isMaster) {
	 *   console.log('I am master');
	 *   cluster.fork();
	 *   cluster.fork();
	 * } else if (cluster.isWorker) {
	 *   console.log('I am worker #' + cluster.worker.id);
	 * }
	 */
	public var worker(default, null) : Null<Worker>;
	
	/**
	 * A hash that stores the active worker objects, keyed by id field. Makes it easy to loop through all the workers. It is only available in the master process.
	 * // Go through all workers
	 * function eachWorker(callback) {
	 *   for (var id in cluster.workers) {
	 *     callback(cluster.workers[id]);
	 *   }
	 * }
	 * eachWorker(function(worker) {
	 *   worker.send('big announcement to all workers');
	 * });
	 * Should you wish to reference a worker over a communication channel, using the worker's unique id is the easiest way to find the worker.
	 * socket.on('data', function(id) {
	 *   var worker = cluster.workers[id];
	 * });
	 */
	public var workers(default, null) : Dynamic<Worker>;
	
	/**
	 * Spawn a new worker process. This can only be called from the master process.
	 */
	public function fork(?env : Dynamic) : Worker;

	/**
	 * setupMaster is used to change the default "fork" behavior. The new settings
	 * are effective immediately and permanently, they cannot be changed later on.
	 * Example:
	 * var cluster = require('cluster');
	 * cluster.setupMaster({
	 *   exec : 'worker.js',
	 *   args : ['--use', 'https'],
	 *   silent : true
	 * });
	 * cluster.fork();
	 */
	public function setupMaster(?settings : Dynamic) : Void;

	/**
	 * When calling this method, all workers will commit a graceful suicide. When they are
	 * disconnected all internal handlers will be closed, allowing the master process to
	 * die graceful if no other event is waiting.
	 * The method takes an optional callback argument which will be called when finished.
	 */
	public function disconnect(?callback : Void -> Void) : Void;

}