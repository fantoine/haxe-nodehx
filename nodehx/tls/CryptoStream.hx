package nodehx.tls;

import nodehx.stream.Writable;

/**
 * This is an encrypted stream.
 */
extern class CryptoStream extends Writable {
	/**
	 * A proxy to the underlying socket's bytesWritten accessor, 
	 * this will return the total bytes written to the socket, including the TLS overhead.
	 */
	public var bytesWritten(default, null) : Int;
}