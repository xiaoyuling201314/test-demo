/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// CONCATENATED MODULE: ./src/md5.js
function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

/*
 Javascript MD5 library - version 0.4

 Coded (2011) by Luigi Galli - LG@4e71.org - http://faultylabs.com

 Thanks to: Roberto Viola

 The below code is PUBLIC DOMAIN - NO WARRANTY!

 Changelog: 
            Version 0.4   - 2011-06-19
            + added compact version (md5_compact_min.js), this is a slower but smaller version 
              (more than 4KB lighter before stripping/minification)
            + added preliminary support for Typed Arrays (see: 
              https://developer.mozilla.org/en/JavaScript_typed_arrays and 
              http://www.khronos.org/registry/typedarray/specs/latest/)
              MD5() now accepts input data as ArrayBuffer, Float32Array, Float64Array, 
              Int16Array, Int32Array, Int8Array, Uint16Array, Uint32Array or Uint8Array 
            - moved unit tests to md5_test.js
            - minor refactoring 

            Version 0.3.* - 2011-06-##
            - Internal dev versions

            Version 0.2 - 2011-05-22 
            ** FIXED: serious integer overflow problems which could cause a wrong MD5 hash being returned

            Version 0.1 - 2011
            -Initial version
*/
if (typeof faultylabs == 'undefined') {
  var faultylabs = {};
}
/*
   MD5()

    Computes the MD5 hash for the given input data

    input :  data as String - (Assumes Unicode code points are encoded as UTF-8. If you 
                               attempt to digest Unicode strings using other encodings 
                               you will get incorrect results!)

             data as array of characters - (Assumes Unicode code points are encoded as UTF-8. If you 
                              attempt to digest Unicode strings using other encodings 
                              you will get incorrect results!)

             data as array of bytes (plain javascript array of integer numbers)

             data as ArrayBuffer (see: https://developer.mozilla.org/en/JavaScript_typed_arrays)
            
             data as Float32Array, Float64Array, Int16Array, Int32Array, Int8Array, Uint16Array, Uint32Array or Uint8Array (see: https://developer.mozilla.org/en/JavaScript_typed_arrays)
             
             (DataView is not supported yet)

   output: MD5 hash (as Hex Uppercase String)
*/


faultylabs.MD5 = function (data) {
  // convert number to (unsigned) 32 bit hex, zero filled string
  function to_zerofilled_hex(n) {
    var t1 = (n >>> 0).toString(16);
    return "00000000".substr(0, 8 - t1.length) + t1;
  } // convert array of chars to array of bytes 


  function chars_to_bytes(ac) {
    var retval = [];

    for (var i = 0; i < ac.length; i++) {
      retval = retval.concat(str_to_bytes(ac[i]));
    }

    return retval;
  } // convert a 64 bit unsigned number to array of bytes. Little endian


  function int64_to_bytes(num) {
    var retval = [];

    for (var i = 0; i < 8; i++) {
      retval.push(num & 0xFF);
      num = num >>> 8;
    }

    return retval;
  } //  32 bit left-rotation


  function rol(num, places) {
    return num << places & 0xFFFFFFFF | num >>> 32 - places;
  } // The 4 MD5 functions


  function fF(b, c, d) {
    return b & c | ~b & d;
  }

  function fG(b, c, d) {
    return d & b | ~d & c;
  }

  function fH(b, c, d) {
    return b ^ c ^ d;
  }

  function fI(b, c, d) {
    return c ^ (b | ~d);
  } // pick 4 bytes at specified offset. Little-endian is assumed


  function bytes_to_int32(arr, off) {
    return arr[off + 3] << 24 | arr[off + 2] << 16 | arr[off + 1] << 8 | arr[off];
  }
  /*
  Conver string to array of bytes in UTF-8 encoding
  See: 
  http://www.dangrossman.info/2007/05/25/handling-utf-8-in-javascript-php-and-non-utf8-databases/
  http://stackoverflow.com/questions/1240408/reading-bytes-from-a-javascript-string
  How about a String.getBytes(<ENCODING>) for Javascript!? Isn't it time to add it?
  */


  function str_to_bytes(str) {
    var retval = [];

    for (var i = 0; i < str.length; i++) {
      if (str.charCodeAt(i) <= 0x7F) {
        retval.push(str.charCodeAt(i));
      } else {
        var tmp = encodeURIComponent(str.charAt(i)).substr(1).split('%');

        for (var j = 0; j < tmp.length; j++) {
          retval.push(parseInt(tmp[j], 0x10));
        }
      }
    }

    return retval;
  } // convert the 4 32-bit buffers to a 128 bit hex string. (Little-endian is assumed)


  function int128le_to_hex(a, b, c, d) {
    var ra = "";
    var t = 0;
    var ta = 0;

    for (var i = 3; i >= 0; i--) {
      ta = arguments[i];
      t = ta & 0xFF;
      ta = ta >>> 8;
      t = t << 8;
      t = t | ta & 0xFF;
      ta = ta >>> 8;
      t = t << 8;
      t = t | ta & 0xFF;
      ta = ta >>> 8;
      t = t << 8;
      t = t | ta;
      ra = ra + to_zerofilled_hex(t);
    }

    return ra;
  } // conversion from typed byte array to plain javascript array 


  function typed_to_plain(tarr) {
    var retval = new Array(tarr.length);

    for (var i = 0; i < tarr.length; i++) {
      retval[i] = tarr[i];
    }

    return retval;
  } // check input data type and perform conversions if needed


  var databytes = null; // String

  var type_mismatch = null;

  if (typeof data == 'string') {
    // convert string to array bytes
    databytes = str_to_bytes(data);
  } else if (data.constructor == Array) {
    if (data.length === 0) {
      // if it's empty, just assume array of bytes
      databytes = data;
    } else if (typeof data[0] == 'string') {
      databytes = chars_to_bytes(data);
    } else if (typeof data[0] == 'number') {
      databytes = data;
    } else {
      type_mismatch = _typeof(data[0]);
    }
  } else if (typeof ArrayBuffer != 'undefined') {
    if (data instanceof ArrayBuffer) {
      databytes = typed_to_plain(new Uint8Array(data));
    } else if (data instanceof Uint8Array || data instanceof Int8Array) {
      databytes = typed_to_plain(data);
    } else if (data instanceof Uint32Array || data instanceof Int32Array || data instanceof Uint16Array || data instanceof Int16Array || data instanceof Float32Array || data instanceof Float64Array) {
      databytes = typed_to_plain(new Uint8Array(data.buffer));
    } else {
      type_mismatch = _typeof(data);
    }
  } else {
    type_mismatch = _typeof(data);
  }

  if (type_mismatch) {
    alert('MD5 type mismatch, cannot process ' + type_mismatch);
  }

  function _add(n1, n2) {
    return 0x0FFFFFFFF & n1 + n2;
  }

  return do_digest();

  function do_digest() {
    // function update partial state for each run
    function updateRun(nf, sin32, dw32, b32) {
      var temp = d;
      d = c;
      c = b; //b = b + rol(a + (nf + (sin32 + dw32)), b32)

      b = _add(b, rol(_add(a, _add(nf, _add(sin32, dw32))), b32));
      a = temp;
    } // save original length


    var org_len = databytes.length; // first append the "1" + 7x "0"

    databytes.push(0x80); // determine required amount of padding

    var tail = databytes.length % 64; // no room for msg length?

    if (tail > 56) {
      // pad to next 512 bit block
      for (var i = 0; i < 64 - tail; i++) {
        databytes.push(0x0);
      }

      tail = databytes.length % 64;
    }

    for (i = 0; i < 56 - tail; i++) {
      databytes.push(0x0);
    } // message length in bits mod 512 should now be 448
    // append 64 bit, little-endian original msg length (in *bits*!)


    databytes = databytes.concat(int64_to_bytes(org_len * 8)); // initialize 4x32 bit state

    var h0 = 0x67452301;
    var h1 = 0xEFCDAB89;
    var h2 = 0x98BADCFE;
    var h3 = 0x10325476; // temp buffers

    var a = 0,
        b = 0,
        c = 0,
        d = 0; // Digest message

    for (i = 0; i < databytes.length / 64; i++) {
      // initialize run
      a = h0;
      b = h1;
      c = h2;
      d = h3;
      var ptr = i * 64; // do 64 runs

      updateRun(fF(b, c, d), 0xd76aa478, bytes_to_int32(databytes, ptr), 7);
      updateRun(fF(b, c, d), 0xe8c7b756, bytes_to_int32(databytes, ptr + 4), 12);
      updateRun(fF(b, c, d), 0x242070db, bytes_to_int32(databytes, ptr + 8), 17);
      updateRun(fF(b, c, d), 0xc1bdceee, bytes_to_int32(databytes, ptr + 12), 22);
      updateRun(fF(b, c, d), 0xf57c0faf, bytes_to_int32(databytes, ptr + 16), 7);
      updateRun(fF(b, c, d), 0x4787c62a, bytes_to_int32(databytes, ptr + 20), 12);
      updateRun(fF(b, c, d), 0xa8304613, bytes_to_int32(databytes, ptr + 24), 17);
      updateRun(fF(b, c, d), 0xfd469501, bytes_to_int32(databytes, ptr + 28), 22);
      updateRun(fF(b, c, d), 0x698098d8, bytes_to_int32(databytes, ptr + 32), 7);
      updateRun(fF(b, c, d), 0x8b44f7af, bytes_to_int32(databytes, ptr + 36), 12);
      updateRun(fF(b, c, d), 0xffff5bb1, bytes_to_int32(databytes, ptr + 40), 17);
      updateRun(fF(b, c, d), 0x895cd7be, bytes_to_int32(databytes, ptr + 44), 22);
      updateRun(fF(b, c, d), 0x6b901122, bytes_to_int32(databytes, ptr + 48), 7);
      updateRun(fF(b, c, d), 0xfd987193, bytes_to_int32(databytes, ptr + 52), 12);
      updateRun(fF(b, c, d), 0xa679438e, bytes_to_int32(databytes, ptr + 56), 17);
      updateRun(fF(b, c, d), 0x49b40821, bytes_to_int32(databytes, ptr + 60), 22);
      updateRun(fG(b, c, d), 0xf61e2562, bytes_to_int32(databytes, ptr + 4), 5);
      updateRun(fG(b, c, d), 0xc040b340, bytes_to_int32(databytes, ptr + 24), 9);
      updateRun(fG(b, c, d), 0x265e5a51, bytes_to_int32(databytes, ptr + 44), 14);
      updateRun(fG(b, c, d), 0xe9b6c7aa, bytes_to_int32(databytes, ptr), 20);
      updateRun(fG(b, c, d), 0xd62f105d, bytes_to_int32(databytes, ptr + 20), 5);
      updateRun(fG(b, c, d), 0x2441453, bytes_to_int32(databytes, ptr + 40), 9);
      updateRun(fG(b, c, d), 0xd8a1e681, bytes_to_int32(databytes, ptr + 60), 14);
      updateRun(fG(b, c, d), 0xe7d3fbc8, bytes_to_int32(databytes, ptr + 16), 20);
      updateRun(fG(b, c, d), 0x21e1cde6, bytes_to_int32(databytes, ptr + 36), 5);
      updateRun(fG(b, c, d), 0xc33707d6, bytes_to_int32(databytes, ptr + 56), 9);
      updateRun(fG(b, c, d), 0xf4d50d87, bytes_to_int32(databytes, ptr + 12), 14);
      updateRun(fG(b, c, d), 0x455a14ed, bytes_to_int32(databytes, ptr + 32), 20);
      updateRun(fG(b, c, d), 0xa9e3e905, bytes_to_int32(databytes, ptr + 52), 5);
      updateRun(fG(b, c, d), 0xfcefa3f8, bytes_to_int32(databytes, ptr + 8), 9);
      updateRun(fG(b, c, d), 0x676f02d9, bytes_to_int32(databytes, ptr + 28), 14);
      updateRun(fG(b, c, d), 0x8d2a4c8a, bytes_to_int32(databytes, ptr + 48), 20);
      updateRun(fH(b, c, d), 0xfffa3942, bytes_to_int32(databytes, ptr + 20), 4);
      updateRun(fH(b, c, d), 0x8771f681, bytes_to_int32(databytes, ptr + 32), 11);
      updateRun(fH(b, c, d), 0x6d9d6122, bytes_to_int32(databytes, ptr + 44), 16);
      updateRun(fH(b, c, d), 0xfde5380c, bytes_to_int32(databytes, ptr + 56), 23);
      updateRun(fH(b, c, d), 0xa4beea44, bytes_to_int32(databytes, ptr + 4), 4);
      updateRun(fH(b, c, d), 0x4bdecfa9, bytes_to_int32(databytes, ptr + 16), 11);
      updateRun(fH(b, c, d), 0xf6bb4b60, bytes_to_int32(databytes, ptr + 28), 16);
      updateRun(fH(b, c, d), 0xbebfbc70, bytes_to_int32(databytes, ptr + 40), 23);
      updateRun(fH(b, c, d), 0x289b7ec6, bytes_to_int32(databytes, ptr + 52), 4);
      updateRun(fH(b, c, d), 0xeaa127fa, bytes_to_int32(databytes, ptr), 11);
      updateRun(fH(b, c, d), 0xd4ef3085, bytes_to_int32(databytes, ptr + 12), 16);
      updateRun(fH(b, c, d), 0x4881d05, bytes_to_int32(databytes, ptr + 24), 23);
      updateRun(fH(b, c, d), 0xd9d4d039, bytes_to_int32(databytes, ptr + 36), 4);
      updateRun(fH(b, c, d), 0xe6db99e5, bytes_to_int32(databytes, ptr + 48), 11);
      updateRun(fH(b, c, d), 0x1fa27cf8, bytes_to_int32(databytes, ptr + 60), 16);
      updateRun(fH(b, c, d), 0xc4ac5665, bytes_to_int32(databytes, ptr + 8), 23);
      updateRun(fI(b, c, d), 0xf4292244, bytes_to_int32(databytes, ptr), 6);
      updateRun(fI(b, c, d), 0x432aff97, bytes_to_int32(databytes, ptr + 28), 10);
      updateRun(fI(b, c, d), 0xab9423a7, bytes_to_int32(databytes, ptr + 56), 15);
      updateRun(fI(b, c, d), 0xfc93a039, bytes_to_int32(databytes, ptr + 20), 21);
      updateRun(fI(b, c, d), 0x655b59c3, bytes_to_int32(databytes, ptr + 48), 6);
      updateRun(fI(b, c, d), 0x8f0ccc92, bytes_to_int32(databytes, ptr + 12), 10);
      updateRun(fI(b, c, d), 0xffeff47d, bytes_to_int32(databytes, ptr + 40), 15);
      updateRun(fI(b, c, d), 0x85845dd1, bytes_to_int32(databytes, ptr + 4), 21);
      updateRun(fI(b, c, d), 0x6fa87e4f, bytes_to_int32(databytes, ptr + 32), 6);
      updateRun(fI(b, c, d), 0xfe2ce6e0, bytes_to_int32(databytes, ptr + 60), 10);
      updateRun(fI(b, c, d), 0xa3014314, bytes_to_int32(databytes, ptr + 24), 15);
      updateRun(fI(b, c, d), 0x4e0811a1, bytes_to_int32(databytes, ptr + 52), 21);
      updateRun(fI(b, c, d), 0xf7537e82, bytes_to_int32(databytes, ptr + 16), 6);
      updateRun(fI(b, c, d), 0xbd3af235, bytes_to_int32(databytes, ptr + 44), 10);
      updateRun(fI(b, c, d), 0x2ad7d2bb, bytes_to_int32(databytes, ptr + 8), 15);
      updateRun(fI(b, c, d), 0xeb86d391, bytes_to_int32(databytes, ptr + 36), 21); // update buffers

      h0 = _add(h0, a);
      h1 = _add(h1, b);
      h2 = _add(h2, c);
      h3 = _add(h3, d);
    } // Done! Convert buffers to 128 bit (LE)


    return int128le_to_hex(h3, h2, h1, h0).toUpperCase();
  }
};

