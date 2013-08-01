package nodehx.buffer;

/**
 * Pure JavaScript is Unicode friendly but not nice to binary data.  When
 * dealing with TCP streams or the file system, it"s necessary to handle octet
 * streams. Node has several strategies for manipulating, creating, and
 * consuming octet streams.
 * Raw data is stored in instances of the Buffer class. A Buffer is similar
 * to an array of integers but corresponds to a raw memory allocation outside
 * the V8 heap. A Buffer cannot be resized.
 * The Buffer class is a global, making it very rare that one would need
 * to ever require("buffer").
 * Converting between Buffers and JavaScript string objects requires an explicit
 * encoding method.  Here are the different string encodings.
 * "ascii" - for 7 bit ASCII data only.  This encoding method is very fast, and
 * will strip the high bit if set.
 * Note that when converting from string to buffer, this encoding converts a null
 * character ("\0" or "\u0000") into 0x20 (character code of a space). If
 * you want to convert a null character into 0x00, you should use "utf8".
 * "utf8" - Multibyte encoded Unicode characters. Many web pages and other
 * document formats use UTF-8.
 * "utf16le" - 2 or 4 bytes, little endian encoded Unicode characters.
 * Surrogate pairs (U+10000 to U+10FFFF) are supported.
 * "ucs2" - Alias of "utf16le".
 * "base64" - Base64 string encoding.
 * "binary" - A way of encoding raw binary data into strings by using only
 * the first 8 bits of each character. This encoding method is deprecated and
 * should be avoided in favor of Buffer objects where possible. This encoding
 * will be removed in future versions of Node.
 * "hex" - Encode each byte as two hexadecimal characters.
 * A Buffer object can also be used with typed arrays.  The buffer object is
 * cloned to an ArrayBuffer that is used as the backing store for the typed
 * array.  The memory of the buffer and the ArrayBuffer is not shared.
 * NOTE: Node.js v0.8 simply retained a reference to the buffer in array.buffer
 * instead of cloning it.
 * While more efficient, it introduces subtle incompatibilities with the typed
 * arrays specification.  ArrayBuffer#slice() makes a copy of the slice while
 * Buffer#slice() creates a view.
 */
extern class BufferModule implements nodehx.Node.NodeModule<"buffer", "", ""> {
	/**
	 * How many bytes will be returned when buffer.inspect() is called. This can 
	 * be overridden by user modules.
	 * Note that this is a property on the buffer module returned by require('buffer'), 
	 * not on the Buffer global, or a buffer instance.
	 */
	public var INSPECT_MAX_BYTES : Int;
}