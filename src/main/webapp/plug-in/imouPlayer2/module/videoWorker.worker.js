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


// CONCATENATED MODULE: ./src/Decode/h264Decoder.js


function H264Decoder() {
  var initDecoder = null;
  var decoderContext = null;
  var outpic = new Uint8Array();
  var ID = 264;
  var isFirstIFrame = false;
  var copyOutput;
  var beforeDecoding;
  var data;
  var frame;
  var decodingTime;
  var height;
  var ylen;
  var frameData;
  var outpicsize;
  var outpicptr;

  function Constructor() {
    decoderContext = Module._OpenDecoder(0, 0, 0);
    Constructor.prototype.setIsFirstFrame(false);
  }

  Constructor.prototype = {
    init: function init() {
      debug.log("H264 Decoder init");
    },
    setOutputSize: function setOutputSize(size) {
      if (outpicsize != size * 1.5) {
        outpicsize = size * 1.5;
        outpicptr = Module._malloc(outpicsize);
        outpic = new Uint8Array(Module.HEAPU8.buffer, outpicptr, outpicsize);
      }
    },
    decode: function decode(inputBufferSub, frameType) {
      beforeDecoding = Date.now();
      data = new Uint8Array(inputBufferSub);
      outpic.set(data);
      frame = Module._FrameAlloc();

      Module._DecodeFrame(decoderContext, outpic.byteOffset, inputBufferSub.byteLength, outpicsize, frame);

      decodingTime = Date.now() - beforeDecoding; //width = Module._getWidth(frame);

      ylen = Module._getYLength(frame);
      height = Module._getHeight(frame);

      if (!Constructor.prototype.isFirstFrame()) {
        Constructor.prototype.setIsFirstFrame(true);
        return {
          'firstFrame': true
        };
      }

      if (ylen > 0 && height > 0) {
        beforeDecoding = Date.now();
        var copyOutput = new Uint8Array(outpic);
        frameData = {
          'data': copyOutput,
          'option': {
            'yaddr': Module._getY(frame),
            'uaddr': Module._getU(frame),
            'vaddr': Module._getV(frame),
            'ylen': ylen,
            'height': height,
            'beforeDecoding': beforeDecoding
          },
          'width': ylen,
          'height': height,
          'codecType': 'h264',
          'decodingTime': decodingTime,
          'frameType': frameType
        };

        Module._FrameFree(frame);

        return frameData;
      }
    },
    setIsFirstFrame: function setIsFirstFrame(flag) {
      isFirstIFrame = flag;
    },
    isFirstFrame: function isFirstFrame() {
      return isFirstIFrame;
    },
    free: function free() {
      Module._free(outpicptr);

      outpicptr = null;
    }
  };
  return new Constructor();
}

/* harmony default export */ var h264Decoder = (H264Decoder);
// CONCATENATED MODULE: ./src/mp4remux.js
/*
 MP4封装类
 */


var mp4remux_MP4Remux = function MP4Remux() {
  var _types = [];

  var _dtsBase;

  var datas = {};
  _types = {
    avc1: [],
    avcC: [],
    btrt: [],
    dinf: [],
    dref: [],
    esds: [],
    ftyp: [],
    hdlr: [],
    mdat: [],
    mdhd: [],
    mdia: [],
    mfhd: [],
    minf: [],
    moof: [],
    moov: [],
    mp4a: [],
    mvex: [],
    mvhd: [],
    sdtp: [],
    stbl: [],
    stco: [],
    stsc: [],
    stsd: [],
    stsz: [],
    stts: [],
    tfdt: [],
    tfhd: [],
    traf: [],
    trak: [],
    trun: [],
    trex: [],
    tkhd: [],
    vmhd: [],
    smhd: []
  };

  function Constructor() {
    for (var name in _types) {
      _types[name] = [name.charCodeAt(0), name.charCodeAt(1), name.charCodeAt(2), name.charCodeAt(3)];
    }

    _dtsBase = 0;
    datas.FTYP = new Uint8Array([0x69, 0x73, 0x6F, 0x6D, // major_brand: isom
    0x0, 0x0, 0x0, 0x1, // minor_version: 0x01
    0x69, 0x73, 0x6F, 0x6D, // isom
    0x61, 0x76, 0x63, 0x31 // avc1
    ]);
    datas.STSD_PREFIX = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x01 // entry_count
    ]);
    datas.STTS = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00 // entry_count
    ]);
    datas.STSC = datas.STCO = datas.STTS;
    datas.STSZ = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00, // sample_size
    0x00, 0x00, 0x00, 0x00 // sample_count
    ]);
    datas.HDLR_VIDEO = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00, // pre_defined
    0x76, 0x69, 0x64, 0x65, // handler_type: 'vide'
    0x00, 0x00, 0x00, 0x00, // reserved: 3 * 4 bytes
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x69, 0x64, 0x65, 0x6F, 0x48, 0x61, 0x6E, 0x64, 0x6C, 0x65, 0x72, 0x00 // name: VideoHandler
    ]);
    datas.HDLR_AUDIO = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00, // pre_defined
    0x73, 0x6F, 0x75, 0x6E, // handler_type: 'soun'
    0x00, 0x00, 0x00, 0x00, // reserved: 3 * 4 bytes
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x53, 0x6F, 0x75, 0x6E, 0x64, 0x48, 0x61, 0x6E, 0x64, 0x6C, 0x65, 0x72, 0x00 // name: SoundHandler
    ]);
    datas.DREF = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x01, // entry_count
    0x00, 0x00, 0x00, 0x0C, // entry_size
    0x75, 0x72, 0x6C, 0x20, // type 'url '
    0x00, 0x00, 0x00, 0x01 // version(0) + flags
    ]); // Sound media header

    datas.SMHD = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00 // balance(2) + reserved(2)
    ]); // video media header

    datas.VMHD = new Uint8Array([0x00, 0x00, 0x00, 0x01, // version(0) + flags
    0x00, 0x00, // graphicsmode: 2 bytes
    0x00, 0x00, 0x00, 0x00, // opcolor: 3 * 2 bytes
    0x00, 0x00]);
  }

  var box = function box(type) {
    var size = 8;
    var arrs = Array.prototype.slice.call(arguments, 1);

    for (var i = 0; i < arrs.length; i++) {
      size += arrs[i].byteLength;
    }

    var data = new Uint8Array(size);
    var pos = 0; // set size

    data[pos++] = size >>> 24 & 0xFF;
    data[pos++] = size >>> 16 & 0xFF;
    data[pos++] = size >>> 8 & 0xFF;
    data[pos++] = size & 0xFF; // set type

    data.set(type, pos);
    pos += 4; // set data

    for (var i = 0; i < arrs.length; i++) {
      data.set(arrs[i], pos);
      pos += arrs[i].byteLength;
    }

    return data;
  }; //组装mp4a


  var esds = function esds(meta) {
    var config = meta.config;
    var configSize = config.length;
    var data = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version 0 + flags
    0x03, // descriptor_type
    0x17 + configSize, // length3
    0x00, 0x01, // es_id
    0x00, // stream_priority
    0x04, // descriptor_type
    0x0F + configSize, // length
    0x40, // codec: mpeg4_audio
    0x15, // stream_type: Audio
    0x00, 0x00, 0x00, // buffer_size
    0x00, 0x00, 0x00, 0x00, // maxBitrate
    0x00, 0x00, 0x00, 0x00, // avgBitrate
    0x05 // descriptor_type
    ].concat([configSize]).concat(config).concat([0x06, 0x01, 0x02] // GASpecificConfig
    ));
    return box(_types.esds, data);
  }; //组装stsd


  var audioSample = function audioSample(track) {
    return box(_types.mp4a, new Uint8Array([// SampleEntry, ISO/IEC 14496-12
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // reserved
    0x00, 0x01, // data_reference_index
    // AudioSampleEntry, ISO/IEC 14496-12
    0x00, 0x00, 0x00, 0x00, // reserved
    0x00, 0x00, 0x00, 0x00, // reserved
    (track.channelcount & 0xff00) >> 8, track.channelcount & 0xff, // channelcount
    (track.samplesize & 0xff00) >> 8, track.samplesize & 0xff, // samplesize
    0x00, 0x00, // pre_defined
    0x00, 0x00, // reserved
    (track.samplerate & 0xff00) >> 8, track.samplerate & 0xff, 0x00, 0x00 // samplerate, 16.16
    // MP4AudioSampleEntry, ISO/IEC 14496-14
    ]), esds(track));
  };

  var videoSample = function videoSample(track) {
    var sps = track.sps || [],
        pps = track.pps || [],
        sequenceParameterSets = [],
        pictureParameterSets = [],
        i = 0; // assemble the SPSs

    for (i = 0; i < sps.length; i++) {
      sequenceParameterSets.push((sps[i].byteLength & 0xFF00) >>> 8);
      sequenceParameterSets.push(sps[i].byteLength & 0xFF); // sequenceParameterSetLength

      sequenceParameterSets = sequenceParameterSets.concat(Array.prototype.slice.call(sps[i])); // SPS
    } // assemble the PPSs


    for (i = 0; i < pps.length; i++) {
      pictureParameterSets.push((pps[i].byteLength & 0xFF00) >>> 8);
      pictureParameterSets.push(pps[i].byteLength & 0xFF);
      pictureParameterSets = pictureParameterSets.concat(Array.prototype.slice.call(pps[i]));
    }

    return box(_types.avc1, new Uint8Array([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // reserved
    0x00, 0x01, // data_reference_index
    0x00, 0x00, // pre_defined
    0x00, 0x00, // reserved
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // pre_defined
    (track.width & 0xff00) >> 8, track.width & 0xff, // width
    (track.height & 0xff00) >> 8, track.height & 0xff, // height
    0x00, 0x48, 0x00, 0x00, // horizresolution
    0x00, 0x48, 0x00, 0x00, // vertresolution
    0x00, 0x00, 0x00, 0x00, // reserved
    0x00, 0x01, // frame_count
    0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // compressorname
    0x00, 0x18, // depth = 24
    0x11, 0x11 // pre_defined = -1
    ]), box(_types.avcC, new Uint8Array([0x01, // configurationVersion
    track.profileIdc, // AVCProfileIndication
    track.profileCompatibility, // profile_compatibility
    track.levelIdc, // AVCLevelIndication
    0xff // lengthSizeMinusOne, hard-coded to 4 bytes
    ].concat([sps.length // numOfSequenceParameterSets
    ]).concat(sequenceParameterSets).concat([pps.length // numOfPictureParameterSets
    ]).concat(pictureParameterSets))));
  }; //组装stbl


  var stsd = function stsd(meta) {
    if (meta.type === 'audio') {
      return box(_types.stsd, datas.STSD_PREFIX, audioSample(meta));
    } else {
      return box(_types.stsd, datas.STSD_PREFIX, videoSample(meta));
    }
  }; //组装minf


  var dinf = function dinf() {
    return box(_types.dinf, box(_types.dref, datas.DREF));
  };

  var stbl = function stbl(meta) {
    var result = box(_types.stbl, // type: stbl
    stsd(meta), // Sample Description Table
    box(_types.stts, datas.STTS), // Time-To-Sample
    box(_types.stsc, datas.STSC), // Sample-To-Chunk
    box(_types.stsz, datas.STSZ), // Sample size
    box(_types.stco, datas.STCO) // Chunk offset
    );
    return result;
  }; //组装mdia


  var mdhd = function mdhd(meta) {
    var timescale = meta.timescale;
    var duration = meta.duration;
    return box(_types.mdhd, new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00, // creation_time
    0x00, 0x00, 0x00, 0x00, // modification_time
    timescale >>> 24 & 0xFF, // timescale: 4 bytes
    timescale >>> 16 & 0xFF, timescale >>> 8 & 0xFF, timescale & 0xFF, duration >>> 24 & 0xFF, // duration: 4 bytes
    duration >>> 16 & 0xFF, duration >>> 8 & 0xFF, duration & 0xFF, 0x55, 0xC4, // language: und (undetermined)
    0x00, 0x00 // pre_defined = 0
    ]));
  };

  var hdlr = function hdlr(meta) {
    var data = null;

    if (meta.type === 'audio') {
      data = datas.HDLR_AUDIO;
    } else {
      data = datas.HDLR_VIDEO;
    }

    return box(_types.hdlr, data);
  };

  var minf = function minf(meta) {
    var xmhd = null;

    if (meta.type === 'audio') {
      xmhd = box(_types.smhd, datas.SMHD);
    } else {
      xmhd = box(_types.vmhd, datas.VMHD);
    }

    return box(_types.minf, xmhd, dinf(), stbl(meta));
  }; // 组装trak


  var tkhd = function tkhd(meta) {
    var trackId = meta.id;
    var duration = meta.duration;
    var width = meta.width;
    var height = meta.height;
    return box(_types.tkhd, new Uint8Array([0x00, 0x00, 0x00, 0x07, // version(0) + flags
    0x00, 0x00, 0x00, 0x00, // creation_time
    0x00, 0x00, 0x00, 0x00, // modification_time
    trackId >>> 24 & 0xFF, // track_ID: 4 bytes
    trackId >>> 16 & 0xFF, trackId >>> 8 & 0xFF, trackId & 0xFF, 0x00, 0x00, 0x00, 0x00, // reserved: 4 bytes
    duration >>> 24 & 0xFF, // duration: 4 bytes
    duration >>> 16 & 0xFF, duration >>> 8 & 0xFF, duration & 0xFF, 0x00, 0x00, 0x00, 0x00, // reserved: 2 * 4 bytes
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // layer(2bytes) + alternate_group(2bytes)
    0x00, 0x00, 0x00, 0x00, // volume(2bytes) + reserved(2bytes)
    0x00, 0x01, 0x00, 0x00, // ----begin composition matrix----
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, // ----end composition matrix----
    width >>> 8 & 0xFF, // width and height
    width & 0xFF, 0x00, 0x00, height >>> 8 & 0xFF, height & 0xFF, 0x00, 0x00]));
  };

  var mdia = function mdia(meta) {
    return box(_types.mdia, mdhd(meta), hdlr(meta), minf(meta));
  }; //组装mvex


  var trex = function trex(meta) {
    var trackId = meta.id;
    var data = new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    trackId >>> 24 & 0xFF, // track_ID
    trackId >>> 16 & 0xFF, trackId >>> 8 & 0xFF, trackId & 0xFF, 0x00, 0x00, 0x00, 0x01, // default_sample_description_index
    0x00, 0x00, 0x00, 0x00, // default_sample_duration
    0x00, 0x00, 0x00, 0x00, // default_sample_size
    0x00, 0x01, 0x00, 0x01 // default_sample_flags
    ]);
    return box(_types.trex, data);
  }; //组装moov


  var mvhd = function mvhd(timescale, duration) {
    debug.log('mvhd:  timescale: ' + timescale + '  duration: ' + duration);
    return box(_types.mvhd, new Uint8Array([0x00, 0x00, 0x00, 0x00, // version(0) + flags
    0x00, 0x00, 0x00, 0x00, // creation_time
    0x00, 0x00, 0x00, 0x00, // modification_time
    timescale >>> 24 & 0xFF, // timescale: 4 bytes
    timescale >>> 16 & 0xFF, timescale >>> 8 & 0xFF, timescale & 0xFF, duration >>> 24 & 0xFF, // duration: 4 bytes
    duration >>> 16 & 0xFF, duration >>> 8 & 0xFF, duration & 0xFF, 0x00, 0x01, 0x00, 0x00, // Preferred rate: 1.0
    0x01, 0x00, 0x00, 0x00, // PreferredVolume(1.0, 2bytes) + reserved(2bytes)
    0x00, 0x00, 0x00, 0x00, // reserved: 4 + 4 bytes
    0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, // ----begin composition matrix----
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, // ----end composition matrix----
    0x00, 0x00, 0x00, 0x00, // ----begin pre_defined 6 * 4 bytes----
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // ----end pre_defined 6 * 4 bytes----
    0xFF, 0xFF, 0xFF, 0xFF // next_track_ID
    ]));
  };

  var trak = function trak(meta) {
    return box(_types.trak, tkhd(meta), mdia(meta));
  };

  var mvex = function mvex(meta) {
    return box(_types.mvex, trex(meta));
  }; //组装initSegment


  var moov = function moov(meta) {
    var mvhd1 = mvhd(meta.timescale, meta.duration);
    var trak1 = trak(meta);
    var mvex1 = mvex(meta);
    return box(_types.moov, mvhd1, trak1, mvex1);
  }; //组装traf


  var sdtp = function sdtp(track) {
    var samples = track.samples || [];
    var sampleCount = samples.length;
    var data = new Uint8Array(4 + sampleCount); // 0~4 bytes: version(0) & flags

    for (var i = 0; i < sampleCount; i++) {
      var flags = samples[i].flags;
      data[i + 4] = flags.isLeading << 6 | // is_leading: 2 (bit)
      flags.dependsOn << 4 // sample_depends_on
      | flags.isDependedOn << 2 // sample_is_depended_on
      | flags.hasRedundancy; // sample_has_redundancy
    }

    return box(_types.sdtp, data);
  }; //var trun = function(track, offset) {
  //    var samples = track.samples || [];
  //    var sampleCount = samples.length;
  //    var dataSize = 12 + 16 * sampleCount;
  //    var data = new Uint8Array(dataSize);
  //
  //    offset += 8 + dataSize;
  //
  //    data.set([
  //        0x00, 0x00, 0x0F, 0x01,      // version(0) & flags
  //        (sampleCount >>> 24) & 0xFF, // sample_count
  //        (sampleCount >>> 16) & 0xFF,
  //        (sampleCount >>>  8) & 0xFF,
  //        (sampleCount) & 0xFF,
  //        (offset >>> 24) & 0xFF,      // data_offset
  //        (offset >>> 16) & 0xFF,
  //        (offset >>>  8) & 0xFF,
  //        (offset) & 0xFF
  //    ], 0);
  //
  //    for (var i = 0; i < sampleCount; i++) {
  //        var duration = samples[i].duration;
  //        var size = samples[i].size;
  //        var flags = samples[i].flags;
  //        var cts = samples[i].cts;
  //
  //        data.set([
  //            (duration >>> 24) & 0xFF, // sample_duration
  //            (duration >>> 16) & 0xFF,
  //            (duration >>>  8) & 0xFF,
  //            (duration) & 0xFF,
  //            (size >>> 24) & 0xFF,     // sample_size
  //            (size >>> 16) & 0xFF,
  //            (size >>>  8) & 0xFF,
  //            (size) & 0xFF,
  //            (flags.isLeading << 2) | flags.dependsOn, // sample_flags
  //            (flags.isDependedOn << 6) | (flags.hasRedundancy << 4) | flags.isNonSync,
  //            0x00, 0x00,               // sample_degradation_priority
  //            (cts >>> 24) & 0xFF,      // sample_composition_time_offset
  //            (cts >>> 16) & 0xFF,
  //            (cts >>>  8) & 0xFF,
  //            (cts) & 0xFF
  //        ], 12 + 16 * i);
  //    }
  //
  //    return box(_types.trun, data);
  //};


  var trunHeader1 = function trunHeader1(samples, offset) {
    return [0, 0, 3, 5, (samples.length & 4278190080) >>> 24, (samples.length & 16711680) >>> 16, (samples.length & 65280) >>> 8, samples.length & 255, (offset & 4278190080) >>> 24, (offset & 16711680) >>> 16, (offset & 65280) >>> 8, offset & 255, 0, 0, 0, 0];
  };

  var videoTrun = function videoTrun(track, _offset) {
    var bytes = null,
        samples = null,
        sample = null,
        i = 0;
    var offset = _offset;
    samples = track.samples || [];

    if (samples[0].frameDuration === null) {
      offset += 8 + 12 + 4 + 4 * samples.length;
      bytes = trunHeader(samples, offset);

      for (i = 0; i < samples.length; i++) {
        sample = samples[i];
        bytes = bytes.concat([(sample.size & 4278190080) >>> 24, (sample.size & 16711680) >>> 16, (sample.size & 65280) >>> 8, sample.size & 255]);
      }
    } else {
      offset += 8 + 12 + 4 + 4 * samples.length + 4 * samples.length;
      bytes = trunHeader1(samples, offset);

      for (i = 0; i < samples.length; i++) {
        sample = samples[i];
        bytes = bytes.concat([(sample.frameDuration & 4278190080) >>> 24, (sample.frameDuration & 16711680) >>> 16, (sample.frameDuration & 65280) >>> 8, sample.frameDuration & 255, (sample.size & 4278190080) >>> 24, (sample.size & 16711680) >>> 16, (sample.size & 65280) >>> 8, sample.size & 255]);
      }
    }

    return box(_types.trun, new Uint8Array(bytes));
  };

  var trun = function trun(track, offset) {
    if (track.type === "audio") {
      return audioTrun(track, offset);
    }

    return videoTrun(track, offset);
  }; //组装moof


  var mfhd = function mfhd(sequenceNumber) {
    var data = new Uint8Array([0x00, 0x00, 0x00, 0x00, sequenceNumber >>> 24 & 0xFF, // sequence_number: int32
    sequenceNumber >>> 16 & 0xFF, sequenceNumber >>> 8 & 0xFF, sequenceNumber & 0xFF]);
    return box(_types.mfhd, data);
  }; //var traf = function(track, baseMediaDecodeTime) {
  //    var trackId = track.id;
  //
  //    // Track fragment header box
  //    var tfhd = box(_types.tfhd, new Uint8Array([
  //        0x00, 0x00, 0x00, 0x00,  // version(0) & flags
  //        (trackId >>> 24) & 0xFF, // track_ID
  //        (trackId >>> 16) & 0xFF,
  //        (trackId >>>  8) & 0xFF,
  //        (trackId) & 0xFF
  //    ]));
  //
  //    // Track Fragment Decode Time
  //    var tfdt = box(_types.tfdt, new Uint8Array([
  //        0x00, 0x00, 0x00, 0x00,              // version(0) & flags
  //        (baseMediaDecodeTime >>> 24) & 0xFF, // baseMediaDecodeTime: int32
  //        (baseMediaDecodeTime >>> 16) & 0xFF,
  //        (baseMediaDecodeTime >>>  8) & 0xFF,
  //        (baseMediaDecodeTime) & 0xFF
  //    ]));
  //
  //    var sdtp1 = sdtp(track);
  //    var trun1 = trun(track, sdtp1.byteLength + 16 + 16 + 8 + 16 + 8 + 8);
  //
  //    return box(_types.traf, tfhd, tfdt, trun1, sdtp1);
  //};


  var traf = function traf(track) {
    var trackFragmentHeader = null,
        trackFragmentDecodeTime = null,
        trackFragmentRun = null,
        dataOffset = null;
    trackFragmentHeader = box(_types.tfhd, new Uint8Array([0, 2, 0, 0, 0, 0, 0, 1]));
    trackFragmentDecodeTime = box(_types.tfdt, new Uint8Array([0, 0, 0, 0, track.baseMediaDecodeTime >>> 24 & 255, track.baseMediaDecodeTime >>> 16 & 255, track.baseMediaDecodeTime >>> 8 & 255, track.baseMediaDecodeTime & 255]));
    dataOffset = 16 + 16 + 8 + 16 + 8 + 8;
    trackFragmentRun = trun(track, dataOffset);
    return box(_types.traf, trackFragmentHeader, trackFragmentDecodeTime, trackFragmentRun);
  }; //组装mediaSegment


  var moof = function moof(sequenceNumber, track) {
    //console.log('moof--------:  sequenceNumber: ' + JSON.stringify(sequenceNumber) + '  track: ' + JSON.stringify(track))
    return box(_types.moof, mfhd(sequenceNumber), traf(track)); //var trackFragments = [], i = tracks.length;
    //while (i--) {
    //    trackFragments[i] = traf(tracks[i])
    //}
    //return box.apply(null, [_types.moof, mfhd(sequenceNumber)].concat(trackFragments))
    //console.log('trackFragmentsLength: ' +trackFragments.length)
  };

  var mdat = function mdat(data) {
    return box(_types.mdat, data);
  };

  Constructor.prototype = {
    initSegment: function initSegment(meta) {
      var ftyp = box(_types.ftyp, datas.FTYP);
      debug.log(meta);
      var moov1 = moov(meta);
      var seg = new Uint8Array(ftyp.byteLength + moov1.byteLength);
      seg.set(ftyp, 0);
      seg.set(moov1, ftyp.byteLength);
      return seg;
    },
    mediaSegment: function mediaSegment(sequenceNumber, tracks, data, ept) {
      var moofBox = moof(sequenceNumber, tracks);
      var frameData = mdat(data);
      var result = null;
      result = new Uint8Array(moofBox.byteLength + frameData.byteLength);
      result.set(moofBox);
      result.set(frameData, moofBox.byteLength);
      return result;
    }
  };
  return new Constructor();
};