function hex_md5(s) {
  return faultylabs.MD5(s);
}

/* harmony default export */ var md5 = (hex_md5);
// CONCATENATED MODULE: ./src/public.js
function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }


var isDebug = false;

var public_debug = function (flag) {
  if (flag) {
    return {
      log: function log(message) {
        console.log(message);
      },
      error: function error(message) {
        console.error(message);
      },
      count: function count(message) {
        console.count(message);
      },
      info: function info(message) {
        console.info(message);
      },
      trace: function trace(message) {
        console.trace(message);
      }
    };
  } else {
    return {
      log: function log() {},
      error: function error() {},
      count: function count() {},
      info: function info() {}
    };
  }
}(isDebug);

function BrowserDetect() {
  var agent = navigator.userAgent.toLowerCase(),
      name = navigator.appName,
      browser = null;

  if (name === "Microsoft Internet Explorer" || agent.indexOf("trident") > -1 || agent.indexOf("edge/") > -1) {
    browser = "ie";

    if (name === "Microsoft Internet Explorer") {
      agent = /msie ([0-9]{1,}[\.0-9]{0,})/.exec(agent);
      browser += parseInt(agent[1]);
    } else {
      if (agent.indexOf("trident") > -1) {
        browser += 11;
      } else if (agent.indexOf("edge/") > -1) {
        browser = "edge";
      }
    }
  } else if (agent.indexOf("safari") > -1) {
    if (agent.indexOf("chrome") > -1) {
      browser = "chrome";
    } else {
      browser = "safari";
    }
  } else if (agent.indexOf("firefox") > -1) {
    browser = "firefox";
  }

  return browser;
}

var Script = function script() {
  function Constructor() {}

  Constructor.createFromElementId = function (id) {
    var script = document.getElementById(id); //assert(script, "Could not find shader with ID: " + id);

    var source = "";
    var currentChild = script.firstChild;

    while (currentChild) {
      if (currentChild.nodeType === 3) {
        source += currentChild.textContent;
      }

      currentChild = currentChild.nextSibling;
    }

    var res = new Constructor();
    res.type = script.type;
    res.source = source;
    return res;
  };

  Constructor.createFromSource = function (type, source) {
    var res = new Constructor();
    res.type = type;
    res.source = source;
    return res;
  };

  return Constructor;
}();

var Shader = function shader() {
  function Constructor(gl, script) {
    if (script.type === "x-shader/x-fragment") {
      this.shader = gl.createShader(gl.FRAGMENT_SHADER);
    } else if (script.type === "x-shader/x-vertex") {
      this.shader = gl.createShader(gl.VERTEX_SHADER);
    } else {
      error("Unknown shader type: " + script.type);
      return;
    }

    gl.shaderSource(this.shader, script.source);
    gl.compileShader(this.shader);

    if (!gl.getShaderParameter(this.shader, gl.COMPILE_STATUS)) {
      error("An error occurred compiling the shaders: " + gl.getShaderInfoLog(this.shader));
      return;
    }
  }

  return Constructor;
}();

var Program = function () {
  function Constructor(gl) {
    this.gl = gl;
    this.program = this.gl.createProgram();
  }

  Constructor.prototype = {
    attach: function attach(shader) {
      this.gl.attachShader(this.program, shader.shader);
    },
    link: function link() {
      this.gl.linkProgram(this.program); //assert(this.gl.getProgramParameter(this.program, this.gl.LINK_STATUS), "Unable to initialize the shader program.")
    },
    use: function use() {
      this.gl.useProgram(this.program);
    },
    getAttributeLocation: function getAttributeLocation(name) {
      return this.gl.getAttribLocation(this.program, name);
    },
    setMatrixUniform: function setMatrixUniform(name, array) {
      var uniform = this.gl.getUniformLocation(this.program, name);
      this.gl.uniformMatrix4fv(uniform, false, array);
    }
  };
  return Constructor;
}();

var Texture = function texture() {
  var textureIDs = null;

  function Constructor(gl, size, format) {
    this.gl = gl;
    this.size = size;
    this.texture = gl.createTexture();
    gl.bindTexture(gl.TEXTURE_2D, this.texture);
    this.format = format ? format : gl.LUMINANCE;
    gl.texImage2D(gl.TEXTURE_2D, 0, this.format, size.w, size.h, 0, this.format, gl.UNSIGNED_BYTE, null);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
  }

  Constructor.prototype = {
    fill: function fill(textureData, useTexSubImage2D) {
      var gl = this.gl; //assert(textureData.length >= this.size.w * this.size.h, "Texture size mismatch, data:" + textureData.length + ", texture: " + this.size.w * this.size.h);

      gl.bindTexture(gl.TEXTURE_2D, this.texture);

      if (useTexSubImage2D) {
        gl.texSubImage2D(gl.TEXTURE_2D, 0, 0, 0, this.size.w, this.size.h, this.format, gl.UNSIGNED_BYTE, textureData);
      } else {
        gl.texImage2D(gl.TEXTURE_2D, 0, this.format, this.size.w, this.size.h, 0, this.format, gl.UNSIGNED_BYTE, textureData);
      }
    },
    bind: function bind(num, program, name) {
      var gl = this.gl;

      if (!textureIDs) {
        textureIDs = [gl.TEXTURE0, gl.TEXTURE1, gl.TEXTURE2];
      }

      gl.activeTexture(textureIDs[num]);
      gl.bindTexture(gl.TEXTURE_2D, this.texture);
      gl.uniform1i(gl.getUniformLocation(program.program, name), num);
    }
  };
  return Constructor;
}();
/**
* Created by 33596 on 2018/5/8.
*/


