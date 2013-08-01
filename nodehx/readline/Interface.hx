package nodehx.readline;

import nodehx.events.EventEmitter;

/**
 * The class that represents a readline interface with an input and output
 * stream.
 */
extern class Interface extends EventEmitter {
	/**
	 * Prepends the prompt with query and invokes callback with the user"s
	 * response. Displays the query to the user, and then invokes callback
	 * with the user"s response after it has been typed.
	 * This will also resume the input stream used with createInterface if
	 * it has been paused.
	 * Example usage:
	 * interface.question("What is your favorite food?", function(answer) {
	 *   console.log("Oh, so your favorite food is " + answer);
	 * });
	 */
	public function question(query : String, callback : String -> Void) : Void;

	/**
	 * Resumes the readline input stream.
	 */
	public function resume() : Void;

	/**
	 * Writes data to output stream. key is an object literal to represent a key
	 * sequence; available if the terminal is a TTY.
	 * This will also resume the input stream if it has been paused.
	 * Example:
	 * rl.write("Delete me!");
	 * // Simulate ctrl+u to delete the line written previously
	 * rl.write(null, {ctrl: true, name: "u"});
	 */
	public function write(data : String, ?key : Dynamic) : Void;

	/**
	 * Pauses the readline input stream, allowing it to be resumed later if needed.
	 */
	public function pause() : Void;

	/**
	 * Sets the prompt, for example when you run node on the command line, you see
	 * > , which is node"s prompt.
	 */
	public function setPrompt(prompt : String, length : Int) : Void;

	/**
	 * Closes the Interface instance, relinquishing control on the input and
	 * output streams. The 'close' event will also be emitted.
	 */
	public function close() : Void;

	/**
	 * Readies readline for input from the user, putting the current setPrompt
	 * options on a new line, giving the user a new spot to write. Set preserveCursor
	 * to true to prevent the cursor placement being reset to 0.
	 * This will also resume the input stream used with createInterface if it has
	 * been paused.
	 */
	public function prompt(?preserveCursor : Bool) : Void;

}
