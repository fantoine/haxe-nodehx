package nodehx.http;

import nodehx.net.Server;
import nodehx.net.Socket;

/**
 * This is an [EventEmitter][] with the following events:
 */
extern class Server {
	/**
	 * Limits maximum incoming headers count, equal to 1000 by default. 
	 * If set to 0 - no limit will be applied.
	 */
	public var maxHeadersCount : Int;
	
	/**
	 * The number of milliseconds of inactivity before a socket is presumed to have timed out.
	 * Note that the socket timeout logic is set up on connection, so changing this value only 
	 * affects new connections to the server, not any existing connections.
	 * Set to 0 to disable any kind of automatic timeout behavior on incoming connections.
	 */
	public var timeout : Int;
	
	/**
	 * Begin accepting connections on the specified port and hostname.  If the
	 * hostname is omitted, the server will accept connections directed to any
	 * IPv4 address (INADDR_ANY).
	 * To listen to a unix socket, supply a filename instead of port and hostname.
	 * Backlog is the maximum length of the queue of pending connections.
	 * The actual length will be determined by your OS through sysctl settings such as
	 * tcp_max_syn_backlog and somaxconn on linux. The default value of this
	 * parameter is 511 (not 512).
	 * This function is asynchronous. The last parameter callback will be added as
	 * a listener for the ["listening"][] event.  See also [net.Server.listen(port)][].
	 */
	@:overload(function(path : String, ?callback : Void -> Void) : Server {})
	@:overload(function(handle : Server, ?callback : Void -> Void) : Server {})
	@:overload(function(handle : Socket, ?callback : Void -> Void) : Server {})
	public function listen(port : Int, ?hostname : String, ?backlog : Int, ?callback : Void -> Void) : Server;

	/**
	 * Sets the timeout value for sockets, and emits a "timeout" event on
	 * the Server object, passing the socket as an argument, if a timeout
	 * occurs.
	 * If there is a "timeout" event listener on the Server object, then it
	 * will be called with the timed-out socket as an argument.
	 * By default, the Server"s timeout value is 2 minutes, and sockets are
	 * destroyed automatically if they time out.  However, if you assign a
	 * callback to the Server"s "timeout" event, then you are responsible
	 * for handling socket timeouts.
	 */
	public function setTimeout(msecs : Int, callback : Void -> Void) : Dynamic;

	/**
	 * Stops the server from accepting new connections.  See [net.Server.close()][].
	 */
	public function close(?callback : Void -> Void) : Void;

}