var base64ArrayBuffer = function base64ArrayBuffer(arrayBuffer) {
  var base64 = '';
  var encodings = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  var bytes = new Uint8Array(arrayBuffer);
  var byteLength = bytes.byteLength;
  var byteRemainder = byteLength % 3;
  var mainLength = byteLength - byteRemainder;
  var a = 0,
      b = 0,
      c = 0,
      d = 0;
  var chunk = 0; // Main loop deals with bytes in chunks of 3

  for (var i = 0; i < mainLength; i = i + 3) {
    // Combine the three bytes into a single integer
    chunk = bytes[i] << 16 | bytes[i + 1] << 8 | bytes[i + 2]; // Use bitmasks to extract 6-bit segments from the triplet

    a = (chunk & 16515072) >> 18; // 16515072 = (2^6 - 1) << 18

    b = (chunk & 258048) >> 12; // 258048   = (2^6 - 1) << 12

    c = (chunk & 4032) >> 6; // 4032     = (2^6 - 1) << 6

    d = chunk & 63; // 63       = 2^6 - 1
    // Convert the raw binary segments to the appropriate ASCII encoding

    base64 += encodings[a] + encodings[b] + encodings[c] + encodings[d];
  } // Deal with the remaining bytes and padding


  if (byteRemainder === 1) {
    chunk = bytes[mainLength];
    a = (chunk & 252) >> 2; // 252 = (2^6 - 1) << 2
    // Set the 4 least significant bits to zero

    b = (chunk & 3) << 4; // 3   = 2^2 - 1

    base64 += encodings[a] + encodings[b] + '==';
  } else if (byteRemainder === 2) {
    chunk = bytes[mainLength] << 8 | bytes[mainLength + 1];
    a = (chunk & 64512) >> 10; // 64512 = (2^6 - 1) << 10

    b = (chunk & 1008) >> 4; // 1008  = (2^6 - 1) << 4
    // Set the 2 least significant bits to zero

    c = (chunk & 15) << 2; // 15    = 2^4 - 1

    base64 += encodings[a] + encodings[b] + encodings[c] + '=';
  }

  return base64;
};