/* harmony default export */ var mp4remux = (new mp4remux_MP4Remux());
// CONCATENATED MODULE: ./src/hashMap.js
var Map = function Map() {
  this.map = {};
};

Map.prototype = {
  put: function put(key, value) {
    this.map[key] = value;
  },
  get: function get(key) {
    return this.map[key];
  },
  containsKey: function containsKey(key) {
    return key in this.map;
  },
  containsValue: function containsValue(value) {
    for (var prop in this.map) {
      if (this.map[prop] === value) {
        return true;
      }
    }

    return false;
  },
  isEmpty: function isEmpty(key) {
    return this.size() === 0;
  },
  clear: function clear() {
    for (var prop in this.map) {
      delete this.map[prop];
    }
  },
  remove: function remove(key) {
    delete this.map[key];
  },
  keys: function keys() {
    var keys = new Array();

    for (var prop in this.map) {
      keys.push(prop);
    }

    return keys;
  },
  values: function values() {
    var values = new Array();

    for (var prop in this.map) {
      values.push(this.map[prop]);
    }

    return values;
  },
  size: function size() {
    var count = 0;

    for (var prop in this.map) {
      count++;
    }

    return count;
  }
};
/* harmony default export */ var hashMap = (Map);
// CONCATENATED MODULE: ./src/h264Session.js
/*
   解析H264格式
   canvas解码时，调用H264Decoder将视频解析成YUV数据
   video播放时，裸视频组装成mp4
 */





var h264Session_H264Session = function H264Session() {
  var rtpTimeStamp = 0,
      inputLength = 0,
      outputSize = 0,
      size1M = 1048576,
      //1024 * 1024
  playback = false,
      inputBuffer = new Uint8Array(size1M),
      PREFIX = new Uint8Array(['0x00', '0x00', '0x00', '0x01']),
      SPSParser = new H264SPSParser(),
      curSize = 0,
      preInfo = null,
      preCodecInfo = null,
      privIRtpTime = 0,
      // frameDiffTime = 0,
  // needDropCnt = 0,
  delayingTime = 0,
      DELAY_LIMIT = 8000,
      changeModeFlag = false,
      iFrameNum = 0,
      decodedData = {
    frameData: null,
    timeStamp: null,
    initSegmentData: null,
    mediaSample: null,
    dropPercent: 0,
    dropCount: 0,
    codecInfo: "",
    playback: false
  },
      timeData = {
    'timestamp': null,
    'timezone': null
  },
      playbackVideoTagTempSample = {}; //initial segment test

  var spsSegment = null,
      ppsSegment = null,
      initalSegmentFlag = false,
      initalMediaFrameFlag = false,
      widthSegment = 0,
      heightSegment = 0,
      videoTagLimitSize = 786432; //1024 * 768

  var width = 0;
  var height = 0;
  var errorcheck = false;
  var errorIFrameNum = 0;
  var preTimeStamp = null;
  var frameDuration = 0;
  var preRtpTimeStamp = null;
  var rtpDuration = 0;
  var decodeMode = "";
  var govLength = null;
  var dropPer = 0;
  var dropCount = 0;
  var frameRate = 0;
  var ticks = 0;
  var firstTime = 0;
  var resolution = {
    width: 0,
    height: 0
  };
  var smartEnable = null;
  var lessRateCanvas = false;

  var setBuffer = function setBuffer(buffer1, buffer2) {
    var bufferTemp = buffer1;

    if (inputLength + buffer2.length > buffer1.length) {
      bufferTemp = new Uint8Array(buffer1.length + size1M);
    }

    bufferTemp.set(buffer2, inputLength);
    inputLength += buffer2.length;
    return bufferTemp;
  };

  function changeMode(mode) {
    if (mode !== decodeMode) {
      if (mode === "video") {
        decodeMode = "video";
      } else {
        decodeMode = "canvas";
        changeModeFlag = true;
        iFrameNum = 0;
        decodedData.frameData.firstFrame = true;
      }
    }
  }

  function checkMode(width, height, smartEnable) {
    var mode = '';

    if (width * height > 1280 * 720 && smartEnable === false) {
      mode = 'video';

      if (lessRateCanvas && frameRate > 0 && frameRate <= 3) {
        //低帧率时是否用canvas
        mode = 'canvas';
      }
    } else {
      mode = 'canvas';
    }

    return mode;
  }

  function Constructor() {
    this.decoder = new h264Decoder(); //new H264Decoder();

    this.firstDiffTime = 0;
    this.firstTime = 0;
    this.lastMSW = 0;
  }

  Constructor.prototype = {
    setReturnCallback: function setReturnCallback(RtpReturn) {
      this.rtpReturnCallback = RtpReturn;
    },
    setBufferfullCallback: function setBufferfullCallback(bufferFull) {
      if (this.videoBufferList !== null) {
        this.videoBufferList.setBufferFullCallback(bufferFull);
      }
    },
    getVideoBuffer: function getVideoBuffer(idx) {
      if (this.videoBufferList !== null) {
        return this.videoBufferList.searchNodeAt(idx);
        /*this.videoBufferList.getCurIdx()*/
      }
    },
    clearBuffer: function clearBuffer() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.clear();
      }
    },
    findCurrent: function findCurrent() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.searchTimestamp(this.getTimeStamp());
      }
    },
    setTimeStamp: function setTimeStamp(data) {
      this.timeData = data;
    },
    getTimeStamp: function getTimeStamp() {
      return this.timeData;
    },
    ntohl: function ntohl(buffer) {
      return (buffer[0] << 24) + (buffer[1] << 16) + (buffer[2] << 8) + buffer[3] >>> 0;
    },
    appendBuffer: function appendBuffer(currentBuffer, newBuffer, readLength) {
      var BUFFER_SIZE = 1024 * 1024;

      if (readLength + newBuffer.length >= currentBuffer.length) {
        var tmp = new Uint8Array(currentBuffer.length + BUFFER_SIZE);
        tmp.set(currentBuffer, 0);
        currentBuffer = tmp;
      }

      currentBuffer.set(newBuffer, readLength);
      return currentBuffer;
    },
    getFramerate: function getFramerate() {
      return frameRate;
    },
    setGovLength: function setGovLength(_govLength) {
      govLength = _govLength;
    },
    getGovLength: function getGovLength() {
      return govLength;
    },
    setDecodingTime: function setDecodingTime(time) {
      this.decodingTime = time;
    },
    getDropPercent: function getDropPercent() {
      return dropPer;
    },
    getDropCount: function getDropCount() {
      return dropCount;
    },
    initStartTime: function initStartTime() {
      this.firstDiffTime = 0;
      this.calcGov = 0;
    },
    setCheckDelay: function setCheckDelay(checkDelay) {
      this.checkDelay = checkDelay;
    },
    init: function init(mode) {
      initalSegmentFlag = false;
      playback = false;
      decodeMode = mode;
      this.decoder.setIsFirstFrame(false);
      this.videoBufferList = new VideoBufferList();
      this.firstDiffTime = 0;
      this.checkDelay = true;
      this.timeData = null;
    },
    setFramerate: function setFramerate(framerate) {
      if (0 < framerate && typeof framerate !== "undefined") {
        frameRate = framerate;

        if (this.videoBufferList !== null) {
          this.videoBufferList.setMaxLength(frameRate * 6);
          this.videoBufferList.setBUFFERING(frameRate * 4);
        }
      }
    },
    parseRTPData: function parseRTPData(rtspInterleaved, dhPayload, isBackup, dropout, info) {
      var PAYLOAD = null,
          extensionHeaderLen = 0,
          PaddingSize = 0,
          data = {}; //var fsynctime = {};

      var time = (dhPayload[19] << 24) + (dhPayload[18] << 16) + (dhPayload[17] << 8) + dhPayload[16] >>> 0;
      var timeString = "year: " + (time >> 26) + ' month: ' + (time >> 22 & 0x0f) + ' day: ' + (time >> 17 & 0x1f) + ' hour: ' + (time >> 12 & 0x1f) + ' minute: ' + (time >> 6 & 0x3f) + ' second: ' + (time & 0x3f);
      var lsw = Date.UTC('20' + (time >>> 26), (time >>> 22 & 0x0f) - 1, time >>> 17 & 0x1f, time >>> 12 & 0x1f, time >>> 6 & 0x3f, time & 0x3f) / 1000; //var msw = info.timeStampmsw;
      //debug.log('time:  ' + (lsw + msw) + '  ' + (new Date()).getTime() + ' ' + timeString)
      //var lsw = '20' + (time >> 26) + (((time >> 22) & 0x0f) ) + ((time >> 17) & 0x1f) + ((time >> 12) & 0x1f) + ((time >> 6) & 0x3f) + (time & 0x3f);

      var msw = info.timeStampmsw; //fsynctime.seconds = lsw - 8 * 3600; //大华帧头默认按照东8区打时间戳
      //fsynctime.useconds = msw;
      //timeData = {
      //    timestamp: fsynctime.seconds,
      //    timestamp_usec: fsynctime.useconds
      //};

      lsw = lsw + new Date().getTimezoneOffset() / 60 * 3600;

      if (!decodeMode && dhPayload[4] === 0xFD) {
        //如果没有设置播放模式,正常情况第一帧都为I帧
        smartEnable = dhPayload[5] === 0x00 ? false : true; //判断智能编码

        decodeMode = checkMode(info.width, info.height, smartEnable);
      }

      if (decodeMode === "") return; //编码模式还未计算出来

      if (this.firstTime == 0) {
        this.firstTime = lsw;
        this.lastMSW = 0;
        preRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        timeData = {
          timestamp: this.firstTime,
          timestamp_usec: 0
        }; //console.log('第一帧时间: ' + this.firstTime)
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
        timeData = {
          timestamp: lsw,
          timestamp_usec: this.lastMSW
        };
        preRtpTimeStamp = currentRtpTimeStamp;
      }

      if ((this.getFramerate() === 0 || typeof this.getFramerate() === 'undefined') && typeof this.getTimeStamp() !== 'undefined') {
        this.setFramerate(Math.round(1000 / ((timeData.timestamp - this.getTimeStamp().timestamp === 0 ? 0 : 1000) + (timeData.timestamp_usec - this.getTimeStamp().timestamp_usec))));
        debug.log('setFramerate' + Math.round(1000 / ((timeData.timestamp - this.getTimeStamp().timestamp === 0 ? 0 : 1000) + (timeData.timestamp_usec - this.getTimeStamp().timestamp_usec))));
      }

      this.setTimeStamp(timeData); // debug.log(' dhPayloadLength:   '  + dhPayload.length)

      var extenLen = dhPayload[22]; //check marker bit
      //if ((HEADER[1] & 0x80) === 0x80) {

      var inputBufferSub = dhPayload.subarray(24 + extenLen, dhPayload.length - 8);
      var end = dhPayload.subarray(dhPayload.length - 8, dhPayload.length);
      var frameLength = (end[7] << 24) + (end[6] << 16) + (end[5] << 8) + end[4];
      var pos = [];

      for (var i = 0; i <= inputBufferSub.length;) {
        //遍历整个payload最后一个001的位置是115
        if (inputBufferSub[i] == 0) {
          // 0
          if (inputBufferSub[i + 1] == 0) {
            //00
            if (inputBufferSub[i + 2] == 1) {
              //001
              pos.push(i);
              i = i + 3;

              if ((inputBufferSub[i] & 0x1f) == 5 || (inputBufferSub[i] & 0x1f) == 1) {
                //debug.log('break');
                break;
              }
            } else if (inputBufferSub[i + 2] == 0) {
              // i = 000时i向右移动一位
              i++;
            } else {
              // i = 00x时i向右移动3位
              i = i + 3;
            }
          } else {
            // i!= 00时候向右移动2位
            i = i + 2;
          }
        } else {
          // i != 0时向右移动1位
          i = i + 1;
        }
      }

      var frameType = 'P';
      rtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20]; //debug.log('pos: ' + pos)
      //if (pos[pos.length - 1] > 100){
      //    debug.log('大于100: ' + pos[pos.length - 1])
      //    debug.log('pos: ' + pos);
      //}
      //debug.log('VIDEO rtpTimeStamp: ' +　rtpTimeStamp)

      var nalType;
      var endP = 0;

      for (var i = 0; i < pos.length; i++) {
        PAYLOAD = inputBufferSub.subarray(pos[i] + 3, pos[i + 1]);
        nalType = inputBufferSub[pos[i] + 3] & 0x1f;

        switch (nalType) {
          default:
            break;

          case 1:
            frameType = 'P';
            endP = pos[i] - 1; //debug.log('nalType: ' + nalType  + ' '  + ' ' + PAYLOAD.length)

            break;

          case 5:
            frameType = 'I';
            endP = pos[i] - 1; //debug.log('nalType: ' + nalType  + ' '  + ' ' + PAYLOAD.length)

            break;
          // Fragmentation unit(FU)

          case 28:
            //debug.log('FU')
            break;
          //SPS

          case 7:
            SPSParser.parse(PAYLOAD); //var sizeInfo = SPSParser.getSizeInfo();

            var sizeInfo = info;
            curSize = SPSParser.getSizeInfo().decodeSize; //Make initial segment whenever resolution is changed

            if (preInfo === null || preCodecInfo === null || preInfo.width !== sizeInfo.width || preInfo.height !== sizeInfo.height || preCodecInfo !== SPSParser.getCodecInfo()) {
              initalSegmentFlag = false;
              preInfo = sizeInfo;
              preCodecInfo = SPSParser.getCodecInfo();
              this.decoder.setIsFirstFrame(false);
            }

            width = widthSegment = sizeInfo.width;
            height = heightSegment = sizeInfo.height;
            spsSegment = PAYLOAD;

            if (resolution.width != sizeInfo.width || resolution.height != sizeInfo.height) {
              if (resolution.width != 0) {
                resolution.width = sizeInfo.width;
                resolution.height = sizeInfo.height;
                data.resolution = resolution;
                data.resolution.decodeMode = checkMode(resolution.width, resolution.height, smartEnable); //分辨率改变后计算播放模式

                data.resolution.encodeMode = 'h264';
              } else {
                resolution.width = sizeInfo.width;
                resolution.height = sizeInfo.height;
                data.decodeStart = resolution;
                data.decodeStart.decodeMode = decodeMode;
                data.decodeStart.encodeMode = 'h264';
              }
            } //debug.log('SPS:  ' + inputBufferSub.subarray(pos[i] + 3 , pos[i + 1]))
            //debug.log('inputBufferSub[pos[i] + 3]:' + inputBufferSub[pos[i] + 3])


            break;
          //PPS

          case 8:
            //inputBuffer = setBuffer(inputBuffer, PREFIX);
            //inputBuffer = setBuffer(inputBuffer, PAYLOAD);
            ppsSegment = PAYLOAD; //debug.log('PPS:  ' + inputBufferSub.subarray(pos[i] + 3 , pos[i + 1]));

            break;
          //SEI

          case 6:
            break;

          case 9:
            break;
        }
      } //debug.log('endddddddddddddddddddddddddddddd')
      //var inputSegBufferSub;


      if (isBackup && changeModeFlag === false) {
        data.backupData = {
          'stream': new Uint8Array(inputBufferSub),
          'frameType': frameType,
          'width': width,
          'height': height,
          'codecType': 'h264'
        };

        if (timeData.timestamp !== null && typeof timeData.timestamp !== "undefined") {
          data.backupData.timestamp_usec = timeData.timestamp_usec;
        } else {
          data.backupData.timestamp = (rtpTimeStamp / 90).toFixed(0);
        }
      }

      if (decodeMode === "canvas") {
        var curTimeStamp = 1000 * timeData.timestamp + timeData.timestamp_usec; //if (preTimeStamp === null) {
        //preRtpTimeStamp = parseInt((rtpTimeStamp).toFixed(0));
        //return null;
        //} else {
        //    frameDuration = Math.abs(curTimeStamp - preTimeStamp);
        //rtpDuration = Math.abs((rtpTimeStamp).toFixed(0) - preRtpTimeStamp);
        //if (preRtpTimeStamp > (rtpTimeStamp + ticks * 65535)) {
        //    ticks ++;
        // }
        //rtpTimeStamp = ((dhPayload[21] << 8) + dhPayload[20]) + ticks * 65535;
        //preRtpTimeStamp = rtpTimeStamp;
        //}

        if (this.firstDiffTime == 0) {
          delayingTime = 0;
          this.firstDiffTime = Date.now() - curTimeStamp;
          debug.log('firstDiff: ' + firstTime); // needDropCnt = 0;
        } else {
          if (curTimeStamp - preTimeStamp < 0) {
            this.firstDiffTime = delayingTime + (Date.now() - curTimeStamp).toFixed(0);
          }

          delayingTime = Date.now() - curTimeStamp - this.firstDiffTime;

          if (delayingTime < 0) {
            this.firstDiffTime = 0;
            delayingTime = 0;
          } //debug.log('delayingTime: ' + delayingTime)


          if (delayingTime > DELAY_LIMIT) {
            data.error = {
              errorCode: 101 //

            };
            this.rtpReturnCallback(data); //return;
          }
        }

        preTimeStamp = curTimeStamp; //debug.log('frameType:  ' + frameType)

        if (outputSize !== curSize) {
          this.decoder.free(); //如果播放中切换分辨率，需要释放内存（按照ffmpeg要求）

          outputSize = curSize;
          this.decoder.setOutputSize(outputSize);
        } //inputBufferSub = inputBuffer.subarray(0, inputLength);
        //frameType = (inputBufferSub[4] == 0x67) ? 'I' : 'P';


        if (changeModeFlag === true && frameType === 'P') {
          inputLength = 0;
          return;
        } else if (changeModeFlag === true) {
          changeModeFlag = false;
        }

        if (frameType === 'I' && iFrameNum < 2) {
          iFrameNum++;
        }

        decodedData.frameData = null;

        if (isBackup !== true || playback !== true) {
          decodedData.frameData = this.decoder.decode(inputBufferSub); // debug.log('decodingTime: ' + decodedData.frameData.decodingTime)
        }

        decodedData.timeStamp = null;
        inputLength = 0; //将时间戳传递，以供回放的进度条使用
        //if (playback === true) {

        timeData = timeData.timestamp === null ? this.getTimeStamp() : timeData;
        decodedData.timeStamp = timeData; //}
      } else {
        var inputSegBufferSub = null;

        if (!initalSegmentFlag) {
          initalSegmentFlag = true;
          var info = {
            id: 1,
            width: widthSegment,
            height: heightSegment,
            type: 'video',
            profileIdc: SPSParser.getSpsValue("profile_idc"),
            profileCompatibility: 0,
            levelIdc: SPSParser.getSpsValue("level_idc"),
            sps: [spsSegment],
            pps: [ppsSegment],
            timescale: 1000,
            fps: this.getFramerate()
          };
          debug.log(JSON.stringify(info));
          decodedData.initSegmentData = mp4remux.initSegment(info);
          decodedData.codecInfo = SPSParser.getCodecInfo();
        } else {
          decodedData.initSegmentData = null;
        }

        if (!endP) {
          debug.log('11111111111111111111111111111111111111111');
        }

        if (frameType === 'I') {
          //debug.log('I')
          //var h264parameterLength = spsSegment.length + ppsSegment.length + 8;
          var h264parameterLength = endP;
          inputSegBufferSub = inputBufferSub.subarray(h264parameterLength, inputBufferSub.length);
        } else {
          //debug.log('P')
          inputSegBufferSub = inputBufferSub.subarray(endP, inputBufferSub.length);
        }

        var segSize = inputSegBufferSub.length - 4;
        inputSegBufferSub[0] = (segSize & 0xFF000000) >>> 24;
        inputSegBufferSub[1] = (segSize & 0xFF0000) >>> 16;
        inputSegBufferSub[2] = (segSize & 0xFF00) >>> 8;
        inputSegBufferSub[3] = segSize & 0xFF;
        var framerate = this.getFramerate();
        var sample = {
          duration: Math.round(1 / framerate * 1000),
          size: inputSegBufferSub.length,
          frame_time_stamp: null,
          //added
          frameDuration: null //added

        };

        if (playback) {
          sample.frame_time_stamp = rtpTimeStamp;
          decodedData.frameData = new Uint8Array(inputSegBufferSub);
          decodedData.mediaSample = sample; // inputLength = 0;
        } else {
          if (isBackup === false) {
            sample.frame_time_stamp = 1000 * timeData.timestamp + timeData.timestamp_usec - firstTime;

            if (initalMediaFrameFlag === false) {
              sample.frame_time_stamp = 0;
              firstTime = 1000 * timeData.timestamp + timeData.timestamp_usec;
              sample.frameDuration = 0;
              playbackVideoTagTempSample = sample;
              initalMediaFrameFlag = true;
            } else {
              var preFrameTime = playbackVideoTagTempSample.frame_time_stamp;
              var curFrameTime = sample.frame_time_stamp;
              sample.frameDuration = Math.abs(curFrameTime - preFrameTime);

              if (sample.frameDuration > 3000) {
                sample.frameDuration = 0;
              }

              playbackVideoTagTempSample = sample;
            }

            decodedData.frameData = new Uint8Array(inputSegBufferSub);
            decodedData.mediaSample = sample;
          }

          timeData = timeData.timestamp === null ? this.getTimeStamp() : timeData;
          decodedData.timeStamp = timeData;
        }

        inputLength = 0;
      }

      var size = width * height;

      if (playback === true) {
        var speedFlag = (rtpDuration / frameDuration * 100).toFixed(0) < 60;

        if (size > videoTagLimitSize) {
          if (frameDuration < 5000) {
            changeMode("video");
            data.decodeMode = "video";
          } else {
            if (speedFlag === true) {
              changeMode("video");
              data.decodeMode = "video";
            } else {
              changeMode("canvas");
              data.decodeMode = "canvas";
            }
          }
        } else {
          changeMode("canvas");
          data.decodeMode = "canvas";
        }
      }

      decodedData.playback = playback;
      decodedData.frameData.frameIndex = info.frameIndex;
      data.decodedData = decodedData;

      if (errorcheck === true) {
        if (frameType === 'I') {
          errorIFrameNum++;
        }

        if (errorIFrameNum === 2) {
          errorIFrameNum = 0;
          errorcheck = false;
        }

        debug.info("H264Session::stop");
        return;
      } //debug.log('data: ' + data.decodedData.timeStamp)


      this.rtpReturnCallback(data);
      return; //}
    },
    findIFrame: function findIFrame() {
      if (this.videoBufferList !== null) {
        var bufferNode = this.videoBufferList.findIFrame();

        if (bufferNode === null || typeof bufferNode === "undefined") {
          return false;
        } else {
          var data = {};
          this.setTimeStamp(bufferNode.timeStamp);
          data.frameData = this.decoder.decode(bufferNode.buffer);
          data.timeStamp = bufferNode.timeStamp;
          return data;
        }
      }
    },
    setInitSegment: function setInitSegment() {
      initalSegmentFlag = false;
      preInfo = null;
      preCodecInfo = null;
    },
    setLessRate: function setLessRate(state) {
      lessRateCanvas = state;
    }
  };
  return new Constructor();
};

