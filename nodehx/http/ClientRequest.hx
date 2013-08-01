package nodehx.http;
import nodehx.Buffer;
import nodehx.events.EventEmitter;

/**
 * This object is created internally and returned from http.request().  It
 * represents an in-progress request whose header has already been queued.  The
 * header is still mutable using the setHeader(name, value), getHeader(name),
 * removeHeader(name) API.  The actual header will be sent along with the first
 * data chunk or when closing the connection.
 * To get the response, add a listener for "response" to the request object.
 * "response" will be emitted from the request object when the response
 * headers have been received.  The "response" event is executed with one
 * argument which is an instance of http.IncomingMessage.
 * During the "response" event, one can add listeners to the
 * response object; particularly to listen for the "data" event.
 * If no "response" handler is added, then the response will be
 * entirely discarded.  However, if you add a "response" event handler,
 * then you must consume the data from the response object, either by
 * calling response.read() whenever there is a "readable" event, or
 * by adding a "data" handler, or by calling the .resume() method.
 * Until the data is consumed, the "end" event will not fire.
 * Note: Node does not check whether Content-Length and the length of the body
 * which has been transmitted are equal or not.
 * The request implements the [Writable Stream][] interface. This is an
 * [EventEmitter][] with the following events:
 */
extern class ClientRequest extends EventEmitter {
	/**
	 * Once a socket is assigned to this request and is connected
	 * [socket.setNoDelay()][] will be called.
	 */
	public function setNoDelay(?noDelay : Bool) : Void;

	/**
	 * Sends a chunk of the body.  By calling this method
	 * many times, the user can stream a request body to a
	 * server--in that case it is suggested to use the
	 * ["Transfer-Encoding", "chunked"] header line when
	 * creating the request.
	 * The chunk argument should be a [Buffer][] or a string.
	 * The encoding argument is optional and only applies when chunk is a string.
	 * Defaults to "utf8".
	 */
	@:overload(function(chunk : Buffer) : Void {})
	public function write(chunk : String, encoding : String) : Void;

	/**
	 * Once a socket is assigned to this request and is connected
	 * [socket.setTimeout()][] will be called.
	 */
	public function setTimeout(timeout : Int, ?callback : Void -> Void) : Void;

	/**
	 * Finishes sending the request. If any parts of the body are
	 * unsent, it will flush them to the stream. If the request is
	 * chunked, this will send the terminating "0\r\n\r\n".
	 * If data is specified, it is equivalent to calling
	 * request.write(data, encoding) followed by request.end().
	 */
	@:overload(function() : Void {})
	@:overload(function(data : Buffer) : Void {})
	public function end(data : String, encoding : String) : Void;

	/**
	 * Aborts a request.  (New since v0.3.8.)
	 */
	public function abort() : Void;

	/**
	 * Once a socket is assigned to this request and is connected
	 * [socket.setKeepAlive()][] will be called.
	 */
	public function setSocketKeepAlive(?enable : Bool, ?initialDelay : Int) : Void;

}