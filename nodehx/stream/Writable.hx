package nodehx.stream;

import nodehx.Buffer;
import nodehx.events.EventEmitter;

/**
 * A Writable Stream has the following methods, members, and events.
 * Note that stream.Writable is an abstract class designed to be
 * extended with an underlying implementation of the
 * _write(chunk, encoding, cb) method. (See below.)
 */
extern class Writable extends EventEmitter {
	/**
	 * In classes that extend the Writable class, make sure to call the
	 * constructor so that the buffering settings can be properly
	 * initialized.
	 */
	public function new(?options : Dynamic) : Void;

	/**
	 * Writes chunk to the stream.  Returns true if the data has been
	 * flushed to the underlying resource.  Returns false to indicate that
	 * the buffer is full, and the data will be sent out in the future. The
	 * "drain" event will indicate when the buffer is empty again.
	 * The specifics of when write() will return false, is determined by
	 * the highWaterMark option provided to the constructor.
	 */
	@:overload(function(chunk : String, ?encoding : String, ?callback : ?Dynamic -> Void) : Bool {})
	public function write(chunk : Buffer, ?callback : ?Dynamic -> Void) : Bool;

	/**
	 * All Writable stream implementations must provide a _write method to
	 * send data to the underlying resource.
	 * Note: This function MUST NOT be called directly.  It should be
	 * implemented by child classes, and called by the internal Writable
	 * class methods only.
	 * Call the callback using the standard callback(error) pattern to
	 * signal that the write completed successfully or with an error.
	 * If the decodeStrings flag is set in the constructor options, then
	 * chunk may be a string rather than a Buffer, and encoding will
	 * indicate the sort of string that it is.  This is to support
	 * implementations that have an optimized handling for certain string
	 * data encodings.  If you do not explicitly set the decodeStrings
	 * option to false, then you can safely ignore the encoding argument,
	 * and assume that chunk will always be a Buffer.
	 * This method is prefixed with an underscore because it is internal to
	 * the class that defines it, and should not be called directly by user
	 * programs.  However, you are expected to override this method in
	 * your own extension classes.
	 */
	@:overload(function(chunk : String, encoding : String, callback : Dynamic -> Void) : Void {})
	public function _write(chunk : Buffer, encoding : String, callback : Dynamic -> Void) : Void;

	/**
	 * Call this method to signal the end of the data being written to the
	 * stream.
	 */
	@:overload(function(?callback : Void -> Void) : Dynamic {})
	@:overload(function(chunk : String, ?encoding : String, ?callback : Void -> Void) : Dynamic {})
	public function end(chunk : Buffer, ?callback : Void -> Void) : Dynamic;

}