package nodehx.tls;

import nodehx.stream.Duplex;

/**
 * This is a stream on top of the Encrypted stream that makes it possible to
 * read/write an encrypted data as a cleartext data.
 * This instance implements a duplex [Stream][] interfaces.  It has all the
 * common stream methods and events.
 * A ClearTextStream is the clear member of a SecurePair object.
 */
extern class CleartextStream extends Duplex {
	/**
	 * A boolean that is true if the peer certificate was signed by one of the specified CAs,
	 * otherwise false
	 */
	public var authorized(default, null) : Bool;
	
	/**
	 * The reason why the peer's certificate has not been verified. This property becomes 
	 * available only when cleartextStream.authorized === false.
	 */
	public var authorizationError(default, null) : Bool;
	
	/**
	 * The string representation of the remote IP address. 
	 * For example, '74.125.127.100' or '2001:4860:a005::68'.
	 */
	public var remoteAddress(default, null) : String;
	
	/**
	 * The numeric representation of the remote port. For example, 443.
	 */
	public var remotePort(default, null) : Int;
	
	/**
	 * Returns an object representing the peer"s certificate. The returned object has
	 * some properties corresponding to the field of the certificate.
	 * Example:
	 * { subject: 
	 *    { C: "UK",
	 *      ST: "Acknack Ltd",
	 *      L: "Rhys Jones",
	 *      O: "node.js",
	 *      OU: "Test TLS Certificate",
	 *      CN: "localhost" },
	 *   issuer: 
	 *    { C: "UK",
	 *      ST: "Acknack Ltd",
	 *      L: "Rhys Jones",
	 *      O: "node.js",
	 *      OU: "Test TLS Certificate",
	 *      CN: "localhost" },
	 *   valid_from: "Nov 11 09:52:22 2009 GMT",
	 *   valid_to: "Nov  6 09:52:22 2029 GMT",
	 *   fingerprint: "2A:7A:C2:DD:E5:F9:CC:53:72:35:99:7A:02:5A:71:38:52:EC:8A:DF" }
	 * If the peer does not provide a certificate, it returns null or an empty
	 * object.
	 */
	public function getPeerCertificate() : Dynamic;

	/**
	 * Returns an object representing the cipher name and the SSL/TLS
	 * protocol version of the current connection.
	 * Example:
	 * { name: "AES256-SHA", version: "TLSv1/SSLv3" }
	 * See SSL_CIPHER_get_name() and SSL_CIPHER_get_version() in
	 * http://www.openssl.org/docs/ssl/ssl.html#DEALING_WITH_CIPHERS for more
	 * information.
	 */
	public function getCipher() : { name : String, version : String };

	/**
	 * Returns the bound address, the address family name and port of the
	 * underlying socket as reported by the operating system. Returns an
	 * object with three properties, e.g.
	 * { port: 12346, family: "IPv4", address: "127.0.0.1" }
	 */
	public function address() : { port : Int, family : String, address : String };

}