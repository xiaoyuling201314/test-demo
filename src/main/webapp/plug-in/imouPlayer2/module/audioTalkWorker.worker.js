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

var debug = function (flag) {
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


// CONCATENATED MODULE: ./src/Decode/audioEncoderG711.js
//编码原始音频数据


function G711AudioEncoder() {
  var localSampleRate = 48000;
  var BIAS = 0x84;
  var SEG_SHIFT = 4; //#define SEG_SHIFT (4) /* Left shift for segment number. */

  var QUANT_MASK = 0xf; //#define QUANT_MASK (0xf) /* Quantization field mask. */
  //var CLIP = 8159;

  var seg_end = [0xFF, 0x1FF, 0x3FF, 0x7FF, 0xFFF, 0x1FFF, 0x3FFF, 0x7FFF]; //var seg_uend = [0x3F, 0x7F, 0xFF, 0x1FF,0x3FF, 0x7FF, 0xFFF, 0x1FFF];
  //var self = this;

  var codecInfo = {
    type: 'G.711',
    samplingRate: 8000 // bitrate : 64000

  };
  var remainBuffer = null;
  /*
  将采集到的音频的频率一般是48K，但传递给设备的是8k，因此需要转化,
  当然，如果设备需要比48k频率还高的，那就无法做到了。
   */

  function downsampleBuffer(buffer, rate) {
    if (rate === localSampleRate) {
      return buffer;
    }

    if (rate > localSampleRate) {
      debug.log('The rate of device show be smaller than local sample rate');
    }

    var sampleRateRatio = localSampleRate / rate;
    var newLength = Math.floor(buffer.length / sampleRateRatio);
    var result = new Float32Array(newLength);
    var offsetResult = 0;
    var offsetBuffer = 0;

    while (offsetResult < result.length) {
      var nextOffsetBuffer = Math.round((offsetResult + 1) * sampleRateRatio);
      var accum = 0,
          count = 0;

      for (var i = offsetBuffer, buffer_length = buffer.length; i < nextOffsetBuffer && i < buffer_length; i++) {
        accum += buffer[i];
        count++;
      }

      result[offsetResult] = accum / count;
      offsetResult++;
      offsetBuffer = nextOffsetBuffer;
    }

    remainBuffer = null;

    if (Math.round(offsetResult * sampleRateRatio) !== buffer.length) {
      var remainStartIndex = Math.round(offsetResult * sampleRateRatio);
      remainBuffer = new Float32Array(buffer.subarray(remainStartIndex, buffer.length));
    }

    return result;
  }
  /*
  将pcm数据进行ulaw进行压缩，g711一般有2种压缩方式，g711a和g711u，该代码是从c++代码转义过来
   */

  /*function linear2ulaw (pcm_val) {//参考备注linear2ulaw,目前没用到，注释
      var mask, seg, uval;
      if (pcm_val < 0) {
          pcm_val = BIAS - pcm_val;
          mask = 0x7F;
      } else {
          pcm_val += BIAS;
          mask = 0xFF;
      }
      seg = search(pcm_val, seg_end);
      if (seg >= 8) {		// out of range, return maximum value.
          return (0x7F ^ mask);
      }
      else {
          uval = (seg << 4) | ((pcm_val >> (seg + 3)) & 0xF);
          return (uval ^ mask);
      }
  }*/

  /*
  unsigned char linear2ulaw(int pcm_val) // 2's complement (16-bit range) {
      int mask;
      int seg;
      unsigned char uval;
      if (pcm_val < 0) {
          pcm_val = BIAS - pcm_val;
          mask = 0x7F;
      } else {
          pcm_val += BIAS;
          mask = 0xFF;
      }
      seg = search(pcm_val, seg_end, 8);
      if (seg >= 8) //out of range, return maximum value.
          return (0x7F ^ mask);
      else {
          uval = (seg << 4) | ((pcm_val >> (seg + 3)) & 0xF);
          return (uval ^ mask);
      }
  }*/


  function search(val, table) {
    for (var i = 0, table_length = table.length; i < table_length; i++) {
      if (val <= table[i]) {
        return i;
      }
    }

    return table.length;
  }
  /*
  将pcm数据进行alaw进行压缩，g711一般有2种压缩方式，g711a和g711u，该代码是从c++代码转义过来
   */


  function linear2alaw(pcm_val) {
    //参考备注linear2alaw
    var mask, seg, aval;

    if (pcm_val >= 0) {
      mask = 0xD5;
      /* sign (7th) bit = 1 */
    } else {
      mask = 0x55;
      /* sign bit = 0 */

      pcm_val = -pcm_val - 8;
    }

    seg = search(pcm_val, seg_end);

    if (seg >= 8) {
      /* out of range, return maximum value. */
      return 0x7F ^ mask;
    } else {
      aval = seg << SEG_SHIFT;

      if (seg < 2) {
        aval |= pcm_val >> 4 & QUANT_MASK;
      } else {
        aval |= pcm_val >> seg + 3 & QUANT_MASK;
      }

      return aval ^ mask;
    }
  }
  /*unsigned char linear2alaw(int pcm_val) // 2's complement (16-bit range){
      int mask;
      int seg;
      unsigned char aval;
      if (pcm_val >= 0) {
          mask = 0xD5;
      } else {
          mask = 0x55;
          pcm_val = -pcm_val - 8;
      }
      seg = search(pcm_val, seg_end, 8);
      if (seg >= 8)
          return (0x7F ^ mask);
      else {
          aval = seg << SEG_SHIFT;
          if (seg < 2)
              aval |= (pcm_val >> 4) & QUANT_MASK;
          else
              aval |= (pcm_val >> (seg + 3)) & QUANT_MASK;
          return (aval ^ mask);
      }
  }*/


  function Constructor() {}

  Constructor.prototype = {
    setSampleRate: function setSampleRate(_sampleRate) {
      localSampleRate = _sampleRate;
    },
    encode: function encode(buffer) {
      var float32Array = null;

      if (remainBuffer !== null) {
        float32Array = new Float32Array(buffer.length + remainBuffer.length);
        float32Array.set(remainBuffer, 0);
        float32Array.set(buffer, remainBuffer.length);
      } else {
        float32Array = buffer;
      }

      float32Array = downsampleBuffer(float32Array, codecInfo.samplingRate);
      var pcmArray = new Int16Array(float32Array.length); //var ulawArray = new Uint8Array(pcmArray.length);/ulaw编码，按理是需要和设备协商，但是设备目前不支持协商，返回里面的是pcma，那先期就按照alaw，也就是g711a来进行压缩

      var alawArray = new Uint8Array(pcmArray.length);

      for (var i = 0, float32Array_length = float32Array.length; i < float32Array_length; i++) {
        pcmArray[i] = float32Array[i] * Math.pow(2, 15); //ulawArray[i] = linear2ulaw(pcmArray[i]);

        alawArray[i] = linear2alaw(pcmArray[i]);
      } //return ulawArray;


      return alawArray;
    }
  };
  return new Constructor();
}

/* harmony default export */ var audioEncoderG711 = (G711AudioEncoder);
// CONCATENATED MODULE: ./src/audioTalkSession.js
/*
    处理对讲中，从客户端获取到的音频数据，
    该代码中，talk.js中采集到的音频数据，根据audioEncoder.js，编码为g711a的数据，
    然后再将g711的数据，封装成适合websocket可以传递的大华包数据（其中封装为大华帧）
 */


var audioTalkSession_AudioTalkSession = function AudioTalkSession(RtpInterlevedID) {
  var rtpPacket = null;
  var audioEncoder = null;
  /*
  打包格式为: 0x24($) + 交织通道(interleaved) +
  4字节长度信息 + 大华帧,类似于以下数据
  00000AD5  24 0a 00 00 02 2c                                $....,
  00000ADB  44 48 41 56 f0 00 01 00  02 00 00 00 2c 02 00 00 DHAV.... ....,...
  00000AEB  ad e7 76 51 40 00 0c eb  83 01 0e 02 88 00 ce cd ..vQ@... ........
  00000AFB  cd 00 00 00
  */

  var rtpPacketHead = [0x24, RtpInterlevedID, 0x0, 0x0, 0x0, 0x0]; //打包格式为: 0x24($) + 交织通道(interleaved) + 长度（大端序）

  var DHAV = [0x44, 0x48, 0x41, 0x56]; //DHAV 0 - 4帧头标识

  var dhav = [0x64, 0x68, 0x61, 0x76]; //dhav 0 - 4帧尾标识，参考大华标准码流格式定义.pptx 58页
  //var rtpDataHead4_7 = [0xF0, 0x00, 0x01, 0x00];//4类型,5子类型,6通道号,7子帧序号
  //var rtpDataHead8_11 = [0x00, 0x00, 0x00, 0x00];//帧序号

  var frameNum = 0xF5; //帧序号
  //var rtpDataHead12_15 = [0x00, 0x00, 0x00, 0x00];//帧序号

  var timestamp = 0; //毫秒时间戳
  //var currTime = null;

  var preTime = null;
  var MAXFRAMEINTERVAL = 65535; //最大毫秒，在0-该值之间循环，可以不为0开始，设置区间主要用于节约空间。

  var rtpDataHeadExtLength = 4 + 4 + 8; //扩展帧头的长度，扩展帧0x83 + 0x86 + 0x88

  var rtpDataHeadLength = 24 + rtpDataHeadExtLength; //帧头24 + 扩展帧头

  var rtpDataFootLength = 8; //帧尾长度

  /**
   * [getHexArrayDec description] 将10进制的数据，转为length个字节长度的16进制数组，可以通过参数控制大小端序
   * @param  {[number]}   num [description] 需要转化的数字
   * @param  {[big]}   length [description] 需要转为为多少个字节长度的数组，默认为4
   * @param  {[big]}   big [description] big强等于true时，为大端序，其他为小端序
   * @return {[array]}     temp [description] 4个字节长度的16进制数组
   **/

  function getHexArrayDec(num, lengthArg, big) {
    var temp = [];
    var length = lengthArg || 4;

    if (big === true) {
      for (var i = 0; i < length; i++) {
        temp[i] = num >>> (length - 1 - i) * 8 & 0xFF;
      }
    } else {
      for (var _i = 0; _i < length; _i++) {
        temp[_i] = num >>> _i * 8 & 0xFF;
      }
    }

    return temp;
  }
  /**
   * [sum_32_verify description] 0x88扩展帧的计算，代码来源于c++，由潘军秋翻译成js，参考【大华码流标准格式定义.pptx】，第28页
   * 该处目前还未理解啥意思。反正是按照c++的逻辑来的。
   **/


  function sum_32_verify(buf, len) {
    var ret = 0;

    for (var i = 0; i < len; i++) {
      ret += buf[i] << i % 4 * 8;
    }

    return ret;
  }
  /**
   * [getTotal description] 根据传入的数据，返回总的长度，主要用于计算【大华标准码流格式定义pptx】13页中的23-校验和
   * @param  {[head]}   Uint8Array [description] 需要转化的数字
   * @param  {[start]}   num [description] 从哪里开始计算
   * @return {[total]}     num [description] 总的长度
   **/


  function getTotal(head, start) {
    var total = 0;

    for (var i = start; i < head.length; i++) {
      total = total + head[i];
    }

    return total;
  }

  function Constructor() {
    audioEncoder = new audioEncoderG711();
  }

  Constructor.prototype = {
    setSampleRate: function setSampleRate(_sampleRate) {
      audioEncoder.setSampleRate(_sampleRate);
    },

    /*
      将音频数据（此处是g711a），封装成大华包的格式。
     */
    getRTPPacket: function getRTPPacket(buffer) {
      var rtpPayload = audioEncoder.encode(buffer); //得到g711a的数据

      rtpPacket = new Uint8Array(rtpPacketHead.length + rtpDataHeadLength + rtpPayload.length + rtpDataFootLength);
      var offset = 0; //大华私有打包格式为: 0x24($) + 交织通道(interleaved) + 4字节长度信息 + 大华帧

      rtpPacket.set([0x24, RtpInterlevedID], offset), offset = offset + 2; //0x24($) + 交织通道(interleaved)

      rtpPacket.set(getHexArrayDec(rtpDataHeadLength + rtpPayload.length + rtpDataFootLength, 4, true), offset), offset = offset + 4; // + 4字节长度信息,使用大端序号
      //大华私有打包结束
      //以下是大华帧，大华帧参考的【大华标准码流格式定义.pptx】13页

      rtpPacket.set(DHAV, offset), offset = offset + 4; //帧头标识，固定为DHAV；0-3

      rtpPacket.set([0xF0], offset), offset = offset + 1; //类型，音频固定为0xF0；4

      rtpPacket.set([0x00], offset), offset = offset + 1; //子类型，音频固定为0x00；5

      rtpPacket.set([0x01], offset), offset = offset + 1; //通道号，音频固定为0x01；6

      rtpPacket.set([0x00], offset), offset = offset + 1; //子帧序号，音频固定为0x00；7

      if (frameNum > 65535) {
        frameNum = 0xF0;
      }

      rtpPacket.set(getHexArrayDec(frameNum), offset), offset = offset + 4, frameNum++; //子帧序号，0-65535循环； 8 -11

      var frameLength = getHexArrayDec(rtpDataHeadLength + rtpPayload.length + rtpDataFootLength);
      rtpPacket.set(frameLength, offset), offset = offset + 4; //帧长度 = 帧头长度 + 数据长度 + 帧尾长度；12-15

      var currDate = new Date();
      var year = currDate.getFullYear() - 2000; //协议要求要减去2000年，不知道啥规定，可能是为了节约空间。

      var month = currDate.getMonth() + 1; //月份是1-12，因此+1

      var day = currDate.getDate();
      var hours = currDate.getHours();
      var minutes = currDate.getMinutes();
      var seconds = currDate.getSeconds();
      var totalData = (year << 26) + (month << 22) + (day << 17) + (hours << 12) + (minutes << 6) + seconds;
      var currTime = currDate.getTime(); //当前时间

      var currTimeStamp = preTime === null ? 0 : currTime - preTime; //当前时间和上一次时间的差值,如果是第一帧，则设置为0

      preTime = currTime; //将当前时间设置为上一次时间，以便下次使用

      timestamp = timestamp + currTimeStamp; //当前帧比上一帧增加后的时间，毫秒为单位，

      if (timestamp > MAXFRAMEINTERVAL) {
        //如果毫秒时间戳，超过最大值，那么则顺延下去,比如当前帧为65585。比65535大，那么当前帧的时间戳为65585-65535 = 50ms
        timestamp = MAXFRAMEINTERVAL - timestamp;
      }

      rtpPacket.set(getHexArrayDec(totalData), offset), offset = offset + 4; //时间日期，精确到秒；16-19

      rtpPacket.set(getHexArrayDec(timestamp, 2), offset), offset = offset + 2; //毫秒时间戳；20 -21

      rtpPacket.set([rtpDataHeadExtLength], offset), offset = offset + 1; //扩展字段长度；22

      var total = getTotal(rtpPacket, 6);
      rtpPacket.set([total], offset), offset = offset + 1; //校验和；23
      //大华帧头封装结束
      //以下是扩展帧

      var medieType = [0x83, 0x01, 0x0E, 0x02]; //音频格式，参考大华码流标准格式定义.pptx，第23页，音频帧必须携带此扩展帧头

      rtpPacket.set(medieType, offset), offset = offset + 4;
      var audioChannel = [0x96, 0x01, 0x00, 0x00]; //音视频多合一通道，参考大华码流标准格式定义.pptx，第39页

      rtpPacket.set(audioChannel, offset), offset = offset + 4;
      var verify = sum_32_verify(rtpPayload, rtpPayload.length);
      rtpPacket.set([0x88], offset), offset = offset + 1; //0x88，校验位

      rtpPacket.set(getHexArrayDec(verify), offset), offset = offset + 4; //校验位

      rtpPacket.set([0x00, 0x00, 0x00], offset), offset = offset + 3; //固定为0
      //扩展帧结束
      //g711裸数据

      rtpPacket.set(rtpPayload, offset), offset = offset + rtpPayload.length; //g711裸数据
      //g711裸数据结束
      //帧尾 帧尾 = 帧尾dhav（4） + 【帧头长度 + 数据长度 + 帧尾长度】（4）

      rtpPacket.set(dhav, offset), offset = offset + 4; //帧尾dhav

      rtpPacket.set(frameLength, offset); //帧尾结束

      return rtpPacket; //该数据可以直接发送给设备了。
    }
  };
  return new Constructor(RtpInterlevedID);
};

/* harmony default export */ var audioTalkSession = (audioTalkSession_AudioTalkSession);
// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--5!./src/audioTalkWorker.worker.js
/*
    对收到的音频数据，进行处理，然后再返回出去
*/

var audioTalkWorker_worker_audioTalkSession = null;

function setAudioTalkSession(sdpInfo) {
  for (var sdpIndex = 0; sdpIndex < sdpInfo.length; sdpIndex++) {
    if (sdpInfo[sdpIndex].TalkTransType === 'sendonly') {
      //sendonly的交织通道，sendonly时，为对讲发送通道
      audioTalkWorker_worker_audioTalkSession = new audioTalkSession(sdpInfo[sdpIndex].RtpInterlevedID);
    }
  }
}

function sendMessage(type, data) {
  var event = {
    'type': type,
    'data': data
  };
  postMessage(event, [data.buffer]);
}

function receiveMessage(event) {
  var message = event.data;

  switch (message.type) {
    case 'sdpInfo':
      setAudioTalkSession(message.data.sdpInfo);
      break;

    case 'getRtpData':
      var rtpPacket = audioTalkWorker_worker_audioTalkSession.getRTPPacket(message.data);
      sendMessage('rtpData', rtpPacket);
      break;

    case 'sampleRate':
      {
        if (audioTalkWorker_worker_audioTalkSession !== null) {
          audioTalkWorker_worker_audioTalkSession.setSampleRate(message.data);
        }

        break;
      }
  }
}

addEventListener('message', receiveMessage, false);

/***/ })
/******/ ]);