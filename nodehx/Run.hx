/**
 * ...
 * @author Fabien Antoine
 * @copy Fabien Antoine (fantoine@intuitiv.fr)
 */

package nodehx;

import haxe.io.Output;
import sys.FileSystem;
import sys.io.File;
import tjson.TJSON;

using Lambda;
using Reflect;
using StringTools;

class Run {
	static inline var SRC			= "all.json";
	static inline var PATCH			= "patch.json";
	static inline var DOCS			= "docs/";
	static inline var BASEPACKAGE	= "nodehx";
	
	static var PACKAGE = "";
	static var INPUT = "";
	static var OUTPUT = "";
	
	static function main() {
		// Get params
		var params = Sys.args();
		var lib		= (params.length < 1 ? "nodejs" : params[0]);
		var version = (params.length < 2 ? "0.10.12" : params[1]);
		
		INPUT	= DOCS + lib + "/" + version + "/";
		OUTPUT	= Sys.getCwd() + BASEPACKAGE + "/" + lib.toLowerCase();
		PACKAGE	= BASEPACKAGE + "." + lib;
		
		// Get json content
		var all : Dynamic	= TJSON.parse(File.getContent(INPUT + SRC));
		var patch : Dynamic	= TJSON.parse(File.getContent(INPUT + PATCH));
		
		// Apply patch
		var modules = _patchModules(all.modules, patch);
		
		// Create output folder
		if(!FileSystem.exists(OUTPUT)) FileSystem.createDirectory(OUTPUT);
		
		// Generate modules
		for(module in modules) {
			// Get module name
			var name : String = module.name;
			
			// Get filename
			var filename = "";
			for(s in name.split("_")) {
				if(s == "") continue;
				filename += s.substr(0, 1).toUpperCase();
				if(s.length > 1) filename += s.substr(1);
			}
			filename += "Module";
			
			// Open file
			_open(filename);
			
			// Start module class
			_writeClass(module, filename, name);
			
			// Add additional classes
			if(module.hasField("classes")) {
				for(clss in _a(module.classes)) {
					_wln("");
					_writeClass(clss);
				}
			}
		}
	}
	
	static function _writeClass(infos : Dynamic, ?classname : String, ?modulename : String) : Void {
		if(classname == null) {
			classname = "";
			for(s in Std.string(infos.name).split("_")) {
				if(s == "") continue;
				classname += s.substr(0, 1).toUpperCase();
				if(s.length > 1) classname += s.substr(1);
			}
		}
		// Start class
		_doc(infos.desc);
		if(modulename != null) _waln([ "@:NodehxModule(\"", modulename, "\")" ]);
		_waln([ "extern class ", classname, " {"]);
		_tab();
		{
			// Add methods
			if(infos.hasField("properties")) {
				for(property in _a(infos.properties)) {
					_doc(property.desc);
					_waln([ "public var ", property.name, " : ", (property.hasField("type") ? _haxeType(property.type) : "Dynamic"), ";\n" ]);
				}
			}
			
			// Add methods
			if(infos.hasField("methods")) {
				for(method in _a(infos.methods)) {
					// Prepare signature
					var signatures = [];
					if(method.hasField("signatures") && method.signatures.length > 0) {
						for(sign in _a(method.signatures)) {
							var signature = "";
							// Get params
							for(p in _a(sign.params)) {
								if(p.name == "...") {
									for(i in 0...5) {
										var p2 = Reflect.copy(p);
										p2.name = "argument" + (i + 1);
										signature = _addParam(signature, p2);
									}
								} else {
									signature = _addParam(signature, p);
								}
							}
							// Get return type
							var returns : Dynamic = (sign.hasField("return") ? sign.field("return") : null);
							var ret = ((returns != null && returns.hasField("type")) ? 
								_haxeType(returns.type) : 
								"Dynamic"
							);
							if(returns != null && returns.hasField("nullable") && returns.nullable == true) ret = "Null<" + ret + ">";
							
							signatures.push("(" + signature + ") : " + ret);
						}
					}
					
					// Write
					_doc(method.desc);
					if(signatures.length > 0) {
						for(i in 1...signatures.length)
							_waln([ "@:overload(function", signatures[i], " {})" ]);
						_waln([ "public function ", _clean(method.name), signatures[0], ";\n" ]);
					} else {
						_wln("// No signature found\n");
					}
				}
			}
		}
		_untab();
		_wln("}");
	}
	static function _addParam(signature : String, param : Dynamic) : String {
		if(signature != "") signature += ", ";
		if(param.hasField("optional") && param.optional == true) signature += "?";
		signature += _kw(param.name);
		signature +=  " : ";
		signature +=  (param.hasField("type") ? _haxeType(param.type) : "Dynamic");
		return signature;
	}
	static function _haxeType(jsType : String) : String {
		var type : String = Std.string(jsType);
		return switch(type) {
			case "null":
				"Dynamic";
			case "Function", "Object":
				"Dynamic";
			case "Array":
				"Array<Dynamic>";
			case "Number":
				"Float";
			case "Boolean":
				"Bool";
			default:
				type.trim().split(" ").shift();
		}
	}
	