function H264SPSParser() {
  //BITWISE variables for magic number lint error.
  var BITWISE0x00000007 = 0x00000007;
  var BITWISE0x7 = 0x7;
  var BITWISE2 = 2;
  var BITWISE3 = 3;
  var BITWISE4 = 4;
  var BITWISE5 = 5;
  var BITWISE6 = 6;
  var BITWISE8 = 8;
  var BITWISE12 = 12;
  var BITWISE15 = 15;
  var BITWISE16 = 16;
  var BITWISE32 = 32;
  var BITWISE64 = 64;
  var BITWISE255 = 255;
  var BITWISE256 = 256;
  var vBitCount = 0;
  var spsMap = null;

  function Constructor() {
    vBitCount = 0;
    spsMap = new hashMap();
  }

  function getBit(base, offset) {
    var offsetData = offset;
    var vCurBytes = vBitCount + offsetData >> BITWISE3;
    offsetData = vBitCount + offset & BITWISE0x00000007;
    return base[vCurBytes] >> BITWISE0x7 - (offsetData & BITWISE0x7) & 0x1;
  }

  function setBits(pBuf, vSetBits) {
    //sar设为1
    var vCurBytes = vBitCount >> BITWISE3; //取得当前字节

    var vAllBytes = (vCurBytes + 1) * 8; //取得当前字节下所有位数

    var bits = vAllBytes - vBitCount;

    if (bits < 8) {
      // 表示分散在3个字节
      for (var i = 0; i < 3; i++) {
        var tmp = pBuf[vCurBytes + i];

        if (i == 0) {
          //后面bit位置0
          tmp = tmp >> bits << bits;
        } else if (i == 2) {
          tmp = tmp & 0xFF >> 8 - bits | 1 << bits;
        } else {
          tmp = 0; //中间一位直接清0
        }

        pBuf.set([tmp], vCurBytes + i);
      }
    } else {
      // bit = 8 表示分散在2个字节
      pBuf.set([0], vCurBytes);
      pBuf.set([1], vCurBytes + 1);
    }
  }

  function readBits(pBuf, vReadBits) {
    var vOffset = 0;
    var vTmp = 0,
        vTmp2 = 0;

    if (vReadBits === 1) {
      vTmp = getBit(pBuf, vOffset);
    } else {
      for (var i = 0; i < vReadBits; i++) {
        vTmp2 = getBit(pBuf, i);
        vTmp = (vTmp << 1) + vTmp2;
      }
    }

    vBitCount += vReadBits; //debug.log('vTmp: ' + vTmp)

    return vTmp;
  }

  function ue(base, offset) {
    var zeros = 0,
        vTmp = 0,
        vReturn = 0;
    var vIdx = offset;

    while (vBitCount + vIdx < base.length * 8) {
      vTmp = getBit(base, vIdx++);

      if (vTmp) {
        break;
      } else {
        zeros++;
      }
    }

    if (zeros === 0) {
      vBitCount += 1;
      return 0;
    }

    vReturn = 1 << zeros;

    for (var i = zeros - 1; i >= 0; i--, vIdx++) {
      vTmp = getBit(base, vIdx);
      vReturn |= vTmp << i;
    }

    var addBitCount = zeros * BITWISE2 + 1;
    vBitCount += addBitCount;
    return vReturn - 1;
  }

  function se(base, offset) {
    var vReturn = ue(base, offset);

    if (vReturn & 0x1) {
      return (vReturn + 1) / BITWISE2;
    } else {
      return -vReturn / BITWISE2;
    }
  } // function byteAligned() {
  //   if ((vBitCount & 0x00000007) == 0) {
  //     return 1;
  //   } else {
  //     return 0;
  //   }
  // }


  function hrdParameters(pSPSBytes) {
    spsMap.put("cpb_cnt_minus1", ue(pSPSBytes, 0));
    spsMap.put("bit_rate_scale", readBits(pSPSBytes, BITWISE4));
    spsMap.put("cpb_size_scale", readBits(pSPSBytes, BITWISE4));
    var cpdCntMinus1 = spsMap.get("cpb_cnt_minus1");
    var bitRateValueMinus1 = new Array(cpdCntMinus1);
    var cpbSizeValueMinus1 = new Array(cpdCntMinus1);
    var cbrFlag = new Array(cpdCntMinus1);

    for (var i = 0; i <= cpdCntMinus1; i++) {
      bitRateValueMinus1[i] = ue(pSPSBytes, 0);
      cpbSizeValueMinus1[i] = ue(pSPSBytes, 0);
      cbrFlag[i] = readBits(pSPSBytes, 1);
    }

    spsMap.put("bit_rate_value_minus1", bitRateValueMinus1);
    spsMap.put("cpb_size_value_minus1", cpbSizeValueMinus1);
    spsMap.put("cbr_flag", cbrFlag);
    spsMap.put("initial_cpb_removal_delay_length_minus1", readBits(pSPSBytes, BITWISE5));
    spsMap.put("cpb_removal_delay_length_minus1", readBits(pSPSBytes, BITWISE5));
    spsMap.put("dpb_output_delay_length_minus1", readBits(pSPSBytes, BITWISE5));
    spsMap.put("time_offset_length", readBits(pSPSBytes, BITWISE5));
  }

  function vuiParameters(pSPSBytes) {
    spsMap.put("aspect_ratio_info_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("aspect_ratio_info_present_flag")) {
      spsMap.put("aspect_ratio_idc", readBits(pSPSBytes, BITWISE8)); //Extended_SAR

      if (spsMap.get("aspect_ratio_idc") === BITWISE255) {
        setBits(pSPSBytes, BITWISE16);
        spsMap.put("sar_width", readBits(pSPSBytes, BITWISE16));
        setBits(pSPSBytes, BITWISE16);
        spsMap.put("sar_height", readBits(pSPSBytes, BITWISE16));
      }
    }

    spsMap.put("overscan_info_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("overscan_info_present_flag")) {
      spsMap.put("overscan_appropriate_flag", readBits(pSPSBytes, 1));
    }

    spsMap.put("video_signal_type_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("video_signal_type_present_flag")) {
      spsMap.put("video_format", readBits(pSPSBytes, BITWISE3));
      spsMap.put("video_full_range_flag", readBits(pSPSBytes, 1));
      spsMap.put("colour_description_present_flag", readBits(pSPSBytes, 1));

      if (spsMap.get("colour_description_present_flag")) {
        spsMap.put("colour_primaries", readBits(pSPSBytes, BITWISE8));
        spsMap.put("transfer_characteristics", readBits(pSPSBytes, BITWISE8));
        spsMap.put("matrix_coefficients", readBits(pSPSBytes, BITWISE8));
      }
    }

    spsMap.put("chroma_loc_info_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("chroma_loc_info_present_flag")) {
      spsMap.put("chroma_sample_loc_type_top_field", ue(pSPSBytes, 0));
      spsMap.put("chroma_sample_loc_type_bottom_field", ue(pSPSBytes, 0));
    }

    spsMap.put("timing_info_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("timing_info_present_flag")) {
      spsMap.put("num_units_in_tick", readBits(pSPSBytes, BITWISE32));
      spsMap.put("time_scale", readBits(pSPSBytes, BITWISE32));
      spsMap.put("fixed_frame_rate_flag", readBits(pSPSBytes, 1));
    }

    spsMap.put("nal_hrd_parameters_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("nal_hrd_parameters_present_flag")) {
      hrdParameters(pSPSBytes);
    }

    spsMap.put("vcl_hrd_parameters_present_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("vcl_hrd_parameters_present_flag")) {
      hrdParameters(pSPSBytes);
    }

    if (spsMap.get("nal_hrd_parameters_present_flag") || spsMap.get("vcl_hrd_parameters_present_flag")) {
      spsMap.put("low_delay_hrd_flag", readBits(pSPSBytes, 1));
    }

    spsMap.put("pic_struct_present_flag", readBits(pSPSBytes, 1));
    spsMap.put("bitstream_restriction_flag", readBits(pSPSBytes, 1));

    if (spsMap.get("bitstream_restriction_flag")) {
      spsMap.put("motion_vectors_over_pic_boundaries_flag", readBits(pSPSBytes, 1));
      spsMap.put("max_bytes_per_pic_denom", ue(pSPSBytes, 0));
      spsMap.put("max_bits_per_mb_denom", ue(pSPSBytes, 0)); //spsMap.put("log2_max_mv_length_horizontal", ue(pSPSBytes, 0));
      //spsMap.put("log2_max_mv_length_vertical", ue(pSPSBytes, 0));
      //spsMap.put("max_num_reorder_frames", ue(pSPSBytes, 0));
      //spsMap.put("max_dec_frame_buffering", ue(pSPSBytes, 0));
    }
  }

  Constructor.prototype = {
    parse: function parse(pSPSBytes) {
      //debug.log("=========================SPS START=========================");
      vBitCount = 0;
      spsMap.clear(); // forbidden_zero_bit, nal_ref_idc, nal_unit_type

      spsMap.put("forbidden_zero_bit", readBits(pSPSBytes, 1));
      spsMap.put("nal_ref_idc", readBits(pSPSBytes, BITWISE2));
      spsMap.put("nal_unit_type", readBits(pSPSBytes, BITWISE5)); // profile_idc

      spsMap.put("profile_idc", readBits(pSPSBytes, BITWISE8));
      spsMap.put("profile_compatibility", readBits(pSPSBytes, BITWISE8)); // spsMap.put("constrained_set0_flag", readBits(pSPSBytes, 1));
      // spsMap.put("constrained_set1_flag", readBits(pSPSBytes, 1));
      // spsMap.put("constrained_set2_flag", readBits(pSPSBytes, 1));
      // spsMap.put("constrained_set3_flag", readBits(pSPSBytes, 1));
      // spsMap.put("constrained_set4_flag", readBits(pSPSBytes, 1));
      // spsMap.put("constrained_set5_flag", readBits(pSPSBytes, 1));
      // spsMap.put("reserved_zero_2bits", readBits(pSPSBytes, 2));
      // level_idc

      spsMap.put("level_idc", readBits(pSPSBytes, BITWISE8));
      spsMap.put("seq_parameter_set_id", ue(pSPSBytes, 0));
      var profileIdc = spsMap.get("profile_idc");
      var BITWISE100 = 100;
      var BITWISE110 = 110;
      var BITWISE122 = 122;
      var BITWISE244 = 244;
      var BITWISE44 = 44;
      var BITWISE83 = 83;
      var BITWISE86 = 86;
      var BITWISE118 = 118;
      var BITWISE128 = 128;
      var BITWISE138 = 138;
      var BITWISE139 = 139;
      var BITWISE134 = 134;

      if (profileIdc === BITWISE100 || profileIdc === BITWISE110 || profileIdc === BITWISE122 || profileIdc === BITWISE244 || profileIdc === BITWISE44 || profileIdc === BITWISE83 || profileIdc === BITWISE86 || profileIdc === BITWISE118 || profileIdc === BITWISE128 || profileIdc === BITWISE138 || profileIdc === BITWISE139 || profileIdc === BITWISE134) {
        spsMap.put("chroma_format_idc", ue(pSPSBytes, 0));

        if (spsMap.get("chroma_format_idc") === BITWISE3) {
          spsMap.put("separate_colour_plane_flag", readBits(pSPSBytes, 1));
        }

        spsMap.put("bit_depth_luma_minus8", ue(pSPSBytes, 0));
        spsMap.put("bit_depth_chroma_minus8", ue(pSPSBytes, 0));
        spsMap.put("qpprime_y_zero_transform_bypass_flag", readBits(pSPSBytes, 1));
        spsMap.put("seq_scaling_matrix_present_flag", readBits(pSPSBytes, 1));

        if (spsMap.get("seq_scaling_matrix_present_flag")) {
          var num = spsMap.get("chroma_format_idc") !== BITWISE3 ? BITWISE8 : BITWISE12;
          var seqScalingListPresentFlag = new Array(num);

          for (var i = 0; i < num; i++) {
            seqScalingListPresentFlag[i] = readBits(pSPSBytes, 1);

            if (seqScalingListPresentFlag[i]) {
              var slNumber = i < BITWISE6 ? BITWISE16 : BITWISE64;
              var lastScale = 8;
              var nextScale = 8;
              var deltaScale = 0;

              for (var j = 0; j < slNumber; j++) {
                if (nextScale) {
                  deltaScale = se(pSPSBytes, 0);
                  nextScale = (lastScale + deltaScale + BITWISE256) % BITWISE256;
                }

                lastScale = nextScale === 0 ? lastScale : nextScale;
              }
            }
          }

          spsMap.put("seq_scaling_list_present_flag", seqScalingListPresentFlag);
        }
      }

      spsMap.put("log2_max_frame_num_minus4", ue(pSPSBytes, 0));
      spsMap.put("pic_order_cnt_type", ue(pSPSBytes, 0));

      if (spsMap.get("pic_order_cnt_type") === 0) {
        spsMap.put("log2_max_pic_order_cnt_lsb_minus4", ue(pSPSBytes, 0));
      } else if (spsMap.get("pic_order_cnt_type") === 1) {
        spsMap.put("delta_pic_order_always_zero_flag", readBits(pSPSBytes, 1));
        spsMap.put("offset_for_non_ref_pic", se(pSPSBytes, 0));
        spsMap.put("offset_for_top_to_bottom_field", se(pSPSBytes, 0));
        spsMap.put("num_ref_frames_in_pic_order_cnt_cycle", ue(pSPSBytes, 0));

        for (var numR = 0; numR < spsMap.get("num_ref_frames_in_pic_order_cnt_cycle"); numR++) {
          spsMap.put("num_ref_frames_in_pic_order_cnt_cycle", se(pSPSBytes, 0));
        }
      }

      spsMap.put("num_ref_frames", ue(pSPSBytes, 0));
      spsMap.put("gaps_in_frame_num_value_allowed_flag", readBits(pSPSBytes, 1));
      spsMap.put("pic_width_in_mbs_minus1", ue(pSPSBytes, 0));
      spsMap.put("pic_height_in_map_units_minus1", ue(pSPSBytes, 0));
      spsMap.put("frame_mbs_only_flag", readBits(pSPSBytes, 1));

      if (spsMap.get("frame_mbs_only_flag") === 0) {
        spsMap.put("mb_adaptive_frame_field_flag", readBits(pSPSBytes, 1));
      }

      spsMap.put("direct_8x8_interence_flag", readBits(pSPSBytes, 1));
      spsMap.put("frame_cropping_flag", readBits(pSPSBytes, 1));

      if (spsMap.get("frame_cropping_flag") === 1) {
        spsMap.put("frame_cropping_rect_left_offset", ue(pSPSBytes, 0));
        spsMap.put("frame_cropping_rect_right_offset", ue(pSPSBytes, 0));
        spsMap.put("frame_cropping_rect_top_offset", ue(pSPSBytes, 0));
        spsMap.put("frame_cropping_rect_bottom_offset", ue(pSPSBytes, 0));
      } //vui parameters


      spsMap.put("vui_parameters_present_flag", readBits(pSPSBytes, 1));

      if (spsMap.get("vui_parameters_present_flag")) {
        vuiParameters(pSPSBytes);
      } //debug.log("=========================SPS END=========================");


      return true;
    },
    getSizeInfo: function getSizeInfo() {
      var SubWidthC = 0;
      var SubHeightC = 0;

      if (spsMap.get("chroma_format_idc") === 0) {
        //monochrome
        SubWidthC = SubHeightC = 0;
      } else if (spsMap.get("chroma_format_idc") === 1) {
        //4:2:0
        SubWidthC = SubHeightC = BITWISE2;
      } else if (spsMap.get("chroma_format_idc") === BITWISE2) {
        //4:2:2
        SubWidthC = BITWISE2;
        SubHeightC = 1;
      } else if (spsMap.get("chroma_format_idc") === BITWISE3) {
        //4:4:4
        if (spsMap.get("separate_colour_plane_flag") === 0) {
          SubWidthC = SubHeightC = 1;
        } else if (spsMap.get("separate_colour_plane_flag") === 1) {
          SubWidthC = SubHeightC = 0;
        }
      }

      var PicWidthInMbs = spsMap.get("pic_width_in_mbs_minus1") + 1;
      var PicHeightInMapUnits = spsMap.get("pic_height_in_map_units_minus1") + 1;
      var FrameHeightInMbs = (BITWISE2 - spsMap.get("frame_mbs_only_flag")) * PicHeightInMapUnits;
      var cropLeft = 0;
      var cropRight = 0;
      var cropTop = 0;
      var cropBottom = 0;

      if (spsMap.get("frame_cropping_flag") === 1) {
        cropLeft = spsMap.get("frame_cropping_rect_left_offset");
        cropRight = spsMap.get("frame_cropping_rect_right_offset");
        cropTop = spsMap.get("frame_cropping_rect_top_offset");
        cropBottom = spsMap.get("frame_cropping_rect_bottom_offset");
      }

      var decodeSize = PicWidthInMbs * BITWISE16 * (FrameHeightInMbs * BITWISE16);
      var width = PicWidthInMbs * BITWISE16 - SubWidthC * (cropLeft + cropRight);
      var height = FrameHeightInMbs * BITWISE16 - SubHeightC * (BITWISE2 - spsMap.get("frame_mbs_only_flag")) * (cropTop + cropBottom);
      var sizeInfo = {
        'width': width,
        'height': height,
        'decodeSize': decodeSize
      };
      return sizeInfo;
    },
    getSpsValue: function getSpsValue(key) {
      return spsMap.get(key);
    },
    getCodecInfo: function getCodecInfo() {
      var profileIdc = spsMap.get("profile_idc").toString(BITWISE16);
      var profileCompatibility = spsMap.get("profile_compatibility") < BITWISE15 ? "0" + spsMap.get("profile_compatibility").toString(BITWISE16) : spsMap.get("profile_compatibility").toString(BITWISE16);
      var levelIdc = spsMap.get("level_idc").toString(BITWISE16); //debug.log("getCodecInfo = " + (profile_idc + profile_compatibility + level_idc));

      return profileIdc + profileCompatibility + levelIdc;
    }
  };
  return new Constructor();
}

