package nodehx.tty;
import nodehx.net.Socket;

/**
 * A net.Socket subclass that represents the writable portion of a tty. In normal
 * circumstances, process.stdout will be the only tty.WriteStream instance
 * ever created (and only when isatty(1) is true).
 */
extern class WriteStream extends Socket {
	/**
	 * A Number that gives the number of columns the TTY currently has. 
	 * This property gets updated on "resize" events
	 */
	public var columns(default, null) : Int;
	
	/**
	 * A Number that gives the number of rows the TTY currently has. 
	 * This property gets updated on "resize" events.
	 */
	public var rows(default, null) : Int;
}