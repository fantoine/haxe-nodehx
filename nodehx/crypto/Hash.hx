package nodehx.crypto;
import nodehx.Buffer;

/**
 * The class for creating hash digests of data.
 * It is a stream that is both readable and writable.  The
 * written data is used to compute the hash.  Once the writable side of
 * the stream is ended, use the read() method to get the computed hash
 * digest.  The legacy update and digest methods are also supported.
 * Returned by crypto.createHash.
 */
extern class Hash {
	/**
	 * Updates the hash content with the given data, the encoding of which
	 * is given in input_encoding and can be "utf8", "ascii" or
	 * "binary".  If no encoding is provided, then a buffer is expected.
	 * This can be called many times with new data as it is streamed.
	 */
	@:overload(function(data : Buffer) : Void {})
	public function update(data : String, input_encoding : String) : Void;

	/**
	 * Calculates the digest of all of the passed data to be hashed.  The
	 * encoding can be "hex", "binary" or "base64".  If no encoding
	 * is provided, then a buffer is returned.
	 * Note: hash object can not be used after digest() method has been
	 * called.
	 */
	@:overload(function() : Buffer {})
	public function digest(encoding : String) : String;

}