/* harmony default export */ var h264Session = (h264Session_H264Session);
// CONCATENATED MODULE: ./src/Decode/h265Decoder.js


function H265Decoder() {
  var initDecoder = null;
  var decoderContext = null;
  var outpic = new Uint8Array();
  var ID = 265;
  var isFirstIFrame = false;
  var copyOutput;
  var beforeDecoding;
  var data;
  var frame;
  var decodingTime;
  var height;
  var ylen;
  var frameData;
  var outpicsize;
  var outpicptr;

  function Constructor() {
    decoderContext = Module._OpenDecoder(1, 0, 0);
    Constructor.prototype.setIsFirstFrame(false);
  }

  Constructor.prototype = {
    init: function init() {
      debug.log("H265 Decoder init");
    },
    setOutputSize: function setOutputSize(size) {
      if (outpicsize != size * 1.5) {
        outpicsize = size * 1.5;
        outpicptr = Module._malloc(outpicsize);
        outpic = new Uint8Array(Module.HEAPU8.buffer, outpicptr, outpicsize);
      }
    },
    decode: function decode(inputBufferSub, frameType) {
      beforeDecoding = Date.now();
      data = new Uint8Array(inputBufferSub);
      outpic.set(data);
      frame = Module._FrameAlloc();

      Module._DecodeFrame(decoderContext, outpic.byteOffset, inputBufferSub.byteLength, outpicsize, frame);

      decodingTime = Date.now() - beforeDecoding; //width = Module._getWidth(frame);

      ylen = Module._getYLength(frame);
      height = Module._getHeight(frame);

      if (!Constructor.prototype.isFirstFrame()) {
        Constructor.prototype.setIsFirstFrame(true);
        return {
          'firstFrame': true
        };
      }

      if (ylen > 0 && height > 0) {
        beforeDecoding = Date.now();
        var copyOutput = new Uint8Array(outpic); //console.log('decodingTime=' + decodingTime + ':::::initTime' + (Date.now() - beforeDecoding) + ':::::copyOutput.Length=' + copyOutput.byteLength);

        frameData = {
          'data': copyOutput,
          'option': {
            'yaddr': Module._getY(frame),
            'uaddr': Module._getU(frame),
            'vaddr': Module._getV(frame),
            'ylen': ylen,
            'height': height,
            'beforeDecoding': beforeDecoding
          },
          'width': ylen,
          'height': height,
          'codecType': 'h265',
          'decodingTime': decodingTime,
          'frameType': frameType
        };

        Module._FrameFree(frame);

        return frameData;
      }
    },
    setIsFirstFrame: function setIsFirstFrame(flag) {
      isFirstIFrame = flag;
    },
    isFirstFrame: function isFirstFrame() {
      return isFirstIFrame;
    },
    free: function free() {
      Module._free(outpicptr);

      outpicptr = null;
    }
  };
  return new Constructor();
}

/* harmony default export */ var h265Decoder = (H265Decoder);
// CONCATENATED MODULE: ./src/h265Session.js
/* exported H265Session */

/* global Uint8Array, H265SPSParser, H265Decoder, inheritObject,
 RtpSession, VideoBufferList, ArrayBuffer, decodeMode */

/* eslint-disable no-magic-numbers */




var h265Session_H265Session = function H265Session() {
  var rtpTimeStamp = 0,
      preRtpTimeStamp = 0,
      inputLength = 0,
      playback = false,
      outputSize = 0,
      curSize = 0,
      SPSParser = new H265SPSParser(),
      decodedData = {
    frameData: null,
    timeStamp: null
  },
      timeData = {
    'timestamp': null,
    'timezone': null
  };
  var width = 0,
      height = 0;
  var inputBufferSub;
  var govLength = null;
  var dropPer = 0;
  var dropCount = 0;
  var frameRate = 0;
  var ticks = 0;
  var firstTime = 0;
  var resolution = {
    width: 0,
    height: 0
  };
  var delayingTime = 0;
  var DELAY_LIMIT = 8000;
  var preTimeStamp = 0;

  function Constructor() {
    this.decoder = h265Decoder();
    this.firstTime = 0;
    this.lastMSW = 0;
  }

  Constructor.prototype = {
    setReturnCallback: function setReturnCallback(RtpReturn) {
      this.rtpReturnCallback = RtpReturn;
    },
    setBufferfullCallback: function setBufferfullCallback(bufferFull) {
      if (this.videoBufferList !== null) {
        this.videoBufferList.setBufferFullCallback(bufferFull);
      }
    },
    getVideoBuffer: function getVideoBuffer(idx) {
      if (this.videoBufferList !== null) {
        return this.videoBufferList.searchNodeAt(idx);
        /*this.videoBufferList.getCurIdx()*/
      }
    },
    clearBuffer: function clearBuffer() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.clear();
      }
    },
    findCurrent: function findCurrent() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.searchTimestamp(this.getTimeStamp());
      }
    },
    ntohl: function ntohl(buffer) {
      return (buffer[0] << 24) + (buffer[1] << 16) + (buffer[2] << 8) + buffer[3] >>> 0;
    },
    appendBuffer: function appendBuffer(currentBuffer, newBuffer, readLength) {
      var BUFFER_SIZE = 1024 * 1024;

      if (readLength + newBuffer.length >= currentBuffer.length) {
        var tmp = new Uint8Array(currentBuffer.length + BUFFER_SIZE);
        tmp.set(currentBuffer, 0);
        currentBuffer = tmp;
      }

      currentBuffer.set(newBuffer, readLength);
      return currentBuffer;
    },
    setGovLength: function setGovLength(_govLength) {
      govLength = _govLength;
    },
    getGovLength: function getGovLength() {
      return govLength;
    },
    setDecodingTime: function setDecodingTime(time) {
      this.decodingTime = time;
    },
    getDropPercent: function getDropPercent() {
      return dropPer;
    },
    getDropCount: function getDropCount() {
      return dropCount;
    },
    initStartTime: function initStartTime() {
      this.firstDiffTime = 0;
      this.calcGov = 0;
    },
    setCheckDelay: function setCheckDelay(checkDelay) {
      this.checkDelay = checkDelay;
    },
    init: function init() {
      this.decoder.setIsFirstFrame(false);
      this.videoBufferList = new VideoBufferList();
      this.firstDiffTime = 0;
      this.checkDelay = true;
      this.timeData = null;
    },
    parseRTPData: function parseRTPData(rtspInterleaved, dhPayload, isBackup, dropout, info) {
      var PAYLOAD = null,
          data = {};
      var time = (dhPayload[19] << 24) + (dhPayload[18] << 16) + (dhPayload[17] << 8) + dhPayload[16] >>> 0;
      var lsw = Date.UTC('20' + (time >>> 26), (time >>> 22 & 0x0f) - 1, time >>> 17 & 0x1f, time >>> 12 & 0x1f, time >>> 6 & 0x3f, time & 0x3f) / 1000;
      lsw = lsw + new Date().getTimezoneOffset() / 60 * 3600;

      if (this.firstTime == 0) {
        //第一次
        this.firstTime = lsw; //系统时间精确到秒

        this.lastMSW = 0;
        preRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        timeData = {
          timestamp: this.firstTime,
          timestamp_usec: 0
        };
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
        timeData = {
          timestamp: lsw,
          timestamp_usec: this.lastMSW
        };
        preRtpTimeStamp = currentRtpTimeStamp;
      }

      if ((this.getFramerate() === 0 || typeof this.getFramerate() === 'undefined') && typeof this.getTimeStamp() !== 'undefined') {
        this.setFramerate(Math.round(1000 / ((timeData.timestamp - this.getTimeStamp().timestamp === 0 ? 0 : 1000) + (timeData.timestamp_usec - this.getTimeStamp().timestamp_usec))));
        debug.log('setFramerate' + Math.round(1000 / ((timeData.timestamp - this.getTimeStamp().timestamp === 0 ? 0 : 1000) + (timeData.timestamp_usec - this.getTimeStamp().timestamp_usec))));
      }

      this.setTimeStamp(timeData);
      var extenLen = dhPayload[22];
      inputBufferSub = dhPayload.subarray(24 + extenLen, dhPayload.length - 8);
      rtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
      var pos = [];

      for (var i = 0; i <= inputBufferSub.length;) {
        //遍历整个payload最后一个001的位置是115
        if (inputBufferSub[i] == 0) {
          // 0
          if (inputBufferSub[i + 1] == 0) {
            //00
            if (inputBufferSub[i + 2] == 1) {
              //001
              pos.push(i);
              i = i + 3;

              if ((inputBufferSub[i] & 0x1f) == 5 || (inputBufferSub[i] & 0x1f) == 1) {
                //debug.log('break');
                break;
              }
            } else if (inputBufferSub[i + 2] == 0) {
              // i = 000时i向右移动一位
              i++;
            } else {
              // i = 00x时i向右移动3位
              i = i + 3;
            }
          } else {
            // i!= 00时候向右移动2位
            i = i + 2;
          }
        } else {
          // i != 0时向右移动1位
          i = i + 1;
        }
      }

      var frameType = 'P';
      var nalType;

      for (var i = 0; i < pos.length; i++) {
        PAYLOAD = inputBufferSub.subarray(pos[i] + 3, pos[i + 1]);
        nalType = inputBufferSub[pos[i] + 3] >> 1 & 0x3F; //debug.log('nalType: ' +  nalType +  ' : ' + inputBufferSub[pos[i] + 3])

        switch (nalType) {
          default:
            break;
          //SPS

          case 33:
            frameType = 'I';
            SPSParser.parse2(PAYLOAD); //debug.log(SPSParser.getSizeInfo())
            //var sizeInfo = SPSParser.getSizeInfo();

            var sizeInfo = info; //var sizeInfo = {
            //    width: info.width,
            //    height: info.height
            //};
            //debug.log(sizeInfo)

            curSize = SPSParser.getSizeInfo().decodeSize;
            width = sizeInfo.width;
            height = sizeInfo.height;

            if (resolution.width != sizeInfo.width || resolution.height != sizeInfo.height) {
              //this.decoder.setIsFirstFrame(false);
              if (resolution.width != 0) {
                resolution.width = sizeInfo.width;
                resolution.height = sizeInfo.height;
                data.resolution = resolution;
                data.resolution.decodeMode = 'canvas'; //分辨率改变后计算播放模式

                data.resolution.encodeMode = 'h265';
              } else {
                resolution.width = sizeInfo.width;
                resolution.height = sizeInfo.height;
                data.decodeStart = resolution;
                data.decodeStart.decodeMode = 'canvas';
                data.decodeStart.encodeMode = 'h265';
              }
            }

            break;
        } //end of switch(nalType)

      }

      var curTimeStamp = 1000 * timeData.timestamp + timeData.timestamp_usec;

      if (this.firstDiffTime == 0) {
        delayingTime = 0;
        this.firstDiffTime = Date.now() - curTimeStamp;
        debug.log('firstDiff: ' + firstTime); // needDropCnt = 0;
      } else {
        if (curTimeStamp - preTimeStamp < 0) {
          this.firstDiffTime = delayingTime + (Date.now() - curTimeStamp).toFixed(0);
        }

        delayingTime = Date.now() - curTimeStamp - this.firstDiffTime;

        if (delayingTime < 0) {
          this.firstDiffTime = 0;
          delayingTime = 0;
        } //debug.log('delayingTime: ' + delayingTime)


        if (delayingTime > DELAY_LIMIT) {
          //如果大于了最大延迟
          data.error = {
            errorCode: 101 //

          };
          this.rtpReturnCallback(data); //return;
        }
      }

      preTimeStamp = curTimeStamp;
      decodedData.frameData = null;

      if (outputSize !== curSize) {
        this.decoder.free(); //如果播放中切换分辨率，需要释放内存（按照ffmpeg要求）

        outputSize = curSize;
        this.decoder.setOutputSize(outputSize);
      }

      if (isBackup !== true || playback !== true) {
        decodedData.frameData = this.decoder.decode(inputBufferSub);
        decodedData.frameData.frameType = frameType;
        decodedData.frameData.frameIndex = info.frameIndex; // 帧序号
      }

      decodedData.timeStamp = null;
      inputLength = 0; //将时间戳传递，以供回放的进度条使用
      //if (playback === true) {

      timeData = timeData.timestamp === null ? this.getTimeStamp() : timeData;
      decodedData.timeStamp = timeData; //}

      if (isBackup) {
        data.backupData = {
          'stream': inputBufferSub,
          'frameType': frameType,
          'width': width,
          'height': height,
          'codecType': 'h265'
        };

        if (timeData.timestamp !== null && typeof timeData.timestamp !== "undefined") {
          data.backupData.timestamp_usec = timeData.timestamp_usec;
        } else {
          data.backupData.timestamp = (rtpTimeStamp / 90).toFixed(0);
        }
      }

      data.decodedData = decodedData; //切换播放模式做到外部业务层
      //if (decodeMode !== "canvas") {
      //    data.decodeMode = "canvas";
      //}

      this.rtpReturnCallback(data);
      return; // data;
    },
    findIFrame: function findIFrame() {
      if (this.videoBufferList !== null) {
        var bufferNode = this.videoBufferList.findIFrame();

        if (bufferNode === null || typeof bufferNode === "undefined") {
          return false;
        } else {
          var data = {};
          this.setTimeStamp(bufferNode.timeStamp);
          data.frameData = this.decoder.decode(bufferNode.buffer);
          data.timeStamp = bufferNode.timeStamp;
          return data;
        }
      }
    },
    getFramerate: function getFramerate() {
      return frameRate;
    },
    setFramerate: function setFramerate(framerate) {
      if (0 < framerate && typeof framerate !== "undefined") {
        frameRate = framerate;

        if (this.videoBufferList !== null) {
          this.videoBufferList.setMaxLength(frameRate * 6);
          this.videoBufferList.setBUFFERING(frameRate * 4);
        }
      }
    },
    getTimeStamp: function getTimeStamp() {
      return this.timeData;
    },
    setTimeStamp: function setTimeStamp(data) {
      this.timeData = data;
    }
  };
  return new Constructor();
};
/* eslint-enable no-magic-numbers */


"use strict";

