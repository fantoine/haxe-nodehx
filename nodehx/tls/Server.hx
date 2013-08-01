package nodehx.tls;

/**
 * This class is a subclass of net.Server and has the same methods on it.
 * Instead of accepting just raw TCP connections, this accepts encrypted
 * connections using TLS or SSL.
 */
extern class Server extends nodehx.net.Server {
	/**
	 * The number of concurrent connections on the server.
	 */
	public var connections(default, null) : Int;
	
	/**
	 * Add secure context that will be used if client request"s SNI hostname is
	 * matching passed hostname (wildcards can be used). credentials can contain
	 * key, cert and ca.
	 */
	public function addContext(hostname : String, credentials : Dynamic) : Void;

}