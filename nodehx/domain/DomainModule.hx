package nodehx.domain;

/**
 * Domains provide a way to handle multiple different IO operations as a
 * single group.  If any of the event emitters or callbacks registered to a
 * domain emit an error event, or throw an error, then the domain object
 * will be notified, rather than losing the context of the error in the
 * process.on("uncaughtException") handler, or causing the program to
 * exit immediately with an error code.
 */
extern class DomainModule implements nodehx.Node.NodeModule<"domain", "events", "Domain"> {
	/**
	 * Returns a new Domain object.
	 */
	public function create() : Domain;

}