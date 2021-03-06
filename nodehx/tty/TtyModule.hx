package nodehx.tty;

/**
 * The tty module houses the tty.ReadStream and tty.WriteStream classes. In
 * most cases, you will not need to use this module directly.
 * When node detects that it is being run inside a TTY context, then process.stdin
 * will be a tty.ReadStream instance and process.stdout will be
 * a tty.WriteStream instance. The preferred way to check if node is being run in
 * a TTY context is to check process.stdout.isTTY:
 * $ node -p -e 'Boolean(process.stdout.isTTY)'
 * true
 * $ node -p -e 'Boolean(process.stdout.isTTY)' | cat
 * false
 */
extern class TtyModule implements nodehx.Node.NodeModule<"tty", "net", "ReadStream,WriteStream"> {
	/**
	 * Deprecated. Use tty.ReadStream#setRawMode()
	 * (i.e. process.stdin.setRawMode()) instead.
	 */
	public function setRawMode(mode : Bool) : Void;

	/**
	 * Returns true or false depending on if the fd is associated with a
	 * terminal.
	 */
	public function isatty(fd : Int) : Bool;

}