function H265SPSParser() {
  var vBitCount = 0;
  var spsMap = null;
  var pSPSBytes = null;
  var m_data = null;
  var m_len = 0;
  var m_idx = 0;
  var m_bits = 0;
  var m_byte = 0;
  var m_zeros = 0;

  function Constructor() {
    vBitCount = 0;
    spsMap = new hashMap();
  }

  function GetBYTE() {
    if (m_idx >= m_len) return 0;
    var b = m_data[m_idx++];

    if (b == 0) {
      m_zeros++;

      if (m_idx < m_len && m_zeros == 2 && m_data[m_idx] == 0x03) {
        m_idx++;
        m_zeros = 0;
      }
    } else m_zeros = 0;

    return b;
  }

  function get_bit(base, offset) {
    var vCurBytes = vBitCount + offset >> 3;
    offset = vBitCount + offset & 0x00000007;
    return base[vCurBytes] >> 0x7 - (offset & 0x7) & 0x1;
  }

  function GetBit() {
    if (m_bits == 0) {
      m_byte = GetBYTE();
      m_bits = 8;
    }

    m_bits--;
    return m_byte >> m_bits & 0x1;
  }

  function read_bits(pBuf, bits) {
    //var vCurBytes = vBitCount / 8;
    //var vCurBits = vBitCount % 8;
    //var vOffset = 0;
    //var vTmp = 0,
    //    vTmp2 = 0;
    //
    //if (vReadBits == 1) {
    //    vTmp = get_bit(pBuf, vOffset);
    //} else {
    //    for (var i = 0; i < vReadBits; i++) {
    //        vTmp2 = get_bit(pBuf, i);
    //        vTmp = (vTmp << 1) + vTmp2;
    //    }
    //}
    //
    //vBitCount += vReadBits;
    //return vTmp;
    var u = 0;

    while (bits > 0) {
      u <<= 1;
      u |= GetBit();
      bits--;
    }

    return u;
  }

  function ue(base, offset) {
    //var zeros = 0,
    //    vTmp = 0,
    //    vReturn = 0;
    //var vIdx = offset;
    //do {
    //    vTmp = get_bit(base, vIdx++);
    //    if (vTmp == 0)
    //        zeros++;
    //} while (0 == vTmp);
    //
    //if (zeros == 0) {
    //    vBitCount += 1;
    //    return 0;
    //}
    //
    //// insert first 1 bit
    //vReturn = 1 << zeros;
    //
    //for (var i = zeros - 1; i >= 0; i-- , vIdx++) {
    //    vTmp = get_bit(base, vIdx);
    //    vReturn |= vTmp << i;
    //}
    //
    //vBitCount += zeros * 2 + 1;
    //
    //return (vReturn - 1);
    var zeros = 0;

    while (m_idx < m_len && GetBit() == 0) {
      zeros++;
    }

    return read_bits(null, zeros) + ((1 << zeros) - 1);
  }

  function se(base, offset) {
    var vReturn = ue(base, offset);

    if (vReturn & 0x1) {
      return (vReturn + 1) / 2;
    } else {
      return -vReturn / 2;
    }
  }

  function byte_aligned() {
    if ((vBitCount & 0x00000007) == 0) return 1;else return 0;
  }

  function profile_tier_level(profilePresentFlag, maxNumSubLayersMinus1) {
    if (profilePresentFlag) {
      spsMap.put("general_profile_space", read_bits(pSPSBytes, 2));
      spsMap.put("general_tier_flag", read_bits(pSPSBytes, 1));
      spsMap.put("general_profile_idc", read_bits(pSPSBytes, 5));
      var generalProfileCompatibilityFlag = new Array(32);

      for (var j = 0; j < 32; j++) {
        generalProfileCompatibilityFlag[j] = read_bits(pSPSBytes, 1);
      }

      spsMap.put("general_progressive_source_flag", read_bits(pSPSBytes, 1));
      spsMap.put("general_interlaced_source_flag", read_bits(pSPSBytes, 1));
      spsMap.put("general_non_packed_constraint_flag", read_bits(pSPSBytes, 1));
      spsMap.put("general_frame_only_constraint_flag", read_bits(pSPSBytes, 1));
      var generalProfileIdc = spsMap.get("general_profile_idc");

      if (generalProfileIdc === 4 || generalProfileCompatibilityFlag[4] || generalProfileIdc === 5 || generalProfileCompatibilityFlag[5] || generalProfileIdc === 6 || generalProfileCompatibilityFlag[6] || generalProfileIdc === 7 || generalProfileCompatibilityFlag[7] || generalProfileIdc === 8 || generalProfileCompatibilityFlag[8] || generalProfileIdc === 9 || generalProfileCompatibilityFlag[9] || generalProfileIdc === 10 || generalProfileCompatibilityFlag[10]) {
        spsMap.put("general_max_12bit_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_max_10bit_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_max_8bit_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_max_422chroma_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_max_420chroma_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_max_monochrome_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_intra_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_one_picture_only_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("general_lower_bit_rate_constraint_flag", read_bits(pSPSBytes, 1)); //spsMap.put("general_reserved_zero_34bits", read_bits(pSPSBytes, 34));

        if (generalProfileIdc === 5 || generalProfileCompatibilityFlag[5] || generalProfileIdc === 9 || generalProfileCompatibilityFlag[9] || generalProfileIdc === 10 || generalProfileCompatibilityFlag[10]) {
          spsMap.put("general_max_14bit_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("general_reserved_zero_33bits", read_bits(pSPSBytes, 33));
        } else {
          spsMap.put("general_reserved_zero_34bits", read_bits(pSPSBytes, 34));
        }
      } else {
        spsMap.put("general_reserved_zero_43bits", read_bits(pSPSBytes, 43));
      }

      if (generalProfileIdc >= 1 && generalProfileIdc <= 5 || generalProfileCompatibilityFlag[1] || generalProfileCompatibilityFlag[2] || generalProfileCompatibilityFlag[3] || generalProfileCompatibilityFlag[4] || generalProfileCompatibilityFlag[5] || generalProfileCompatibilityFlag[9]) {
        /* The number of bits in this syntax structure is not affected by this condition */
        spsMap.put("general_inbld_flag", read_bits(pSPSBytes, 1));
      } else {
        spsMap.put("general_reserved_zero_bit", read_bits(pSPSBytes, 1));
      }
    }

    spsMap.put("general_level_idc", read_bits(pSPSBytes, 8));
    var subLayerProfilePresentFlag = new Array(maxNumSubLayersMinus1);
    var subLayerLevelPresentFlag = new Array(maxNumSubLayersMinus1);

    for (i = 0; i < maxNumSubLayersMinus1; i++) {
      subLayerProfilePresentFlag[i] = read_bits(pSPSBytes, 1);
      subLayerLevelPresentFlag[i] = read_bits(pSPSBytes, 1);
    }

    var reservedZero2bits = new Array(8);
    var subLayerProfileIdc = new Array(maxNumSubLayersMinus1);
    var subLayerProfileSpace = new Array(maxNumSubLayersMinus1);
    var subLayerTierFlag = new Array(maxNumSubLayersMinus1);
    var subLayerProfileCompatibilityFlag = [];
    var subLayerReservedZero34bits = new Array(maxNumSubLayersMinus1);

    if (maxNumSubLayersMinus1 > 0) {
      for (var i = maxNumSubLayersMinus1; i < 8; i++) {
        reservedZero2bits[i] = read_bits(pSPSBytes, 2);
      }
    }

    for (var i = 0; i < maxNumSubLayersMinus1; i++) {
      if (subLayerProfilePresentFlag[i]) {
        subLayerProfileSpace[i] = read_bits(pSPSBytes, 2);
        subLayerTierFlag[i] = read_bits(pSPSBytes, 1);
        subLayerProfileIdc[i] = read_bits(pSPSBytes, 5);

        for (var j = 0; j < 32; j++) {
          subLayerProfileCompatibilityFlag[i][j] = read_bits(pSPSBytes, 1);
        }

        spsMap.put("sub_layer_progressive_source_flag", read_bits(pSPSBytes, 1));
        spsMap.put("sub_layer_interlaced_source_flag", read_bits(pSPSBytes, 1));
        spsMap.put("sub_layer_non_packed_constraint_flag", read_bits(pSPSBytes, 1));
        spsMap.put("sub_layer_frame_only_constraint_flag", read_bits(pSPSBytes, 1));

        if (subLayerProfileIdc[i] === 4 || subLayerProfileCompatibilityFlag[i][4] || subLayerProfileIdc[i] === 5 || subLayerProfileCompatibilityFlag[i][5] || subLayerProfileIdc[i] === 6 || subLayerProfileCompatibilityFlag[i][6] || subLayerProfileIdc[i] === 7 || subLayerProfileCompatibilityFlag[i][7] || subLayerProfileIdc[i] === 8 || subLayerProfileCompatibilityFlag[i][8] || subLayerProfileIdc[i] === 9 || subLayerProfileCompatibilityFlag[i][9] || subLayerProfileIdc[i] === 10 || subLayerProfileCompatibilityFlag[i][10]) {
          /* The number of bits in this syntax structure is not affected by this condition */
          spsMap.put("sub_layer_max_12bit_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_max_10bit_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_max_8bit_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_max_422chroma_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_max_420chroma_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_max_monochrome_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_intra_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_one_picture_only_constraint_flag", read_bits(pSPSBytes, 1));
          spsMap.put("sub_layer_lower_bit_rate_constraint_flag", read_bits(pSPSBytes, 1)); //spsMap.put("sub_layer_reserved_zero_34bits", read_bits(pSPSBytes, 34));

          if (subLayerProfileIdc[i] === 5 || subLayerProfileCompatibilityFlag[i][5]) {
            spsMap.put("sub_layer_max_14bit_constraint_flag", read_bits(pSPSBytes, 1));
            spsMap.put("sub_layer_lower_bit_rate_constraint_flag", read_bits(pSPSBytes, 1));
            subLayerReservedZero34bits[i] = read_bits(pSPSBytes, 33);
          } else {
            subLayerReservedZero34bits[i] = read_bits(pSPSBytes, 34);
          }
        } else {
          spsMap.put("sub_layer_reserved_zero_43bits", read_bits(pSPSBytes, 43));
        }

        if (subLayerProfileIdc[i] >= 1 && subLayerProfileIdc[i] <= 5 || subLayerProfileIdc[i] == 9 || subLayerProfileCompatibilityFlag[1] || subLayerProfileCompatibilityFlag[2] || subLayerProfileCompatibilityFlag[3] || subLayerProfileCompatibilityFlag[4] || subLayerProfileCompatibilityFlag[5] || subLayerProfileCompatibilityFlag[9]) {
          /* The number of bits in this syntax structure is not affected by this condition */
          spsMap.put("sub_layer_inbld_flag", read_bits(pSPSBytes, 1));
        } else {
          spsMap.put("sub_layer_reserved_zero_bit", read_bits(pSPSBytes, 1));
        }
      }

      if (subLayerLevelPresentFlag[i]) {
        spsMap.put("sub_layer_level_idc", read_bits(pSPSBytes, 8));
      }
    }
  }

  Constructor.prototype = {
    parse: function parse(spsPayload) {
      pSPSBytes = spsPayload; //debug.log("=========================SPS START=========================");

      vBitCount = 0;
      spsMap.clear();
      spsMap.put("forbidden_zero_bit", read_bits(pSPSBytes, 1));
      spsMap.put("nal_unit_type", read_bits(pSPSBytes, 6));
      spsMap.put("nuh_layer_id", read_bits(pSPSBytes, 6));
      spsMap.put("nuh_temporal_id_plus1", read_bits(pSPSBytes, 3));
      spsMap.put("sps_video_parameter_set_id", read_bits(pSPSBytes, 4));

      if (spsMap.get("nuh_layer_id") === 0) {
        spsMap.put("sps_max_sub_layers_minus1", read_bits(pSPSBytes, 3));
      } else {
        spsMap.put("sps_ext_or_max_sub_layers_minus1", read_bits(pSPSBytes, 3));
      }

      var MultiLayerExtSpsFlag = spsMap.get("nuh_layer_id") !== 0 && spsMap.get("sps_ext_or_max_sub_layers_minus1") === 7;

      if (!MultiLayerExtSpsFlag) {
        spsMap.put("sps_max_sub_layers_minus1", read_bits(pSPSBytes, 1));
        profile_tier_level(1, spsMap.get("sps_max_sub_layers_minus1"));
      } //H265偏移84位，smart265偏移136位，原因未知


      read_bits(pSPSBytes, 84); //read_bits(pSPSBytes, 136);

      spsMap.put("sps_seq_parameter_set_id", ue(pSPSBytes, 0));

      if (MultiLayerExtSpsFlag) {
        spsMap.put("update_rep_format_flag", read_bits(pSPSBytes, 1));

        if (spsMap.get("update_rep_format_flag")) {
          spsMap.put("sps_rep_format_idx", read_bits(pSPSBytes, 8));
        }
      } else {
        spsMap.put("chroma_format_idc", ue(pSPSBytes, 0));

        if (spsMap.get("chroma_format_idc") === 3) {
          spsMap.put("separate_colour_plane_flag", read_bits(pSPSBytes, 1));
        }

        spsMap.put("pic_width_in_luma_samples", ue(pSPSBytes, 0));
        spsMap.put("pic_height_in_luma_samples", ue(pSPSBytes, 0));
        spsMap.put("conformance_window_flag", read_bits(pSPSBytes, 1));

        if (spsMap.get("conformance_window_flag")) {
          spsMap.put("conf_win_left_offset", ue(pSPSBytes, 0));
          spsMap.put("conf_win_right_offset", ue(pSPSBytes, 0));
          spsMap.put("conf_win_top_offset", ue(pSPSBytes, 0));
          spsMap.put("conf_win_bottom_offset", ue(pSPSBytes, 0));
        }
      } //debug.log("=========================SPS END=========================");


      return true;
    },
    parse2: function parse2(data) {
      //debug.log(data)
      var size = data.length;
      pSPSBytes = data;
      m_data = data;
      m_len = data.length;
      m_idx = 0;
      m_bits = 0;
      m_byte = 0;
      m_zeros = 0;
      vBitCount = 0;
      spsMap.clear();

      if (size < 20) {
        return false;
      } // seq_parameter_set_rbsp()
      //getInfo();


      read_bits(pSPSBytes, 16);
      read_bits(pSPSBytes, 4); // sps_video_parameter_set_id
      //getInfo();

      var sps_max_sub_layers_minus1 = read_bits(pSPSBytes, 3);
      spsMap.put("sps_max_sub_layers_minus1", sps_max_sub_layers_minus1); //getInfo();

      if (sps_max_sub_layers_minus1 > 6) {
        return false;
      }

      read_bits(pSPSBytes, 1); //debug.log('m_idx = ' + m_idx)

      read_bits(pSPSBytes, 2); //getInfo();

      read_bits(pSPSBytes, 1); //getInfo();
      //params.profile = read_bits(pSPSBytes, 5);

      var profile = read_bits(pSPSBytes, 5); //debug.log('profile: ' +  profile)

      read_bits(pSPSBytes, 32); //

      read_bits(pSPSBytes, 1); //

      read_bits(pSPSBytes, 1); //

      read_bits(pSPSBytes, 1); //

      read_bits(pSPSBytes, 1); //

      read_bits(pSPSBytes, 43); //

      read_bits(pSPSBytes, 1); //
      //debug.log('m_idx = ' + m_idx)
      //params.level = read_bits(pSPSBytes, 8);// general_level_idc

      spsMap.put("general_level_idc", read_bits(pSPSBytes, 8)); //debug.log('level = ' + spsMap.get("general_level_idc"))

      var sub_layer_profile_present_flag = [];
      var sub_layer_level_present_flag = [];

      for (var i = 0; i < sps_max_sub_layers_minus1; i++) {
        sub_layer_profile_present_flag[i] = read_bits(pSPSBytes, 1);
        sub_layer_level_present_flag[i] = read_bits(pSPSBytes, 1);
      }

      if (sps_max_sub_layers_minus1 > 0) {
        for (var i = sps_max_sub_layers_minus1; i < 8; i++) {
          var reserved_zero_2bits = read_bits(pSPSBytes, 2);
        }
      }

      for (var i = 0; i < sps_max_sub_layers_minus1; i++) {
        if (sub_layer_profile_present_flag[i]) {
          read_bits(pSPSBytes, 2);
          read_bits(pSPSBytes, 1);
          read_bits(pSPSBytes, 5); //

          read_bits(pSPSBytes, 32);
          read_bits(pSPSBytes, 1);
          read_bits(pSPSBytes, 1);
          read_bits(pSPSBytes, 1);
          read_bits(pSPSBytes, 1);
          read_bits(pSPSBytes, 44);
        }

        if (sub_layer_level_present_flag[i]) {
          read_bits(pSPSBytes, 8); // sub_layer_level_idc[i]
        }
      }

      var sps_seq_parameter_set_id = ue(pSPSBytes, 0);
      spsMap.put("sps_seq_parameter_set_id", sps_seq_parameter_set_id);

      if (sps_seq_parameter_set_id > 15) {
        return false;
      }

      var chroma_format_idc = ue(pSPSBytes, 0);
      spsMap.put("chroma_format_idc", chroma_format_idc);

      if (sps_seq_parameter_set_id > 3) {
        return false;
      }

      if (chroma_format_idc == 3) {
        read_bits(pSPSBytes, 1); //
      } //params.width = ue(pSPSBytes, 0); // pic_width_in_luma_samples
      //params.height = ue(pSPSBytes, 0); // pic_height_in_luma_samples


      spsMap.put("pic_width_in_luma_samples", ue(pSPSBytes, 0));
      spsMap.put("pic_height_in_luma_samples", ue(pSPSBytes, 0));

      if (read_bits(pSPSBytes, 1)) {
        ue(pSPSBytes, 0);
        ue(pSPSBytes, 0);
        ue(pSPSBytes, 0);
        ue(pSPSBytes, 0);
      }

      var bit_depth_luma_minus8 = ue(pSPSBytes, 0);
      var bit_depth_chroma_minus8 = ue(pSPSBytes, 0);

      if (bit_depth_luma_minus8 != bit_depth_chroma_minus8) {
        return false;
      } //...


      return true;
    },
    getSizeInfo: function getSizeInfo() {
      //debug.log(spsMap)
      var width = spsMap.get("pic_width_in_luma_samples");
      var height = spsMap.get("pic_height_in_luma_samples");

      if (spsMap.get("conformance_window_flag")) {
        var chromaFormatIdc = spsMap.get("chroma_format_idc");
        var separateColourPlaneFlag = spsMap.get("separate_colour_plane_flag");

        if (typeof separateColourPlaneFlag === "undefined") {
          separateColourPlaneFlag = 0;
        }

        var subWidthC = (1 === chromaFormatIdc || 2 === chromaFormatIdc) && 0 === separateColourPlaneFlag ? 2 : 1;
        var subHeightC = 1 === chromaFormatIdc && 0 === separateColourPlaneFlag ? 2 : 1;
        width -= subWidthC * spsMap.get("conf_win_right_offset") + subWidthC * spsMap.get("conf_win_left_offset");
        height -= subHeightC * spsMap.get("conf_win_bottom_offset") + subHeightC * spsMap.get("conf_win_top_offset");
      }

      var decodeSize = width * height;
      var sizeInfo = {
        'width': width,
        'height': height,
        'decodeSize': decodeSize
      };
      return sizeInfo;
    },
    getSpsValue: function getSpsValue(key) {
      return spsMap.get(key);
    }
  };
  return new Constructor();
}

/* harmony default export */ var h265Session = (h265Session_H265Session);
// CONCATENATED MODULE: ./src/Decode/MjpegDecoder.js


function MJPEGDecoder() {
  var width, height;
  var isFirstIFrame = false;

  function Constructor() {
    debug.log('MJPEG Decoder');
  }

  Constructor.prototype = {
    setIsFirstFrame: function setIsFirstFrame(flag) {
      isFirstIFrame = flag;
    },
    isFirstFrame: function isFirstFrame() {
      return isFirstIFrame;
    },
    setResolution: function setResolution(w, h) {
      width = w;
      height = h;
    },
    decode: function decode(data, type) {
      if (!Constructor.prototype.isFirstFrame()) {
        Constructor.prototype.setIsFirstFrame(true);
        var frameData = {
          'firstFrame': true
        };
        return frameData;
      }

      return {
        'data': data,
        'width': width,
        'height': height,
        'codecType': 'mjpeg'
      };
    }
  };
  return new Constructor();
}

/* harmony default export */ var MjpegDecoder = (MJPEGDecoder);
// CONCATENATED MODULE: ./src/mjpegSession.js
/* exported H264Session */

/* global Uint8Array, H264SPSParser, H264Decoder, RtpSession, VideoBufferList,
 inheritObject, ArrayBuffer, initSegment, MJPEGDecoder, decodeMode */

/* eslint-disable no-magic-numbers */

/*eslint id-length: ["error", { "exceptions": ["Q","q","i"] }]*/



var mjpegSession_MjpegSession = function MjpegSession() {
  var MARKERSOF0 = 0xc0; // start-of-frame, baseline scan

  var MARKERSOI = 0xd8; // start of image
  //var MARKEREOI = 0xd9; // end of image

  var MARKERSOS = 0xda; // start of scan

  var MARKERDRI = 0xdd; // restart interval

  var MARKERDQT = 0xdb; // define quantization tables

  var MARKERDHT = 0xc4; // huffman tables

  var MARKERAPPFIRST = 0xe0; // var MARKERAPPLAST = 0xef;
  // var MARKERCOMMENT = 0xfe;

  var extensionHeaderLen = null;
  var width = 0,
      height = 0;
  var frameCount = 0;
  var decodedData = {
    frameData: null,
    timeStamp: null
  },
      timeData = {
    'timestamp': null,
    'timezone': null
  };
  var lumDcCodelens = [0, 1, 5, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];
  var lumDcSymbols = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  var lumAcCodelens = [0, 2, 1, 3, 3, 2, 4, 3, 5, 5, 4, 4, 0, 0, 1, 0x7d];
  var lumAcSymbols = [0x01, 0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12, 0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61, 0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xa1, 0x08, 0x23, 0x42, 0xb1, 0xc1, 0x15, 0x52, 0xd1, 0xf0, 0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0a, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa];
  var chmDcCodelens = [0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0];
  var chmDcSymbols = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  var chmAcCodelens = [0, 2, 1, 2, 4, 4, 3, 4, 7, 5, 4, 4, 0, 1, 2, 0x77];
  var chmAcSymbols = [0x00, 0x01, 0x02, 0x03, 0x11, 0x04, 0x05, 0x21, 0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61, 0x71, 0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91, 0xa1, 0xb1, 0xc1, 0x09, 0x23, 0x33, 0x52, 0xf0, 0x15, 0x62, 0x72, 0xd1, 0x0a, 0x16, 0x24, 0x34, 0xe1, 0x25, 0xf1, 0x17, 0x18, 0x19, 0x1a, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xea, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa]; // The default 'luma' and 'chroma' quantizer tables, in zigzag order:

  var defaultQuantizers = [// luma table:
  16, 11, 12, 14, 12, 10, 16, 14, 13, 14, 18, 17, 16, 19, 24, 40, 26, 24, 22, 22, 24, 49, 35, 37, 29, 40, 58, 51, 61, 60, 57, 51, 56, 55, 64, 72, 92, 78, 64, 68, 87, 69, 55, 56, 80, 109, 81, 87, 95, 98, 103, 104, 103, 62, 77, 113, 121, 112, 100, 120, 92, 101, 103, 99, // chroma table:
  17, 18, 18, 24, 21, 24, 47, 26, 26, 47, 99, 66, 56, 66, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99];

  function createHuffmanHeader(ptr, indexValue, codelens, ncodes, symbols, nsymbols, tableNo, tableClass) {
    var index = indexValue;
    ptr[index] = 0xFF;
    index += 1;
    ptr[index] = MARKERDHT;
    index += 1;
    ptr[index] = 0;
    index += 1;
    /* length msb */

    ptr[index] = 3 + ncodes + nsymbols;
    index += 1;
    /* length lsb */

    ptr[index] = tableClass << 4 | tableNo;
    index += 1;
    ptr.set(codelens, index);
    index += ncodes;
    ptr.set(symbols, index);
    index += nsymbols;
    return index;
  }

  function makeDefaultQtables(resultTables, Q) {
    var factor = Q;
    var q = 0;

    if (Q < 1) {
      factor = 1;
    } else if (Q > 99) {
      factor = 99;
    }

    if (Q < 50) {
      q = 5000 / factor;
    } else {
      q = 200 - factor * 2;
    }

    for (var i = 0; i < 128; i++) {
      var newVal = (defaultQuantizers[i] * q + 50) / 100;

      if (newVal < 1) {
        newVal = 1;
      } else if (newVal > 255) {
        newVal = 255;
      }

      resultTables[i] = newVal;
    }
  }

  var makeJPEGHeader = function makeJPEGHeader(type, width, height, qtablesArray, qtlen, dri) {
    var qtables = qtablesArray;
    var buf = new Uint8Array(new ArrayBuffer(1000));
    var index = 0;
    var ptr = buf;
    var numQtables = qtlen > 64 ? 2 : 1;
    var qtablesize = 0; // MARKER_SOI:

    ptr[index] = 0xFF;
    index += 1;
    ptr[index] = MARKERSOI;
    index += 1; ////debug.log("makeJPEGHeader 1 Size:",index);
    // MARKER_APP_FIRST:

    ptr[index] = 0xFF;
    index += 1;
    ptr[index] = MARKERAPPFIRST;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x10;
    index += 1;
    ptr[index] = 0x4a;
    index += 1;
    ptr[index] = 0x46;
    index += 1;
    ptr[index] = 0x49;
    index += 1;
    ptr[index] = 0x46;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x01;
    index += 1;
    ptr[index] = 0x01;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x01;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x01;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x00;
    index += 1; ////debug.log("makeJPEGHeader 2 Size:",index);
    // MARKER_DRI:

    if (dri > 0) {
      ptr[index] = 0xFF;
      index += 1;
      ptr[index] = MARKERDRI;
      index += 1;
      ptr[index] = 0x00;
      index += 1;
      ptr[index] = 0x04;
      index += 1;
      ptr[index] = dri >> 8;
      index += 1;
      ptr[index] = dri;
      index += 1; ////debug.log("makeJPEGHeader 3 Size:",index);
    } // MARKER_DQT (luma):


    var tableSize = numQtables === 1 ? qtlen : qtlen / 2;
    ptr[index] = 0xFF;
    index += 1;
    ptr[index] = MARKERDQT;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = tableSize + 3;
    index += 1;
    ptr[index] = 0x00;
    index += 1; ////debug.log("makeJPEGHeader 4 Size:",index);

    ptr.set(qtables.subarray(0, tableSize), index);
    qtablesize += tableSize;
    index += tableSize; ////debug.log("makeJPEGHeader 5 Size:",index);

    if (numQtables > 1) {
      tableSize = qtlen - qtlen / 2; // MARKER_DQT (chroma):

      ptr[index] = 0xFF;
      index += 1;
      ptr[index] = MARKERDQT;
      index += 1;
      ptr[index] = 0x00;
      index += 1;
      ptr[index] = tableSize + 3;
      index += 1;
      ptr[index] = 0x01;
      index += 1;
      ptr.set(qtables.subarray(qtablesize, qtablesize + tableSize), index);
      qtables += tableSize;
      index += tableSize; ////debug.log("makeJPEGHeader 6 Size:",index);
    } // MARKER_SOF0:


    ptr[index] = 0xFF;
    index += 1;
    ptr[index] = MARKERSOF0;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x11;
    index += 1;
    ptr[index] = 0x08;
    index += 1;
    ptr[index] = height >> 8;
    index += 1;
    ptr[index] = height;
    index += 1; // number of lines (must be a multiple of 8)

    ptr[index] = width >> 8;
    index += 1;
    ptr[index] = width;
    index += 1; // number of columns (must be a multiple of 8)

    ptr[index] = 0x03;
    index += 1; // number of components

    ptr[index] = 0x01;
    index += 1; // id of component

    ptr[index] = type ? 0x22 : 0x21;
    index += 1; // sampling ratio (h,v)

    ptr[index] = 0x00;
    index += 1; // quant table id

    ptr[index] = 0x02;
    index += 1; // id of component

    ptr[index] = 0x11;
    index += 1; // sampling ratio (h,v)

    ptr[index] = numQtables === 1 ? 0x00 : 0x01;
    index += 1; // quant table id

    ptr[index] = 0x03;
    index += 1; // id of component

    ptr[index] = 0x11;
    index += 1; // sampling ratio (h,v)

    ptr[index] = 0x01;
    index += 1; // quant table id
    ////debug.log("makeJPEGHeader 7 Size:",index);

    index = createHuffmanHeader(ptr, index, lumDcCodelens, lumDcCodelens.length, lumDcSymbols, lumDcSymbols.length, 0, 0); ////debug.log("makeJPEGHeader 7.1 Size:",index);

    index = createHuffmanHeader(ptr, index, lumAcCodelens, lumAcCodelens.length, lumAcSymbols, lumAcSymbols.length, 0, 1); //// debug.log("makeJPEGHeader 7.2 Size:",index);

    index = createHuffmanHeader(ptr, index, chmDcCodelens, chmDcCodelens.length, chmDcSymbols, chmDcSymbols.length, 1, 0); //// debug.log("makeJPEGHeader 7.3 Size:",index);

    index = createHuffmanHeader(ptr, index, chmAcCodelens, chmAcCodelens.length, chmAcSymbols, chmAcSymbols.length, 1, 1); ////debug.log("makeJPEGHeader 8 Size:",index);
    // MARKER_SOS:

    ptr[index] = 0xFF;
    index += 1;
    ptr[index] = MARKERSOS;
    index += 1;
    ptr[index] = 0x00;
    index += 1;
    ptr[index] = 0x0C;
    index += 1; // size of chunk

    ptr[index] = 0x03;
    index += 1; // number of components

    ptr[index] = 0x01;
    index += 1; // id of component

    ptr[index] = 0x00;
    index += 1; // huffman table id (DC, AC)

    ptr[index] = 0x02;
    index += 1; // id of component

    ptr[index] = 0x11;
    index += 1; // huffman table id (DC, AC)

    ptr[index] = 0x03;
    index += 1; // id of component

    ptr[index] = 0x11;
    index += 1; // huffman table id (DC, AC)

    ptr[index] = 0x00;
    index += 1; // start of spectral

    ptr[index] = 0x3F;
    index += 1; // end of spectral

    ptr[index] = 0x00;
    index += 1; // successive approximation bit position (high, low)
    ////debug.log("makeJPEGHeader 9 Size:",index);

    var tmpheader = new Uint8Array(new ArrayBuffer(index));
    tmpheader.set(ptr.subarray(0, index), 0); //var receiveMsg = String.fromCharCode.apply(null, tmpheader);
    ////debug.log("JPEG Start Header",receiveMsg);

    return tmpheader;
  };

  function getspecialheadersize(rtpPayload) {
    var resultSpecialHeaderSize = 8;
    var Type = rtpPayload[extensionHeaderLen + 4];
    var Q = rtpPayload[extensionHeaderLen + 5];

    if (Type > 63) {
      resultSpecialHeaderSize += 4; //debug.log("getspecialheadersize 1:",resultSpecialHeaderSize);
    }

    if (Q > 127) {
      var MBZ = rtpPayload[extensionHeaderLen + resultSpecialHeaderSize];

      if (MBZ === 0) {
        //debug.log("getspecialheadersize 2:",resultSpecialHeaderSize);
        var Length = rtpPayload[extensionHeaderLen + resultSpecialHeaderSize + 2] << 8 | rtpPayload[extensionHeaderLen + resultSpecialHeaderSize + 3]; // debug.log("getspecialheadersize 3:",Length);

        resultSpecialHeaderSize += 4;
        resultSpecialHeaderSize += Length; //debug.log("getspecialheadersize 4:",resultSpecialHeaderSize);
      }
    }

    return resultSpecialHeaderSize;
  }

  var createjpegheader = function createjpegheader(rtpPayload) {
    var exHeaderLen = 0;
    var resultSpecialHeaderSize = 8;
    var Offset = rtpPayload[extensionHeaderLen + 1] << 16 | rtpPayload[extensionHeaderLen + 2] << 8 | rtpPayload[extensionHeaderLen + 3];
    var Type = rtpPayload[extensionHeaderLen + 4];
    var type = Type & 1;
    var Q = rtpPayload[extensionHeaderLen + 5];
    width = rtpPayload[extensionHeaderLen + 6] * 8;
    height = rtpPayload[extensionHeaderLen + 7] * 8;

    if (height === 0 || width === 0) {
      // special case
      //height = 256*8;
      if (rtpPayload[0] === 0xAB && rtpPayload[1] === 0xAD) {
        exHeaderLen = 16;
        height = rtpPayload[exHeaderLen + 9] << 8 | rtpPayload[exHeaderLen + 10];
        width = rtpPayload[exHeaderLen + 11] << 8 | rtpPayload[exHeaderLen + 12];
      } else {
        height = rtpPayload[9] << 8 | rtpPayload[10];
        width = rtpPayload[11] << 8 | rtpPayload[12];
      }
    }

    var dri = null;
    var qtables = null;
    var qtlen = 0;

    if (Type > 63) {
      // Restart Marker header present

      /*
       0                   1                   2                   3
       0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       |       Restart Interval        |F|L|       Restart Count       |
       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       */
      var RestartInterval = rtpPayload[extensionHeaderLen + resultSpecialHeaderSize] << 8 | rtpPayload[extensionHeaderLen + resultSpecialHeaderSize + 1];
      dri = RestartInterval;
      resultSpecialHeaderSize += 4; //debug.log("createjpegheader-restart marker added");
    }

    if (Offset === 0) {
      if (Q > 127) {
        // Quantization Table header present

        /*
         0                   1                   2                   3
         0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         |      MBZ      |   Precision   |             Length            |
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         |                    Quantization Table Data                    |
         |                              ...                              |
         +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
         */
        var MBZ = rtpPayload[extensionHeaderLen + resultSpecialHeaderSize];

        if (MBZ === 0) {
          var Length = rtpPayload[extensionHeaderLen + resultSpecialHeaderSize + 2] << 8 | rtpPayload[extensionHeaderLen + resultSpecialHeaderSize + 3];
          resultSpecialHeaderSize += 4;
          qtlen = Length;
          qtables = new Uint8Array(new ArrayBuffer(Length));
          qtables.set(rtpPayload.subarray(extensionHeaderLen + resultSpecialHeaderSize, extensionHeaderLen + resultSpecialHeaderSize + Length), 0);
          resultSpecialHeaderSize += Length; //debug.log("createjpegheader-Q Tables exist:",qtables.length);
        }
      }
    }

    if (qtlen === 0) {
      // A quantization table was not present in the RTP JPEG header,
      // so use the default tables, scaled according to the "Q" factor:
      qtlen = 128;
      qtables = new Uint8Array(new ArrayBuffer(qtlen));
      makeDefaultQtables(qtables, Q); //debug.log("createjpegheader-Used Default Q Tables:",qtables.length);
    } // var jpgheder = makeJPEGHeader(type, width, height, qtables, qtlen, dri);


    return makeJPEGHeader(type, width, height, qtables, qtlen, dri);
  };

  var readLength = 0;
  var jpegDataSize = 0;
  var curFrameSize = 0;
  var frmCnt = 0;
  var totalFrameSize = 0;
  var specialHeaderSize = 0;
  var skipHeaderBytes = 0;
  var rtpTimeStamp = 0;
  var preRtpTimeStamp = 0;
  var playback = false;
  var NTPmsw = null;
  var NTPlsw = null;
  var startHeader = null;
  var gmt = null;
  var fragmentOffset = null;
  var jpegStartHeader = null;
  var jpegStartHeaderSize = null;
  var fsynctime = null;
  var data = null;
  var payloadsize = null;
  var marker = null;
  var Type = null;
  var ntpmsw = null;
  var ntplsw = null;
  var govLength = null;
  var dropPer = 0;
  var dropCount = 0;
  var frameRate = 0;
  var delayingTime = 0;
  var DELAY_LIMIT = 8000;
  var preTimeStamp = 0;
  var resolution = {
    width: 0,
    height: 0
  };

  function Constructor() {
    this.decoder = new MjpegDecoder();
    this.firstTime = 0;
    this.lastMSW = 0;
  }

  Constructor.prototype = {
    init: function init() {
      this.decoder.setIsFirstFrame(false);
      this.videoBufferList = new VideoBufferList();
      frameCount = 0;
      this.timeData = null;
    },
    parseRTPData: function parseRTPData(rtspInterleaved, dhPayload, isBackup, dropout, info) {
      var jpegFrame = new Uint8Array(1024 * 1024);
      width = info.width;
      height = info.height;
      fsynctime = {};
      data = {};
      var extensionHeaderLen = dhPayload[22];
      var inputBufferSub = dhPayload.subarray(24 + extensionHeaderLen, dhPayload.length - 8);
      payloadsize = inputBufferSub.length;
      var time = (dhPayload[19] << 24) + (dhPayload[18] << 16) + (dhPayload[17] << 8) + dhPayload[16] >>> 0;
      var lsw = Date.UTC('20' + (time >>> 26), (time >>> 22 & 0x0f) - 1, time >>> 17 & 0x1f, time >>> 12 & 0x1f, time >>> 6 & 0x3f, time & 0x3f) / 1000; //var msw = info.timeStampmsw;
      //debug.log('time:  ' + (lsw + msw) + '  ' + (new Date()).getTime() + ' ' + timeString)
      //var lsw = '20' + (time >> 26) + (((time >> 22) & 0x0f) ) + ((time >> 17) & 0x1f) + ((time >> 12) & 0x1f) + ((time >> 6) & 0x3f) + (time & 0x3f);

      lsw = lsw - 8 * 3600;

      if (this.firstTime == 0) {
        //第一次
        this.firstTime = lsw; //系统时间精确到秒

        this.lastMSW = 0;
        preRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        timeData = {
          timestamp: this.firstTime,
          timestamp_usec: 0
        };
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
        timeData = {
          timestamp: lsw,
          timestamp_usec: this.lastMSW
        };
        preRtpTimeStamp = currentRtpTimeStamp;
      }

      if ((this.getFramerate() === 0 || typeof this.getFramerate() === 'undefined') && typeof this.getTimeStamp() !== 'undefined') {
        this.setFramerate(Math.round(1000 / ((timeData.timestamp - this.getTimeStamp().timestamp === 0 ? 0 : 1000) + (timeData.timestamp_usec - this.getTimeStamp().timestamp_usec))));
      }

      this.setTimeStamp(timeData);
      rtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20]; //skip specialHeader Bytes

      jpegDataSize = payloadsize;
      totalFrameSize = jpegDataSize;
      jpegFrame = this.appendBuffer(jpegFrame, inputBufferSub, readLength);
      readLength += payloadsize;
      jpegFrame[readLength + totalFrameSize - 2] = 0xFF;
      jpegFrame[readLength + totalFrameSize - 1] = 0xD9; //call decoder

      frmCnt++;

      if (resolution.width != width || resolution.height != height) {
        //this.decoder.setIsFirstFrame(false);
        if (resolution.width != 0) {
          resolution.width = width;
          resolution.height = height;
          data.resolution = resolution;
          data.resolution.decodeMode = 'canvas'; //分辨率改变后计算播放模式

          data.resolution.encodeMode = 'mjpeg';
        } else {
          resolution.width = width;
          resolution.height = height;
          data.decodeStart = resolution;
          data.decodeStart.decodeMode = 'canvas';
          data.decodeStart.encodeMode = 'mjpeg';
        }
      }

      var curTimeStamp = 1000 * timeData.timestamp + timeData.timestamp_usec;

      if (this.firstDiffTime == 0) {
        delayingTime = 0;
        this.firstDiffTime = Date.now() - curTimeStamp;
        debug.log('firstDiff: ' + this.firstTime); // needDropCnt = 0;
      } else {
        if (curTimeStamp - preTimeStamp < 0) {
          this.firstDiffTime = delayingTime + (Date.now() - curTimeStamp).toFixed(0);
        }

        delayingTime = Date.now() - curTimeStamp - this.firstDiffTime;

        if (delayingTime < 0) {
          this.firstDiffTime = 0;
          delayingTime = 0;
        } //debug.log('delayingTime: ' + delayingTime)


        if (delayingTime > DELAY_LIMIT) {
          data.error = {
            errorCode: 101 //

          };
          this.rtpReturnCallback(data); //return;
        }
      }

      preTimeStamp = curTimeStamp;
      decodedData.frameData = null;

      if (isBackup !== true || playback !== true) {
        this.decoder.setResolution(width, height);
        decodedData.frameData = this.decoder.decode(jpegFrame.subarray(0, readLength));
      }

      decodedData.timeStamp = null; //call decoder callback
      //将时间戳传递，以供回放的进度条使用
      //if (playback === true) {

      timeData = timeData.timestamp === null ? this.getTimeStamp() : timeData;
      decodedData.timeStamp = timeData; // this.rtpBufferingCbFunc(jpegFrame.subarray(0, readLength), timeData, "jpeg", this.rtpPayloadCbFunc);
      //}

      if (isBackup === true) {
        data.backupData = {
          'stream': jpegFrame.subarray(0, readLength),
          'width': width,
          'height': height,
          'codecType': 'mjpeg'
        };

        if (timeData.timestamp !== null && typeof timeData.timestamp !== "undefined") {
          data.backupData.timestamp_usec = timeData.timestamp_usec;
        } else {
          data.backupData.timestamp = (rtpTimeStamp / 90).toFixed(0);
        }
      }

      readLength = 0;
      decodedData.playback = playback;
      data.decodedData = decodedData; //if (decodeMode !== "canvas") {
      //    data.decodeMode = "canvas";
      //}

      this.rtpReturnCallback(data);
      return; // data;
      //}
    },
    getVideoBuffer: function getVideoBuffer(idx) {
      if (this.videoBufferList !== null) {
        return this.videoBufferList.searchNodeAt(idx);
        /*this.videoBufferList.getCurIdx()*/
      }
    },
    clearBuffer: function clearBuffer() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.clear();
      }
    },
    findCurrent: function findCurrent() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.searchTimestamp(this.getTimeStamp());
      }
    },
    findIFrame: function findIFrame() {
      if (this.videoBufferList !== null) {
        this.videoBufferList.findIFrame();
      }
    },
    SetRtpInterlevedID: function SetRtpInterlevedID(interleavedID) {
      this.interleavedID = interleavedID;
    },
    setTimeStamp: function setTimeStamp(data) {
      this.timeData = data;
    },
    getTimeStamp: function getTimeStamp() {
      return this.timeData;
    },
    getRTPPacket: function getRTPPacket(Channel, rtpPayload) {},
    calculatePacketTime: function calculatePacketTime(rtpTimeStamp) {},
    ntohl: function ntohl(buffer) {
      return (buffer[0] << 24) + (buffer[1] << 16) + (buffer[2] << 8) + buffer[3] >>> 0;
    },
    appendBuffer: function appendBuffer(currentBuffer, newBuffer, readLength) {
      var BUFFER_SIZE = 1024 * 1024;

      if (readLength + newBuffer.length >= currentBuffer.length) {
        var tmp = new Uint8Array(currentBuffer.length + BUFFER_SIZE);
        tmp.set(currentBuffer, 0);
        currentBuffer = tmp;
      }

      currentBuffer.set(newBuffer, readLength);
      return currentBuffer;
    },
    setFramerate: function setFramerate(framerate) {
      if (0 < framerate && typeof framerate !== "undefined") {
        frameRate = framerate;

        if (this.videoBufferList !== null) {
          this.videoBufferList.setMaxLength(frameRate * 6);
          this.videoBufferList.setBUFFERING(frameRate * 4);
        }
      }
    },
    getFramerate: function getFramerate() {
      return frameRate;
    },
    setReturnCallback: function setReturnCallback(RtpReturn) {
      this.rtpReturnCallback = RtpReturn;
    },
    setBufferfullCallback: function setBufferfullCallback(bufferFull) {
      if (this.videoBufferList !== null) {
        this.videoBufferList.setBufferFullCallback(bufferFull);
      }
    },
    setGovLength: function setGovLength(_govLength) {
      govLength = _govLength;
    },
    getGovLength: function getGovLength() {
      return govLength;
    },
    setDecodingTime: function setDecodingTime(time) {
      this.decodingTime = time;
    },
    getDropPercent: function getDropPercent() {
      return dropPer;
    },
    getDropCount: function getDropCount() {
      return dropCount;
    },
    initStartTime: function initStartTime() {
      this.firstDiffTime = 0;
      this.calcGov = 0;
    },
    setCheckDelay: function setCheckDelay(checkDelay) {
      this.checkDelay = checkDelay;
    }
  };
  return new Constructor();
};
/* eslint-enable no-magic-numbers */