function CommonAudioUtil() {
  var power2 = [1, 2, 4, 8, 0x10, 0x20, 0x40, 0x80, 0x100, 0x200, 0x400, 0x800, 0x1000, 0x2000, 0x4000];
  /*
   * quan()
   *
   * quantizes the input val against the table of size short integers.
   * It returns i if table[i - 1] <= val < table[i].
   *
   * Using linear search for simple coding.
   */

  var quan = function quan(val, table, size) {
    //int, *int, int
    var i = 0; //int

    var j = 0;

    for (i = 0; i < size; i++) {
      if (val < table[j]) {
        break;
      } else {
        j++;
      }
    }

    return i;
  };
  /*
   * fmult()
   *
   * returns the integer product of the 14-bit integer "an" and
   * "floating point" representation (4-bit exponent, 6-bit mantessa) "srn".
   */


  var fmult = function fmult(an, srn) {
    // int, int
    var anmag = 0; //int

    var anexp = 0; //int

    var anmant = 0; //int

    var wanexp = 0; //int

    var wanmant = 0; //int

    var retval = 0; //int

    anmag = an > 0 ? an : -an & 0x1FFF;
    anexp = quan(anmag, power2, 15) - 6;

    if (anmag === 0) {
      anmant = 32;
    } else {
      anmant = anexp >= 0 ? anmag >> anexp : anmag << -anexp;
    }

    wanexp = anexp + (srn >> 6 & 0xF) - 13;
    wanmant = anmant * (srn & parseInt('077', 8)) + 0x30 >> 4;
    retval = wanexp >= 0 ? wanmant << wanexp & 0x7FFF : wanmant >> -wanexp;
    return (an ^ srn) < 0 ? -retval : retval;
  };
  /*
   * g72x_init_state()
   *
   * This routine initializes and/or resets the g72x_state structure
   * pointed to by 'statePtr'.
   * All the initial state values are specified in the CCITT G.721 document.
   */


  this.g726InitState = function () {
    // var a[2];//int  /* Coefficients of pole portion of prediction filter. */
    // var b[6];//int  /* Coefficients of zero portion of prediction filter. */
    // var pk[2];//int /* Signs of previous two samples of a partially reconstructed signal. */
    // var dq[6];//short /* int here fails in newupdate on encode!
    //         // Previous 6 samples of the quantized difference
    //         // signal represented in an internal floating point
    //         // format.
    // var sr[2];//int /* Previous 2 samples of the quantized difference
    var statePtr = {};
    var cnta = 0; //int

    statePtr.pp = new Array(2);
    statePtr.zp = new Array(6);
    statePtr.pk = new Array(2);
    statePtr.dq = new Array(6);
    statePtr.sr = new Array(2);
    statePtr.yl = 34816;
    statePtr.yu = 544;
    statePtr.dms = 0;
    statePtr.dml = 0;
    statePtr.ppp = 0;

    for (cnta = 0; cnta < 2; cnta++) {
      statePtr.pp[cnta] = 0;
      statePtr.pk[cnta] = 0;
      statePtr.sr[cnta] = 32;
    }

    for (cnta = 0; cnta < 6; cnta++) {
      statePtr.zp[cnta] = 0;
      statePtr.dq[cnta] = 32;
    }

    statePtr.td = 0; // g726_state = statePtr;

    return statePtr;
  };
  /*
   * predictorZero()
   *
   * computes the estimated signal from 6-zero predictor.
   *
   */


  this.predictorZero = function (statePtr) {
    var i = 0; //int

    var sezi = 0; //int

    sezi = fmult(statePtr.zp[0] >> 2, statePtr.dq[0]);

    for (i = 1; i < 6; i++) {
      /* ACCUM */
      sezi += fmult(statePtr.zp[i] >> 2, statePtr.dq[i]);
    }

    return sezi;
  };
  /*
   * predictorPole()
   *
   * computes the estimated signal from 2-pole predictor.
   *
   */


  this.predictorPole = function (statePtr) {
    return fmult(statePtr.pp[1] >> 2, statePtr.sr[1]) + fmult(statePtr.pp[0] >> 2, statePtr.sr[0]);
  };
  /*
   * stepSize()
   *
   * computes the quantization step size of the adaptive quantizer.
   *
   */


  this.stepSize = function (statePtr) {
    var y = 0; //int

    var dif = 0; //int

    var al = 0; //int

    if (statePtr.ppp >= 256) {
      return statePtr.yu;
    } else {
      y = statePtr.yl >> 6;
      dif = statePtr.yu - y;
      al = statePtr.ppp >> 2;

      if (dif > 0) {
        y += dif * al >> 6;
      } else if (dif < 0) {
        y += dif * al + 0x3F >> 6;
      }

      return y;
    }
  };
  /*
   * quantize()
   *
   * Given a raw sample, 'd', of the difference signal and a
   * quantization step size scale factor, 'y', this routine returns the
   * ADPCM codeword to which that sample gets quantized.  The step
   * size scale factor division operation is done in the log base 2 domain
   * as a subtraction.
   */


  this.quantize = function (rd,
  /* Raw difference signal sample */
  y,
  /* Step size multiplier */
  table,
  /* quantization table */
  //wjuncho
  size)
  /* table size of integers */
  {
    var dqm = 0; //int /* Magnitude of 'd' */

    var exp = 0; //int /* Integer part of base 2 log of 'd' */

    var mant = 0; //int  /* Fractional part of base 2 log */

    var dl = 0; //int  /* Log of magnitude of 'd' */

    var dln = 0; //int /* Step size scale factor normalized log */

    var i = 0; //int

    /*
     * LOG
     *
     * Compute base 2 log of 'd', and store in 'dl'.
     */

    dqm = Math.abs(rd);
    exp = quan(dqm >> 1, power2, 15);
    mant = dqm << 7 >> exp & 0x7F;
    /* Fractional portion. */

    dl = (exp << 7) + mant;
    /*
     * SUBTB
     *
     * "Divide" by step size multiplier.
     */

    dln = dl - (y >> 2);
    /*
     * QUAN
     *
     * Obtain codword i for 'd'.
     */

    i = quan(dln, table, size);

    if (rd < 0) {
      /* take 1's complement of i */
      return (size << 1) + 1 - i;
    } else if (i === 0) {
      /* take 1's complement of 0 */
      return (size << 1) + 1;
      /* new in 1988 */
    } else {
      return i;
    }
  };
  /*
   * reconstruct()
   *
   * Returns reconstructed difference signal 'dq' obtained from
   * codeword 'i' and quantization step size scale factor 'y'.
   * Multiplication is performed in log base 2 domain as addition.
   */


  this.reconstruct = function (sign,
  /* 0 for non-negative value */
  dqln,
  /* G.72x codeword */
  y)
  /* Step size multiplier */
  {
    var dql = 0; //int /* Log of 'dq' magnitude */

    var dex = 0; //int /* Integer part of log */

    var dqt = 0; //int

    var dq = 0; //int    /* Reconstructed difference signal sample */

    dql = dqln + (y >> 2);
    /* ADDA */

    if (dql < 0) {
      return sign ? -0x8000 : 0;
    } else {
      /* ANTILOG */
      dex = dql >> 7 & 15;
      dqt = 128 + (dql & 127);
      dq = dqt << 7 >> 14 - dex; //wjuncho convert it to (short) :: dq = (short)((dqt << 7) >> (14 - dex));

      return sign ? dq - 0x8000 : dq;
    }
  };
  /*
   * update()
   *
   * updates the state variables for each output code
   */


  this.update = function (codeSize, //int /* distinguish 723_40 with others */
  y, //int   /* quantizer step size */
  wi, //int    /* scale factor multiplier */
  fi, //int    /* for long/short term energies */
  dq, //int    /* quantized prediction difference */
  sr, //int    /* reconstructed signal */
  dqsez, //int   /* difference from 2-pole predictor */
  statePtr)
  /* coder state pointer */
  {
    var cnt = 0; //int

    var mag = 0,
        exp = 0; //int  /* Adaptive predictor, FLOAT A */

    var a2p = 0; //int   /* LIMC */

    var a1ul = 0; //int    /* UPA1 */

    var pks1 = 0; //int    /* UPA2 */

    var fa1 = 0; //int

    var tr = 0; //int      /* tone/transition detector */

    var ylint = 0,
        thr2 = 0,
        dqthr = 0; //int

    var ylfrac = 0,
        thr1 = 0; //int

    var pk0 = 0; //int

    pk0 = dqsez < 0 ? 1 : 0;
    /* needed in updating predictor poles */

    mag = dq & 0x7FFF;
    /* prediction difference magnitude */

    /* TRANS */

    ylint = statePtr.yl >> 15;
    /* exponent part of yl */

    ylfrac = statePtr.yl >> 10 & 0x1F;
    /* fractional part of yl */

    thr1 = 32 + ylfrac << ylint;
    /* threshold */

    thr2 = ylint > 9 ? 31 << 10 : thr1;
    /* limit thr2 to 31 << 10 */

    dqthr = thr2 + (thr2 >> 1) >> 1;
    /* dqthr = 0.75 * thr2 */

    if (statePtr.td === 0) {
      /* signal supposed voice */
      tr = 0;
    } else if (mag <= dqthr) {
      /* supposed data, but small mag */
      tr = 0;
      /* treated as voice */
    } else {
      /* signal is data (modem) */
      tr = 1;
    }
    /*
     * Quantizer scale factor adaptation.
     */

    /* FUNCTW & FILTD & DELAY */

    /* update non-steady state step size multiplier */


    statePtr.yu = y + (wi - y >> 5);
    /* LIMB */

    if (statePtr.yu < 544) {
      /* 544 <= yu <= 5120 */
      statePtr.yu = 544;
    } else if (statePtr.yu > 5120) {
      statePtr.yu = 5120;
    }
    /* FILTE & DELAY */

    /* update steady state step size multiplier */


    statePtr.yl += statePtr.yu + (-statePtr.yl >> 6);
    /*
     * Adaptive predictor coefficients.
     */

    if (tr === 1) {
      /* reset a's and b's for modem signal */
      statePtr.pp[0] = 0;
      statePtr.pp[1] = 0;
      statePtr.zp[0] = 0;
      statePtr.zp[1] = 0;
      statePtr.zp[2] = 0;
      statePtr.zp[3] = 0;
      statePtr.zp[4] = 0;
      statePtr.zp[5] = 0;
      a2p = 0;
    } else {
      /* update a's and b's */
      pks1 = pk0 ^ statePtr.pk[0];
      /* UPA2 */

      /* update predictor pole a[1] */

      a2p = statePtr.pp[1] - (statePtr.pp[1] >> 7);

      if (dqsez !== 0) {
        fa1 = pks1 ? statePtr.pp[0] : -statePtr.pp[0];

        if (fa1 < -8191) {
          /* a2p = function of fa1 */
          a2p -= 0x100;
        } else if (fa1 > 8191) {
          a2p += 0xFF;
        } else {
          a2p += fa1 >> 5;
        }

        if (pk0 ^ statePtr.pk[1]) {
          /* LIMC */
          if (a2p <= -12160) {
            a2p = -12288;
          } else if (a2p >= 12416) {
            a2p = 12288;
          } else {
            a2p -= 0x80;
          }
        } else if (a2p <= -12416) {
          a2p = -12288;
        } else if (a2p >= 12160) {
          a2p = 12288;
        } else {
          a2p += 0x80;
        }
      }
      /* TRIGB & DELAY */


      statePtr.pp[1] = a2p;
      /* UPA1 */

      /* update predictor pole a[0] */

      statePtr.pp[0] -= statePtr.pp[0] >> 8;

      if (dqsez !== 0) {
        if (pks1 === 0) {
          statePtr.pp[0] += 192;
        } else {
          statePtr.pp[0] -= 192;
        }
      }
      /* LIMD */


      a1ul = 15360 - a2p;

      if (statePtr.pp[0] < -a1ul) {
        statePtr.pp[0] = -a1ul;
      } else if (statePtr.pp[0] > a1ul) {
        statePtr.pp[0] = a1ul;
      }
      /* UPB : update predictor zeros b[6] */


      for (cnt = 0; cnt < 6; cnt++) {
        if (codeSize === 5) {
          /* for 40Kbps G.723 */
          statePtr.zp[cnt] -= statePtr.zp[cnt] >> 9;
        } else {
          /* for G.721 and 24Kbps G.723 */
          statePtr.zp[cnt] -= statePtr.zp[cnt] >> 8;
        }

        if (dq & 0x7FFF) {
          /* XOR */
          if ((dq ^ statePtr.dq[cnt]) >= 0) {
            statePtr.zp[cnt] += 128;
          } else {
            statePtr.zp[cnt] -= 128;
          }
        }
      }
    }

    for (cnt = 5; cnt > 0; cnt--) {
      statePtr.dq[cnt] = statePtr.dq[cnt - 1];
    }
    /* FLOAT A : convert dq[0] to 4-bit exp, 6-bit mantissa f.p. */


    if (mag === 0) {
      statePtr.dq[0] = dq >= 0 ? 0x20 : 0xFC20;
    } else {
      exp = quan(mag, power2, 15);
      statePtr.dq[0] = dq >= 0 ? //wjuncho  statePtr.dq[0] = (short)((dq >= 0) ?
      (exp << 6) + (mag << 6 >> exp) : (exp << 6) + (mag << 6 >> exp) - 0x400;
    }

    statePtr.sr[1] = statePtr.sr[0];
    /* FLOAT B : convert sr to 4-bit exp., 6-bit mantissa f.p. */

    if (sr === 0) {
      statePtr.sr[0] = 0x20;
    } else if (sr > 0) {
      exp = quan(sr, power2, 15);
      statePtr.sr[0] = (exp << 6) + (sr << 6 >> exp);
    } else if (sr > -32768) {
      mag = -sr;
      exp = quan(mag, power2, 15);
      statePtr.sr[0] = (exp << 6) + (mag << 6 >> exp) - 0x400;
    } else {
      statePtr.sr[0] = 0xFC20;
    }
    /* DELAY A */


    statePtr.pk[1] = statePtr.pk[0];
    statePtr.pk[0] = pk0;
    /* TONE */

    if (tr === 1) {
      /* this sample has been treated as data */
      statePtr.td = 0;
      /* next one will be treated as voice */
    } else if (a2p < -11776) {
      /* small sample-to-sample correlation */
      statePtr.td = 1;
      /* signal may be data */
    } else {
      /* signal is voice */
      statePtr.td = 0;
    }
    /*
     * Adaptation speed control.
     */


    statePtr.dms += fi - statePtr.dms >> 5;
    /* FILTA */

    statePtr.dml += (fi << 2) - statePtr.dml >> 7;
    /* FILTB */

    if (tr === 1) {
      statePtr.ppp = 256;
    } else if (y < 1536) {
      /* SUBTC */
      statePtr.ppp += 0x200 - statePtr.ppp >> 4;
    } else if (statePtr.td === 1) {
      statePtr.ppp += 0x200 - statePtr.ppp >> 4;
    } else if (Math.abs((statePtr.dms << 2) - statePtr.dml) >= statePtr.dml >> 3) {
      statePtr.ppp += 0x200 - statePtr.ppp >> 4;
    } else {
      statePtr.ppp += -statePtr.ppp >> 4;
    }

    return statePtr;
  };
  /*
   * tandem_adjust(sr, se, y, i, sign)
   *
   * At the end of ADPCM decoding, it simulates an encoder which may be receiving
   * the output of this decoder as a tandem process. If the output of the
   * simulated encoder differs from the input to this decoder, the decoder output
   * is adjusted by one level of A-law or u-law codes.
   *
   * Input:
   *  sr  decoder output linear PCM sample,
   *  se  predictor estimate sample,
   *  y quantizer step size,
   *  i decoder input code,
   *  sign  sign bit of code i
   *
   * Return:
   *  adjusted A-law or u-law compressed sample.
   */
  // var tandem_adjust_alaw = function(
  //   sr, /* decoder output linear PCM sample */ //int
  //   se, /* predictor estimate sample */ //int
  //   y,  /* quantizer step size */ //int
  //   i,  /* decoder input code */ //int
  //   sign,  //int
  //   qtab) //*int
  // {
  //   var sp; /* A-law compressed 8-bit code */
  //   var dx; /* prediction error */
  //   var id; /* quantized prediction error */
  //   var sd; /* adjusted A-law decoded sample value */
  //   var im; /* biased magnitude of i */
  //   var imx;  /* biased magnitude of id */
  //   if (sr <= -32768)
  //     sr = -1;
  //   sp = linear2alaw((sr >> 1) << 3); /* short to A-law compression */
  //   dx = (alaw2linear(sp) >> 2) - se; /* 16-bit prediction error */
  //   id = quantize(dx, y, qtab, sign - 1);
  //   if (id === i) {       no adjustment on sp
  //     return (sp);
  //   } else {      /* sp adjustment needed */
  //     /* ADPCM codes : 8, 9, ... F, 0, 1, ... , 6, 7 */
  //     im = i ^ sign;    /* 2's complement to biased unsigned */
  //     imx = id ^ sign;
  //     if (imx > im) {   /* sp adjusted to next lower value */
  //       if (sp & 0x80) {
  //         sd = (sp === 0xD5) ? 0x55 :
  //             ((sp ^ 0x55) - 1) ^ 0x55;
  //       } else {
  //         sd = (sp === 0x2A) ? 0x2A :
  //             ((sp ^ 0x55) + 1) ^ 0x55;
  //       }
  //     } else {    /* sp adjusted to next higher value */
  //       if (sp & 0x80)
  //         sd = (sp === 0xAA) ? 0xAA :
  //             ((sp ^ 0x55) + 1) ^ 0x55;
  //       else
  //         sd = (sp === 0x55) ? 0xD5 :
  //             ((sp ^ 0x55) - 1) ^ 0x55;
  //     }
  //     return (sd);
  //   }
  // };
  // var tandem_adjust_ulaw = function(
  //   sr, /* decoder output linear PCM sample */ // int
  //   se, /* predictor estimate sample */ // int
  //   y,  /* quantizer step size */ // int
  //   i,  /* decoder input code */ // int
  //   sign, // int
  //   qtab) // *int
  // {
  //   var sp; /* u-law compressed 8-bit code */
  //   var dx; /* prediction error */
  //   var id; /* quantized prediction error */
  //   var sd; /* adjusted u-law decoded sample value */
  //   var im; /* biased magnitude of i */
  //   var imx;  /* biased magnitude of id */
  //   if (sr <= -32768){
  //     sr = 0;
  //   }
  //   sp = linear2ulaw(sr << 2);  /* short to u-law compression */
  //   dx = (ulaw2linear(sp) >> 2) - se;  16-bit prediction error
  //   id = quantize(dx, y, qtab, sign - 1);
  //   if (id === i) {
  //     return (sp);
  //   } else {
  //     /* ADPCM codes : 8, 9, ... F, 0, 1, ... , 6, 7 */
  //     im = i ^ sign;    /* 2's complement to biased unsigned */
  //     imx = id ^ sign;
  //     if (imx > im) {   /* sp adjusted to next lower value */
  //       if (sp & 0x80)
  //         sd = (sp === 0xFF) ? 0x7E : sp + 1;
  //       else
  //         sd = (sp === 0) ? 0 : sp - 1;
  //     } else {    /* sp adjusted to next higher value */
  //       if (sp & 0x80)
  //         sd = (sp === 0x80) ? 0x80 : sp - 1;
  //       else
  //         sd = (sp === 0x7F) ? 0xFE : sp + 1;
  //     }
  //     return (sd);
  //   }
  // };
  // constructor.prototype = {
  //   quan: function(val, table, size) {
  //     return quan(val, table, size);
  //   },
  //   fmult: function(an, srn) {
  //     return fmult(an, srn);
  //   },
  //   g726InitState: function() {
  //     return g726InitState();
  //   },
  //   predictorZero: function(statePtr) {
  //     return predictorZero(statePtr);
  //   },
  //   predictorPole: function(statePtr) {
  //     return predictorPole(statePtr);
  //   },
  //   stepSize: function(statePtr) {
  //     return stepSize(statePtr);
  //   },
  //   quantize: function(d, y, table, size) {
  //     return quantize(d, y, table, size);
  //   },
  //   reconstruct: function(sign, dqln, y) {
  //     return reconstruct(sign, dqln, y);
  //   },
  //   update: function(codeSize, y, wi, fi, dq, sr, dqsez, statePtr) {
  //     return update(codeSize, y, wi, fi, dq, sr, dqsez, statePtr);
  //   },
  //   // tandem_adjust_alaw: function(sr, se, y, i, sign, qtab) {
  //   //   return tandem_adjust_alaw(sr, se, y, i, sign, qtab);
  //   // },
  //   // tandem_adjust_ulaw: function(sr, se, y, i, sign, qtab) {
  //   //   return tandem_adjust_ulaw(sr, se, y, i, sign, qtab);
  //   // }
  // };
  // return new constructor();

}

