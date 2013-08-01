package nodehx.net;

import nodehx.events.EventEmitter;

/**
 * The net module provides you with an asynchronous network wrapper. It contains
 * methods for creating both servers and clients (called streams). You can include
 * this module with require("net");
 */
extern class NetModule extends EventEmitter implements nodehx.Node.NodeModule<"net", "events", "Server,Socket"> {
	/**
	 * Constructs a new socket object and opens the socket to the given location.
	 * When the socket is established, the ["connect"][] event will be emitted.
	 * For TCP sockets, options argument should be an object which specifies:
	 * port: Port the client should connect to (Required).
	 * host: Host the client should connect to. Defaults to "localhost".
	 * localAddress: Local interface to bind to for network connections.
	 * For UNIX domain sockets, options argument should be an object which specifies:
	 * path: Path the client should connect to (Required).
	 * Common options are:
	 * allowHalfOpen: if true, the socket won"t automatically send
	 * a FIN packet when the other end of the socket sends a FIN packet.
	 * Defaults to false.  See ["end"][] event for more information.
	 * The connectListener parameter will be added as an listener for the
	 * ["connect"][] event.
	 * Here is an example of a client of echo server as described previously:
	 * var net = require("net");
	 * var client = net.connect({port: 8124},
	 *     function() { //"connect" listener
	 *   console.log("client connected");
	 *   client.write("world!\r\n");
	 * });
	 * client.on("data", function(data) {
	 *   console.log(data.toString());
	 *   client.end();
	 * });
	 * client.on("end", function() {
	 *   console.log("client disconnected");
	 * });
	 * To connect on the socket /tmp/echo.sock the second line would just be
	 * changed to
	 * var client = net.connect({path: "/tmp/echo.sock"},
	 */
	@:overload(function(port : Int, ?host : String, ?connectListener : Void -> Void) : Socket {})
	@:overload(function(path : String, ?connectListener : Void -> Void) : Socket {})
	public function connect(options : Dynamic, ?connectionListener : Void -> Void) : Socket;

	/**
	 * Constructs a new socket object and opens the socket to the given location.
	 * When the socket is established, the ["connect"][] event will be emitted.
	 * For TCP sockets, options argument should be an object which specifies:
	 * port: Port the client should connect to (Required).
	 * host: Host the client should connect to. Defaults to "localhost".
	 * localAddress: Local interface to bind to for network connections.
	 * For UNIX domain sockets, options argument should be an object which specifies:
	 * path: Path the client should connect to (Required).
	 * Common options are:
	 * allowHalfOpen: if true, the socket won"t automatically send
	 * a FIN packet when the other end of the socket sends a FIN packet.
	 * Defaults to false.  See ["end"][] event for more information.
	 * The connectListener parameter will be added as an listener for the
	 * ["connect"][] event.
	 * Here is an example of a client of echo server as described previously:
	 * var net = require("net");
	 * var client = net.connect({port: 8124},
	 *     function() { //"connect" listener
	 *   console.log("client connected");
	 *   client.write("world!\r\n");
	 * });
	 * client.on("data", function(data) {
	 *   console.log(data.toString());
	 *   client.end();
	 * });
	 * client.on("end", function() {
	 *   console.log("client disconnected");
	 * });
	 * To connect on the socket /tmp/echo.sock the second line would just be
	 * changed to
	 * var client = net.connect({path: "/tmp/echo.sock"},
	 */
	@:overload(function(port : Int, ?host : String, ?connectListener : Void -> Void) : Socket {})
	@:overload(function(path : String, ?connectListener : Void -> Void) : Socket {})
	public function createConnection(options : Dynamic, ?connectionListener : Void -> Void) : Socket;

	/**
	 * Tests if input is an IP address. Returns 0 for invalid strings,
	 * returns 4 for IP version 4 addresses, and returns 6 for IP version 6 addresses.
	 */
	public function isIP(input : String) : Bool;

	/**
	 * Returns true if input is a version 4 IP address, otherwise returns false.
	 */
	public function isIPv4(input : String) : Bool;

	/**
	 * Creates a new TCP server. The connectionListener argument is
	 * automatically set as a listener for the ["connection"][] event.
	 * options is an object with the following defaults:
	 * { allowHalfOpen: false
	 * }
	 * If allowHalfOpen is true, then the socket won"t automatically send a FIN
	 * packet when the other end of the socket sends a FIN packet. The socket becomes
	 * non-readable, but still writable. You should call the end() method explicitly.
	 * See ["end"][] event for more information.
	 * Here is an example of an echo server which listens for connections
	 * on port 8124:
	 * var net = require("net");
	 * var server = net.createServer(function(c) { //"connection" listener
	 *   console.log("server connected");
	 *   c.on("end", function() {
	 *     console.log("server disconnected");
	 *   });
	 *   c.write("hello\r\n");
	 *   c.pipe(c);
	 * });
	 * server.listen(8124, function() { //"listening" listener
	 *   console.log("server bound");
	 * });
	 * Test this by using telnet:
	 * telnet localhost 8124
	 * To listen on the socket /tmp/echo.sock the third line from the last would
	 * just be changed to
	 * server.listen("/tmp/echo.sock", function() { //"listening" listener
	 * Use nc to connect to a UNIX domain socket server:
	 * nc -U /tmp/echo.sock
	 */
	public function createServer(?options : Dynamic, ?connectionListener : ?Socket -> Void) : Void;

	/**
	 * Returns true if input is a version 6 IP address, otherwise returns false.
	 */
	public function isIPv6(input : String) : Bool;

}