	static inline function _a(v : Dynamic) : Array<Dynamic> {
		return (v == null ? [] : cast(v, Array<Dynamic>));
	}
	static var _keywords = "break callback case catch class continue default do else enum extends for function if implements import in interface new package return switch throw try typedef using var while dynamic extern inline override private public static untyped cast trace super this arguments null true false".split(" ");
	static inline function _iskw(word : String) : Bool {
		return _keywords.has(word);
	}
	static inline function _kw(word : String) : String {
		word = _clean(word);
		return word + (_iskw(word) ? "_" : "");
	}
	static inline function _clean(word : String) : String {
		return ~/[^a-z0-9_]+/ig.replace(word, "");
	}
	
	static function _doc(doc : String) : Void {
		var replaced = doc.replace("&#39;", "\"").replace("&quot;", "'").replace("&amp;", "&").replace("*/", "*\\/").replace("&lt;", "<").replace("&gt;", ">");
		var clean = ~/<\/?[a-z0-9-]+([^>]*)>/ig.replace(replaced, "").trim();
		var trimmed = ~/(\r\n|\n)+/ig.replace(clean, "\n");
		var tabbed = ~/(\r\n|\n)/g.split(trimmed).join("\n"+_tabs+" * ");
		_wln("/**");
		_waln([" * ", tabbed]);
		_wln(" */");
	}
	static var _out : Output = null;
	static inline function _open(name : String) : Void {
		// Auto close previous file
		_close();
		
		// Create file
		_out = File.write(OUTPUT + "/" + name + ".hx", true);
		_waln([ "package ", PACKAGE, ";\n" ]);
	}
	static inline function _close() : Void {
		if(_out != null) {
			_out.close();
			_out = null;
		}
	}
	static inline function _w(content : String) : Void {
		_out.writeString(_tabs);
		_out.writeString(content);
	}
	static inline function _wln(content : String) : Void {
		_w(content + "\n");
	}
	static inline function _wa(contents : Array<String>) : Void {
		_w(contents.join(""));
	}
	static inline function _waln(contents : Array<String>) : Void {
		_wa(contents.concat(["\n"]));
	}
	static var _tabs = "";
	static inline function _tab() : Void {
		_tabs += "\t";
	}
	static inline function _untab() : Void {
		if(_tabs.length > 0) _tabs = _tabs.substr(1);
	}
	