function stringToUint8Array(inputString) {
  var stringLength = inputString.length;
  var outputUint8Array = new Uint8Array(new ArrayBuffer(stringLength));

  for (var i = 0; i < stringLength; i++) {
    outputUint8Array[i] = inputString.charCodeAt(i);
  }

  return outputUint8Array;
}

function formAuthorizationResponse(username, password, url, realm, nonce, method) {
  var A1 = null;
  var A2 = null;
  var response = null;
  A1 = md5(username + ':' + realm + ':' + password).toLowerCase();
  A2 = md5(method + ':' + url).toLowerCase();
  response = md5(A1 + ':' + nonce + ':' + A2).toLowerCase();
  return response;
}

function VideoBufferList() {
  var MAX_LENGTH = 0,
      BUFFERING = 0,
      bufferFullCallback = null;

  function Constructor() {
    MAX_LENGTH = 360;
    BUFFERING = 240;
    bufferFullCallback = null;
    this._length = 0;
    this.head = null;
    this.tail = null;
    this.curIdx = 0;
  }

  Constructor.prototype = {
    push: function push(data, width, height, codecType, frameType, timeStamp) {
      var node = new VideoBufferNode(data, width, height, codecType, frameType, timeStamp);

      if (this._length > 0) {
        this.tail.next = node;
        node.previous = this.tail;
        this.tail = node;
      } else {
        this.head = node;
        this.tail = node;
      }

      this._length += 1;
      bufferFullCallback !== null && this._length >= BUFFERING ? bufferFullCallback() : 0; // PLAYBACK bufferFull
      //      debug.log("VideoBufferList after push node count is " + this._length + " frameType is " + frameType);

      return node;
    },
    pop: function pop() {
      //    debug.log("before pop node count is " + this._length + " MINBUFFER is " + MINBUFFER);
      var node = null;

      if (this._length > 1) {
        node = this.head;
        this.head = this.head.next;

        if (this.head !== null) {
          this.head.previous = null; // 2nd use-case: there is no second node
        } else {
          this.tail = null;
        }

        this._length -= 1;
      }

      return node;
    },
    setMaxLength: function setMaxLength(length) {
      MAX_LENGTH = length;

      if (MAX_LENGTH > 360) {
        MAX_LENGTH = 360;
      } else if (MAX_LENGTH < 30) {
        MAX_LENGTH = 30;
      }
    },
    setBUFFERING: function setBUFFERING(interval) {
      BUFFERING = interval;

      if (BUFFERING > 240) {
        BUFFERING = 240;
      } else if (BUFFERING < 6) {
        BUFFERING = 6;
      }
    },
    setBufferFullCallback: function setBufferFullCallback(callback) {
      bufferFullCallback = callback; // debug.log("setBufferFullCallback MAX_LENGTH is " + MAX_LENGTH );
    },
    searchTimestamp: function searchTimestamp(frameTimestamp) {
      //      debug.log("searchTimestamp frameTimestamp = " + frameTimestamp.timestamp + " frameTimestamp usec = " + frameTimestamp.timestamp_usec);
      var currentNode = this.head,
          length = this._length,
          count = 1,
          message = {
        failure: 'Failure: non-existent node in this list.'
      }; // 1st use-case: an invalid position

      if (length === 0 || frameTimestamp <= 0 || currentNode === null) {
        throw new Error(message.failure);
      } // 2nd use-case: a valid position


      while (currentNode !== null && (currentNode.timeStamp.timestamp !== frameTimestamp.timestamp || currentNode.timeStamp.timestamp_usec !== frameTimestamp.timestamp_usec)) {
        //        debug.log("currentNode Timestamp = " + currentNode.timeStamp.timestamp + " Timestamp usec = " + currentNode.timeStamp.timestamp_usec);
        currentNode = currentNode.next;
        count++;
      }

      if (length < count) {
        currentNode = null;
      } else {
        this.curIdx = count; // debug.log("searchTimestamp curIdx = " + this.curIdx + " currentNode.timeStamp.timestamp = " + currentNode.timeStamp.timestamp + " currentNode.timestamp_usec = " + currentNode.timeStamp.timestamp_usec + " frameTimestamp = " + frameTimestamp.timestamp + " frameTimestamp usec = " + frameTimestamp.timestamp_usec);
      }

      return currentNode;
    },
    findIFrame: function findIFrame(isForward) {
      var currentNode = this.head,
          length = this._length,
          count = 1,
          message = {
        failure: 'Failure: non-existent node in this list.'
      }; // 1st use-case: an invalid position

      if (length === 0) {
        throw new Error(message.failure);
      } // 2nd use-case: a valid position


      while (count < this.curIdx) {
        currentNode = currentNode.next;
        count++;
      }

      if (isForward === true) {
        while (currentNode.frameType !== 'I') {
          currentNode = currentNode.next;
          count++;
        }
      } else {
        while (currentNode.frameType !== 'I') {
          currentNode = currentNode.previous;
          count--;
        }
      }

      if (length < count) {
        currentNode = null;
      } else {
        this.curIdx = count; // debug.log('findIFrame curIdx ' + this.curIdx + ' count ' + count + ' _length ' + this._length);
      }

      return currentNode;
    }
  };
  return new Constructor();
}

var Queue = /*#__PURE__*/function () {
  function Queue() {
    _classCallCheck(this, Queue);

    this.first = null;
    this.size = 0;
  }

  _createClass(Queue, [{
    key: "enqueue",
    value: function enqueue(node) {
      if (this.first === null) {
        this.first = node;
      } else {
        var tempNode = this.first;

        while (tempNode.next !== null) {
          tempNode = tempNode.next;
        }

        tempNode.next = node;
      }

      this.size += 1;
    }
  }, {
    key: "dequeue",
    value: function dequeue() {
      var temp = null;

      if (this.first !== null) {
        temp = this.first;
        this.first = this.first.next;
        this.size -= 1;
      }

      return temp;
    }
  }, {
    key: "clear",
    value: function clear() {
      this.size = 0;
      this.first = null;
    }
  }]);

  return Queue;
}();


// CONCATENATED MODULE: ./src/Decode/audioDecoderG711.js
/* exported G711AudioDecoder */

/* global inheritObject, AudioDecoder, Uint8Array, Int16Array, Float32Array*/
function G711AudioDecoder(type) {
  var BIAS = 0x84,
      SIGN_BIT = 0x80,

  /* Sign bit for a A-law byte. */
  QUANT_MASK = 0xf,

  /* Quantization field mask. */
  //NSEGS = 8,

  /* Number of A-law segments. */
  SEG_SHIFT = 4,

  /* Left shift for segment number. */
  SEG_MASK = 0x70;
  /* Segment field mask. */

  /* var codecInfo = {
   type: "G.711",
   samplingRate : 8000,
   bitrate : '64000'
   }; */

  function uLaw2Linear(uVal) {
    var temp = 0;
    /* Complement to obtain normal u-law value. */

    var uValc = ~uVal;
    /*
     * Extract and bias the quantization bits. Then
     * shift up by the segment number and subtract out the bias.
     */

    temp = ((uValc & QUANT_MASK) << 3) + BIAS;
    temp <<= (uValc & SEG_MASK) >> SEG_SHIFT;
    return uValc & SIGN_BIT ? BIAS - temp : temp - BIAS;
  }

  function aLaw2Linear(a_val) {
    var temp = 0;
    var seg = 0;
    a_val ^= 0x55;
    temp = (a_val & QUANT_MASK) << 4;
    seg = (a_val & SEG_MASK) >> SEG_SHIFT;

    switch (seg) {
      case 0:
        temp += 8;
        break;

      case 1:
        temp += 0x108;
        break;

      default:
        temp += 0x108;
        temp <<= seg - 1;
    }

    return a_val & SIGN_BIT ? temp : -temp;
  }

  function Constructor() {}

  Constructor.prototype = {
    decode: function decode(buffer) {
      var rawData = new Uint8Array(buffer);
      var pcmData = new Int16Array(rawData.length);
      var idx = 0;

      if (type == 'G.711A') {
        for (idx = 0; idx < rawData.length; idx++) {
          pcmData[idx] = aLaw2Linear(rawData[idx]);
        }
      } else if (type == 'G.711Mu') {
        for (idx = 0; idx < rawData.length; idx++) {
          pcmData[idx] = uLaw2Linear(rawData[idx]);
        }
      }

      var jsData = new Float32Array(pcmData.length);

      for (idx = 0; idx < pcmData.length; idx++) {
        /* var a1 = pcmData[i]/Math.pow(2,15);
         var a2 = Math.round(a1*100000) / 100000;
         jsData[i] = a2; */
        jsData[idx] = pcmData[idx] / Math.pow(2, 15);
      }

      return jsData;
    }
  };
  return new Constructor();
}

