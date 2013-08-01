package nodehx.dgram;

import nodehx.Buffer;

/**
 * Datagram sockets are available through require("dgram").
 * Important note: the behavior of dgram.Socket#bind() has changed in v0.10
 * and is always asynchronous now.  If you have code that looks like this:
 * var s = dgram.createSocket("udp4");
 * s.bind(1234);
 * s.addMembership("224.0.0.114");
 * You have to change it to this:
 * var s = dgram.createSocket("udp4");
 * s.bind(1234, function() {
 *   s.addMembership("224.0.0.114");
 * });
 */
extern class DgramModule implements nodehx.Node.NodeModule<"dgram", "", "Socket"> {
	/**
	 * Creates a datagram Socket of the specified types.  Valid types are udp4
	 * and udp6.
	 * Takes an optional callback which is added as a listener for message events.
	 * Call socket.bind if you want to receive datagrams. socket.bind() will bind
	 * to the 'all interfaces' address on a random port (it does the right thing for
	 * both udp4 and udp6 sockets). You can then retrieve the address and port
	 * with socket.address().address and socket.address().port.
	 */
	public function createSocket(type : String, ?callback : Buffer -> Dynamic -> Void) : Socket;

}
