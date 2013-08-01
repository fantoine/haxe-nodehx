package nodehx.fs;

import nodehx.stream.Writable;

/**
 * WriteStream is a Writable Stream.
 */
extern class WriteStream extends Writable {
	/**
	 * The number of bytes written so far. Does not include data that is still queued for writing.
	 */
	public var bytesWritten(default, null) : Int;
}