/* harmony default export */ var audioDecoderG711 = (G711AudioDecoder);
// CONCATENATED MODULE: ./src/Decode/audioDecoderG726x.js
/* exported G726xAudioDecoder */

/* global G726_16_AudioDecoder, G726_24_AudioDecoder, G726_32_AudioDecoder, G726_40_AudioDecoder */


function G726xAudioDecoder(bits) {
  var decoder = null;
  var BIT16 = 16,
      BIT24 = 24,
      BIT32 = 32,
      BIT40 = 40;

  switch (bits) {
    case BIT16:
      decoder = new G726_16_AudioDecoder();
      break;

    case BIT24:
      decoder = new G726_24_AudioDecoder();
      break;

    case BIT32:
      decoder = new G726_32_AudioDecoder();
      break;

    case BIT40:
      decoder = new G726_40_AudioDecoder();
      break;

    default:
      debug.log("wrong bits");
      break;
  }

  return decoder;
}

function G726_16_AudioDecoder() {
  //var AUDIO_ENCODING_ULAW = 1; /* ISDN u-law */
  //var AUDIO_ENCODING_ALAW = 2; /* ISDN A-law */
  var AUDIO_ENCODING_LINEAR = 3;
  /* PCM 2's-complement (0-center) */

  var BITWISE_HEX_0000FF00 = 0x0000ff00;
  /*
   * Maps G.723_16 code word to reconstructed scale factor normalized log
   * magnitude values.  Comes from Table 11/G.726
   */

  var _dqlntab = [116, 365, 365, 116]; //short

  /* Maps G.723_16 code word to log of scale factor multiplier.
   *
   * _witab[4] is actually {-22 , 439, 439, -22}, but FILTD wants it
   * as WI << 5  (multiplied by 32), so we'll do that here
   */

  var _witab = [-704, 14048, 14048, -704]; //short

  /*
   * Maps G.723_16 code words to a set of values whose long and short
   * term averages are computed and then compared to give an indication
   * how stationary (steady state) the signal is.
   */

  /* Comes from FUNCTF */

  var _fitab = [0, 0xE00, 0xE00, 0]; // short

  /* Comes from quantizer decision level tables (Table 7/G.726)
   */
  // var qtab_723_16 = [1]; // int

  var g726State = {};
  var commonAudioUtil = null; //i(int), out_coding(int)

  function g726Decode16Bit(_idx, _outCoding) {
    var sezi = 0; //int

    var sez = 0; //int     /* ACCUM */

    var sei = 0; //int

    var se = 0; //int

    var y = 0; //int       /* MIX */

    var dq = 0; //int

    var sr = 0; //int        /* ADDB */

    var dqsez = 0; //int

    var idx = _idx;
    var outCoding = _outCoding;
    idx = idx &= 0x03;
    /* mask to get proper bits */

    sezi = commonAudioUtil.predictorZero(g726State);
    sez = sezi >> 1;
    sei = sezi + commonAudioUtil.predictorPole(g726State);
    se = sei >> 1;
    /* se = estimated signal */

    y = commonAudioUtil.stepSize(g726State);
    /* dynamic quantizer step size */

    dq = commonAudioUtil.reconstruct(idx & 0x02, _dqlntab[idx], y);
    /* quantized diff. */

    sr = dq < 0 ? se - (dq & 0x3FFF) : se + dq;
    /* reconst. signal */

    dqsez = sr - se + sez;
    /* pole prediction diff. */

    g726State = commonAudioUtil.update(2, y, _witab[idx], _fitab[idx], dq, sr, dqsez, g726State);

    switch (outCoding) {
      // case AUDIO_ENCODING_ALAW:
      //   return (commonAudioUtil.tandem_adjust_alaw(sr, se, y, i, 2, qtab_723_16));
      // case AUDIO_ENCODING_ULAW:
      //   return (commonAudioUtil.tandem_adjust_ulaw(sr, se, y, i, 2, qtab_723_16));
      case AUDIO_ENCODING_LINEAR:
        return sr << 2;

      /* sr was of 14-bit dynamic range */

      default:
        return -1;
    }
  }

  function Constructor() {
    commonAudioUtil = new CommonAudioUtil();
    g726State = commonAudioUtil.g726InitState();
  }

  Constructor.prototype = {
    decode: function decode(buffer) {
      var decodedBuffer = new Int16Array(buffer.length * 4);

      for (var i = 0, n = 0; i < buffer.length; i++) {
        var res = null;
        var data = null;
        data = buffer[i] >> 6;
        res = g726Decode16Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i] >> 4;
        res = g726Decode16Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i] >> 2;
        res = g726Decode16Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i];
        res = g726Decode16Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
      }

      return decodedBuffer;
    }
  };
  return new Constructor();
}

function G726_24_AudioDecoder() {
  // var AUDIO_ENCODING_ULAW = 1; /* ISDN u-law */
  // var AUDIO_ENCODING_ALAW = 2; /* ISDN A-law */
  var AUDIO_ENCODING_LINEAR = 3;
  /* PCM 2's-complement (0-center) */

  var BITWISE_HEX_0000FF00 = 0x0000ff00;
  /*
   * Maps G.723_24 code word to reconstructed scale factor normalized log
   * magnitude values.
   */

  var _dqlntab = [-2048, 135, 273, 373, 373, 273, 135, -2048]; //short[]

  /* Maps G.723_24 code word to log of scale factor multiplier. */

  var _witab = [-128, 960, 4384, 18624, 18624, 4384, 960, -128]; // short[]

  /*
   * Maps G.723_24 code words to a set of values whose long and short
   * term averages are computed and then compared to give an indication
   * how stationary (steady state) the signal is.
   */

  var _fitab = [0, 0x200, 0x400, 0xE00, 0xE00, 0x400, 0x200, 0]; //short[]
  // var qtab_723_24 = [8, 218, 331]; //int[]

  var g726State = {};
  var commonAudioUtil = null;
  /*
   * g723_24_decoder()
   *
   * Decodes a 3-bit CCITT G.723_24 ADPCM code and returns
   * the resulting 16-bit linear PCM, A-law or u-law sample value.
   * -1 is returned if the output coding is unknown.
   * i            int
   * out_coding   int
   */

  function g726Decode24Bit(_idx, _outCoding) {
    var sezi = 0;
    var sez = 0;
    /* ACCUM */

    var sei = 0;
    var se = 0;
    var y = 0;
    /* MIX */

    var dq = 0;
    var sr = 0;
    /* ADDB */

    var dqsez = 0;
    var idx = _idx;
    var outCoding = _outCoding;
    idx &= 0x07;
    /* mask to get proper bits */

    sezi = commonAudioUtil.predictorZero(g726State);
    sez = sezi >> 1;
    sei = sezi + commonAudioUtil.predictorPole(g726State);
    se = sei >> 1;
    /* se = estimated signal */

    y = commonAudioUtil.stepSize(g726State);
    /* adaptive quantizer step size */

    dq = commonAudioUtil.reconstruct(idx & 0x04, _dqlntab[idx], y);
    /* unquantize pred diff */

    sr = dq < 0 ? se - (dq & 0x3FFF) : se + dq;
    /* reconst. signal */

    dqsez = sr - se + sez;
    /* pole prediction diff. */

    g726State = commonAudioUtil.update(3, y, _witab[idx], _fitab[idx], dq, sr, dqsez, g726State);

    switch (outCoding) {
      // case AUDIO_ENCODING_ALAW:
      //   return (commonAudioUtil.tandem_adjust_alaw(sr, se, y, i, 4, qtab_723_24));
      // case AUDIO_ENCODING_ULAW:
      //   return (commonAudioUtil.tandem_adjust_ulaw(sr, se, y, i, 4, qtab_723_24));
      case AUDIO_ENCODING_LINEAR:
        return sr << 2;

      /* sr was of 14-bit dynamic range */

      default:
        return -1;
    }
  }

  function Constructor() {
    commonAudioUtil = new CommonAudioUtil();
    g726State = commonAudioUtil.g726InitState();
  }

  Constructor.prototype = {
    decode: function decode(buffer) {
      var decodedBuffer = new Int16Array(buffer.length * 8 / 3);

      for (var i = 0, n = 0; i < buffer.length - 3; i += 3) {
        var res = null;
        var data = null;
        data = buffer[i] >> 5;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i] >> 2;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i] << 1 | buffer[i + 1] >> 7;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 1] >> 4;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 1] >> 1;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 1] << 2 | buffer[i + 2] >> 6;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 2] >> 3;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 2] >> 0;
        res = g726Decode24Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
      }

      return decodedBuffer;
    }
  };
  return new Constructor();
}

