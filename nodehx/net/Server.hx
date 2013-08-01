package nodehx.net;

import nodehx.Error;
import nodehx.events.EventEmitter;

/**
 * This class is used to create a TCP or UNIX server.
 * A server is a net.Socket that can listen for new incoming connections.
 */
extern class Server extends EventEmitter {
	/**
	 * Set this property to reject connections when the server's connection count gets high.
	 * It is not recommended to use this option once a socket has been sent to a child with child_process.fork().
	 */
	public var maxConnections : Int;
	
	/**
	 * Opposite of unref, calling ref on a previously unrefd server will not
	 * let the program exit if it"s the only server left (the default behavior). If
	 * the server is refd calling ref again will have no effect.
	 */
	public function ref() : Void;

	/**
	 * Asynchronously get the number of concurrent connections on the server. Works
	 * when sockets were sent to forks.
	 * Callback should take two arguments err and count.
	 */
	public function getConnections(callback : Error -> Int -> Void) : Void;

	/**
	 * Begin accepting connections on the specified port and host.  If the
	 * host is omitted, the server will accept connections directed to any
	 * IPv4 address (INADDR_ANY). A port value of zero will assign a random port.
	 * Backlog is the maximum length of the queue of pending connections.
	 * The actual length will be determined by your OS through sysctl settings such as
	 * tcp_max_syn_backlog and somaxconn on linux. The default value of this
	 * parameter is 511 (not 512).
	 * This function is asynchronous.  When the server has been bound,
	 * ["listening"][] event will be emitted.  The last parameter callback
	 * will be added as an listener for the ["listening"][] event.
	 * One issue some users run into is getting EADDRINUSE errors. This means that
	 * another server is already running on the requested port. One way of handling this
	 * would be to wait a second and then try again. This can be done with
	 * server.on("error", function (e) {
	 *   if (e.code == "EADDRINUSE") {
	 *     console.log("Address in use, retrying...");
	 *     setTimeout(function () {
	 *       server.close();
	 *       server.listen(PORT, HOST);
	 *     }, 1000);
	 *   }
	 * });
	 * (Note: All sockets in Node set SO_REUSEADDR already)
	 */
	@:overload(function(path : String, ?callback : Void -> Void) : Void {})
	@:overload(function(handle : Server, ?callback : Void -> Void) : Void {})
	@:overload(function(handle : Socket, ?callback : Void -> Void) : Void {})
	public function listen(port : Int, ?host : String, ?backlog : Int, ?callback : Void -> Void) : Void;

	/**
	 * Stops the server from accepting new connections and keeps existing
	 * connections. This function is asynchronous, the server is finally
	 * closed when all connections are ended and the server emits a "close"
	 * event. Optionally, you can pass a callback to listen for the "close"
	 * event.
	 */
	public function close(?callback : Void -> Void) : Void;

	/**
	 * Calling unref on a server will allow the program to exit if this is the only
	 * active server in the event system. If the server is already unrefd calling
	 * unref again will have no effect.
	 */
	public function unref() : Void;

	/**
	 * Returns the bound address, the address family name and port of the server
	 * as reported by the operating system.
	 * Useful to find which port was assigned when giving getting an OS-assigned address.
	 * Returns an object with three properties, e.g.
	 * { port: 12346, family: "IPv4", address: "127.0.0.1" }
	 * Example:
	 * var server = net.createServer(function (socket) {
	 *   socket.end('goodbye\n');
	 * });
	 * // grab a random port.
	 * server.listen(function() {
	 *   address = server.address();
	 *   console.log('opened server on %j', address);
	 * });
	 * Don"t call server.address() until the "listening" event has been emitted.
	 */
	public function address() : { port : Int, family : String, address : String };

}