package nodehx.stream;

/**
 * A stream is an abstract interface implemented by various objects in
 * Node.  For example a request to an HTTP server is a stream, as is
 * stdout. Streams are readable, writable, or both. All streams are
 * instances of [EventEmitter][]
 * You can load the Stream base classes by doing require("stream").
 * There are base classes provided for Readable streams, Writable
 * streams, Duplex streams, and Transform streams.
 */
extern class StreamModule implements nodehx.Node.NodeModule<"stream", "events", "Duplex,PassThrough,Readable,Transform,Readable"> {}
