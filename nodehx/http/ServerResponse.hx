package nodehx.http;
import nodehx.Buffer;
import nodehx.events.EventEmitter;
import nodehx.stream.Writable;

/**
 * This object is created internally by a HTTP server--not by the user. It is
 * passed as the second parameter to the "request" event.
 * The response implements the [Writable Stream][] interface. This is an
 * [EventEmitter][] with the following events:
 */
extern class ServerResponse extends Writable {
	/**
	 * When using implicit headers (not calling response.writeHead() explicitly), this property 
	 * controls the status code that will be sent to the client when the headers get flushed.
	 * Example:
	 * response.statusCode = 404;
	 * After response header was sent to the client, this property indicates 
	 * the status code which was sent out.
	 */
	public var statusCode : Int;
	
	/**
	 * True if headers were sent, false otherwise.
	 */
	public var headersSent(default, null) : Bool;
	
	/**
	 * When true, the Date header will be automatically generated and sent in the response 
	 * if it is not already present in the headers. Defaults to true.
	 * This should only be disabled for testing; HTTP requires the Date header in responses.
	 */
	public var sendDate : Bool;
	
	/**
	 * Removes a header that"s queued for implicit sending.
	 * Example:
	 * response.removeHeader('Content-Encoding');
	 */
	public function removeHeader(name : String) : Void;

	/**
	 * This method adds HTTP trailing headers (a header but at the end of the
	 * message) to the response.
	 * Trailers will only be emitted if chunked encoding is used for the
	 * response; if it is not (e.g., if the request was HTTP/1.0), they will
	 * be silently discarded.
	 * Note that HTTP requires the Trailer header to be sent if you intend to
	 * emit trailers, with a list of the header fields in its value. E.g.,
	 * response.writeHead(200, { "Content-Type": "text/plain",
	 *                           "Trailer": "Content-MD5" });
	 * response.write(fileData);
	 * response.addTrailers({"Content-MD5": '7895bf4b8828b55ceaf47747b4bca667'});
	 * response.end();
	 */
	public function addTrailers(headers : Dynamic<String>) : Void;

	/**
	 * Reads out a header that"s already been queued but not sent to the client.  Note
	 * that the name is case insensitive.  This can only be called before headers get
	 * implicitly flushed.
	 * Example:
	 * var contentType = response.getHeader("content-type");
	 */
	public function getHeader(name : String) : String;

	/**
	 * If this method is called and response.writeHead() has not been called, it will
	 * switch to implicit header mode and flush the implicit headers.
	 * This sends a chunk of the response body. This method may
	 * be called multiple times to provide successive parts of the body.
	 * chunk can be a string or a buffer. If chunk is a string,
	 * the second parameter specifies how to encode it into a byte stream.
	 * By default the encoding is "utf8".
	 * Note: This is the raw HTTP body and has nothing to do with
	 * higher-level multi-part body encodings that may be used.
	 * The first time response.write() is called, it will send the buffered
	 * header information and the first body to the client. The second time
	 * response.write() is called, Node assumes you"re going to be streaming
	 * data, and sends that separately. That is, the response is buffered up to the
	 * first chunk of body.
	 * Returns true if the entire data was flushed successfully to the kernel
	 * buffer. Returns false if all or part of the data was queued in user memory.
	 * "drain" will be emitted when the buffer is again free.
	 */
	@:overload(function(chunk : String, ?encoding : String, ?callback : ?Dynamic -> Void) : Bool {})
	public override function write(chunk : Buffer, ?callback : ?Dynamic -> Void) : Bool;

	/**
	 * Sets a single header value for implicit headers.  If this header already exists
	 * in the to-be-sent headers, its value will be replaced.  Use an array of strings
	 * here if you need to send multiple headers with the same name.
	 * Example:
	 * response.setHeader('Content-Type', 'text/html');
	 * or
	 * response.setHeader('Set-Cookie', ['type=ninja', 'language=javascript']);
	 */
	@:overload(function(name : String, values : Array<String>) : Void {})
	public function setHeader(name : String, value : String) : Void;

	/**
	 * Sends a response header to the request. The status code is a 3-digit HTTP
	 * status code, like 404. The last argument, headers, are the response headers.
	 * Optionally one can give a human-readable reasonPhrase as the second
	 * argument.
	 * Example:
	 * var body = "hello world";
	 * response.writeHead(200, {
	 *   "Content-Length": body.length,
	 *   "Content-Type": "text/plain" });
	 * This method must only be called once on a message and it must
	 * be called before response.end() is called.
	 * If you call response.write() or response.end() before calling this, the
	 * implicit/mutable headers will be calculated and call this function for you.
	 * Note: that Content-Length is given in bytes not characters. The above example
	 * works because the string "hello world" contains only single byte characters.
	 * If the body contains higher coded characters then Buffer.byteLength()
	 * should be used to determine the number of bytes in a given encoding.
	 * And Node does not check whether Content-Length and the length of the body
	 * which has been transmitted are equal or not.
	 */
	public function writeHead(statusCode : Int, ?reasonPhrase : String, ?headers : Dynamic<String>) : Void;

	/**
	 * Sets the Socket"s timeout value to msecs.  If a callback is
	 * provided, then it is added as a listener on the "timeout" event on
	 * the response object.
	 * If no "timeout" listener is added to the request, the response, or
	 * the server, then sockets are destroyed when they time out.  If you
	 * assign a handler on the request, the response, or the server"s
	 * "timeout" events, then it is your responsibility to handle timed out
	 * sockets.
	 */
	public function setTimeout(msecs : Int, ?callback : Void -> Void) : Void;

	/**
	 * Sends a HTTP/1.1 100 Continue message to the client, indicating that
	 * the request body should be sent. See the ["checkContinue"][] event on Server.
	 */
	public function writeContinue() : Void;

	/**
	 * This method signals to the server that all of the response headers and body
	 * have been sent; that server should consider this message complete.
	 * The method, response.end(), MUST be called on each
	 * response.
	 * If data is specified, it is equivalent to calling response.write(data, encoding)
	 * followed by response.end().
	 */
	@:overload(function(?callback : Void -> Void) : Dynamic {})
	@:overload(function(data : String, ?encoding : String, ?callback : Void -> Void) : Dynamic {})
	public override function end(data : Buffer, ?callback : Void -> Void) : Dynamic;
}