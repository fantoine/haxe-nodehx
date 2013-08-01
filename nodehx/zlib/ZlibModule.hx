package nodehx.zlib;

import nodehx.Buffer;
import nodehx.Error;

/**
 * You can access this module with:
 * var zlib = require("zlib");
 * This provides bindings to Gzip/Gunzip, Deflate/Inflate, and
 * DeflateRaw/InflateRaw classes.  Each class takes the same options, and
 * is a readable/writable Stream.
 * Examples
 * Compressing or decompressing a file can be done by piping an
 * fs.ReadStream into a zlib stream, then into an fs.WriteStream.
 * var gzip = zlib.createGzip();
 * var fs = require("fs");
 * var inp = fs.createReadStream("input.txt");
 * var out = fs.createWriteStream("input.txt.gz");
 * inp.pipe(gzip).pipe(out);
 * Compressing or decompressing data in one step can be done by using
 * the convenience methods.
 * var input = ".................................";
 * zlib.deflate(input, function(err, buffer) {
 *   if (!err) {
 *     console.log(buffer.toString("base64"));
 *   }
 * });
 * var buffer = new Buffer("eJzT0yMAAGTvBe8=", "base64");
 * zlib.unzip(buffer, function(err, buffer) {
 *   if (!err) {
 *     console.log(buffer.toString());
 *   }
 * });
 * To use this module in an HTTP client or server, use the
 * accept-encoding
 * on requests, and the
 * content-encoding
 * header on responses.
 * Note: these examples are drastically simplified to show
 * the basic concept.  Zlib encoding can be expensive, and the results
 * ought to be cached.  See Memory Usage Tuning
 * below for more information on the speed/memory/compression
 * tradeoffs involved in zlib usage.
 * // client request example
 * var zlib = require("zlib");
 * var http = require("http");
 * var fs = require("fs");
 * var request = http.get({ host: "izs.me",
 *                          path: "/",
 *                          port: 80,
 *                          headers: { "accept-encoding": "gzip,deflate" } });
 * request.on("response", function(response) {
 *   var output = fs.createWriteStream("izs.me_index.html");
 *   switch (response.headers["content-encoding"]) {
 *     // or, just use zlib.createUnzip() to handle both cases
 *     case "gzip":
 *       response.pipe(zlib.createGunzip()).pipe(output);
 *       break;
 *     case "deflate":
 *       response.pipe(zlib.createInflate()).pipe(output);
 *       break;
 *     default:
 *       response.pipe(output);
 *       break;
 *   }
 * });
 * // server example
 * // Running a gzip operation on every request is quite expensive.
 * // It would be much more efficient to cache the compressed buffer.
 * var zlib = require("zlib");
 * var http = require("http");
 * var fs = require("fs");
 * http.createServer(function(request, response) {
 *   var raw = fs.createReadStream("index.html");
 *   var acceptEncoding = request.headers["accept-encoding"];
 *   if (!acceptEncoding) {
 *     acceptEncoding = "";
 *   }
 *   // Note: this is not a conformant accept-encoding parser.
 *   // See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3
 *   if (acceptEncoding.match(/\bdeflate\b/)) {
 *     response.writeHead(200, { "content-encoding": "deflate" });
 *     raw.pipe(zlib.createDeflate()).pipe(response);
 *   } else if (acceptEncoding.match(/\bgzip\b/)) {
 *     response.writeHead(200, { "content-encoding": "gzip" });
 *     raw.pipe(zlib.createGzip()).pipe(response);
 *   } else {
 *     response.writeHead(200, {});
 *     raw.pipe(response);
 *   }
 * }).listen(1337);
 */
extern class ZlibModule implements nodehx.Node.NodeModule<"zlib", "", "Deflate,DeflateRaw,Gunzip,Gzip,Inflate,InflateRaw,Unzip,Zlib"> {
	/**
	 * Compress a string with Gzip.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function gzip(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Decompress a raw Buffer with InflateRaw.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function inflateRaw(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Compress a string with DeflateRaw.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function deflateRaw(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Decompress a raw Buffer with Gunzip.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function gunzip(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Decompress a raw Buffer with Inflate.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function inflate(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Returns a new Gzip object with an
	 * options.
	 */
	public function createGzip(?options : Dynamic) : Gzip;

	/**
	 * Compress a string with Deflate.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function deflate(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

	/**
	 * Returns a new Deflate object with an
	 * options.
	 */
	public function createDeflate(?options : Dynamic) : Deflate;

	/**
	 * Returns a new Inflate object with an
	 * options.
	 */
	public function createInflate(?options : Dynamic) : Inflate;

	/**
	 * Returns a new Gunzip object with an
	 * options.
	 */
	public function createGunzip(?options : Dynamic) : Gunzip;

	/**
	 * Returns a new DeflateRaw object with an
	 * options.
	 */
	public function createDeflateRaw(?options : Dynamic) : DeflateRaw;

	/**
	 * Returns a new InflateRaw object with an
	 * options.
	 */
	public function createInflateRaw(?options : Dynamic) : InflateRaw;

	/**
	 * Returns a new Unzip object with an
	 * options.
	 */
	public function createUnzip(?options : Dynamic) : Unzip;

	/**
	 * Decompress a raw Buffer with Unzip.
	 */
	@:overload(function(buf : String, callback : Error -> Buffer -> Void) : Void {})
	public function unzip(buf : Buffer, callback : Error -> Buffer -> Void) : Void;

}
