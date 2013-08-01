package nodehx.tls;

/**
 * Use require("tls") to access this module.
 * The tls module uses OpenSSL to provide Transport Layer Security and/or
 * Secure Socket Layer: encrypted stream communication.
 * TLS/SSL is a public/private key infrastructure. Each client and each
 * server must have a private key. A private key is created like this
 * openssl genrsa -out ryans-key.pem 1024
 * All severs and some clients need to have a certificate. Certificates are public
 * keys signed by a Certificate Authority or self-signed. The first step to
 * getting a certificate is to create a 'Certificate Signing Request' (CSR)
 * file. This is done with:
 * openssl req -new -key ryans-key.pem -out ryans-csr.pem
 * To create a self-signed certificate with the CSR, do this:
 * openssl x509 -req -in ryans-csr.pem -signkey ryans-key.pem -out ryans-cert.pem
 * Alternatively you can send the CSR to a Certificate Authority for signing.
 * (TODO: docs on creating a CA, for now interested users should just look at
 * test/fixtures/keys/Makefile in the Node source code)
 * To create .pfx or .p12, do this:
 * openssl pkcs12 -export -in agent5-cert.pem -inkey agent5-key.pem \
 *     -certfile ca-cert.pem -out agent5.pfx
 * in:  certificate
 * inkey: private key
 * certfile: all CA certs concatenated in one file like
 * cat ca1-cert.pem ca2-cert.pem > ca-cert.pem
 */