	static function _patchModules(modules : Array<Dynamic>, patch : Dynamic) : Array<Dynamic> {
		var datas = [];
		
		var pmodules : Array<Dynamic> = _a(patch.modules);
		for(module in modules) {
			// Get patched module
			var pmodule : Dynamic = _patched(pmodules, module.name);
			
			// Ignore deleted modules
			if(_hasPatch(pmodule, "delete")) continue;
			
			// Copy module
			var dmodule = {
				name	: module.name,
				desc	: module.desc,
				methods	: [],
				classes	: [],
			};
			
			// Patch module
			_patchClass(module, dmodule, pmodule);
			
			// Patch classes
			if(module.hasField("classes")) {
				for(clss in _a(module.classes)) {
					var pclss = (pmodule.hasField("classes") ? _patched(pmodule.classes, clss.name) : null);
					var dclss = {
						name		: clss.name,
						desc		: clss.desc,
						methods		: [],
						properties	: [],
					};
					_patchClass(clss, dclss, pclss);
					dmodule.classes.push(dclss);
				}
			}
			
			datas.push(dmodule);
		}
		
		return datas;
	}
	static function _patchClass(clss : Dynamic, dclss : Dynamic, pclss : Dynamic) : Dynamic {
		if(pclss != null && _hasPatch(pclss, "rename")) dclss.name = pclss.rename;
		
		// Apply methods
		if(clss.hasField("methods")) {
			var methods = new Hash<Dynamic>();
			
			// Fusion duplicated methods
			for(method in _a(clss.methods)) {
				if(methods.exists(method.name)) {
					var tmp = methods.get(method.name);
					tmp.signatures = tmp.signatures.concat(method.signatures);
				} else {
					methods.set(method.name, method);
				}
			}
			
			// Apply patches
			for(method in methods) {
				var pmethod = (pclss.hasField("methods") ? _patched(pclss.methods, method.name) : null);
				var dmethod = {
					name		: method.name,
					desc		: method.desc,
					signatures	: [],
				};
				_patchMethod(method, dmethod, pmethod);
				dclss.methods.push(dmethod);
			}
		}
	}
	static function _patchMethod(method : Dynamic, dmethod : Dynamic, pmethod : Dynamic) : Dynamic {
		if(pmethod != null) {
			if(_hasPatch(pmethod, "rename"))
				dmethod.name = pmethod.rename;
			if(_hasPatch(pmethod, "signatures"))
				dmethod.signatures = pmethod.signatures;
		}
		
		var signatures : Array<Dynamic> = _a(method.signatures);
		
		// Split multi-type parameters
		var newSignatures = [];
		for(signature in signatures) {
			// Split return type
			if(Reflect.hasField(signature, "return")) {
				var ret = Reflect.field(signature, "return");
				var split = Std.string(ret.type).split("|").map(StringTools.trim);
				var nullable = split.has("null");
				split = split.filter(function(s) return (s != "null"));
				ret.type = (split.length == 0 || split.length > 1 ? "Dynamic" : split.first());
				if(nullable) ret.nullable = true;
			}
			
			// Split parameters
			function splitter(acc : Array<Dynamic>, params : Array<Dynamic>) : Array<Array<Dynamic>> {
				if(params.length == 0) return [ acc ];
				
				// Check parameters
				var param : Dynamic = params.pop();
				var type : String = (param.hasField("type") ? param.field("type") : null);
				var split = (type != null ? type.split("|").map(StringTools.trim).array() : [null]);
				var nullable = split.has("null");
				var filtered = split.filter(function(s) return (s != "null"));
				
				// Aplply parameter type
				var signs = [];
				for(p in filtered) {
					var copy		= Reflect.copy(param);
					if(p != null) copy.type	= p;
					copy.nullable	= nullable;
					
					signs = signs.concat(splitter(acc.concat([copy]), params));
				}
				return signs;
			}
			
			// Apply new signatures
			var newParameters = splitter([], signature.params);
			for(newParam in newParameters) {
				var copy = Reflect.copy(signature);
				copy.params = newParam;
				if(copy.params != null) copy.params.reverse();
				newSignatures.push(copy);
			}
		}
		signatures = newSignatures;
		
		// Clear useless signatures
		if(signatures.length > 1) {
			var newSignatures = [];
			
			for(i in 0...signatures.length) {
				var signature = signatures[i];
				var found = false;
				for(j in 0...i) {
					var compared = signatures[j];
					
					var sparams : Array<Dynamic> = (Reflect.hasField(signature, "params") ? signature.params : []);
					var cparams : Array<Dynamic> = (Reflect.hasField(compared, "params") ? compared.params : []);
					
					// Compare signatures params
					if(sparams.length == cparams.length) {
						var weight = 0, equals = true;
						for(k in 0...sparams.length) {
							if(sparams[k].name != cparams[k].name) {
								equals = false;
								break;
							} else {
								var stype = Reflect.hasField(sparams[k], "type");
								var ctype = Reflect.hasField(cparams[k], "type");
								if(stype && ctype) {
									if(Reflect.field(sparams[k], "type") != Reflect.field(cparams[k], "type")) {
										equals = false;
										break;
									}
								} else if(stype) {
									weight += 1;
								}
								else if(ctype) weight -= 1;
							}
						}
						
						// If name are all equals, but no informations are provided keep the more detailed one
						if(equals) {
							found = true;
							if(weight > 0) {
								newSignatures.push(signature);
							} else if(weight < 0) {
								//TODO : replace compared by this one
							}
							break;
						}
					}
				}
				if(!found) newSignatures.push(signature);
			}
			signatures = newSignatures;
		}
		
		dmethod.signatures = signatures;
	}
	static function _patchSignature(signature : Dynamic, dsignature : Dynamic, psignature : Dynamic) : Void {
		
	}
	
	static inline function _patched(data : Array<Dynamic>, name : String) : Dynamic {
		return (data == null ? null : data.filter(function(d) return (d.name == name)).pop());
	}
	static function _hasPatch(data : Dynamic, type : String) : Bool {
		if(data != null && data.hasField("patch")) {
			return if(Std.is(data.patch, Array)) {
				Lambda.has(data.patch, type);
			} else {
				Std.string(data.patch) == type;
			}
		}
		return false;
	}
}