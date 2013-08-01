package nodehx.http;

/**
 * To use the HTTP server and client one must require("http").
 * The HTTP interfaces in Node are designed to support many features
 * of the protocol which have been traditionally difficult to use.
 * In particular, large, possibly chunk-encoded, messages. The interface is
 * careful to never buffer entire requests or responses--the
 * user is able to stream data.
 * HTTP message headers are represented by an object like this:
 * { "content-length": "123",
 *   "content-type": "text/plain",
 *   "connection": "keep-alive",
 *   "accept": "*\/*" }
 * Keys are lowercased. Values are not modified.
 * In order to support the full spectrum of possible HTTP applications, Node"s
 * HTTP API is very low-level. It deals with stream handling and message
 * parsing only. It parses a message into headers and body but it does not
 * parse the actual headers or the body.
 */
extern class HttpModule implements nodehx.Node.NodeModule<"http", "events,net,stream", "Agent,ClientRequest,IncomingMessage,Server,ServerResponse"> {
	/**
	 * A collection of all the standard HTTP response status codes, and the short description of each. For example,
	 */
	public var STATUS_CODES(default, null) : Array<String>;
	
	/**
	 * Global instance of Agent which is used as the default for all http client requests.
	 */
	public var globalAgent : Agent;
	
	/**
	 * This function is deprecated; please use [http.request()][] instead.
	 * Constructs a new HTTP client. port and host refer to the server to be
	 * connected to.
	 */
	public function createClient(?port : Int, ?host : String) : ClientRequest;

	/**
	 * Returns a new web server object.
	 * The requestListener is a function which is automatically
	 * added to the "request" event.
	 */
	public function createServer(?requestListener : IncomingMessage -> ServerResponse -> Void) : Server;

	/**
	 * Node maintains several connections per server to make HTTP requests.
	 * This function allows one to transparently issue requests.
	 * options can be an object or a string. If options is a string, it is
	 * automatically parsed with [url.parse()][].
	 * Options:
	 * host: A domain name or IP address of the server to issue the request to.
	 * Defaults to "localhost".
	 * hostname: To support url.parse() hostname is preferred over host
	 * port: Port of remote server. Defaults to 80.
	 * localAddress: Local interface to bind for network connections.
	 * socketPath: Unix Domain Socket (use one of host:port or socketPath)
	 * method: A string specifying the HTTP request method. Defaults to "GET".
	 * path: Request path. Defaults to "/". Should include query string if any.
	 * E.G. "/index.html?page=12"
	 * headers: An object containing request headers.
	 * auth: Basic authentication i.e. "user:password" to compute an
	 * Authorization header.
	 * agent: Controls [Agent][] behavior. When an Agent is used request will
	 * default to Connection: keep-alive. Possible values:
	 * undefined (default): use [global Agent][] for this host and port.
	 * Agent object: explicitly use the passed in Agent.
	 * false: opts out of connection pooling with an Agent, defaults request to
	 * Connection: close.
	 * http.request() returns an instance of the http.ClientRequest
	 * class. The ClientRequest instance is a writable stream. If one needs to
	 * upload a file with a POST request, then write to the ClientRequest object.
	 * Example:
	 * var options = {
	 *   hostname: "www.google.com",
	 *   port: 80,
	 *   path: "/upload",
	 *   method: "POST"
	 * };
	 * var req = http.request(options, function(res) {
	 *   console.log("STATUS: " + res.statusCode);
	 *   console.log("HEADERS: " + JSON.stringify(res.headers));
	 *   res.setEncoding("utf8");
	 *   res.on("data", function (chunk) {
	 *     console.log("BODY: " + chunk);
	 *   });
	 * });
	 * req.on("error", function(e) {
	 *   console.log("problem with request: " + e.message);
	 * });
	 * // write data to request body
	 * req.write("data\n");
	 * req.write("data\n");
	 * req.end();
	 * Note that in the example req.end() was called. With http.request() one
	 * must always call req.end() to signify that you"re done with the request -
	 * even if there is no data being written to the request body.
	 * If any error is encountered during the request (be that with DNS resolution,
	 * TCP level errors, or actual HTTP parse errors) an "error" event is emitted
	 * on the returned request object.
	 * There are a few special headers that should be noted.
	 * Sending a "Connection: keep-alive" will notify Node that the connection to
	 * the server should be persisted until the next request.
	 * Sending a "Content-length" header will disable the default chunked encoding.
	 * Sending an "Expect" header will immediately send the request headers.
	 * Usually, when sending "Expect: 100-continue", you should both set a timeout
	 * and listen for the continue event. See RFC2616 Section 8.2.3 for more
	 * information.
	 * Sending an Authorization header will override using the auth option
	 * to compute basic authentication.
	 */
	public function request(options : Dynamic, callback : IncomingMessage -> Void) : ClientRequest;

	/**
	 * Since most requests are GET requests without bodies, Node provides this
	 * convenience method. The only difference between this method and http.request()
	 * is that it sets the method to GET and calls req.end() automatically.
	 * Example:
	 * http.get('http://www.google.com/index.html', function(res) {
	 *   console.log('Got response: ' + res.statusCode);
	 * }).on("error", function(e) {
	 *   console.log('Got error: ' + e.message);
	 * });
	 */
	public function get(options : Dynamic, callback : IncomingMessage -> Void) : ClientRequest;

}