extern class TlsModule implements nodehx.Node.NodeModule<"tls", "stream", "CleartextStream,CryptoStream,SecurePair,Server"> {
	/**
	 * Size of slab buffer used by all tls servers and clients. Default: 10 * 1024 * 1024.
	 * Don't change the defaults unless you know what you are doing.
	 */
	public var SLAB_BUFFER_SIZE(default, null) : Int;
	
	/**
	 * Returns an array with the names of the supported SSL ciphers.
	 * Example:
	 * var ciphers = tls.getCiphers();
	 * console.log(ciphers); // ["AES128-SHA", "AES256-SHA", ...]
	 */
	public function getCiphers() : Array<String>;

	/**
	 * Creates a new client connection to the given port and host (old API) or
	 * options.port and options.host. (If host is omitted, it defaults to
	 * localhost.) options should be an object which specifies:
	 * host: Host the client should connect to
	 * port: Port the client should connect to
	 * socket: Establish secure connection on a given socket rather than
	 * creating a new socket. If this option is specified, host and port
	 * are ignored.
	 * pfx: A string or Buffer containing the private key, certificate and
	 * CA certs of the server in PFX or PKCS12 format.
	 * key: A string or Buffer containing the private key of the client in
	 * PEM format.
	 * passphrase: A string of passphrase for the private key or pfx.
	 * cert: A string or Buffer containing the certificate key of the client in
	 * PEM format.
	 * ca: An array of strings or Buffers of trusted certificates. If this is
	 * omitted several well known 'root' CAs will be used, like VeriSign.
	 * These are used to authorize connections.
	 * rejectUnauthorized: If true, the server certificate is verified against
	 * the list of supplied CAs. An "error" event is emitted if verification
	 * fails. Default: true.
	 * NPNProtocols: An array of string or Buffer containing supported NPN
	 * protocols. Buffer should have following format: 0x05hello0x05world,
	 * where first byte is next protocol name"s length. (Passing array should
	 * usually be much simpler: ["hello", "world"].)
	 * servername: Servername for SNI (Server Name Indication) TLS extension.
	 * secureProtocol: The SSL method to use, e.g. SSLv3_method to force
	 * SSL version 3. The possible values depend on your installation of
	 * OpenSSL and are defined in the constant [SSL_METHODS][].
	 * The callback parameter will be added as a listener for the
	 * ["secureConnect"][] event.
	 * tls.connect() returns a [CleartextStream][] object.
	 * Here is an example of a client of echo server as described previously:
	 * var tls = require("tls");
	 * var fs = require("fs");
	 * var options = {
	 *   // These are necessary only if using the client certificate authentication
	 *   key: fs.readFileSync("client-key.pem"),
	 *   cert: fs.readFileSync("client-cert.pem"),
	 *   // This is necessary only if the server uses the self-signed certificate
	 *   ca: [ fs.readFileSync("server-cert.pem") ]
	 * };
	 * var cleartextStream = tls.connect(8000, options, function() {
	 *   console.log("client connected",
	 *               cleartextStream.authorized ? "authorized" : "unauthorized");
	 *   process.stdin.pipe(cleartextStream);
	 *   process.stdin.resume();
	 * });
	 * cleartextStream.setEncoding("utf8");
	 * cleartextStream.on("data", function(data) {
	 *   console.log(data);
	 * });
	 * cleartextStream.on("end", function() {
	 *   server.close();
	 * });
	 * Or
	 * var tls = require("tls");
	 * var fs = require("fs");
	 * var options = {
	 *   pfx: fs.readFileSync("client.pfx")
	 * };
	 * var cleartextStream = tls.connect(8000, options, function() {
	 *   console.log("client connected",
	 *               cleartextStream.authorized ? "authorized" : "unauthorized");
	 *   process.stdin.pipe(cleartextStream);
	 *   process.stdin.resume();
	 * });
	 * cleartextStream.setEncoding("utf8");
	 * cleartextStream.on("data", function(data) {
	 *   console.log(data);
	 * });
	 * cleartextStream.on("end", function() {
	 *   server.close();
	 * });
	 */
	@:overload(function(options : Dynamic, ?callback : CleartextStream -> Void) : Void {})
	public function connect(port : Int, ?host : String, ?options : Dynamic, ?callback : CleartextStream -> Void) : Void;

	/**
	 * Creates a new secure pair object with two streams, one of which reads/writes
	 * encrypted data, and one reads/writes cleartext data.
	 * Generally the encrypted one is piped to/from an incoming encrypted data stream,
	 * and the cleartext one is used as a replacement for the initial encrypted stream.
	 * credentials: A credentials object from crypto.createCredentials( ... )
	 * isServer: A boolean indicating whether this tls connection should be
	 * opened as a server or a client.
	 * requestCert: A boolean indicating whether a server should request a
	 * certificate from a connecting client. Only applies to server connections.
	 * rejectUnauthorized: A boolean indicating whether a server should
	 * automatically reject clients with invalid certificates. Only applies to
	 * servers with requestCert enabled.
	 * tls.createSecurePair() returns a SecurePair object with [cleartext][] and
	 * encrypted stream properties.
	 */
	public function createSecurePair(?credentials : Dynamic, ?isServer : Bool, ?requestCert : Bool, ?rejectUnauthorized : Bool) : SecurePair;

	/**
	 * Creates a new [tls.Server][].  The connectionListener argument is
	 * automatically set as a listener for the [secureConnection][] event.  The
	 * options object has these possibilities:
	 * pfx: A string or Buffer containing the private key, certificate and
	 * CA certs of the server in PFX or PKCS12 format. (Mutually exclusive with
	 * the key, cert and ca options.)
	 * key: A string or Buffer containing the private key of the server in
	 * PEM format. (Required)
	 * passphrase: A string of passphrase for the private key or pfx.
	 * cert: A string or Buffer containing the certificate key of the server in
	 * PEM format. (Required)
	 * ca: An array of strings or Buffers of trusted certificates. If this is
	 * omitted several well known 'root' CAs will be used, like VeriSign.
	 * These are used to authorize connections.
	 * crl : Either a string or list of strings of PEM encoded CRLs (Certificate
	 * Revocation List)
	 * ciphers: A string describing the ciphers to use or exclude.
	 * To mitigate [BEAST attacks] it is recommended that you use this option in
	 * conjunction with the honorCipherOrder option described below to
	 * prioritize the non-CBC cipher.
	 * Defaults to
	 * ECDHE-RSA-AES128-SHA256:AES128-GCM-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH.
	 * Consult the [OpenSSL cipher list format documentation] for details on the
	 * format.
	 * ECDHE-RSA-AES128-SHA256 and AES128-GCM-SHA256 are used when node.js is
	 * linked against OpenSSL 1.0.1 or newer and the client speaks TLS 1.2, RC4 is
	 * used as a secure fallback.
	 * NOTE: Previous revisions of this section suggested AES256-SHA as an
	 * acceptable cipher. Unfortunately, AES256-SHA is a CBC cipher and therefore
	 * susceptible to BEAST attacks. Do not use it.
	 * handshakeTimeout: Abort the connection if the SSL/TLS handshake does not
	 * finish in this many milliseconds. The default is 120 seconds.
	 * A "clientError" is emitted on the tls.Server object whenever a handshake
	 * times out.
	 * honorCipherOrder : When choosing a cipher, use the server"s preferences
	 * instead of the client preferences.
	 * Note that if SSLv2 is used, the server will send its list of preferences
	 * to the client, and the client chooses the cipher.
	 * Although, this option is disabled by default, it is recommended that you
	 * use this option in conjunction with the ciphers option to mitigate
	 * BEAST attacks.
	 * requestCert: If true the server will request a certificate from
	 * clients that connect and attempt to verify that certificate. Default:
	 * false.
	 * rejectUnauthorized: If true the server will reject any connection
	 * which is not authorized with the list of supplied CAs. This option only
	 * has an effect if requestCert is true. Default: false.
	 * NPNProtocols: An array or Buffer of possible NPN protocols. (Protocols
	 * should be ordered by their priority).
	 * SNICallback: A function that will be called if client supports SNI TLS
	 * extension. Only one argument will be passed to it: servername. And
	 * SNICallback should return SecureContext instance.
	 * (You can use crypto.createCredentials(...).context to get proper
	 * SecureContext). If SNICallback wasn"t provided - default callback with
	 * high-level API will be used (see below).
	 * sessionIdContext: A string containing a opaque identifier for session
	 * resumption. If requestCert is true, the default is MD5 hash value
	 * generated from command-line. Otherwise, the default is not provided.
	 * Here is a simple example echo server:
	 * var tls = require("tls");
	 * var fs = require("fs");
	 * var options = {
	 *   key: fs.readFileSync("server-key.pem"),
	 *   cert: fs.readFileSync("server-cert.pem"),
	 *   // This is necessary only if using the client certificate authentication.
	 *   requestCert: true,
	 *   // This is necessary only if the client uses the self-signed certificate.
	 *   ca: [ fs.readFileSync("client-cert.pem") ]
	 * };
	 * var server = tls.createServer(options, function(cleartextStream) {
	 *   console.log("server connected",
	 *               cleartextStream.authorized ? "authorized" : "unauthorized");
	 *   cleartextStream.write('welcome!\n');
	 *   cleartextStream.setEncoding("utf8");
	 *   cleartextStream.pipe(cleartextStream);
	 * });
	 * server.listen(8000, function() {
	 *   console.log("server bound");
	 * });
	 * Or
	 * var tls = require("tls");
	 * var fs = require("fs");
	 * var options = {
	 *   pfx: fs.readFileSync("server.pfx"),
	 *   // This is necessary only if using the client certificate authentication.
	 *   requestCert: true,
	 * };
	 * var server = tls.createServer(options, function(cleartextStream) {
	 *   console.log("server connected",
	 *               cleartextStream.authorized ? "authorized" : "unauthorized");
	 *   cleartextStream.write('welcome!\n');
	 *   cleartextStream.setEncoding("utf8");
	 *   cleartextStream.pipe(cleartextStream);
	 * });
	 * server.listen(8000, function() {
	 *   console.log("server bound");
	 * });
	 * You can test this server by connecting to it with openssl s_client:
	 * openssl s_client -connect 127.0.0.1:8000
	 */
	public function createServer(options : Dynamic, ?secureConnectionListener : CleartextStream -> Void) : Void;

}
