package nodehx.dns;

import nodehx.Error;

/**
 * Use require("dns") to access this module. All methods in the dns module
 * use C-Ares except for dns.lookup which uses getaddrinfo(3) in a thread
 * pool. C-Ares is much faster than getaddrinfo but the system resolver is
 * more constant with how other programs operate. When a user does
 * net.connect(80, "google.com") or http.get({ host: "google.com" }) the
 * dns.lookup method is used. Users who need to do a large number of lookups
 * quickly should use the methods that go through C-Ares.
 * Here is an example which resolves "www.google.com" then reverse
 * resolves the IP addresses which are returned.
 * var dns = require("dns");
 * dns.resolve4("www.google.com", function (err, addresses) {
 *   if (err) throw err;
 *   console.log("addresses: " + JSON.stringify(addresses));
 *   addresses.forEach(function (a) {
 *     dns.reverse(a, function (err, domains) {
 *       if (err) {
 *         throw err;
 *       }
 *       console.log("reverse for " + a + ": " + JSON.stringify(domains));
 *     });
 *   });
 * });
 */
extern class DnsModule implements nodehx.Node.NodeModule<"dns", "", ""> {
	/**
	 * DNS server returned answer with no data.
	 */
	public var NODATA(default, never) : String;
	
	/**
	 * DNS server claims query was misformatted.
	 */
	public var FORMERR(default, never) : String;
	
	/**
	 * DNS server returned general failure.
	 */
	public var SERVFAIL(default, never) : String;
	
	/**
	 * Domain name not found.
	 */
	public var NOTFOUND(default, never) : String;
	
	/**
	 * DNS server does not implement requested operation.
	 */
	public var NOTIMP(default, never) : String;
	
	/**
	 * DNS server refused query.
	 */
	public var REFUSED(default, never) : String;
	
	/**
	 * Misformatted DNS query.
	 */
	public var BADQUERY(default, never) : String;
	
	/**
	 * Misformatted domain name.
	 */
	public var BADNAME(default, never) : String;
	
	/**
	 * Unsupported address family.
	 */
	public var BADFAMILY(default, never) : String;
	
	/**
	 * Misformatted DNS reply.
	 */
	public var BADRESP(default, never) : String;
	
	/**
	 * Could not contact DNS servers.
	 */
	public var CONNREFUSED(default, never) : String;
	
	/**
	 * Timeout while contacting DNS servers.
	 */
	public var TIMEOUT(default, never) : String;
	
	/**
	 * End of file.
	 */
	public var EOF(default, never) : String;
	
	/**
	 * Error reading file.
	 */
	public var FILE(default, never) : String;
	
	/**
	 * Out of memory.
	 */
	public var NOMEM(default, never) : String;
	
	/**
	 * Channel is being destroyed.
	 */
	public var DESTRUCTION(default, never) : String;
	
	/**
	 * Misformatted string.
	 */
	public var BADSTR(default, never) : String;
	
	/**
	 * Illegal flags specified.
	 */
	public var BADFLAGS(default, never) : String;
	
	/**
	 * Given hostname is not numeric.
	 */
	public var NONAME(default, never) : String;
	
	/**
	 * Illegal hints flags specified.
	 */
	public var BADHINTS(default, never) : String;
	
	/**
	 * c-ares library initialization not yet performed.
	 */
	public var NOTINITIALIZED(default, never) : String;
	
	/**
	 * Error loading iphlpapi.dll.
	 */
	public var LOADIPHLPAPI(default, never) : String;
	
	/**
	 * Could not find GetNetworkParams function.
	 */
	public var ADDRGETNETWORKPARAMS(default, never) : String;
	
	/**
	 * DNS query cancelled.
	 */
	public var CANCELLED(default, never) : String;
	
	/**
	 * The same as dns.resolve(), but only for mail exchange queries (MX records).
	 * addresses is an array of MX records, each with a priority and an exchange
	 * attribute (e.g. [{"priority": 10, "exchange": "mx.example.com"},...]).
	 */
	public function resolveMx(domain : String, callback : Error -> Array<Dynamic> -> Void) : Void;

	/**
	 * The same as dns.resolve(), but only for name server records (NS records).
	 * addresses is an array of the name server records available for domain
	 * (e.g., ["ns1.example.com", "ns2.example.com"]).
	 */
	public function resolveNs(domain : String, callback : Error -> Array<String> -> Void) : Void;

	/**
	 * The same as dns.resolve4() except for IPv6 queries (an AAAA query).
	 */
	public function resolve6(domain : String, callback : Error -> Array<String> -> Void) : Void;

	/**
	 * Resolves a domain (e.g. "google.com") into an array of the record types
	 * specified by rrtype. Valid rrtypes are "A" (IPV4 addresses, default),
	 * "AAAA" (IPV6 addresses), "MX" (mail exchange records), "TXT" (text
	 * records), "SRV" (SRV records), "PTR" (used for reverse IP lookups),
	 * "NS" (name server records) and "CNAME" (canonical name records).
	 * The callback has arguments (err, addresses).  The type of each item
	 * in addresses is determined by the record type, and described in the
	 * documentation for the corresponding lookup methods below.
	 * On error, err is an Error object, where err.code is
	 * one of the error codes listed below.
	 */
	public function resolve(domain : String, ?rrtype : String, callback : Error -> Array<Dynamic> -> Void) : Void;

	/**
	 * The same as dns.resolve(), but only for service records (SRV records).
	 * addresses is an array of the SRV records available for domain. Properties
	 * of SRV records are priority, weight, port, and name (e.g.,
	 * [{"priority": 10, {"weight": 5, "port": 21223, "name": "service.example.com"}, ...]).
	 */
	public function resolveSrv(domain : String, callback : Error -> Array<Dynamic> -> Void) : Void;

	/**
	 * The same as dns.resolve(), but only for IPv4 queries (A records).
	 * addresses is an array of IPv4 addresses (e.g.
	 * ["74.125.79.104", "74.125.79.105", "74.125.79.106"]).
	 */
	public function resolve4(domain : String, callback : Error -> Array<String> -> Void) : Void;

	/**
	 * Resolves a domain (e.g. "google.com") into the first found A (IPv4) or
	 * AAAA (IPv6) record.
	 * The family can be the integer 4 or 6. Defaults to null that indicates
	 * both Ip v4 and v6 address family.
	 * The callback has arguments (err, address, family).  The address argument
	 * is a string representation of a IP v4 or v6 address. The family argument
	 * is either the integer 4 or 6 and denotes the family of address (not
	 * necessarily the value initially passed to lookup).
	 * On error, err is an Error object, where err.code is the error code.
	 * Keep in mind that err.code will be set to "ENOENT" not only when
	 * the domain does not exist but also when the lookup fails in other ways
	 * such as no available file descriptors.
	 */
	public function lookup(domain : String, ?family : Int, callback : Error -> String -> Int -> Void) : Void;

	/**
	 * The same as dns.resolve(), but only for text queries (TXT records).
	 * addresses is an array of the text records available for domain (e.g.,
	 * ["v=spf1 ip4:0.0.0.0 ~all"]).
	 */
	public function resolveTxt(domain : String, callback : Error -> Array<String> -> Void) : Void;

	/**
	 * The same as dns.resolve(), but only for canonical name records (CNAME
	 * records). addresses is an array of the canonical name records available for
	 * domain (e.g., ["bar.example.com"]).
	 */
	public function resolveCname(domain : String, callback : Error -> Array<String> -> Void) : Void;

	/**
	 * Reverse resolves an ip address to an array of domain names.
	 * The callback has arguments (err, domains).
	 * On error, err is an Error object, where err.code is
	 * one of the error codes listed below.
	 */
	public function reverse(ip : String, callback : Error -> Array<String> -> Void) : Void;

}
