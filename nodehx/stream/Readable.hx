package nodehx.stream;

import nodehx.Buffer;
import nodehx.events.EventEmitter;

/**
 * A Readable Stream has the following methods, members, and events.
 * Note that stream.Readable is an abstract class designed to be
 * extended with an underlying implementation of the _read(size)
 * method. (See below.)
 */
extern class Readable extends EventEmitter {	
	/**
	 * If you are using an older Node library that emits "data" events and
	 * has a pause() method that is advisory only, then you can use the
	 * wrap() method to create a Readable stream that uses the old stream
	 * as its data source.
	 * For example:
	 * var OldReader = require("./old-api-module.js").OldReader;
	 * var oreader = new OldReader;
	 * var Readable = require("stream").Readable;
	 * var myReader = new Readable().wrap(oreader);
	 * myReader.on("readable", function() {
	 *   myReader.read(); // etc.
	 * });
	 */
	public function wrap(stream : Readable) : Dynamic;

	/**
	 * Makes the "data" event emit a string instead of a Buffer. encoding
	 * can be "utf8", "utf16le" ("ucs2"), "ascii", or "hex".
	 * The encoding can also be set by specifying an encoding field to the
	 * constructor.
	 */
	public function setEncoding(encoding : String) : Void;

	/**
	 * Switches the readable stream into 'old mode', where data is emitted
	 * using a "data" event rather than being buffered for consumption via
	 * the read() method.
	 * Resumes the incoming "data" events after a pause().
	 */
	public function resume() : Void;

	/**
	 * Note: This function should usually be called by Readable consumers,
	 * NOT by implementors of Readable subclasses.  It does not indicate
	 * the end of a _read() transaction in the way that
	 * readable.push(chunk) does.  If you find that you have to call
	 * this.unshift(chunk) in your Readable class, then there"s a good
	 * chance you ought to be using the
	 * stream.Transform class instead.
	 * This is the corollary of readable.push(chunk).  Rather than putting
	 * the data at the end of the read queue, it puts it at the front of
	 * the read queue.
	 * This is useful in certain cases where a stream is being consumed by a
	 * parser, which needs to 'un-consume' some data that it has
	 * optimistically pulled out of the source, so that the stream can be
	 * passed on to some other party.
	 * // A parser for a simple data protocol.
	 * // The 'header' is a JSON object, followed by 2 \n characters, and
	 * // then a message body.
	 * //
	 * // NOTE: This can be done more simply as a Transform stream!
	 * // Using Readable directly for this is sub-optimal.  See the
	 * // alternative example below under the Transform section.
	 * function SimpleProtocol(source, options) {
	 *   if (!(this instanceof SimpleProtocol))
	 *     return new SimpleProtocol(options);
	 *   Readable.call(this, options);
	 *   this._inBody = false;
	 *   this._sawFirstCr = false;
	 *   // source is a readable stream, such as a socket or file
	 *   this._source = source;
	 *   var self = this;
	 *   source.on("end", function() {
	 *     self.push(null);
	 *   });
	 *   // give it a kick whenever the source is readable
	 *   // read(0) will not consume any bytes
	 *   source.on("readable", function() {
	 *     self.read(0);
	 *   });
	 *   this._rawHeader = [];
	 *   this.header = null;
	 * }
	 * SimpleProtocol.prototype = Object.create(
	 *   Readable.prototype, { constructor: { value: SimpleProtocol }});
	 * SimpleProtocol.prototype._read = function(n) {
	 *   if (!this._inBody) {
	 *     var chunk = this._source.read();
	 *     // if the source doesn"t have data, we don"t have data yet.
	 *     if (chunk === null)
	 *       return this.push("");
	 *     // check if the chunk has a \n\n
	 *     var split = -1;
	 *     for (var i = 0; i < chunk.length; i++) {
	 *       if (chunk[i] === 10) { // "\n"
	 *         if (this._sawFirstCr) {
	 *           split = i;
	 *           break;
	 *         } else {
	 *           this._sawFirstCr = true;
	 *         }
	 *       } else {
	 *         this._sawFirstCr = false;
	 *       }
	 *     }
	 *     if (split === -1) {
	 *       // still waiting for the \n\n
	 *       // stash the chunk, and try again.
	 *       this._rawHeader.push(chunk);
	 *       this.push("");
	 *     } else {
	 *       this._inBody = true;
	 *       var h = chunk.slice(0, split);
	 *       this._rawHeader.push(h);
	 *       var header = Buffer.concat(this._rawHeader).toString();
	 *       try {
	 *         this.header = JSON.parse(header);
	 *       } catch (er) {
	 *         this.emit("error", new Error("invalid simple protocol data"));
	 *         return;
	 *       }
	 *       // now, because we got some extra data, unshift the rest
	 *       // back into the read queue so that our consumer will see it.
	 *       var b = chunk.slice(split);
	 *       this.unshift(b);
	 *       // and let them know that we are done parsing the header.
	 *       this.emit("header", this.header);
	 *     }
	 *   } else {
	 *     // from there on, just provide the data to our consumer.
	 *     // careful not to push(null), since that would indicate EOF.
	 *     var chunk = this._source.read();
	 *     if (chunk) this.push(chunk);
	 *   }
	 * };
	 * // Usage:
	 * var parser = new SimpleProtocol(source);
	 * // Now parser is a readable stream that will emit "header"
	 * // with the parsed header data.
	 */
	@:overload(function(chunk : String) : Bool {})
	public function unshift(chunk : Buffer) : Bool;

	/**
	 * In classes that extend the Readable class, make sure to call the
	 * constructor so that the buffering settings can be properly
	 * initialized.
	 */
	public function new(?options : Dynamic) : Void;

	/**
	 * Note: This function SHOULD be called by Readable stream users.
	 * Call this method to consume data once the "readable" event is
	 * emitted.
	 * The size argument will set a minimum number of bytes that you are
	 * interested in.  If not set, then the entire content of the internal
	 * buffer is returned.
	 * If there is no data to consume, or if there are fewer bytes in the
	 * internal buffer than the size argument, then null is returned, and
	 * a future "readable" event will be emitted when more is available.
	 * Calling stream.read(0) will always return null, and will trigger a
	 * refresh of the internal buffer, but otherwise be a no-op.
	 */
	public function read(?size : Null<Int>) : Dynamic;

	/**
	 * Connects this readable stream to destination WriteStream. Incoming
	 * data on this stream gets written to destination.  Properly manages
	 * back-pressure so that a slow destination will not be overwhelmed by a
	 * fast readable stream.
	 * This function returns the destination stream.
	 * For example, emulating the Unix cat command:
	 * process.stdin.pipe(process.stdout);
	 * By default end() is called on the destination when the source stream
	 * emits end, so that destination is no longer writable. Pass { end:
	 * false } as options to keep the destination stream open.
	 * This keeps writer open so that 'Goodbye' can be written at the
	 * end.
	 * reader.pipe(writer, { end: false });
	 * reader.on('end', function() {
	 *   writer.end('Goodbye\n');
	 * });
	 * Note that process.stderr and process.stdout are never closed until
	 * the process exits, regardless of the specified options.
	 */
	public function pipe(destination : Writable, ?options : Dynamic) : Void;

	/**
	 * Undo a previously established pipe().  If no destination is
	 * provided, then all previously established pipes are removed.
	 */
	public function unpipe(?destination : Writable) : Void;

	/**
	 * Switches the readable stream into 'old mode', where data is emitted
	 * using a "data" event rather than being buffered for consumption via
	 * the read() method.
	 * Ceases the flow of data.  No "data" events are emitted while the
	 * stream is in a paused state.
	 */
	public function pause() : Void;

	/**
	 * Note: This function should be called by Readable implementors, NOT
	 * by consumers of Readable streams.  The _read() function will not
	 * be called again until at least one push(chunk) call is made.  If no
	 * data is available, then you MAY call push("") (an empty string) to
	 * allow a future _read call, without adding any data to the queue.
	 * The Readable class works by putting data into a read queue to be
	 * pulled out later by calling the read() method when the "readable"
	 * event fires.
	 * The push() method will explicitly insert some data into the read
	 * queue.  If it is called with null then it will signal the end of the
	 * data.
	 * In some cases, you may be wrapping a lower-level source which has some
	 * sort of pause/resume mechanism, and a data callback.  In those cases,
	 * you could wrap the low-level source object by doing something like
	 * this:
	 * // source is an object with readStop() and readStart() methods,
	 * // and an `ondata` member that gets called when it has data, and
	 * // an `onend` member that gets called when the data is over.
	 * var stream = new Readable();
	 * source.ondata = function(chunk) {
	 *   // if push() returns false, then we need to stop reading from source
	 *   if (!stream.push(chunk))
	 *     source.readStop();
	 * };
	 * source.onend = function() {
	 *   stream.push(null);
	 * };
	 * // _read will be called when the stream wants to pull more data in
	 * // the advisory size argument is ignored in this case.
	 * stream._read = function(n) {
	 *   source.readStart();
	 * };
	 */
	@:overload(function(chunk : String, ?encoding : String) : Bool {})
	public function push(chunk : Buffer, ?encoding : String) : Bool;

	/**
	 * Note: This function should NOT be called directly.  It should be
	 * implemented by child classes, and called by the internal Readable
	 * class methods only.
	 * All Readable stream implementations must provide a _read method
	 * to fetch data from the underlying resource.
	 * This method is prefixed with an underscore because it is internal to
	 * the class that defines it, and should not be called directly by user
	 * programs.  However, you are expected to override this method in
	 * your own extension classes.
	 * When data is available, put it into the read queue by calling
	 * readable.push(chunk).  If push returns false, then you should stop
	 * reading.  When _read is called again, you should start pushing more
	 * data.
	 * The size argument is advisory.  Implementations where a 'read' is a
	 * single call that returns data can use this to know how much data to
	 * fetch.  Implementations where that is not relevant, such as TCP or
	 * TLS, may ignore this argument, and simply provide data whenever it
	 * becomes available.  There is no need, for example to 'wait' until
	 * size bytes are available before calling stream.push(chunk).
	 */
	public function _read(size : Int) : Void;

}