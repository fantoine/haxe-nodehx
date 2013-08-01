package nodehx.http;

import nodehx.net.Socket;
import nodehx.stream.Readable;

/**
 * An IncomingMessage object is created by http.Server or http.ClientRequest 
 * and passed as the first argument to the 'request' and 'response' event respectively. 
 * It may be used to access response status, headers and data.
 * It implements the Readable Stream interface, as well as the following additional 
 * events, methods, and properties.
 */
extern class IncomingMessage extends Readable {
	/**
	 * In case of server request, the HTTP version sent by the client. 
	 * In the case of client response, the HTTP version of the connected-to server. 
	 * Probably either '1.1' or '1.0'.
	 * Also response.httpVersionMajor is the first integer and response.httpVersionMinor 
	 * is the second.
	 */
	public var httpVersion : String;

	/**
	 * The request/response headers object.
	 * Read only map of header names and values. Header names are lower-cased. Example:
	 * // Prints something like:
	 * //
	 * // { 'user-agent': 'curl/7.22.0',
	 * //   host: '127.0.0.1:8000',
	 * //   accept: '*\/*' }
	 * console.log(request.headers);
	 **/
	public var headers : Dynamic<String>;

	/**
	 * The request / response trailers object. Only populated after the 'end' event.
	 */
	public var trailers : Dynamic;

	/**
	 * Only valid for request obtained from http.Server.
	 * The request method as a string. Read only. Example: 'GET', 'DELETE'.
	 */
	public var method(default, null) : String;

	/**
	 * Only valid for request obtained from http.Server.
	 * Request URL string. This contains only the URL that is present in the actual HTTP request. If the request is:
	 * GET /status?name=ryan HTTP/1.1\r\n
	 * Accept: text/plain\r\n
	 * \r\n
	 * Then request.url will be:
	 * '/status?name=ryan'
	 * If you would like to parse the URL into its parts, you can use require('url').parse(request.url). Example:
	 * node> require('url').parse('/status?name=ryan')
	 * { href: '/status?name=ryan',
	 *   search: '?name=ryan',
	 *   query: 'name=ryan',
	 *   pathname: '/status' }
	 * If you would like to extract the params from the query string, you can use the require('querystring').parse function, or pass true as the second argument to require('url').parse. Example:
	 * node> require('url').parse('/status?name=ryan', true)
	 * { href: '/status?name=ryan',
	 *   search: '?name=ryan',
	 *   query: { name: 'ryan' },
	 *   pathname: '/status' }
	 */
	public var url : String;
	
	/**
	 * Only valid for response obtained from http.ClientRequest.
	 * The 3-digit HTTP response status code. E.G. 404.
	 */
	public var statusCode : Int;

	/**
	 * The net.Socket object associated with the connection.
	 * With HTTPS support, use request.connection.verifyPeer() and 
	 * request.connection.getPeerCertificate() to obtain the client's authentication details.
	 */
	public var socket : Socket;

	/**
	 * Calls message.connection.setTimeout(msecs, callback).
	 */
	public function setTimeout(msecs : Int, callback : Void -> Void) : Void;
}