package nodehx.crypto;
import nodehx.Buffer;

/**
 * Class for encrypting data.
 * Returned by crypto.createCipher and crypto.createCipheriv.
 * Cipher objects are streams that are both readable and
 * writable.  The written plain text data is used to produce the
 * encrypted data on the readable side.  The legacy update and final
 * methods are also supported.
 */
extern class Cipher {
	/**
	 * You can disable automatic padding of the input data to block size. If
	 * auto_padding is false, the length of the entire input data must be a
	 * multiple of the cipher"s block size or final will fail.  Useful for
	 * non-standard padding, e.g. using 0x0 instead of PKCS padding. You
	 * must call this before cipher.final.
	 */
	public function setAutoPadding(?auto_padding : Bool) : Void;

	/**
	 * Updates the cipher with data, the encoding of which is given in
	 * input_encoding and can be "utf8", "ascii" or "binary".  If no
	 * encoding is provided, then a buffer is expected.
	 * The output_encoding specifies the output format of the enciphered
	 * data, and can be "binary", "base64" or "hex".  If no encoding is
	 * provided, then a buffer is returned.
	 * Returns the enciphered contents, and can be called many times with new
	 * data as it is streamed.
	 */
	@:overload(function(data : Buffer) : Buffer {})
	@:overload(function(data : String, input_encoding : String) : Buffer {})
	public function update(data : String, input_encoding : String, output_encoding : String) : String;

	/**
	 * Returns any remaining enciphered contents, with output_encoding
	 * being one of: "binary", "base64" or "hex".  If no encoding is
	 * provided, then a buffer is returned.
	 * Note: cipher object can not be used after final() method has been
	 * called.
	 */
	@:overload(function() : Buffer {})
	public function final(output_encoding : String) : String;

}