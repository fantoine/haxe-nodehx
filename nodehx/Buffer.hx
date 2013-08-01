package nodehx;

/**
 * The Buffer class is a global type for dealing with binary data directly.
 * It can be constructed in a variety of ways.
 */
@:native("Buffer")
extern class Buffer implements ArrayAccess<Int> {
	/**
	 * Allocates a new buffer
	 */
	@:overload(function(array : Array<Int>) : Void {})
	@:overload(function(str : String, ?encoding : String) : Void {})
	public function new(size : Int);
	
	/**
	 * Returns true if the encoding is a valid encoding argument, or false otherwise.
	 */
	static function isEncoding(encoding : String) : Bool;
	
	/**
	 * Tests if obj is a Buffer.
	 */
	static function isBuffer(obj : Dynamic) : Bool;
	
	/**
	 * Gives the actual byte length of a string. encoding defaults to 'utf8'. This is 
	 * not the same as String.prototype.length since that returns the number of characters in a string.
	 * Example:
	 * str = '\u00bd + \u00bc = \u00be';
	 * console.log(str + ": " + str.length + " characters, " +
	 *   Buffer.byteLength(str, 'utf8') + " bytes");
	 * // ½ + ¼ = ¾: 9 characters, 12 bytes
	 */
	static function byteLength(string : String, ?encoding : String) : Int;
	
	/**
	 * Returns a buffer which is the result of concatenating all the buffers in the list together.
	 * If the list has no items, or if the totalLength is 0, then it returns a zero-length buffer.
	 * If the list has exactly one item, then the first item of the list is returned.
	 * If the list has more than one item, then a new Buffer is created.
	 * If totalLength is not provided, it is read from the buffers in the list. However, this adds 
	 * an additional loop to the function, so it is faster to provide the length explicitly.
	 */
	static function concat(list : Array<Buffer>, ?totalLength : Int) : Buffer;
	
	/**
	 * The size of the buffer in bytes. Note that this is not necessarily the size of the contents. 
	 * length refers to the amount of memory allocated for the buffer object. It does not change 
	 * when the contents of the buffer are changed.
	 * buf = new Buffer(1234);
	 * console.log(buf.length);
	 * buf.write("some string", 0, "ascii");
	 * console.log(buf.length);
	 * // 1234
	 * // 1234
	 */
	public var length(default, null) : Int;
	
	
	/**
	 * Reads a signed 32 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Works as buffer.readUInt32*, except buffer contents are treated as two"s
	 * complement signed values.
	 */
	public function readInt32BE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Writes value to the buffer at the specified offset. Note, value must be a
	 * valid unsigned 8 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeUInt8(0x3, 0);
	 * buf.writeUInt8(0x4, 1);
	 * buf.writeUInt8(0x23, 2);
	 * buf.writeUInt8(0x42, 3);
	 * console.log(buf);
	 * //
	 */
	public function writeUInt8(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid unsigned 16 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeUInt16BE(0xdead, 0);
	 * buf.writeUInt16BE(0xbeef, 2);
	 * console.log(buf);
	 * buf.writeUInt16LE(0xdead, 0);
	 * buf.writeUInt16LE(0xbeef, 2);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeUInt16LE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid unsigned 32 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeUInt32BE(0xfeedface, 0);
	 * console.log(buf);
	 * buf.writeUInt32LE(0xfeedface, 0);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeUInt32BE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Reads an unsigned 32 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x3;
	 * buf[1] = 0x4;
	 * buf[2] = 0x23;
	 * buf[3] = 0x42;
	 * console.log(buf.readUInt32BE(0));
	 * console.log(buf.readUInt32LE(0));
	 * // 0x03042342
	 * // 0x42230403
	 */
	public function readUInt32BE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Reads an unsigned 32 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x3;
	 * buf[1] = 0x4;
	 * buf[2] = 0x23;
	 * buf[3] = 0x42;
	 * console.log(buf.readUInt32BE(0));
	 * console.log(buf.readUInt32LE(0));
	 * // 0x03042342
	 * // 0x42230403
	 */
	public function readUInt32LE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, behavior is unspecified if value is not a 32 bit float.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeFloatBE(0xcafebabe, 0);
	 * console.log(buf);
	 * buf.writeFloatLE(0xcafebabe, 0);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeFloatBE(value : Float, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Writes string to the buffer at offset using the given encoding.
	 * offset defaults to 0, encoding defaults to "utf8". length is
	 * the number of bytes to write. Returns number of octets written. If buffer did
	 * not contain enough space to fit the entire string, it will write a partial
	 * amount of the string. length defaults to buffer.length - offset.
	 * The method will not write partial characters.
	 * buf = new Buffer(256);
	 * len = buf.write("\u00bd + \u00bc = \u00be", 0);
	 * console.log(len + ' bytes: ' + buf.toString("utf8", 0, len));
	 * The number of characters written (which may be different than the number of
	 * bytes written) is set in Buffer._charsWritten and will be overwritten the
	 * next time buf.write() is called.
	 */
	public function write(string : String, ?offset : Int, ?length : Int, ?encoding : String) : Void;

	/**
	 * Reads a 32 bit float from the buffer at the specified offset with specified
	 * endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x00;
	 * buf[1] = 0x00;
	 * buf[2] = 0x80;
	 * buf[3] = 0x3f;
	 * console.log(buf.readFloatLE(0));
	 * // 0x01
	 */
	public function readFloatLE(offset : Int, ?noAssert : Bool) : Null<Float>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, behavior is unspecified if value is not a 32 bit float.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeFloatBE(0xcafebabe, 0);
	 * console.log(buf);
	 * buf.writeFloatLE(0xcafebabe, 0);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeFloatLE(value : Float, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Reads a 32 bit float from the buffer at the specified offset with specified
	 * endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x00;
	 * buf[1] = 0x00;
	 * buf[2] = 0x80;
	 * buf[3] = 0x3f;
	 * console.log(buf.readFloatLE(0));
	 * // 0x01
	 */
	public function readFloatBE(offset : Int, ?noAssert : Bool) : Null<Float>;

	/**
	 * Reads an unsigned 16 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x3;
	 * buf[1] = 0x4;
	 * buf[2] = 0x23;
	 * buf[3] = 0x42;
	 * console.log(buf.readUInt16BE(0));
	 * console.log(buf.readUInt16LE(0));
	 * console.log(buf.readUInt16BE(1));
	 * console.log(buf.readUInt16LE(1));
	 * console.log(buf.readUInt16BE(2));
	 * console.log(buf.readUInt16LE(2));
	 * // 0x0304
	 * // 0x0403
	 * // 0x0423
	 * // 0x2304
	 * // 0x2342
	 * // 0x4223
	 */
	public function readUInt16BE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Does copy between buffers. The source and target regions can be overlapped.
	 * targetStart and sourceStart default to 0.
	 * sourceEnd defaults to buffer.length.
	 * All values passed that are undefined/NaN or are out of bounds are set equal
	 * to their respective defaults.
	 * Example: build two Buffers, then copy buf1 from byte 16 through byte 19
	 * into buf2, starting at the 8th byte in buf2.
	 * buf1 = new Buffer(26);
	 * buf2 = new Buffer(26);
	 * for (var i = 0 ; i < 26 ; i++) {
	 *   buf1[i] = i + 97; // 97 is ASCII a
	 *   buf2[i] = 33; // ASCII !
	 * }
	 * buf1.copy(buf2, 8, 16, 20);
	 * console.log(buf2.toString("ascii", 0, 25));
	 * // !!!!!!!!qrst!!!!!!!!!!!!!
	 */
	public function copy(targetBuffer : Buffer, ?targetStart : Int, ?sourceStart : Int, ?sourceEnd : Int) : Void;

	/**
	 * Reads a signed 16 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Works as buffer.readUInt16*, except buffer contents are treated as two"s
	 * complement signed values.
	 */
	public function readInt16LE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Reads an unsigned 16 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x3;
	 * buf[1] = 0x4;
	 * buf[2] = 0x23;
	 * buf[3] = 0x42;
	 * console.log(buf.readUInt16BE(0));
	 * console.log(buf.readUInt16LE(0));
	 * console.log(buf.readUInt16BE(1));
	 * console.log(buf.readUInt16LE(1));
	 * console.log(buf.readUInt16BE(2));
	 * console.log(buf.readUInt16LE(2));
	 * // 0x0304
	 * // 0x0403
	 * // 0x0423
	 * // 0x2304
	 * // 0x2342
	 * // 0x4223
	 */
	public function readUInt16LE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid signed 32 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Works as buffer.writeUInt32*, except value is written out as a two"s
	 * complement signed integer into buffer.
	 */
	public function writeInt32BE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Reads a signed 8 bit integer from the buffer at the specified offset.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Works as buffer.readUInt8, except buffer contents are treated as two"s
	 * complement signed values.
	 */
	public function readInt8(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Reads a signed 16 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Works as buffer.readUInt16*, except buffer contents are treated as two"s
	 * complement signed values.
	 */
	public function readInt16BE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid unsigned 32 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeUInt32BE(0xfeedface, 0);
	 * console.log(buf);
	 * buf.writeUInt32LE(0xfeedface, 0);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeUInt32LE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Fills the buffer with the specified value. If the offset (defaults to 0)
	 * and end (defaults to buffer.length) are not given it will fill the entire
	 * buffer.
	 * var b = new Buffer(50);
	 * b.fill('h');
	 */
	public function fill(value : String, ?offset : Int, ?end : Int) : Void;

	/**
	 * Decodes and returns a string from buffer data encoded with encoding
	 * (defaults to "utf8") beginning at start (defaults to 0) and ending at
	 * end (defaults to buffer.length).
	 * See buffer.write() example, above.
	 */
	public function toString(?encoding : String, ?start : Int, ?end : Int) : String;

	/**
	 * Reads an unsigned 8 bit integer from the buffer at the specified offset.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf[0] = 0x3;
	 * buf[1] = 0x4;
	 * buf[2] = 0x23;
	 * buf[3] = 0x42;
	 * for (ii = 0; ii < buf.length; ii++) {
	 *   console.log(buf.readUInt8(ii));
	 * }
	 * // 0x3
	 * // 0x4
	 * // 0x23
	 * // 0x42
	 */
	public function readUInt8(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid signed 32 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Works as buffer.writeUInt32*, except value is written out as a two"s
	 * complement signed integer into buffer.
	 */
	public function writeInt32LE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid 64 bit double.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(8);
	 * buf.writeDoubleBE(0xdeadbeefcafebabe, 0);
	 * console.log(buf);
	 * buf.writeDoubleLE(0xdeadbeefcafebabe, 0);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeDoubleBE(value : Float, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Returns a JSON-representation of the Buffer instance, which is identical to the
	 * output for JSON Arrays. JSON.stringify implicitly calls this function when
	 * stringifying a Buffer instance.
	 * Example:
	 * var buf = new Buffer("test");
	 * var json = JSON.stringify(buf);
	 * console.log(json);
	 * // "[116,101,115,116]"
	 * var copy = new Buffer(JSON.parse(json));
	 * console.log(copy);
	 * //
	 */
	public function toJSON() : Dynamic;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid signed 16 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Works as buffer.writeUInt16*, except value is written out as a two"s
	 * complement signed integer into buffer.
	 */
	public function writeInt16BE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Reads a 64 bit double from the buffer at the specified offset with specified
	 * endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(8);
	 * buf[0] = 0x55;
	 * buf[1] = 0x55;
	 * buf[2] = 0x55;
	 * buf[3] = 0x55;
	 * buf[4] = 0x55;
	 * buf[5] = 0x55;
	 * buf[6] = 0xd5;
	 * buf[7] = 0x3f;
	 * console.log(buf.readDoubleLE(0));
	 * // 0.3333333333333333
	 */
	public function readDoubleBE(offset : Int, ?noAssert : Bool) : Null<Float>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid signed 16 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Works as buffer.writeUInt16*, except value is written out as a two"s
	 * complement signed integer into buffer.
	 */
	public function writeInt16LE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid unsigned 16 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(4);
	 * buf.writeUInt16BE(0xdead, 0);
	 * buf.writeUInt16BE(0xbeef, 2);
	 * console.log(buf);
	 * buf.writeUInt16LE(0xdead, 0);
	 * buf.writeUInt16LE(0xbeef, 2);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeUInt16BE(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Reads a 64 bit double from the buffer at the specified offset with specified
	 * endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Example:
	 * var buf = new Buffer(8);
	 * buf[0] = 0x55;
	 * buf[1] = 0x55;
	 * buf[2] = 0x55;
	 * buf[3] = 0x55;
	 * buf[4] = 0x55;
	 * buf[5] = 0x55;
	 * buf[6] = 0xd5;
	 * buf[7] = 0x3f;
	 * console.log(buf.readDoubleLE(0));
	 * // 0.3333333333333333
	 */
	public function readDoubleLE(offset : Int, ?noAssert : Bool) : Null<Float>;

	/**
	 * Writes value to the buffer at the specified offset. Note, value must be a
	 * valid signed 8 bit integer.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Works as buffer.writeUInt8, except value is written out as a two"s complement
	 * signed integer into buffer.
	 */
	public function writeInt8(value : Int, offset : Int, ?noAssert : Bool) : Void;

	/**
	 * Returns a new buffer which references the same memory as the old, but offset
	 * and cropped by the start (defaults to 0) and end (defaults to
	 * buffer.length) indexes.  Negative indexes start from the end of the buffer.
	 * Modifying the new buffer slice will modify memory in the original buffer!
	 * Example: build a Buffer with the ASCII alphabet, take a slice, then modify one
	 * byte from the original Buffer.
	 * var buf1 = new Buffer(26);
	 * for (var i = 0 ; i < 26 ; i++) {
	 *   buf1[i] = i + 97; // 97 is ASCII a
	 * }
	 * var buf2 = buf1.slice(0, 3);
	 * console.log(buf2.toString("ascii", 0, buf2.length));
	 * buf1[0] = 33;
	 * console.log(buf2.toString("ascii", 0, buf2.length));
	 * // abc
	 * // !bc
	 */
	public function slice(?start : Int, ?end : Int) : Buffer;

	/**
	 * Reads a signed 32 bit integer from the buffer at the specified offset with
	 * specified endian format.
	 * Set noAssert to true to skip validation of offset. This means that offset
	 * may be beyond the end of the buffer. Defaults to false.
	 * Works as buffer.readUInt32*, except buffer contents are treated as two"s
	 * complement signed values.
	 */
	public function readInt32LE(offset : Int, ?noAssert : Bool) : Null<Int>;

	/**
	 * Writes value to the buffer at the specified offset with specified endian
	 * format. Note, value must be a valid 64 bit double.
	 * Set noAssert to true to skip validation of value and offset. This means
	 * that value may be too large for the specific function and offset may be
	 * beyond the end of the buffer leading to the values being silently dropped. This
	 * should not be used unless you are certain of correctness. Defaults to false.
	 * Example:
	 * var buf = new Buffer(8);
	 * buf.writeDoubleBE(0xdeadbeefcafebabe, 0);
	 * console.log(buf);
	 * buf.writeDoubleLE(0xdeadbeefcafebabe, 0);
	 * console.log(buf);
	 * // 
	 * //
	 */
	public function writeDoubleLE(value : Float, offset : Int, ?noAssert : Bool) : Void;
}