package nodehx.tty;

import nodehx.net.Socket;

/**
 * A net.Socket subclass that represents the readable portion of a tty. In normal
 * circumstances, process.stdin will be the only tty.ReadStream instance in any
 * node program (only when isatty(0) is true).
 */
extern class ReadStream extends Socket {
	/**
	 * A Boolean that is initialized to false. It represents the current "raw" state 
	 * of the tty.ReadStream instance.
	 */
	public var isRaw(default, null) : Bool;
	
	/**
	 * mode should be true or false. This sets the properties of the
	 * tty.ReadStream to act either as a raw device or default. isRaw will be set
	 * to the resulting mode.
	 */
	public function setRawMode(mode : Bool) : Void;

}
