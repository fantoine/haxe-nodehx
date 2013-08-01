package nodehx.crypto;

import nodehx.Buffer;
import nodehx.Error;

/**
 * Stability: 2 - Unstable; API changes are being discussed for
 * future versions.  Breaking changes will be minimized.  See below.
 * Use require("crypto") to access this module.
 * The crypto module offers a way of encapsulating secure credentials to be
 * used as part of a secure HTTPS net or http connection.
 * It also offers a set of wrappers for OpenSSL"s hash, hmac, cipher,
 * decipher, sign and verify methods.
 */
extern class CryptoModule implements nodehx.Node.NodeModule<"crypto", "", "Cipher,Decipher,DiffieHellman,Hash,Hmac,Sign,Verify"> {
	/**
	 * The default encoding to use for functions that can take either strings 
	 * or buffers. The default value is 'buffer', which makes it default 
	 * to using Buffer objects. This is here to make the crypto module more easily 
	 * compatible with legacy programs that expected 'binary' to be the default encoding.
	 * Note that new programs will probably expect buffers, so only use this as a temporary measure.
	 */
	public var DEFAULT_ENCODING(default, null) : String;
	
	/**
	 * Synchronous PBKDF2 function.  Returns derivedKey or throws error.
	 */
	public function pbkdf2Sync(password : String, salt : String, iterations : Int, keylen : Int) : Buffer;

	/**
	 * Generates non-cryptographically strong pseudo-random data. The data
	 * returned will be unique if it is sufficiently long, but is not
	 * necessarily unpredictable. For this reason, the output of this
	 * function should never be used where unpredictability is important,
	 * such as in the generation of encryption keys.
	 * Usage is otherwise identical to crypto.randomBytes.
	 */
	public function pseudoRandomBytes(size : Int, ?callback : Dynamic -> Buffer -> Void) : Void;

	/**
	 * Creates and returns a signing object, with the given algorithm.  On
	 * recent OpenSSL releases, openssl list-public-key-algorithms will
	 * display the available signing algorithms. Examples are "RSA-SHA256".
	 */
	public function createSign(algorithm : String) : Sign;

	/**
	 * Creates and returns a verification object, with the given algorithm.
	 * This is the mirror of the signing object above.
	 */
	public function createVerify(algorithm : String) : Verify;

	/**
	 * Returns an array with the names of the supported hash algorithms.
	 * Example:
	 * var hashes = crypto.getHashes();
	 * console.log(hashes); // ["sha", "sha1", "sha1WithRSAEncryption", ...]
	 */
	public function getHashes() : Array<String>;

	/**
	 * Creates a predefined Diffie-Hellman key exchange object.  The
	 * supported groups are: "modp1", "modp2", "modp5" (defined in [RFC
	 * 2412][]) and "modp14", "modp15", "modp16", "modp17",
	 * "modp18" (defined in [RFC 3526][]).  The returned object mimics the
	 * interface of objects created by [crypto.createDiffieHellman()][]
	 * above, but will not allow to change the keys (with
	 * [diffieHellman.setPublicKey()][] for example).  The advantage of using
	 * this routine is that the parties don"t have to generate nor exchange
	 * group modulus beforehand, saving both processor and communication
	 * time.
	 * Example (obtaining a shared secret):
	 * var crypto = require("crypto");
	 * var alice = crypto.getDiffieHellman("modp5");
	 * var bob = crypto.getDiffieHellman("modp5");
	 * alice.generateKeys();
	 * bob.generateKeys();
	 * var alice_secret = alice.computeSecret(bob.getPublicKey(), null, "hex");
	 * var bob_secret = bob.computeSecret(alice.getPublicKey(), null, "hex");
	 * /* alice_secret and bob_secret should be the same *\/
	 * console.log(alice_secret == bob_secret);
	 */
	public function getDiffieHellman(group_name : String) : DiffieHellman;

	/**
	 * Creates and returns a cipher object, with the given algorithm and
	 * password.
	 * algorithm is dependent on OpenSSL, examples are "aes192", etc.  On
	 * recent releases, openssl list-cipher-algorithms will display the
	 * available cipher algorithms.  password is used to derive key and IV,
	 * which must be a "binary" encoded string or a buffer.
	 * It is a stream that is both readable and writable.  The
	 * written data is used to compute the hash.  Once the writable side of
	 * the stream is ended, use the read() method to get the computed hash
	 * digest.  The legacy update and digest methods are also supported.
	 */
	@:overload(function(algorithm : String, password : Buffer) : Cipher {})
	public function createCipher(algorithm : String, password : String) : Cipher;

	/**
	 * Returns an array with the names of the supported ciphers.
	 * Example:
	 * var ciphers = crypto.getCiphers();
	 * console.log(ciphers); // ["AES-128-CBC", "AES-128-CBC-HMAC-SHA1", ...]
	 */
	public function getCiphers() : Array<String>;

	/**
	 * Creates and returns a decipher object, with the given algorithm and
	 * key.  This is the mirror of the [createCipher()][] above.
	 */
	@:overload(function(algorithm : String, password : Buffer) : Decipher {})
	public function createDecipher(algorithm : String, password : String) : Decipher;

	/**
	 * Creates a credentials object, with the optional details being a
	 * dictionary with keys:
	 * pfx : A string or buffer holding the PFX or PKCS12 encoded private
	 * key, certificate and CA certificates
	 * key : A string holding the PEM encoded private key
	 * passphrase : A string of passphrase for the private key or pfx
	 * cert : A string holding the PEM encoded certificate
	 * ca : Either a string or list of strings of PEM encoded CA
	 * certificates to trust.
	 * crl : Either a string or list of strings of PEM encoded CRLs
	 * (Certificate Revocation List)
	 * ciphers: A string describing the ciphers to use or exclude.
	 * Consult
	 * http://www.openssl.org/docs/apps/ciphers.html#CIPHER_LIST_FORMAT
	 * for details on the format.
	 * If no "ca" details are given, then node.js will use the default
	 * publicly trusted list of CAs as given in
	 * http://mxr.mozilla.org/mozilla/source/security/nss/lib/ckfw/builtins/certdata.txt.
	 */
	public function createCredentials(details : Dynamic) : Dynamic;

	/**
	 * Creates and returns a hash object, a cryptographic hash with the given
	 * algorithm which can be used to generate hash digests.
	 * algorithm is dependent on the available algorithms supported by the
	 * version of OpenSSL on the platform. Examples are "sha1", "md5",
	 * "sha256", "sha512", etc.  On recent releases, openssl
	 * list-message-digest-algorithms will display the available digest
	 * algorithms.
	 * Example: this program that takes the sha1 sum of a file
	 * var filename = process.argv[2];
	 * var crypto = require("crypto");
	 * var fs = require("fs");
	 * var shasum = crypto.createHash("sha1");
	 * var s = fs.ReadStream(filename);
	 * s.on("data", function(d) {
	 *   shasum.update(d);
	 * });
	 * s.on("end", function() {
	 *   var d = shasum.digest("hex");
	 *   console.log(d + "  " + filename);
	 * });
	 */
	public function createHash(algorithm : String) : Hash;

	/**
	 * Creates and returns a cipher object, with the given algorithm, key and
	 * iv.
	 * algorithm is the same as the argument to createCipher().  key is
	 * the raw key used by the algorithm.  iv is an initialization
	 * vector.
	 * key and iv must be "binary" encoded strings or
	 * buffers.
	 */
	@:overload(function(algorithm : String, key : Buffer, iv : Buffer) : Cipher {})
	@:overload(function(algorithm : String, key : Buffer, iv : String) : Cipher {})
	@:overload(function(algorithm : String, key : String, iv : Buffer) : Cipher {})
	public function createCipheriv(algorithm : String, key : String, iv : String) : Cipher;

	/**
	 * Creates and returns a hmac object, a cryptographic hmac with the given
	 * algorithm and key.
	 * It is a stream that is both readable and writable.  The
	 * written data is used to compute the hmac.  Once the writable side of
	 * the stream is ended, use the read() method to get the computed
	 * digest.  The legacy update and digest methods are also supported.
	 * algorithm is dependent on the available algorithms supported by
	 * OpenSSL - see createHash above.  key is the hmac key to be used.
	 */
	public function createHmac(algorithm : String, key : String) : Hmac;

	/**
	 * Creates and returns a decipher object, with the given algorithm, key
	 * and iv.  This is the mirror of the [createCipheriv()][] above.
	 */
	@:overload(function(algorithm : String, key : Buffer, iv : Buffer) : Decipher {})
	@:overload(function(algorithm : String, key : Buffer, iv : String) : Decipher {})
	@:overload(function(algorithm : String, key : String, iv : Buffer) : Decipher {})
	public function createDecipheriv(algorithm : String, key : String, iv : String) : Decipher;

	/**
	 * Asynchronous PBKDF2 applies pseudorandom function HMAC-SHA1 to derive
	 * a key of given length from the given password, salt and iterations.
	 * The callback gets two arguments (err, derivedKey).
	 */
	public function pbkdf2(password : String, salt : String, iterations : Int, keylen : Int, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Creates a Diffie-Hellman key exchange object and generates a prime of
	 * the given bit length. The generator used is 2.
	 */
	@:overload(function(prime : Buffer, ?encoding : String) : DiffieHellman {})
	@:overload(function(prime : String, ?encoding : String) : DiffieHellman {})
	public function createDiffieHellman(prime_length : Int) : DiffieHellman;

	/**
	 * Generates cryptographically strong pseudo-random data. Usage:
	 * // async
	 * crypto.randomBytes(256, function(ex, buf) {
	 *   if (ex) throw ex;
	 *   console.log("Have %d bytes of random data: %s", buf.length, buf);
	 * });
	 * // sync
	 * try {
	 *   var buf = crypto.randomBytes(256);
	 *   console.log("Have %d bytes of random data: %s", buf.length, buf);
	 * } catch (ex) {
	 *   // handle error
	 * }
	 */
	public function randomBytes(size : Int, ?callback : Error -> Buffer -> Void) : Void;

}