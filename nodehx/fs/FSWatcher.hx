package nodehx.fs;

import nodehx.events.EventEmitter;

/**
 * Objects returned from fs.watch() are of this type.
 */
extern class FSWatcher extends EventEmitter {
	/**
	 * Stop watching for changes on the given fs.FSWatcher.
	 */
	public function close() : Void;

}