function G726_32_AudioDecoder() {
  // var AUDIO_ENCODING_ULAW = 1; /* ISDN u-law */
  // var AUDIO_ENCODING_ALAW = 2; /* ISDN A-law */
  var AUDIO_ENCODING_LINEAR = 3;
  /* PCM 2's-complement (0-center) */

  var BITWISE_HEX_0000FF00 = 0x0000ff00; // var qtab_723_32 = [-124, 80, 178, 246, 300, 349, 400]; //int[]

  /*
   * Maps G.721 code word to reconstructed scale factor normalized log
   * magnitude values.
   */

  var _dqlntab = [-2048, 4, 135, 213, 273, 323, 373, 425, 425, 373, 323, 273, 213, 135, 4, -2048]; //short[]

  /* Maps G.721 code word to log of scale factor multiplier. */

  var _witab = [-12, 18, 41, 64, 112, 198, 355, 1122, 1122, 355, 198, 112, 64, 41, 18, -12]; //short[]

  /*
   * Maps G.721 code words to a set of values whose long and short
   * term averages are computed and then compared to give an indication
   * how stationary (steady state) the signal is.
   */

  var _fitab = [0, 0, 0, 0x200, 0x200, 0x200, 0x600, 0xE00, 0xE00, 0x600, 0x200, 0x200, 0x200, 0, 0, 0];
  var g726State = {};
  var commonAudioUtil = null; //i(int), out_coding(int)

  function g726Decode32Bit(_idx, _outCoding) {
    var sezi = 0; //int

    var sez = 0; //int     /* ACCUM */

    var sei = 0; //int

    var se = 0; //int

    var y = 0; //int       /* MIX */

    var dq = 0; //int

    var sr = 0; //int        /* ADDB */

    var dqsez = 0; //int

    var lino = 0; //long

    var idx = _idx;
    var outCoding = _outCoding;
    idx &= 0x0f;
    /* mask to get proper bits */

    sezi = commonAudioUtil.predictorZero(g726State);
    sez = sezi >> 1;
    sei = sezi + commonAudioUtil.predictorPole(g726State);
    se = sei >> 1;
    /* se = estimated signal */

    y = commonAudioUtil.stepSize(g726State);
    /* dynamic quantizer step size */

    dq = commonAudioUtil.reconstruct(idx & 0x08, _dqlntab[idx], y);
    /* quantized diff. */

    sr = dq < 0 ? se - (dq & 0x3FFF) : se + dq;
    /* reconst. signal */

    dqsez = sr - se + sez;
    /* pole prediction diff. */

    g726State = commonAudioUtil.update(4, y, _witab[idx] << 5, _fitab[idx], dq, sr, dqsez, g726State);

    switch (outCoding) {
      // case AUDIO_ENCODING_ALAW:
      //   return (commonAudioUtil.tandem_adjust_alaw(sr, se, y, i, 8, qtab_723_32));
      // case AUDIO_ENCODING_ULAW:
      //   return (commonAudioUtil.tandem_adjust_ulaw(sr, se, y, i, 8, qtab_723_32));
      case AUDIO_ENCODING_LINEAR:
        lino = sr << 2;
        /* this seems to overflow a short*/

        lino = lino > 32767 ? 32767 : lino;
        lino = lino < -32768 ? -32768 : lino;
        return lino;
      //(sr << 2);  /* sr was 14-bit dynamic range */

      default:
        return -1;
    }
  }

  function Constructor() {
    commonAudioUtil = new CommonAudioUtil();
    g726State = commonAudioUtil.g726InitState();
  }

  Constructor.prototype = {
    decode: function decode(buffer) {
      var decodedBuffer = new Int16Array(buffer.length * 2);

      for (var idx = 0, n = 0; idx < buffer.length; idx++) {
        var res = null;
        var sec = (0xf0 & buffer[idx]) >> 4;
        res = g726Decode32Bit(sec, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00; // if >> 8, it seems to be little endian.

        n++;
        var first = 0x0f & buffer[idx];
        res = g726Decode32Bit(first, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
      }

      return decodedBuffer;
    }
  };
  return new Constructor();
}

function G726_40_AudioDecoder() {
  // var AUDIO_ENCODING_ULAW = 1; /* ISDN u-law */
  // var AUDIO_ENCODING_ALAW = 2; /* ISDN A-law */
  var AUDIO_ENCODING_LINEAR = 3;
  /* PCM 2's-complement (0-center) */

  var BITWISE_HEX_0000FF00 = 0x0000ff00;
  /*
   * Maps G.723_40 code word to ructeconstructed scale factor normalized log
   * magnitude values.
   */

  var _dqlntab = [-2048, -66, 28, 104, 169, 224, 274, 318, 358, 395, 429, 459, 488, 514, 539, 566, 566, 539, 514, 488, 459, 429, 395, 358, 318, 274, 224, 169, 104, 28, -66, -2048]; //short[]

  /* Maps G.723_40 code word to log of scale factor multiplier. */

  var _witab = [448, 448, 768, 1248, 1280, 1312, 1856, 3200, 4512, 5728, 7008, 8960, 11456, 14080, 16928, 22272, 22272, 16928, 14080, 11456, 8960, 7008, 5728, 4512, 3200, 1856, 1312, 1280, 1248, 768, 448, 448]; //short[]

  /*
   * Maps G.723_40 code words to a set of values whose long and short
   * term averages are computed and then compared to give an indication
   * how stationary (steady state) the signal is.
   */

  var _fitab = [0, 0, 0, 0, 0, 0x200, 0x200, 0x200, 0x200, 0x200, 0x400, 0x600, 0x800, 0xA00, 0xC00, 0xC00, 0xC00, 0xC00, 0xA00, 0x800, 0x600, 0x400, 0x200, 0x200, 0x200, 0x200, 0x200, 0, 0, 0, 0, 0]; //short[]
  // var qtab_723_40 = [-122, -16, 68, 139, 198, 250, 298, 339,
  //   378, 413, 445, 475, 502, 528, 553
  // ]; //int[]

  var g726State = {};
  var commonAudioUtil = null;
  /*
   * g723_40_decoder()
   *
   * Decodes a 5-bit CCITT G.723 40Kbps code and returns
   * the resulting 16-bit linear PCM, A-law or u-law sample value.
   * -1 is returned if the output coding is unknown.
   * i            int
   * out_coding   int
   */

  function g726Decode40Bit(_idx, _outCoding) {
    var sezi = 0,
        sei = 0,
        sez = 0,
        se = 0;
    /* ACCUM */

    var y = 0;
    /* MIX */

    var sr = 0;
    /* ADDB */

    var dq = 0;
    var dqsez = 0;
    var idx = _idx;
    var outCoding = _outCoding;
    idx &= 0x1f;
    /* mask to get proper bits */

    sezi = commonAudioUtil.predictorZero(g726State);
    sez = sezi >> 1;
    sei = sezi + commonAudioUtil.predictorPole(g726State);
    se = sei >> 1;
    /* se = estimated signal */

    y = commonAudioUtil.stepSize(g726State);
    /* adaptive quantizer step size */

    dq = commonAudioUtil.reconstruct(idx & 0x10, _dqlntab[idx], y);
    /* estimation diff. */

    sr = dq < 0 ? se - (dq & 0x7FFF) : se + dq;
    /* reconst. signal */

    dqsez = sr - se + sez;
    /* pole prediction diff. */

    g726State = commonAudioUtil.update(5, y, _witab[idx], _fitab[idx], dq, sr, dqsez, g726State);

    switch (outCoding) {
      case AUDIO_ENCODING_LINEAR:
        return sr << 2;

      /* sr was of 14-bit dynamic range */

      default:
        return -1;
    }
  }

  function Constructor() {
    commonAudioUtil = new CommonAudioUtil();
    g726State = commonAudioUtil.g726InitState();
  }

  Constructor.prototype = {
    decode: function decode(buffer) {
      var decodedBuffer = new Int16Array(buffer.length * 1.6);

      for (var i = 0, n = 0; i < buffer.length - 5; i += 5) {
        var res = null;
        var data = null;
        data = buffer[i] >> 3;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i] << 2 | buffer[i + 1] >> 6;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 1] >> 1;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 1] << 4 | buffer[i + 2] >> 4;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 2] << 1 | buffer[i + 3] >> 7;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 3] >> 2;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 3] << 3 | buffer[i + 4] >> 5;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
        data = buffer[i + 4] >> 0;
        res = g726Decode40Bit(data, AUDIO_ENCODING_LINEAR); // decodedBuffer[n] = (res & 0x000000ff);
        // n++;

        decodedBuffer[n] = res & BITWISE_HEX_0000FF00;
        n++;
      }

      return decodedBuffer;
    }
  };
  return new Constructor();
}

/* harmony default export */ var audioDecoderG726x = (G726xAudioDecoder);
// CONCATENATED MODULE: ./src/Decode/audioDecoder.js
/*
 封装FFMPEG接口
 */


var AUDIOMAP = {
  //ffmepg解码器ID对应
  'mpeg4-generic': 86018,
  'G.723': 86068,
  'G.729': 86069,
  'mpeg2': 86016,
  'G.722.1': 69660
};

function convertBlock(incomingData) {
  // incoming data is a UInt8Array
  incomingData = new Int16Array(incomingData.buffer);
  var jsData = new Float32Array(incomingData.length);

  for (var i = 0; i < incomingData.length; i++) {
    jsData[i] = incomingData[i] / Math.pow(2, 15);
  }

  return jsData;
}

function AudioDecoder() {
  var initDecoder = null;
  var outpicptr = null;
  var outpic = null;
  var DecodeNo = 0;
  var DecodePcm = [];
  var AudioType = '';
  var decoder = null; //独立解码器

  var AUDIOBYTE = 100 * 1024; //初始化音频数据大小

  var GBYTE = 10 * 1024; //G系列初始化音频数据大小

  function Constructor() {}

  Constructor.prototype = {
    open: function open(audioType, bit) {
      //打开音频解码对象
      AudioType = audioType;
      DecodeNo = 0;
      DecodePcm = [];

      if (AUDIOMAP[AudioType]) {
        //ffmpeg解码
        initDecoder = Module._OpenAudioDecoder(AUDIOMAP[audioType]); //g723.1   
      } else {
        switch (AudioType) {
          case 'G.711A':
          case 'G.711Mu':
            decoder = new audioDecoderG711(AudioType);
            break;

          case 'G.726-16':
          case 'G.726-24':
          case 'G.726-32':
          case 'G.726-40':
            decoder = new audioDecoderG726x(bit);
            break;
        }
      }
    },
    close: function close() {
      // 关闭aac解码对象
      if (AUDIOMAP[AudioType]) {
        Module._CloseAudioDecoder(initDecoder);

        Module._free(outpicptr);

        outpicptr = null;
      }
    },
    decodeByFFMPEG: function decodeByFFMPEG(buffer) {
      var outpic = new Uint8Array(Module.HEAPU8.buffer, outpicptr, AUDIOBYTE);
      var resultBuf = new Uint8Array(AUDIOBYTE);
      var bufferLen = 0;

      if (AudioType === 'G.729' || AudioType === 'G.723') {
        //分段送到ffmepg。
        var MAXLEN = AudioType === 'G.729' ? 10 : 20; //每次10字节。G723 20字节1段待考证！

        var Framelen = Math.floor(buffer.length / MAXLEN);

        for (var i = 0; i < Framelen; i++) {
          outpic.set(new Uint8Array(buffer.subarray(i * MAXLEN, (i + 1) * MAXLEN)));

          var len = Module._DecodeAudioFrame(initDecoder, outpic.byteOffset, MAXLEN, outpic.byteLength);

          resultBuf.set(new Uint8Array(outpic.subarray(0, len)), bufferLen);
          bufferLen += len;
        }

        resultBuf = convertBlock(new Uint8Array(resultBuf.subarray(0, bufferLen))); //console.log(resultBuf)
      } else {
        outpic.set(new Uint8Array(buffer));
        bufferLen = Module._DecodeAudioFrame(initDecoder, outpic.byteOffset, buffer.byteLength, outpic.byteLength); //console.log('decoded bufferLen',bufferLen)

        resultBuf = new Uint8Array(outpic.subarray(0, bufferLen)); // DecodeNo++;
        // if(DecodeNo === 500){
        //     console.log(DecodePcm.length)
        //     console.log(DecodePcm.join(' '))
        // }else if(DecodeNo < 500){
        //     for(var i=0;i<resultBuf.length;i++){
        //         DecodePcm.push(resultBuf[i].toString(16))
        //     }
        // }

        if (AudioType !== 'mpeg4-generic') {
          resultBuf = convertBlock(resultBuf);
        } else {
          //AAC 32精度  其他16精度
          resultBuf = new Float32Array(resultBuf.buffer);
        }
      }

      return resultBuf;
    },
    decodeBySelf: function decodeBySelf(buffer) {
      //独立解码器
      var resultBuf;

      if (AudioType === 'PCM') {
        resultBuf = new Uint8Array(buffer);
      } else {
        resultBuf = decoder.decode(buffer);
      }

      if (AudioType !== 'G.711A' && AudioType !== 'G.711Mu') {
        //G726需要转化精度
        resultBuf = convertBlock(resultBuf);
      }

      return resultBuf;
    },
    decode: function decode(buffer) {
      //音频解码
      var outpic = null;

      if (AUDIOMAP[AudioType]) {
        //ffmpeg解码器
        if (outpicptr === null) {
          outpicptr = Module._malloc(AUDIOBYTE);
        }

        outpic = this.decodeByFFMPEG(buffer);
      } else {
        outpic = this.decodeBySelf(buffer);
      }

      return outpic;
    }
  };
  return new Constructor();
}

