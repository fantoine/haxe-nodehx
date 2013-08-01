package nodehx.os;

/**
 * Provides a few basic operating-system related utility functions.
 * Use require("os") to access this module.
 */
extern class OsModule implements nodehx.Node.NodeModule<"os", "", ""> {
	/**
	 * A constant defining the appropriate End-of-line marker for the operating system.
	 */
	public var EOL(default, null) : String;
	
	/**
	 * Returns the operating system name.
	 */
	public function type() : String;

	/**
	 * Returns the operating system release.
	 */
	public function release() : String;

	/**
	 * Returns the total amount of system memory in bytes.
	 */
	public function totalmem() : Int;

	/**
	 * Returns the amount of free system memory in bytes.
	 */
	public function freemem() : Int;

	/**
	 * Returns an array of objects containing information about each CPU/core
	 * installed: model, speed (in MHz), and times (an object containing the number of
	 * milliseconds the CPU/core spent in: user, nice, sys, idle, and irq).
	 * Example inspection of os.cpus:
	 * [ { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 252020,
	 *        nice: 0,
	 *        sys: 30340,
	 *        idle: 1070356870,
	 *        irq: 0 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 306960,
	 *        nice: 0,
	 *        sys: 26980,
	 *        idle: 1071569080,
	 *        irq: 0 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 248450,
	 *        nice: 0,
	 *        sys: 21750,
	 *        idle: 1070919370,
	 *        irq: 0 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 256880,
	 *        nice: 0,
	 *        sys: 19430,
	 *        idle: 1070905480,
	 *        irq: 20 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 511580,
	 *        nice: 20,
	 *        sys: 40900,
	 *        idle: 1070842510,
	 *        irq: 0 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 291660,
	 *        nice: 0,
	 *        sys: 34360,
	 *        idle: 1070888000,
	 *        irq: 10 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 308260,
	 *        nice: 0,
	 *        sys: 55410,
	 *        idle: 1071129970,
	 *        irq: 880 } },
	 *   { model: "Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz",
	 *     speed: 2926,
	 *     times:
	 *      { user: 266450,
	 *        nice: 1480,
	 *        sys: 34920,
	 *        idle: 1072572010,
	 *        irq: 30 } } ]
	 */
	public function cpus() : Array<Dynamic>;

	/**
	 * Get a list of network interfaces:
	 * { lo0: 
	 *    [ { address: "::1", family: "IPv6", internal: true },
	 *      { address: "fe80::1", family: "IPv6", internal: true },
	 *      { address: "127.0.0.1", family: "IPv4", internal: true } ],
	 *   en1: 
	 *    [ { address: "fe80::cabc:c8ff:feef:f996", family: "IPv6",
	 *        internal: false },
	 *      { address: "10.0.1.123", family: "IPv4", internal: false } ],
	 *   vmnet1: [ { address: "10.99.99.254", family: "IPv4", internal: false } ],
	 *   vmnet8: [ { address: "10.88.88.1", family: "IPv4", internal: false } ],
	 *   ppp0: [ { address: "10.2.0.231", family: "IPv4", internal: false } ] }
	 */
	public function networkInterfaces() : Dynamic;

	/**
	 * Returns the endianness of the CPU. Possible values are 'BE' or 'LE'.
	 */
	public function endianness() : String;

	/**
	 * Returns the system uptime in seconds.
	 */
	public function uptime() : Int;

	/**
	 * Returns the hostname of the operating system.
	 */
	public function hostname() : String;

	/**
	 * Returns an array containing the 1, 5, and 15 minute load averages.
	 */
	public function loadavg() : Array<Float>;

	/**
	 * Returns the operating system platform.
	 */
	public function platform() : String;

	/**
	 * Returns the operating system"s default directory for temp files.
	 */
	public function tmpdir() : String;

	/**
	 * Returns the operating system CPU architecture.
	 */
	public function arch() : String;

}
