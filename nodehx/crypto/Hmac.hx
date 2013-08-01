package nodehx.crypto;
import nodehx.Buffer;

/**
 * Class for creating cryptographic hmac content.
 * Returned by crypto.createHmac.
 */
extern class Hmac {
	/**
	 * Update the hmac content with the given data. This can be called
	 * many times with new data as it is streamed.
	 */
	public function update(data : Dynamic) : Void;

	/**
	 * Calculates the digest of all of the passed data to the hmac.  The
	 * encoding can be "hex", "binary" or "base64".  If no encoding
	 * is provided, then a buffer is returned.
	 * Note: hmac object can not be used after digest() method has been
	 * called.
	 */
	@:overload(function() : Buffer {})
	public function digest(encoding : String) : String;

}