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
// CONCATENATED MODULE: ./node_modules/babel-loader/lib??ref--5!./src/videoWorkerTrain.worker.js
//处理视频数据和辅助帧的子线程
//实例化session并将数据传入
//将session处理后的数据传递到主线程的workermanager



importScripts('./../module/ffmpegasm.js');
addEventListener('message', receiveMessage, false);

Module.onRuntimeInitialized = function () {
  Module._RegisterAll();

  sendMessage('WorkerReady');
};

var h264Session = null;
var channelId = null;
var videoCHID = null;

function receiveMessage(event) {
  var message = event.data;
  channelId = event.data.channelId;

  switch (message.type) {
    case 'MediaData':
      if (h264Session === null) {
        h264Session = new videoWorkerTrain_worker_H264SessionTrain();
      }

      videoCHID = message.data.rtspInterleave[1];
      h264Session.parseRTPData(message.data.payload);
      break;

    default:
      break;
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

var videoWorkerTrain_worker_H264SessionTrain = function H264SessionTrain() {
  var rtpTimeStamp = 0,
      SPSParser = new H264SPSParser();
  var outputSize = 0;
  var curSize = null;
  var currTime, preTime;

  function Constructor() {
    this.decoder = new h264Decoder(); //new H264Decoder();
  }

  Constructor.prototype = {
    init: function init(mode) {},
    parseRTPData: function parseRTPData(dhPayload) {
      var PAYLOAD = null,
          extensionHeaderLen = 0,
          PaddingSize = 0,
          data = {};
      var decodedData = {};
      var extenLen = dhPayload[22];
      var frameNo = (dhPayload[11] << 24) + (dhPayload[10] << 16) + (dhPayload[9] << 8) + dhPayload[8] >>> 0;
      var inputBufferSub = dhPayload.subarray(24 + extenLen, dhPayload.length - 8);
      var end = dhPayload.subarray(dhPayload.length - 8, dhPayload.length);
      var frameLength = (end[7] << 24) + (end[6] << 16) + (end[5] << 8) + end[4];
      var currTime = (dhPayload[19] << 24) + (dhPayload[18] << 16) + (dhPayload[17] << 8) + dhPayload[16] >>> 0;
      var lsw = Date.UTC('20' + (currTime >>> 26), (currTime >>> 22 & 0x0f) - 1, currTime >>> 17 & 0x1f, currTime >>> 12 & 0x1f, currTime >>> 6 & 0x3f, currTime & 0x3f) / 1000;
      var pos = [];
      lsw = lsw + new Date().getTimezoneOffset() / 60 * 3600; //转换成当前时区的时间

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
            SPSParser.parse(PAYLOAD);
            curSize = SPSParser.getSizeInfo().decodeSize;
            break;

          case 8:
            break;

          case 6:
            break;

          case 9:
            break;
        }
      }

      if (outputSize !== curSize) {
        this.decoder.free(); //如果播放中切换分辨率，需要释放内存（按照ffmpeg要求）

        outputSize = curSize;
        this.decoder.setOutputSize(outputSize);
      }

      decodedData.frameData = null;
      decodedData.frameData = this.decoder.decode(inputBufferSub);

      if (decodedData.frameData != null && decodedData.frameData.data != null) {
        // 需要存储帧数据，因此这里去掉时间的判断
        // if(lsw !== preTime){
        decodedData.frameData.option.time = lsw;
        decodedData.frameData.option.frameNo = frameNo;
        sendMessage('canvasRender', decodedData.frameData.data, decodedData.frameData.option); // }
        // preTime = lsw;
      }
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

/***/ })
/******/ ]);