/* harmony default export */ var mjpegSession = (mjpegSession_MjpegSession);
// CONCATENATED MODULE: ./src/ivsSession.js


var ivsSession_IvsSession = function IvsSession() {
  var mType; //子类型

  var timeData; // 时间戳

  var preRtpTimeStamp = null;
  var mTypeMap = {
    0: '元数据帧',
    1: '调试信息',
    2: '自定义信息',
    3: '用户动作',
    4: '播放密码保护',
    5: '智能分析信息',
    6: '客户水印信息',
    7: '未定义',
    8: '全屏动检数据(编码卡模式)',
    9: '全屏动检数据(标准模式)',
    10: 'GPS信息',
    11: 'ITS信息',
    12: 'SDP信息',
    13: 'Onvif元数据',
    14: '智能结构化数据信息',
    15: 'DTMF信息帧',
    16: '',
    17: '',
    18: '叠加图片帧',
    19: '景物点信息标注帧(球机)',
    20: '开放平台智能帧',
    21: '智能分析大数据量帧',
    22: '加密图像的密码找回帧'
  }; //大类业务方案,详见VideoAnalyseGlobal[0].Scene.Type
  //枚举值详见智能分析帧类型定义.doc 1.1.4.3
  //没写全，后续记得补全

  var videoAnalyseType = {
    1: 'VideoSynopsis',
    2: 'TrafficGate',
    3: 'ElectronicPolice',
    4: 'SinglePtzParking',
    5: 'PtzParking',
    6: 'Traffic',
    7: 'Normal',
    8: 'Prison',
    9: 'ATM',
    10: 'MetroIVS',
    11: 'FaceDetection',
    12: 'FaceRecognition',
    13: 'NumberStat',
    14: 'HeatMap',
    15: 'VideoDiagnosis',
    16: 'VideoEnhance',
    17: 'SmokeFireDetect',
    18: 'VehicleAnalyse',
    19: 'PersonFeature',
    20: 'SDFaceDetect',
    21: 'HeatMapPlan',
    22: 'ATMFD',
    23: 'SCR',
    24: 'NumberStatPlan',
    25: 'CourseRecord',
    26: 'Highway',
    27: 'City',
    28: 'LeTrack',
    29: 'ObjectStruct',
    30: 'Stereo',
    31: 'StereoPc',
    32: 'HumanDetect',
    33: 'SDPedestrain',
    34: 'FaceAnalysis',
    35: 'FaceAttribute',
    36: 'FacePicAnalyse',
    37: 'SDEP',
    38: 'XRayDetect',
    39: 'ObjectDetect',
    40: 'CrowdDistriMap',
    41: 'StereoBehavior'
  }; //物体类型
  //详见智能分析帧类型定义.doc 1.1.4.4
  //没写全，后续记得补全

  var dhIVSObjType = {
    0: 'ANYTHING',
    1: 'HUMAN'
  };
  var ivsStatus = [];

  function Constructor() {
    this.firstTime = 0;
    this.lastMSW = 0;
  }

  Constructor.prototype = {
    init: function init() {
      debug.log('init');
    },
    parseRTPData: function parseRTPData(rtspInterleaved, dhPayload, isBackup, dropout, info, channel) {
      var time = (dhPayload[19] << 24) + (dhPayload[18] << 16) + (dhPayload[17] << 8) + dhPayload[16] >>> 0;
      var lsw = Date.UTC('20' + (time >> 26), (time >> 22 & 0x0f) - 1, time >> 17 & 0x1f, time >> 12 & 0x1f, time >> 6 & 0x3f, time & 0x3f) / 1000;
      lsw = lsw - 8 * 3600;

      if (this.firstTime == 0) {
        this.firstTime = lsw;
        this.lastMSW = 0;
        preRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        timeData = {
          timestamp: this.firstTime,
          timestamp_usec: 0
        }; // console.log('第一帧时间: ' + this.firstTime)
      } else {
        var currentRtpTimeStamp = (dhPayload[21] << 8) + dhPayload[20];
        var duration;

        if (currentRtpTimeStamp >= preRtpTimeStamp) {
          //辅助帧会有两帧时间戳相等的情况
          duration = currentRtpTimeStamp - preRtpTimeStamp;
        } else {
          duration = currentRtpTimeStamp + 65535 - preRtpTimeStamp;
        }

        this.lastMSW += duration;

        if (lsw > this.firstTime) {
          // 说明进秒了
          this.lastMSW -= 1000;
        }

        this.firstTime = lsw;
        timeData = {
          timestamp: lsw,
          timestamp_usec: this.lastMSW
        };
        preRtpTimeStamp = currentRtpTimeStamp;
      }

      mType = dhPayload[5];
      ParseAssistData(mType, dhPayload, this.rtpReturnCallback, channel);
    },
    setBufferfullCallback: function setBufferfullCallback() {},
    setReturnCallback: function setReturnCallback(RtpReturn) {
      this.rtpReturnCallback = RtpReturn;
    }
  };
  /**
   * 将unit8array的数据转化为字符串
   * @param buffer 数据
   * return 字符串
   */

  function decodeUTF8(buffer) {
    var array = [].slice.call(buffer);
    var str = '';

    for (var i = 0; i < array.length; i++) {
      str += String.fromCharCode(array[i]);
    }

    return decodeURIComponent(escape(str));
  }
  /**
   * 解析元数据信息帧
   * @param buffer 数据
   * return {result:true, type:0x00, params:{...}} result:解析是否成功
   */


  function ParseAssist0x00(buffer) {
    var info = {
      result: true,
      type: 0x00
    }; //var infoStr = new TextDecoder("utf-8").decode(buffer);
    //info.params = JSON.parse(infoStr);

    info.params = JSON.parse(decodeUTF8(buffer));
    return info;
  }

  ;
  /**
   * 解析智能分析帧(0x05)
   * @param buffer 数据
   * return {result:true, type:0x05, params:{}} result:解析是否成功,params:null代表清除目标
   */

  function ParseAssist0x05(buffer) {
    var objInfo = {
      result: false
    };
    var offset = 0;
    var version = (buffer[offset + 1] << 8) + buffer[offset];

    if (version !== 1 && version !== 2) {
      return objInfo;
    }

    objInfo.result = true;
    objInfo.type = 0x05;
    objInfo.params = null;
    offset += 2;
    var count = buffer[offset]; //物体目标个数

    if (count === 0) {
      ////目标个数为0，通知清除所有轨迹 
      return objInfo;
    }

    offset += 1;
    var frameType = buffer[offset];
    offset += 1;
    objInfo.params = {};
    objInfo.params.coordinate = frameType & 0x80 ? 8192 : 1024; ///坐标系

    objInfo.params.isTrack = frameType & 0x7F ? true : false; ///是否是跟踪时的物体轨迹点更新信息帧

    objInfo.params.object = [];

    for (var i = 0; i < count; i++) {
      var obj = {};
      obj.objectId = (buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset]; ///物体ID

      offset += 4;
      obj.operateType = buffer[offset]; ///更新操作类型:1 增加，2 更新 3删除 4隐藏

      offset += 1;
      var trackNum = buffer[offset]; ///待增加的轨迹点数目

      offset += 1;
      obj.objectType = buffer[offset]; ///物体类型

      offset += 1;
      var fatherIdNum = buffer[offset]; ///父ID数目

      offset += 1; //obj.reserved1 = buffer[offset];   ///保留字段1

      offset += 1; //obj.reserved2 = buffer[offset];   ///保留字段2

      offset += 1;
      obj.classID = videoAnalyseType[buffer[offset]]; ///大类业务方案  参考1.1.4.3

      offset += 1;
      obj.subType = buffer[offset]; ///物体子类型

      offset += 1;

      if (fatherIdNum > 0) {
        obj.fatherId = []; ///物体父ID列表
      }

      for (var j = 0; j < fatherIdNum; j++) {
        obj.fatherId.push((buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset]);
        offset += 4;
      }

      if (trackNum > 0) {
        obj.track = [];
      }

      for (var k = 0; k < trackNum; k++) {
        var centerX = (buffer[offset + 1] << 8) + buffer[offset]; ///物体中心点X坐标

        offset += 2;
        var centerY = (buffer[offset + 1] << 8) + buffer[offset]; ////物体中心点Y坐标

        offset += 2;
        var xSize = (buffer[offset + 1] << 8) + buffer[offset]; ////物体X方向尺寸

        offset += 2;
        var ySize = (buffer[offset + 1] << 8) + buffer[offset]; ////物体Y方向尺寸

        offset += 2;
        obj.track.push([centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]);
      }

      objInfo.params.object.push(obj);
    }

    return objInfo;
  }

  ;
  /**
   * 解析智能分析帧(0x14), SDEV专属
   * @param buffer 数据
   * return {result:true, type:0x14, params:{}} result:解析是否成功,params:null代表清除目标
   */

  function ParseAssist0x14(buf) {
    var resultInfo = {
      result: false,
      type: 0x14,
      params: []
    };
    var version = buf[0]; // buf[1-3] 是保留字段

    var bufLength = buf.length;
    var offset = 0;
    var tBuffer = buf.slice(4); // 从第4位开始，显示显示对象内容buffer, targetBuffer
    // 解析不同的数据类型

    var parseObje = function parseObje() {
      var objInfo = {}; // 对象ID，4字节

      objInfo.objectId = (tBuffer[offset + 3] << 8 * 3) + (tBuffer[offset + 2] << 8 * 2) + (tBuffer[offset + 1] << 8 * 1) + (tBuffer[offset + 0] << 8 * 0);
      offset += 4;
      objInfo.result = true;
      objInfo.params = {}; // 用户自定义值，在SDEV中，用户会用来描述这个对象的类型，
      // 比如（猫、狗、车），大华无需感知，用户自己管理。

      objInfo.custom = (tBuffer[offset + 1] << 8) + tBuffer[offset];
      offset += 2; // 对象状态 [0创建， 1隐藏，2更新，3销毁]

      objInfo.objectStatus = tBuffer[offset];
      offset += 1; // 元素个数

      var nodeNum = tBuffer[offset];
      offset += 1;
      objInfo.params.object = [];
      var curRuleInfo = null;

      for (var i = 0; i < nodeNum; i++) {
        switch (tBuffer[offset]) {
          case 0x1:
            // 圆,数据位的固定长度为20
            curRuleInfo = ParseAssist0x14_circle(tBuffer.slice(offset));
            break;

          case 0x2:
            // 折线，数据位长度不固定
            curRuleInfo = ParseAssist0x14_polyLine(tBuffer.slice(offset));
            break;

          case 0x3:
            // 多边形，数据位长度不固定, 最小长度是24位
            curRuleInfo = ParseAssist0x14_polygon(tBuffer.slice(offset));
            break;

          case 0x4:
            // 文本类型，数据位长度不固定
            curRuleInfo = ParseAssist0x14_text(tBuffer.slice(offset));
            break;

          default:
            break;
        }

        objInfo.params.object.push(curRuleInfo.info);
        offset += curRuleInfo.offset;
      }

      if (objInfo.objectStatus == 1 || objInfo.objectStatus == 3) {
        objInfo.params = null;
      }

      if (nodeNum == 0) {
        // 当前元素个数为0
        objInfo.params = null;
      } // 附加信息长度


      var appendLength = (tBuffer[offset + 1] << 8) + tBuffer[offset];
      offset += 2; // 附加信息内容

      var appendStr = decodeUTF8(tBuffer.slice(offset, offset + appendLength));
      objInfo.appendInfo = String.fromCharCode.apply(null, tBuffer.slice(offset, offset + appendLength));
      offset += appendLength;
      objInfo.appendInfo = appendStr;
      return objInfo;
    }; // 这个-4是因为从第四位开始才是绘制对象


    for (; offset < bufLength - 4;) {
      resultInfo.params.push(parseObje());
    }

    return resultInfo;
  } // 处理0x14中的多边形信息


  function ParseAssist0x14_polygon(buffer) {
    var offset = 0; // buffer[0] 是当前数据类型

    var info = {
      type: buffer[0] // 当前类型

    };
    offset += 1;
    info.pointCount = buffer[offset]; // 点的个数

    offset += 1;
    info.lineWidth = buffer[offset]; // 线宽

    offset += 1;
    info.strokeStyle = buffer[offset]; // 样式

    offset += 1; // 边框颜色

    info.borderColor = [buffer[offset + 1], buffer[offset + 2], buffer[offset + 3], buffer[offset]];
    info.borderColorType = 'RGBA';
    offset += 4; // 区域填充颜色

    info.fillColor = [buffer[offset + 1], buffer[offset + 2], buffer[offset + 3], buffer[offset]];
    info.fillColorType = 'RGBA';
    offset += 4;
    info.coordinate = [];

    for (var i = 0; i < info.pointCount; i++) {
      var pX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var pY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      info.coordinate.push([pX, pY]);
    }

    return {
      info: info,
      offset: offset
    };
  } // 处理0x14中的折线信息


  function ParseAssist0x14_polyLine(buffer) {
    var offset = 0; // buffer[0] 是当前数据类型

    var info = {
      type: buffer[0] // 当前类型

    };
    offset += 1;
    info.pointCount = buffer[offset]; // 点的个数

    offset += 1;
    info.lineWidth = buffer[offset]; // 线宽，单位px

    offset += 1;
    info.strokeStyle = buffer[offset]; // 线条样式

    offset += 1; // 线条颜色

    info.lineColor = [buffer[offset + 1], buffer[offset + 2], buffer[offset + 3], buffer[offset]];
    info.lineColorType = 'RGBA';
    offset += 4;
    info.coordinate = [];

    for (var i = 0; i < info.pointCount; i++) {
      var pX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var pY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      info.coordinate.push([pX, pY]);
    }

    return {
      info: info,
      offset: offset
    };
  } // 处理0x14中的圆图形信息


  function ParseAssist0x14_circle(buffer) {
    var offset = 0; // buffer[0] 是当前数据类型

    var info = {
      type: buffer[0] // 当前类型

    };
    offset += 1;
    info.lineWidth = buffer[offset]; // 线宽，单位px

    offset += 1;
    info.strokeStyle = buffer[offset]; // 样式 

    offset += 1;
    offset += 1; // 保留字

    info.radius = (buffer[offset + 1] << 8) + buffer[offset]; // 半径

    offset += 2;
    offset += 2; // 预留字段
    // 圆心x

    var centerX = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2; // 圆心y

    var centerY = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    info.coordinate = [centerX, centerY]; // 边框线条颜色

    info.borderColor = [buffer[offset + 1], buffer[offset + 2], buffer[offset + 3], buffer[offset]];
    info.borderColorType = 'RGBA';
    offset += 4; // 区域填充颜色

    info.fillColor = [buffer[offset + 1], buffer[offset + 2], buffer[offset + 3], buffer[offset]];
    info.fillColorType = 'RGBA';
    offset += 4;
    return {
      info: info,
      offset: offset
    };
  } // 处理0x14中的文本信息


  function ParseAssist0x14_text(buffer) {
    var offset = 0; // buffer[0] 是当前数据类型

    var info = {
      type: buffer[0] // 当前类型

    };
    offset += 1;
    info.encodeType = buffer[offset]; // 编码方式 [0:UTF-8, 1:GBK]

    offset += 1;
    offset += 2; // buffer[2-3]保留

    var LTCoordX = (buffer[offset + 1] << 8) + buffer[offset]; // 左上角坐标x

    offset += 2;
    var LTCoordY = (buffer[offset + 1] << 8) + buffer[offset]; // 左上角坐标y

    offset += 2;
    info.coordinate = [LTCoordX, LTCoordY]; // 左上角x,y坐标

    info.fontColor = [buffer[offset + 1], buffer[offset + 2], buffer[offset + 3], buffer[offset]];
    offset += 4;
    info.colorType = 'RGBA'; // 这个对应fontColor的格式，系统给的格式是ARGB

    info.fontSize = buffer[offset];
    offset += 1;
    info.textAlign = buffer[offset]; // 0: 左对齐  1: 右对齐

    offset += 1;
    info.textLength = (buffer[offset + 1] << 8) + buffer[offset]; // 字符长度

    offset += 2;
    info.content = String.fromCharCode.apply(null, buffer.slice(offset, offset + info.textLength));
    offset += info.textLength;
    return {
      info: info,
      offset: offset
    };
  }

  function ParseAttribute80(buffer, object) {
    if (!object.hasOwnProperty('attribute80')) {
      object.attribute80 = [];
    }

    var offset = 1; ///跳过0x80

    var len = buffer[offset];
    offset += 1;
    var tmpObject = {};
    tmpObject.color = {};
    tmpObject.color.valid = buffer[offset];
    offset += 1;
    tmpObject.carModel = buffer[offset];
    offset += 1;
    tmpObject.color.red = buffer[offset];
    offset += 1;
    tmpObject.color.green = buffer[offset];
    offset += 1;
    tmpObject.color.blue = buffer[offset];
    offset += 1;
    tmpObject.color.alpha = buffer[offset];
    offset += 1;
    tmpObject.brand = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.subBrand = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.year = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.reliability = buffer[offset];
    offset += 1;
    offset += 1; ///保留字段

    var centerX = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var centerY = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var xSize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var ySize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.windowPosition = [centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize];
    object.attribute80.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute81(buffer, object) {
    if (!object.hasOwnProperty('attribute81')) {
      object.attribute81 = [];
    }

    var tmpObject = {};
    var offset = 1; ///跳过0x81

    var len = buffer[offset];
    offset += 1;
    var centerX = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var centerY = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var xSize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var ySize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.mainPosition = [centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize];
    centerX = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    centerY = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    xSize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    ySize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.coPosition = [centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize];
    tmpObject.mainSafetyBelt = buffer[offset] >> 2 & 3;
    tmpObject.coSafetyBelt = buffer[offset] & 3;
    offset += 1;
    tmpObject.mainSunvisor = buffer[offset] >> 2 & 3;
    tmpObject.coSunvisor = buffer[offset] & 3;
    offset += 1;
    object.attribute81.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute82(buffer, object) {
    if (!object.hasOwnProperty('attribute82')) {
      object.attribute82 = [];
    }

    var tmpObject = {};
    var offset = 1; /// /跳过0x82

    var len = buffer[offset];
    offset += 1;
    tmpObject.plateEncode = buffer[offset];
    offset += 1;
    tmpObject.plateInfoLen = buffer[offset];
    offset += 1;
    tmpObject.plateInfo = buffer.subarray(offset, offset + tmpObject.plateInfoLen);
    object.attribute82.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute83(buffer, object) {
    if (!object.hasOwnProperty('attribute83')) {
      object.attribute83 = [];
    }

    var tmpObject = {};
    var offset = 1; /// /跳过0x83

    var len = buffer[offset];
    offset += 1;
    tmpObject.color = {};
    tmpObject.color.valid = buffer[offset];
    offset += 1;
    tmpObject.color.red = buffer[offset];
    offset += 1;
    tmpObject.color.green = buffer[offset];
    offset += 1;
    tmpObject.color.blue = buffer[offset];
    offset += 1;
    tmpObject.color.alpha = buffer[offset];
    offset += 1;
    tmpObject.country = String.fromCharCode.apply(null, buffer.subarray(offset, offset + 4));
    offset += 4;
    tmpObject.plateType = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    offset += 1;
    tmpObject.plateWidth = (buffer[offset + 1] << 8) + buffer[offset];
    object.attribute83.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute84(buffer, object) {
    if (!object.hasOwnProperty('attribute84')) {
      object.attribute84 = [];
    }

    var tmpObject = {};
    var offset = 1; ///跳过0x84

    var len = buffer[offset];
    offset += 1;
    tmpObject.fatherCount = buffer[offset];
    offset += 1;
    tmpObject.trackCount = buffer[offset];
    offset += 1;
    tmpObject.trackType = buffer[offset];
    offset += 1;
    offset += 3; ///保留字节

    if (tmpObject.fatherCount > 0) {
      tmpObject.fatherID = [];
    }

    for (var i = 0; i < tmpObject.fatherCount; i++) {
      tmpObject.fatherID.push((buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset]);
      offset += 4;
    }

    if (tmpObject.trackCount > 0) {
      tmpObject.track = [];
    }

    for (var j = 0; j < tmpObject.trackCount; j++) {
      var centerX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var centerY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var xSize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var ySize = (buffer[offset + 1] << 8) + buffer[offset];
      ;
      offset += 2;
      tmpObject.track.push([centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]);
    }

    object.attribute84.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute85(buffer, object) {
    if (!object.hasOwnProperty('attribute85')) {
      object.attribute85 = [];
    }

    var tmpObject = {};
    var offset = 1; ///跳过0x84

    var len = buffer[offset];
    offset += 1;
    tmpObject.colorSpace = buffer[offset];
    offset += 1;
    tmpObject.mainColorCount = buffer[offset];
    offset += 1;

    if (tmpObject.mainColorCount > 0) {
      tmpObject.mainColorInfo = [];
    }

    for (var i = 0; i < tmpObject.mainColorCount; i++) {
      var colorObject = {};
      var centerX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var centerY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var xSize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var ySize = (buffer[offset + 1] << 8) + buffer[offset];
      ;
      offset += 2;
      colorObject.rect = [centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize];
      colorObject.color = (buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset];
      offset += 4;
      tmpObject.mainColorInfo.push(colorObject);
    }

    object.attribute85.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute86(buffer, object) {
    if (!object.hasOwnProperty('attribute86')) {
      object.attribute86 = [];
    }

    var tmpObject = {};
    var offset = 1;
    var len = buffer[offset];
    offset += 1;
    offset += 1; ///保留字段

    tmpObject.speedType = buffer[offset];
    offset += 1;
    tmpObject.speed = buffer[offset + 1] << 8 + buffer[offset];
    offset += 2;
    tmpObject.speedX = buffer[offset + 1] << 8 + buffer[offset];
    offset += 2;
    tmpObject.speedY = (buffer[offset + 1] << 8) + buffer[offset];
    object.attribute86.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute87(buffer, object) {
    if (!object.hasOwnProperty('attribute87')) {
      object.attribute87 = [];
    }

    var tmpObject = {};
    var offset = 1;
    var len = buffer[offset];
    offset += 1;
    offset += 2; ///保留字段

    var centerX = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var centerY = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var xSize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var ySize = (buffer[offset + 1] << 8) + buffer[offset];
    tmpObject.track = [[centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]];
    object.attribute87.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute88(buffer, object) {
    if (!object.hasOwnProperty('attribute88')) {
      object.attribute88 = [];
    }

    var tmpObject = {};
    var offset = 1;
    offset += 1;
    tmpObject.age = buffer[offset];
    offset += 1;
    tmpObject.sex = buffer[offset];
    offset += 1;
    tmpObject.face = buffer[offset];
    offset += 1;
    tmpObject.glass = buffer[offset];
    offset += 1;
    tmpObject.hat = buffer[offset];
    offset += 1;
    tmpObject.call = buffer[offset];
    offset += 1;
    tmpObject.backpack = buffer[offset];
    offset += 1;
    tmpObject.umbrella = buffer[offset];
    offset += 1;
    tmpObject.height = buffer[offset];
    offset += 1;
    tmpObject.mask = buffer[offset] >> 2 & 3;
    tmpObject.beard = buffer[offset] & 3;
    object.attribute88.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute89(buffer, object) {
    if (!object.hasOwnProperty('attribute89')) {
      object.attribute89 = [];
    }

    var tmpObject = {};
    var offset = 1;
    var len = buffer[offset];
    offset += 1;
    tmpObject.yawAngle = parseInt((buffer[offset + 1] << 8) + buffer[offset]);
    offset += 2;
    tmpObject.rollAngle = parseInt((buffer[offset + 1] << 8) + buffer[offset]);
    offset += 2;
    tmpObject.pitchAngle = parseInt((buffer[offset + 1] << 8) + buffer[offset]);
    offset += 2;
    var x = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var y = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.lEyePos = [x, y];
    x = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    y = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.rEyePos = [x, y];
    x = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    y = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.nosePos = [x, y];
    x = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    y = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.lMouthPos = [x, y];
    x = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    y = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.rMouthPos = [x, y];
    var featureCount = buffer[offset];
    offset += 3;

    if (featureCount > 0) {
      tmpObject.featurePos = [];
    }

    for (var i = 0; i < featureCount; i++) {
      x = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      y = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      tmpObject.featurePos.push([x, y]);
    }

    object.attribute89.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute8C(buffer, object) {
    if (!object.hasOwnProperty('attribute8C')) {
      object.attribute8C = [];
    }

    var tmpObject = {};
    var offset = 1;
    var len = buffer[offset];
    offset += 1;
    tmpObject.hangingCount = buffer[offset];
    offset += 1;
    tmpObject.tissueCount = buffer[offset];
    offset += 1;
    tmpObject.sunVisorCount = buffer[offset];
    offset += 1;
    tmpObject.annualInspectionCount = buffer[offset];
    offset += 1;
    offset += 6;

    if (tmpObject.hangingCount > 0) {
      tmpObject.hangingCount = [];
    }

    for (var i = 0; i < tmpObject.hangingCount; i++) {
      var centerX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var centerY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var xSize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var ySize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      tmpObject.hangingPos.push([centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]);
    }

    if (tmpObject.tissueCount > 0) {
      tmpObject.tissueCount = [];
    }

    for (var i = 0; i < tmpObject.tissueCount; i++) {
      var centerX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var centerY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var xSize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var ySize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      tmpObject.tissueCount.push([centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]);
    }

    if (tmpObject.sunVisorCount > 0) {
      tmpObject.sunVisorCount = [];
    }

    for (var i = 0; i < tmpObject.tissueCount; i++) {
      var centerX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var centerY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var xSize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var ySize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      tmpObject.sunVisorCount.push([centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]);
    }

    if (tmpObject.annualInspectionCount > 0) {
      tmpObject.annualInspectionCount = [];
    }

    for (var i = 0; i < tmpObject.tissueCount; i++) {
      var centerX = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var centerY = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var xSize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      var ySize = (buffer[offset + 1] << 8) + buffer[offset];
      offset += 2;
      tmpObject.annualInspectionCount.push([centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]);
    }

    object.attribute8C.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute8E(buffer, object) {
    if (!object.hasOwnProperty('attribute8E')) {
      object.attribute8E = [];
    }

    var tmpObject = {};
    var offset = 1;
    var len = buffer[offset];
    offset += 1;
    tmpObject.nameCodecFormat = buffer[offset];
    offset += 1;
    var nameLen = buffer[offset];
    offset += 1;
    tmpObject.name = String.fromCharCode.apply(null, buffer.subarray(offset, nameLen));
    object.attribute8E.push(tmpObject);
    return len;
  }

  ;

  function ParseAttribute(buffer, object) {
    var funcMap = {
      0x80: ParseAttribute80,
      0x81: ParseAttribute81,
      0x82: ParseAttribute82,
      0x83: ParseAttribute83,
      0x84: ParseAttribute84,
      0x85: ParseAttribute85,
      0x86: ParseAttribute86,
      0x87: ParseAttribute87,
      0x88: ParseAttribute88,
      0x89: ParseAttribute89,
      0x8C: ParseAttribute8C,
      0x8E: ParseAttribute8E
    };
    var offset = 0;
    var type = buffer[offset];

    while (offset < buffer.length) {
      var tmpBuffer = buffer.subarray(offset, buffer.length);
      var size = funcMap[type].call(null, tmpBuffer, object);
      offset += size;
    }
  }

  ;

  function ParseVehicleObject(buffer, object) {
    ////参见协议2.4.2
    if (!object.hasOwnProperty('vehicleObject')) {
      object.vehicleObject = [];
    }

    var tmpObject = {};
    var offset = 0;
    tmpObject.type = buffer[offset]; //物体类型

    offset += 1;
    offset += 1; ///跳过保留字段

    var objectSize = (buffer[offset + 1] << 8) + buffer[offset]; ///目标长度，包括头和属性包的总长度，至少为8

    offset += 2;
    tmpObject.objectId = (buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset]; ///目标ID

    offset += 4;
    var centerX = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var centerY = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var xSize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    var ySize = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.track = [[centerX - xSize, centerY - ySize, centerX + xSize, centerY + ySize]];
    tmpObject.valid = buffer[offset];
    offset += 1;
    tmpObject.operateType = buffer[offset];
    offset += 1;
    offset += 2; ///保留字段

    var subBuffer = buffer.subarray(offset, objectSize);
    ParseAttribute(subBuffer, tmpObject);
    object.vehicleObject.push(tmpObject);
    return objectSize;
  }

  ;

  function ParseFaceObject(buffer, object) {
    if (!object.hasOwnProperty('faceObject')) {
      object.faceObject = [];
    }

    var tmpObject = {};
    var offset = 0;
    tmpObject.type = buffer[offset]; //物体类型

    offset += 1;
    offset += 1; ///跳过保留字段

    var len = (buffer[offset + 1] << 8) + buffer[offset];

    if (len < 12) {
      ///目标长度(从字节0开始计算至少12)
      return 0;
    }

    offset += 2;
    tmpObject.objectId = (buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset];
    offset += 4;
    tmpObject.version = buffer[offset];
    offset += 1;
    offset += 3;
    tmpObject.faceData = buffer.subarray(offset, len);
    object.faceObject.push(tmpObject);
    return len;
  }

  ;

  function ParseCommonObject(buffer, object) {
    if (!object.hasOwnProperty('commonObject')) {
      object.commonObject = [];
    }

    var tmpObject = {};
    var offset = 0;
    tmpObject.type = buffer[offset]; //物体类型

    offset += 1;
    offset += 1;
    var len = (buffer[offset + 1] << 8) + buffer[offset];
    offset += 2;
    tmpObject.objectId = (buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset];
    offset += 4;
    tmpObject.operateType = buffer[offset];
    offset += 1;
    offset += 3;
    var subBuffer = buffer.subarray(offset, len);
    ParseAttribute(subBuffer, tmpObject);
    object.commonObject.push(tmpObject);
    return len;
  }

  ;
  /**
   * 解析智能结构化信息帧
   * @param buffer 数据
   * @param objInfo 物体信息
   * @param callback 信息回调
   * return 该组数据大小,0解析失败,停止解析
   */

  function ParseGroup(buffer, objInfo, callback) {
    var offset = 0; /// 关联组信息

    var groupId = (buffer[offset + 3] << 24) + (buffer[offset + 2] << 16) + (buffer[offset + 1] << 8) + buffer[offset];
    offset += 4;
    var objCount = buffer[offset];
    offset += 1;
    offset += 3; /// 保留字节

    if (objCount == 0) {
      return offset;
    }

    objInfo.groupId = groupId;
    objInfo.object = {};

    for (var i = 0; i < objCount; i++) {
      var objectType = buffer[offset];
      var subBuffer = buffer.subarray(offset, buffer.length);
      var ret = 0;

      switch (objectType) {
        case 0x02:
        case 0x05:
          ret = ParseVehicleObject(subBuffer, objInfo.object);
          break;

        case 0x0F:
          ret = ParseFaceObject(subBuffer, objInfo.object);
          break;

        default:
          ret = ParseCommonObject(subBuffer, objInfo.object);
          break;
      }

      if (ret == 0) {
        /// /数据异常，停止解析
        return 0;
      }

      offset += ret;
    }

    callback(objInfo);
    return offset;
  }

  ;
  /**
   * 解析智能结构化信息帧
   * @param buffer 数据
   * @param callback 信息回调
   * return true or false 返回失败终止解析，成功继续解析
   */

  function ParseCommObjectSeg(classId, buffer, callback) {
    var objInfo = {
      coordinate: 8192
    };

    if (buffer.length < 32) {
      //objInfo.result = true;
      // callback({ivsDraw: objInfo,timeStamp:timeData});
      return false;
    }

    var offset = 4;
    objInfo.classID = classId;
    var groupCount = buffer[offset];

    if (groupCount == 0) {
      /// 有特殊意义，回调空，表示要清除所有的轨迹
      // callback({ivsDraw: objInfo,timeStamp:timeData});
      return true;
    }

    objInfo.groupCount = groupCount;
    offset += 1;
    offset += 7; ///跳过七个字节保留字段

    objInfo.cameral = []; ///视频描述数据对应的摄像机编号

    for (var i = 0; i < 20; i++) {
      objInfo.cameral.push(buffer[offset + i]);
    }

    offset += 20; // console.log('s'+objInfo.params.groupCount);

    for (var j = 0; j < objInfo.groupCount; j++) {
      // 有问题
      var subBuffer = buffer.subarray(offset, buffer.length);
      var ret = ParseGroup(subBuffer, JSON.parse(JSON.stringify(objInfo)), callback);

      if (ret <= 0) {
        break;
      }

      offset += ret;
    }
  }

  ;
  /**
   * 解析智能分析帧(0x0E)
   * @param buffer 数据
   * @param callback 信息回调
   */

  function ParseAssist0x0e(buffer, callback) {
    var len = buffer.length; /// 缓冲大小

    var offset = 0;

    while (offset + 4 < len) {
      var segType = buffer[offset]; /// 段类型: 0xA1浓缩信息轨迹点类型标志, 0x40+智能结构化信息帧类型标记

      var reserved = buffer[offset + 1]; /// 保留字段

      var segLength = (buffer[offset + 3] << 8) + buffer[offset + 2]; /// 段长度

      var segBuffer = buffer.subarray(offset, segLength);
      offset += segLength;

      if (segType === 0xA1) {
        /// 0xA1浓缩信息轨迹,NVR用,暂不考虑
        continue;
      }

      if (!ParseCommObjectSeg(videoAnalyseType[segType - 0x40], segBuffer, callback)) {
        break;
      }
    }
  }

  ;
  /**
   * 解析不同类型的数据，类型见mTypeMap
   * @param type 数据类型
   * @param dhPayload DH帧
   * @param callback 信息回调
   * return 
   */

  function ParseAssistData(type, dhPayload, callback, channel) {
    var extenLen = dhPayload[22];
    var inputBufferSub = dhPayload.subarray(24 + extenLen, dhPayload.length - 8);

    switch (type) {
      case 0x00:
        //元数据帧,详见大化标准码流格式定义PPT P56
        callback({
          ivsDraw: ParseAssist0x00(inputBufferSub),
          timeStamp: timeData,
          channel: channel
        });
        break;

      case 0x05:
        //智能分析信息
        callback({
          ivsDraw: ParseAssist0x05(inputBufferSub),
          timeStamp: timeData,
          channel: channel
        });
        break;

      case 0x06:
        break;

      case 0x0E:
        var jsonArr = [];

        var tmpCallback = function tmpCallback(json) {
          jsonArr.push(json);
        };

        ParseAssist0x0e(inputBufferSub, tmpCallback);

        if (jsonArr.length) {
          var objectData = {
            result: false,
            type: 0x0E,
            params: jsonArr
          };
          callback({
            ivsDraw: objectData,
            timeStamp: timeData,
            channel: channel
          });
        }

        break;

      case 0x14:
        callback({
          ivsDraw: ParseAssist0x14(inputBufferSub),
          timeStamp: timeData,
          channel: channel
        });
        break;

      default:
        break;
    }
  }

  return new Constructor();
};

/* harmony default export */ var ivsSession = (ivsSession_IvsSession);
// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--5!./src/videoWorker.worker.js
//处理视频数据和辅助帧的子线程
//实例化session并将数据传入
//将session处理后的数据传递到主线程的workermanager





importScripts('./../module/ffmpegasm.js');
addEventListener('message', receiveMessage, false);

Module.onRuntimeInitialized = function () {
  Module._RegisterAll();

  sendMessage('WorkerReady');
};

var videoRtpSessionsArray = [];
var sdpInfo = null;
var rtpSession = null;
var videoWorker_worker_decodeMode = "";
var isBackupCommand = false;
var isStepPlay = false;
var isForward = true;
var videoWorker_worker_framerate = 0;
var backupFrameInfo = null;
var videoCHID = -1;
var videoWorker_worker_h264Session = null;
var videoWorker_worker_h265Session = null;
var videoWorker_worker_mjpegSession = null;
var videoWorker_worker_ivsSession = null;
var channelId = null;
var videoWorker_worker_dropout = 1;

function receiveMessage(event) {
  var message = event.data;
  channelId = event.data.channelId;

  switch (message.type) {
    case 'sdpInfo':
      sdpInfo = message.data;
      videoWorker_worker_framerate = 0;
      setVideoRtpSession(sdpInfo);
      break;

    case 'MediaData':
      if (isStepPlay === true) {
        buffering(message);
        break;
      }

      videoCHID = message.data.rtspInterleave[1];

      if (typeof videoRtpSessionsArray[videoCHID] !== "undefined") {
        videoRtpSessionsArray[videoCHID].parseRTPData(message.data.rtspInterleave, message.data.payload, isBackupCommand, videoWorker_worker_dropout, message.info, message.channel);
      }

      break;

    case 'initStartTime':
      videoRtpSessionsArray[videoCHID].initStartTime();
      break;

    case 'end':
      sendMessage('end');
      break;

    default:
      break;
  }
}

function setVideoRtpSession(data) {
  videoRtpSessionsArray = [];
  isStepPlay = false;

  for (var sdpIndex = 0; sdpIndex < data.sdpInfo.length; sdpIndex++) {
    rtpSession = null;
    videoWorker_worker_decodeMode = data.decodeMode;

    if (data.sdpInfo[sdpIndex].codecName === 'H264' || data.sdpInfo[sdpIndex].codecName === 'RAW' && data.mp4Codec && data.mp4Codec.VideoCodec === 'H264') {
      if (videoWorker_worker_h264Session === null) {
        videoWorker_worker_h264Session = h264Session();
      }

      rtpSession = videoWorker_worker_h264Session;
      rtpSession.init(data.decodeMode);
      rtpSession.setFramerate(data.sdpInfo[sdpIndex].Framerate);
      rtpSession.setGovLength(data.govLength);
      rtpSession.setCheckDelay(data.checkDelay);
      rtpSession.setLessRate(data.lessRateCanvas);
    } else if (data.sdpInfo[sdpIndex].codecName === 'H265' || data.sdpInfo[sdpIndex].codecName === 'RAW' && data.mp4Codec && data.mp4Codec.VideoCodec === 'H265') {
      if (videoWorker_worker_h265Session === null) {
        videoWorker_worker_h265Session = h265Session();
      }

      rtpSession = videoWorker_worker_h265Session;
      rtpSession.init();
      rtpSession.setFramerate(data.sdpInfo[sdpIndex].Framerate);
      rtpSession.setGovLength(data.govLength);
      rtpSession.setCheckDelay(data.checkDelay);
    } else if (data.sdpInfo[sdpIndex].codecName === 'JPEG') {
      if (videoWorker_worker_mjpegSession === null) {
        videoWorker_worker_mjpegSession = mjpegSession();
      }

      rtpSession = videoWorker_worker_mjpegSession;
      rtpSession.init();
      rtpSession.setFramerate(data.sdpInfo[sdpIndex].Framerate);
    } else if (data.sdpInfo[sdpIndex].codecName === 'stream-assist-frame') {
      debug.log(data.sdpInfo[sdpIndex]);

      if (videoWorker_worker_ivsSession === null) {
        videoWorker_worker_ivsSession = ivsSession();
      }

      rtpSession = videoWorker_worker_ivsSession;
      rtpSession.init();
    }

    if (typeof data.sdpInfo[sdpIndex].Framerate !== "undefined") {
      videoWorker_worker_framerate = data.sdpInfo[sdpIndex].Framerate;
    }

    if (rtpSession !== null) {
      rtpSession.setBufferfullCallback(BufferFullCallback);
      rtpSession.setReturnCallback(RtpReturnCallback);
      videoCHID = data.sdpInfo[sdpIndex].RtpInterlevedID;
      videoRtpSessionsArray[videoCHID] = rtpSession;
    }
  }
}

function buffering(message) {
  videoCHID = message.data.rtspInterleave[1];

  if (typeof videoRtpSessionsArray[videoCHID] !== "undefined") {
    videoRtpSessionsArray[videoCHID].bufferingRtpData(message.data.rtspInterleave, message.data.header, message.data.payload);
  }
}

function BufferFullCallback() {
  videoRtpSessionsArray[videoCHID].findCurrent();
  sendMessage('stepPlay', 'BufferFull');
}

function RtpReturnCallback(dataInfo) {
  var mediaData = null;
  var backupData = null;

  if (dataInfo === null || typeof dataInfo === "undefined") {
    mediaData = null;
    backupData = null;
    return;
  } else if (typeof dataInfo.error !== "undefined") {
    sendMessage('error', dataInfo.error);
    mediaData = dataInfo.decodedData; //return;
  } else {
    mediaData = dataInfo.decodedData;

    if (dataInfo.decodeMode !== null && typeof dataInfo.decodeMode !== "undefined") {
      videoWorker_worker_decodeMode = dataInfo.decodeMode;
      sendMessage('setVideoTagMode', dataInfo.decodeMode);
    } //if (dataInfo.backupData !== null && typeof dataInfo.backupData !== "undefined") {
    //    backupData = cloneArray(dataInfo.backupData.stream);
    //    dataInfo.backupData.stream = null;
    //}
    //if (dataInfo.throughPut !== null && typeof dataInfo.throughPut !== "undefined") {
    //    sendMessage('throughPut', dataInfo.throughPut);
    //}

  }

  if (dataInfo.decodeStart != null) {
    sendMessage('DecodeStart', dataInfo.decodeStart);
    videoWorker_worker_decodeMode = dataInfo.decodeStart.decodeMode;
  }

  if (mediaData !== null && typeof mediaData !== "undefined") {
    //if (mediaData.playback !== null && typeof mediaData.playback !== "undefined") {
    //    sendMessage('playbackFlag', mediaData.playback);
    //}
    if (mediaData.frameData !== undefined && mediaData.frameData !== null && videoWorker_worker_decodeMode === "canvas") {
      if (mediaData.frameData.firstFrame === true) {
        sendMessage('firstFrame', mediaData.frameData.firstFrame); //return;
      }

      var frameInfo = {
        'bufferIdx': mediaData.frameData.bufferIdx,
        'width': mediaData.frameData.width,
        'height': mediaData.frameData.height,
        'codecType': mediaData.frameData.codecType,
        'frameType': mediaData.frameData.frameType,
        'timeStamp': null,
        'frameIndex': mediaData.frameData.frameIndex
      };

      if (mediaData.timeStamp !== null && typeof mediaData.timeStamp !== "undefined") {
        frameInfo.timeStamp = mediaData.timeStamp;
      }

      sendMessage('videoInfo', frameInfo);

      if (typeof mediaData.frameData.data !== "undefined" && mediaData.frameData.data !== null) {
        sendMessage('canvasRender', mediaData.frameData.data, mediaData.frameData.option);
      }
    } else if (mediaData.frameData !== null && videoWorker_worker_decodeMode === "video") {
      if (mediaData.initSegmentData !== null) {
        sendMessage('codecInfo', mediaData.codecInfo);
        sendMessage('initSegment', mediaData.initSegmentData);
      }

      var frameInfo = {
        'codecType': mediaData.frameData.codecType,
        'frameIndex': mediaData.frameData.frameIndex
      };

      if (typeof mediaData.frameData.width !== "undefined") {
        frameInfo.width = mediaData.frameData.width;
        frameInfo.height = mediaData.frameData.height;
      }

      sendMessage('videoInfo', frameInfo);
      sendMessage('videoTimeStamp', mediaData.timeStamp);

      if (mediaData.frameData.length > 0) {
        sendMessage('mediaSample', mediaData.mediaSample);
        sendMessage('videoRender', mediaData.frameData);
      }
    } else {
      sendMessage('drop', dataInfo.decodedData);
    }
  }

  if (dataInfo.resolution != null) {
    sendMessage('MSEResolutionChanged', dataInfo.resolution);
  }

  if (dataInfo.ivsDraw != null) {
    sendMessage('ivsDraw', dataInfo);
  }
}

function sendMessage(type, data, option) {
  var event = {
    'type': type,
    'data': data,
    'channelId': channelId,
    'option': option
  };

  if (type === 'canvasRender') {
    postMessage(event, [data.buffer]);
  } else {
    postMessage(event);
  }
}

function videoWorker_worker_VideoBufferList() {
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
      bufferFullCallback !== null && this._length >= BUFFERING ? bufferFullCallback() : 0; //PLAYBACK bufferFull
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
        while (currentNode.frameType !== "I") {
          currentNode = currentNode.next;
          count++;
        }
      } else {
        while (currentNode.frameType !== "I") {
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

/***/ })
/******/ ]);