/* harmony default export */ var Decode_audioDecoder = (AudioDecoder);
// CONCATENATED MODULE: ./src/AudioSession.js
/* exported AACSession */

/* global ArrayBuffer, Uint8Array, inheritObject, RtpSession*/



var AudioSession_AudioSession = function AudioSession(audioType, bit) {
  var ADTS_HEADER_SIZE = 7;
  var config = null;
  var clockFreq = null;
  var bitrate = null;
  var rtpTimeStamp = null;
  var preRtpTimeStamp = 0;
  var ADTs = new Uint8Array(ADTS_HEADER_SIZE);
  var fsynctime = {
    seconds: null,
    useconds: null
  };
  var audioDecoder = new Decode_audioDecoder();
  audioDecoder.open(audioType, bit);

  function genADTSAAC(frameSize, payload) {
    var mChannels = 1;
    var firstTwoConfig = null;
    var lastTwoConfig = null;

    if (typeof config === 'string') {
      firstTwoConfig = parseInt(config.substring(0, 2), 16);
      lastTwoConfig = parseInt(config.substring(2, 4), 16);
    } else {
      public_debug.log("wrong type of config in SDP");
      return;
    }

    var mAOT = firstTwoConfig >> 3;
    var freqIndex = (firstTwoConfig & 0x07) << 1 | (lastTwoConfig & 0x80) >> 7;
    ADTs[0] = 0xFF;
    ADTs[1] = 0xF9;
    ADTs[2] = mAOT - 1 << 6;
    ADTs[2] |= freqIndex << 2;
    ADTs[2] |= mChannels >> 2;
    ADTs[3] = mChannels << 6;
    ADTs[3] |= (frameSize + 7 & 0x1800) >> 11;
    ADTs[4] = (frameSize + 7 & 0x07F8) >> 3;
    ADTs[5] = (frameSize + 7 & 0x07) << 5;
    ADTs[5] |= 0x01;
    ADTs[6] = 0x54;
    var ADTsAAC = new Uint8Array(ADTs.length + payload.length);
    ADTsAAC.set(ADTs, 0);
    ADTsAAC.set(payload, ADTs.length);
    return ADTsAAC;
  }

  function Constructor() {
    this.firstTime = 0;
    this.lastMSW = 0;
  }

  Constructor.prototype = {
    parseRTPData: function parseRTPData(rtspInterleaved, dhPayload, isBackup, info) {
      //var headerLen = 4;
      //var extensionHeaderLen = 0;
      // var channelId = rtspInterleaved[1];
      var extenLen = dhPayload[22]; //if (((rtpHeader[0] & 0x10) === 0x10)) {
      //    extensionHeaderLen = ((rtpPayload[2] << 8 | rtpPayload[3]) * 4) + 4;
      //}
      //rtpTimeStamp = new Uint8Array(new ArrayBuffer(4));
      //rtpTimeStamp.set(rtpHeader.subarray(4, 8), 0);
      //rtpTimeStamp = this.ntohl(rtpTimeStamp);

      rtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
      var frameSize = dhPayload.length - 8 - (24 + extenLen);
      var rawPayload = dhPayload.subarray(24 + extenLen, dhPayload.length - 8);
      var temp1 = rawPayload.subarray(0, 2);
      var data = {};
      var time = (dhPayload[19] << 24) + (dhPayload[18] << 16) + (dhPayload[17] << 8) + dhPayload[16] >>> 0;
      var lsw = Date.UTC('20' + (time >> 26), (time >> 22 & 0x0f) - 1, time >> 17 & 0x1f, time >> 12 & 0x1f, time >> 6 & 0x3f, time & 0x3f) / 1000;
      lsw = lsw - 8 * 3600;

      if (this.firstTime == 0) {
        //第一次
        this.firstTime = lsw; //系统时间精确到秒

        this.lastMSW = 0;
        preRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        fsynctime.seconds = lsw;
        fsynctime.useconds = 0;
      } else {
        var currentRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        var duration;

        if (currentRtpTimeStamp > preRtpTimeStamp) {
          duration = currentRtpTimeStamp - preRtpTimeStamp;
        } else {
          duration = currentRtpTimeStamp + 65535 - preRtpTimeStamp;
        }

        this.lastMSW += duration;

        if (lsw > this.firstTime) {
          //说明进秒了 
          this.lastMSW -= 1000;
        }

        this.firstTime = lsw;
        fsynctime.seconds = lsw;
        fsynctime.useconds = this.lastMSW;
        preRtpTimeStamp = currentRtpTimeStamp;
      }

      var tBuffer = audioDecoder.decode(rawPayload);
      var data = {
        codec: 'AAC',
        audio_type: info.audio_type,
        bufferData: tBuffer,
        rtpTimeStamp: fsynctime.seconds * 1000 + fsynctime.useconds,
        samplingRate: clockFreq
      }; //this.rtpPayloadCbFunc(ADTsAAC);

      return data;
    },
    setCodecInfo: function setCodecInfo(info) {
      public_debug.log("Set codec info. for AAC");
      config = info.config;
      bitrate = info.bitrate;
      clockFreq = info.ClockFreq;
    },
    getCodecInfo: function getCodecInfo() {
      return {
        'bitrate': bitrate,
        'clockFreq': clockFreq
      };
    }
  };
  return new Constructor();
};

/* harmony default export */ var src_AudioSession = (AudioSession_AudioSession);
// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--5!./src/audioWorker.worker.js
/* global G711Session, G726Session, AACSession, cloneArray */


importScripts('./../module/ffmpegasm.js');

Module.onRuntimeInitialized = function () {
  Module._RegisterAll();

  sendMessage('WorkerReady');
};

addEventListener('message', receiveMessage, false);
sendMessage('WorkerReady', {}); // 通知workManager，音频worker已经加载完毕

var audioRtpSessionsArray = [];
var audioWorker_worker_sdpInfo = null;
var rtpSession = null;
var isBackupCommand = false;

function receiveMessage(event) {
  var message = event.data;

  switch (message.type) {
    case 'sdpInfo':
      audioWorker_worker_sdpInfo = message.data.sdpInfo;
      var aacCodecInfo = message.data.aacCodecInfo;
      setAudioRtpSession(audioWorker_worker_sdpInfo, aacCodecInfo, message.data.mp4Codec);
      break;

    case 'MediaData':
      //debug.log(message.data.rtspInterleave + '   '  + message.data.payload)
      var channelID = message.data.rtspInterleave[1];

      if (typeof audioRtpSessionsArray[channelID] !== 'undefined') {
        var rtpdata = message.data;
        var frameData = audioRtpSessionsArray[channelID].parseRTPData(rtpdata.rtspInterleave, rtpdata.payload, isBackupCommand, message.info);

        if (frameData !== null && typeof frameData !== 'undefined' && frameData.streamData !== null && typeof frameData.streamData !== 'undefined') {
          frameData.streamData = null;
        }

        sendMessage('render', frameData);
      }

      break;

    default:
      break;
  }
}

function setAudioRtpSession(sdpInfo, aacCodecInfo) {
  var SDPInfo = sdpInfo;

  for (var sdpIndex = 0; sdpIndex < sdpInfo.length; sdpIndex++) {
    if (SDPInfo[sdpIndex].trackID.search('trackID=t') === -1) {
      rtpSession = null;

      if (SDPInfo[sdpIndex].TalkTransType === 'recvonly') {
        switch (SDPInfo[sdpIndex].codecName) {
          case 'G.726-16':
          case 'G.726-24':
          case 'G.726-32':
          case 'G.726-40':
            var bit = parseInt(SDPInfo[sdpIndex].codecName.substr(6, 2));
            public_debug.log(bit);
            rtpSession = new src_AudioSession(SDPInfo[sdpIndex].codecName, bit);
            rtpSession.setCodecInfo(SDPInfo[sdpIndex]);
            break;

          case 'mpeg4-generic':
          case 'G.723':
          case 'G.729':
          case 'mpeg2':
          case 'G.722.1':
          case 'PCM':
          case 'G.711A':
          case 'G.711Mu':
            rtpSession = new src_AudioSession(SDPInfo[sdpIndex].codecName);
            rtpSession.setCodecInfo(SDPInfo[sdpIndex]);
            break;
        }

        var channelID = SDPInfo[sdpIndex].RtpInterlevedID;
        audioRtpSessionsArray[channelID] = rtpSession; //暂只支持一路音频

        if (rtpSession != null) {
          return;
        }
      }
    }
  }
}

function sendMessage(type) {
  var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
  var event = {
    'type': type,
    'codec': data.codec,
    'audio_type': data.audio_type,
    'data': data.bufferData,
    'rtpTimeStamp': data.rtpTimeStamp,
    'samplingRate': data.samplingRate || 8000
  };

  if (type === 'render') {
    postMessage(event, [data.bufferData.buffer]);
  } else if (type === 'backup') {
    var backupMessage = {
      'type': type,
      'data': data
    };
    postMessage(backupMessage);
  } else {
    postMessage(event);
  }
}

/***/ })
/******/ ]);