package nodehx.string_decoder;
import nodehx.Buffer;

/**
 * Accepts a single argument, encoding which defaults to utf8.
 */
extern class StringDecoder {
	/**
	 * Accepts a single argument, encoding which defaults to utf8.
	 */
	public function new(?encoding : String) : Void;
	
	/**
	 * Returns a decoded string.
	 */
	public function write(buffer : Buffer) : String;

	/**
	 * Returns any trailing bytes that were left in the buffer.
	 */
	public function end() : Buffer;

}
