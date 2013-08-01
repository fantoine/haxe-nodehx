package nodehx.net;

import nodehx.events.EventEmitter;

/**
 * This object is an abstraction of a TCP or UNIX socket.  net.Socket
 * instances implement a duplex Stream interface.  They can be created by the
 * user and used as a client (with connect()) or they can be created by Node
 * and passed to the user through the "connection" event of a server.
 */
extern class Socket extends EventEmitter {
	/**
	 * net.Socket has the property that socket.write() always works. This is 
	 * to help users get up and running quickly. The computer cannot always 
	 * keep up with the amount of data that is written to a socket - the network 
	 * connection simply might be too slow. Node will internally queue up the data 
	 * written to a socket and send it out over the wire when it is possible. 
	 * (Internally it is polling on the socket's file descriptor for being writable).
	 * The consequence of this internal buffering is that memory may grow. 
	 * This property shows the number of characters currently buffered to be written. 
	 * (Number of characters is approximately equal to the number of bytes to be written, 
	 * but the buffer may contain strings, and the strings are lazily encoded, 
	 * so the exact number of bytes is not known.)
	 * Users who experience large or growing bufferSize should attempt to "throttle" 
	 * the data flows in their program with pause() and resume().
	 */
	public var bufferSize : Int;
	
	/**
	 * The string representation of the remote IP address. For example, '74.125.127.100' 
	 * or '2001:4860:a005::68'.
	 */
	public var remoteAddress(default, null) : String;
	
	/**
	 * The numeric representation of the remote port. For example, 80 or 21.
	 */
	public var remotePort(default, null) : Int;
	
	/**
	 * The string representation of the local IP address the remote client is connecting on. 
	 * For example, if you are listening on '0.0.0.0' and the client connects on '192.168.1.1', 
	 * the value would be '192.168.1.1'.
	 */
	public var localAddress(default, null) : String;
	
	/**
	 * The numeric representation of the local port. For example, 80 or 21.
	 */
	public var localPort(default, null) : Int;
	
	/**
	 * The amount of received bytes.
	 */
	public var bytesRead(default, null) : Int;
	
	/**
	 * The amount of bytes sent.
	 */
	public var bytesWritten(default, null) : Int;
	
	/**
	 * Set the encoding for the socket as a Readable Stream. See
	 * [stream.setEncoding()][] for more information.
	 */
	public function setEncoding(?encoding : String) : Void;

	/**
	 * Resumes reading after a call to pause().
	 */
	public function resume() : Void;

	/**
	 * Disables the Nagle algorithm. By default TCP connections use the Nagle
	 * algorithm, they buffer data before sending it off. Setting true for
	 * noDelay will immediately fire off data each time socket.write() is called.
	 * noDelay defaults to true.
	 */
	public function setNoDelay(?noDelay : Bool) : Void;

	/**
	 * Opens the connection for a given socket. If port and host are given,
	 * then the socket will be opened as a TCP socket, if host is omitted,
	 * localhost will be assumed. If a path is given, the socket will be
	 * opened as a unix socket to that path.
	 * Normally this method is not needed, as net.createConnection opens the
	 * socket. Use this only if you are implementing a custom Socket.
	 * This function is asynchronous. When the ["connect"][] event is emitted the
	 * socket is established. If there is a problem connecting, the "connect" event
	 * will not be emitted, the "error" event will be emitted with the exception.
	 * The connectListener parameter will be added as an listener for the
	 * ["connect"][] event.
	 */
	@:overload(function(port : Int, ?host : String, ?connectListener : Void -> Void) : Void {})
	public function connect(path : String, ?connectListener : Void -> Void) : Void;

	/**
	 * Sends data on the socket. The second parameter specifies the encoding in the
	 * case of a string--it defaults to UTF8 encoding.
	 * Returns true if the entire data was flushed successfully to the kernel
	 * buffer. Returns false if all or part of the data was queued in user memory.
	 * "drain" will be emitted when the buffer is again free.
	 * The optional callback parameter will be executed when the data is finally
	 * written out - this may not be immediately.
	 */
	public function write(data : Dynamic, ?encoding : String, ?callback : Void -> Void) : Bool;

	/**
	 * Opposite of unref, calling ref on a previously unrefd socket will not
	 * let the program exit if it"s the only socket left (the default behavior). If
	 * the socket is refd calling ref again will have no effect.
	 */
	public function ref() : Void;

	/**
	 * Pauses the reading of data. That is, "data" events will not be emitted.
	 * Useful to throttle back an upload.
	 */
	public function pause() : Void;

	/**
	 * Ensures that no more I/O activity happens on this socket. Only necessary in
	 * case of errors (parse error or so).
	 */
	public function destroy() : Void;

	/**
	 * Sets the socket to timeout after timeout milliseconds of inactivity on
	 * the socket. By default net.Socket do not have a timeout.
	 * When an idle timeout is triggered the socket will receive a "timeout"
	 * event but the connection will not be severed. The user must manually end()
	 * or destroy() the socket.
	 * If timeout is 0, then the existing idle timeout is disabled.
	 * The optional callback parameter will be added as a one time listener for the
	 * "timeout" event.
	 */
	public function setTimeout(timeout : Int, ?callback : Void -> Void) : Void;

	/**
	 * Half-closes the socket. i.e., it sends a FIN packet. It is possible the
	 * server will still send some data.
	 * If data is specified, it is equivalent to calling
	 * socket.write(data, encoding) followed by socket.end().
	 */
	public function end(?data : Dynamic, ?encoding : String) : Void;

	/**
	 * Calling unref on a socket will allow the program to exit if this is the only
	 * active socket in the event system. If the socket is already unrefd calling
	 * unref again will have no effect.
	 */
	public function unref() : Void;

	/**
	 * Construct a new socket object.
	 * options is an object with the following defaults:
	 * { fd: null
	 *   type: null
	 *   allowHalfOpen: false
	 * }
	 * fd allows you to specify the existing file descriptor of socket. type
	 * specified underlying protocol. It can be "tcp4", "tcp6", or "unix".
	 * About allowHalfOpen, refer to createServer() and "end" event.
	 */
	public function new(?options : Dynamic) : Void;

	/**
	 * Enable/disable keep-alive functionality, and optionally set the initial
	 * delay before the first keepalive probe is sent on an idle socket.
	 * enable defaults to false.
	 * Set initialDelay (in milliseconds) to set the delay between the last
	 * data packet received and the first keepalive probe. Setting 0 for
	 * initialDelay will leave the value unchanged from the default
	 * (or previous) setting. Defaults to 0.
	 */
	public function setKeepAlive(?enable : Bool, ?initialDelay : Int) : Void;

	/**
	 * Returns the bound address, the address family name and port of the
	 * socket as reported by the operating system. Returns an object with
	 * three properties, e.g.
	 * { port: 12346, family: "IPv4", address: "127.0.0.1" }
	 */
	public function address() : { port : Int, family : String, address : String };

}