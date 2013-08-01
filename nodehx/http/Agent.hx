package nodehx.http;

import nodehx.net.Socket;

/**
 * In node 0.5.3+ there is a new implementation of the HTTP Agent which is used
 * for pooling sockets used in HTTP client requests.
 * Previously, a single agent instance helped pool for a single host+port. The
 * current implementation now holds sockets for any number of hosts.
 * The current HTTP Agent also defaults client requests to using
 * Connection:keep-alive. If no pending HTTP requests are waiting on a socket
 * to become free the socket is closed. This means that node"s pool has the
 * benefit of keep-alive when under load but still does not require developers
 * to manually close the HTTP clients using keep-alive.
 * Sockets are removed from the agent"s pool when the socket emits either a
 * 'close' event or a special 'agentRemove' event. This means that if you intend
 * to keep one HTTP request open for a long time and don"t want it to stay in the
 * pool you can do something along the lines of:
 * http.get(options, function(res) {
 *   // Do stuff
 * }).on('socket', function (socket) {
 *   socket.emit('agentRemove');
 * });
 * Alternatively, you could just opt out of pooling entirely using agent:false:
 * http.get({hostname:"localhost", port:80, path:"/", agent:false}, function (res) {
 *   // Do stuff
 * })
 */
extern class Agent {
	/**
	 * By default set to 5. Determines how many concurrent sockets 
	 * the agent can have open per host.
	 */
	public var maxSockets : Int;

	/**
	 * An object which contains arrays of sockets currently in use 
	 * by the Agent. Do not modify.
	 */
	public var sockets(default, null) : Array<Socket>;

	/**
	 * An object which contains queues of requests that have not yet 
	 * been assigned to sockets. Do not modify.
	 */
	public var requests(default, null) : Array<ClientRequest>;

	/**
	 * Global instance of Agent which is used as the default for all http client requests.
	 */
	public var globalAgent(default, null) : Agent;
}