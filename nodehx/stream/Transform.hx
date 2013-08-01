package nodehx.stream;

import nodehx.Buffer;

/**
 * A 'transform' stream is a duplex stream where the output is causally
 * connected in some way to the input, such as a zlib stream or a crypto
 * stream.
 * There is no requirement that the output be the same size as the input,
 * the same number of chunks, or arrive at the same time.  For example, a
 * Hash stream will only ever have a single chunk of output which is
 * provided when the input is ended.  A zlib stream will either produce
 * much smaller or much larger than its input.
 * Rather than implement the _read() and _write() methods, Transform
 * classes must implement the _transform() method, and may optionally
 * also implement the _flush() method.  (See below.)
 */
extern class Transform {
	/**
	 * Note: This function MUST NOT be called directly.  It MAY be implemented
	 * by child classes, and if so, will be called by the internal Transform
	 * class methods only.
	 * In some cases, your transform operation may need to emit a bit more
	 * data at the end of the stream.  For example, a Zlib compression
	 * stream will store up some internal state so that it can optimally
	 * compress the output.  At the end, however, it needs to do the best it
	 * can with what is left, so that the data will be complete.
	 * In those cases, you can implement a _flush method, which will be
	 * called at the very end, after all the written data is consumed, but
	 * before emitting end to signal the end of the readable side.  Just
	 * like with _transform, call transform.push(chunk) zero or more
	 * times, as appropriate, and call callback when the flush operation is
	 * complete.
	 * This method is prefixed with an underscore because it is internal to
	 * the class that defines it, and should not be called directly by user
	 * programs.  However, you are expected to override this method in
	 * your own extension classes.
	 * Example: SimpleProtocol parser
	 * The example above of a simple protocol parser can be implemented much
	 * more simply by using the higher level Transform stream class.
	 * In this example, rather than providing the input as an argument, it
	 * would be piped into the parser, which is a more idiomatic Node stream
	 * approach.
	 * function SimpleProtocol(options) {
	 *   if (!(this instanceof SimpleProtocol))
	 *     return new SimpleProtocol(options);
	 *   Transform.call(this, options);
	 *   this._inBody = false;
	 *   this._sawFirstCr = false;
	 *   this._rawHeader = [];
	 *   this.header = null;
	 * }
	 * SimpleProtocol.prototype = Object.create(
	 *   Transform.prototype, { constructor: { value: SimpleProtocol }});
	 * SimpleProtocol.prototype._transform = function(chunk, encoding, done) {
	 *   if (!this._inBody) {
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
	 *       // and let them know that we are done parsing the header.
	 *       this.emit("header", this.header);
	 *       // now, because we got some extra data, emit this first.
	 *       this.push(chunk.slice(split));
	 *     }
	 *   } else {
	 *     // from there on, just provide the data to our consumer as-is.
	 *     this.push(chunk);
	 *   }
	 *   done();
	 * };
	 * var parser = new SimpleProtocol();
	 * source.pipe(parser)
	 * // Now parser is a readable stream that will emit "header"
	 * // with the parsed header data.
	 */
	public function _flush(callback : ?Dynamic -> Void) : Void;

	/**
	 * In classes that extend the Transform class, make sure to call the
	 * constructor so that the buffering settings can be properly
	 * initialized.
	 */
	public function new(?options : Dynamic) : Void;

	/**
	 * Note: This function MUST NOT be called directly.  It should be
	 * implemented by child classes, and called by the internal Transform
	 * class methods only.
	 * All Transform stream implementations must provide a _transform
	 * method to accept input and produce output.
	 * _transform should do whatever has to be done in this specific
	 * Transform class, to handle the bytes being written, and pass them off
	 * to the readable portion of the interface.  Do asynchronous I/O,
	 * process things, and so on.
	 * Call transform.push(outputChunk) 0 or more times to generate output
	 * from this input chunk, depending on how much data you want to output
	 * as a result of this chunk.
	 * Call the callback function only when the current chunk is completely
	 * consumed.  Note that there may or may not be output as a result of any
	 * particular input chunk.
	 * This method is prefixed with an underscore because it is internal to
	 * the class that defines it, and should not be called directly by user
	 * programs.  However, you are expected to override this method in
	 * your own extension classes.
	 */
	@:overload(function(chunk : String, encoding : String, callback : ?Dynamic -> Void) : Void {})
	public function _transform(chunk : Buffer, encoding : String, callback : ?Dynamic -> Void) : Void;

}