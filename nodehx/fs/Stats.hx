package nodehx.fs;

/**
 * Objects returned from fs.stat(), fs.lstat() and fs.fstat() and their
 * synchronous counterparts are of this type.
 * stats.isFile()
 * stats.isDirectory()
 * stats.isBlockDevice()
 * stats.isCharacterDevice()
 * stats.isSymbolicLink() (only valid with  fs.lstat())
 * stats.isFIFO()
 * stats.isSocket()
 * For a regular file util.inspect(stats) would return a string very
 * similar to this:
 * { dev: 2114,
 *   ino: 48064969,
 *   mode: 33188,
 *   nlink: 1,
 *   uid: 85,
 *   gid: 100,
 *   rdev: 0,
 *   size: 527,
 *   blksize: 4096,
 *   blocks: 8,
 *   atime: Mon, 10 Oct 2011 23:24:11 GMT,
 *   mtime: Mon, 10 Oct 2011 23:24:11 GMT,
 *   ctime: Mon, 10 Oct 2011 23:24:11 GMT }
 * Please note that atime, mtime and ctime are instances
 * of [Date][MDN-Date] object and to compare the values of
 * these objects you should use appropriate methods. For most
 * general uses [getTime()][MDN-Date-getTime] will return
 * the number of milliseconds elapsed since 1 January 1970
 * 00:00:00 UTC and this integer should be sufficient for
 * any comparison, however there additional methods which can
 * be used for displaying fuzzy information. More details can
 * be found in the [MDN JavaScript Reference][MDN-Date] page.
 */
extern class Stats {
	public var dev(default, null) : Int;
	public var ino(default, null) : Int;
	public var mode(default, null) : Int;
	public var nlink(default, null) : Int;
	public var uid(default, null) : Int;
	public var gid(default, null) : Int;
	public var rdev(default, null) : Int;
	public var size(default, null) : Int;
	public var blksize(default, null) : Int;
	public var blocks(default, null) : Int;
	public var atime(default, null) : Date;
	public var mtime(default, null) : Date;
	public var ctime(default, null) : Date;
}