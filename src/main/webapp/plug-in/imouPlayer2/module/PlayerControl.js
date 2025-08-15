var PlayerControl =
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
/******/ 	return __webpack_require__(__webpack_require__.s = 75);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = {
  ATOM_MOOV: 'moov',
  ATOM_MVHD: 'mvhd',
  ATOM_TRAK: 'trak',
  ATOM_TKHD: 'tkhd',
  ATOM_MDIA: 'mdia',
  ATOM_MDHD: 'mdhd',
  ATOM_MINF: 'minf',
  ATOM_HDLR: 'hdlr',
  ATOM_VMHD: 'vmhd',
  ATOM_SMHD: 'smhd',
  ATOM_STBL: 'stbl',
  ATOM_STSZ: 'stsz',
  ATOM_STCO: 'stco',
  ATOM_STSS: 'stss',
  ATOM_STTS: 'stts',
  ATOM_STSC: 'stsc',
  ATOM_CO64: 'co64',
  ATOM_STSD: 'stsd',
  ATOM_CTTS: 'ctts',
  ATOM_AVC1: 'avc1',
  ATOM_AVCC: 'avcC',
  ATOM_HEV1: 'hev1',
  ATOM_HVC1: 'hvc1',
  ATOM_HVCC: 'hvcC',
  ATOM_MP4A: 'mp4a',
  ATOM_ESDS: 'esds',
  ATOM_MDAT: 'mdat',
  ATOM_FTYP: 'ftyp',
  TRACK_TYPE_VIDEO: 'vide',
  TRACK_TYPE_AUDIO: 'soun',
  COMPONENT_NAME_VIDEO: 'VideoHandler',
  COMPONENT_NAME_AUDIO: 'SoundHandler',
  COMPRESSOR_NAME: 'NodeVideoLibrary',
  // should be exactly 16 symbols
  createAtom: function createAtom(type) {
    var AtomClass = __webpack_require__(63)("./atom-" + type);

    return new AtomClass();
  }
};

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Atom = /*#__PURE__*/function () {
  function Atom() {
    _classCallCheck(this, Atom);
  }

  _createClass(Atom, [{
    key: "type",
    value: function type() {}
  }, {
    key: "parse",
    value: function parse() {}
  }, {
    key: "build",
    value: function build() {}
  }, {
    key: "bufferSize",
    value: function bufferSize() {}
  }]);

  return Atom;
}();

module.exports = Atom;

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(global) {/*!
 * The buffer module from node.js, for the browser.
 *
 * @author   Feross Aboukhadijeh <http://feross.org>
 * @license  MIT
 */
/* eslint-disable no-proto */



var base64 = __webpack_require__(57)
var ieee754 = __webpack_require__(58)
var isArray = __webpack_require__(59)

exports.Buffer = Buffer
exports.SlowBuffer = SlowBuffer
exports.INSPECT_MAX_BYTES = 50

/**
 * If `Buffer.TYPED_ARRAY_SUPPORT`:
 *   === true    Use Uint8Array implementation (fastest)
 *   === false   Use Object implementation (most compatible, even IE6)
 *
 * Browsers that support typed arrays are IE 10+, Firefox 4+, Chrome 7+, Safari 5.1+,
 * Opera 11.6+, iOS 4.2+.
 *
 * Due to various browser bugs, sometimes the Object implementation will be used even
 * when the browser supports typed arrays.
 *
 * Note:
 *
 *   - Firefox 4-29 lacks support for adding new properties to `Uint8Array` instances,
 *     See: https://bugzilla.mozilla.org/show_bug.cgi?id=695438.
 *
 *   - Chrome 9-10 is missing the `TypedArray.prototype.subarray` function.
 *
 *   - IE10 has a broken `TypedArray.prototype.subarray` function which returns arrays of
 *     incorrect length in some situations.

 * We detect these buggy browsers and set `Buffer.TYPED_ARRAY_SUPPORT` to `false` so they
 * get the Object implementation, which is slower but behaves correctly.
 */
Buffer.TYPED_ARRAY_SUPPORT = global.TYPED_ARRAY_SUPPORT !== undefined
  ? global.TYPED_ARRAY_SUPPORT
  : typedArraySupport()

/*
 * Export kMaxLength after typed array support is determined.
 */
exports.kMaxLength = kMaxLength()

function typedArraySupport () {
  try {
    var arr = new Uint8Array(1)
    arr.__proto__ = {__proto__: Uint8Array.prototype, foo: function () { return 42 }}
    return arr.foo() === 42 && // typed array instances can be augmented
        typeof arr.subarray === 'function' && // chrome 9-10 lack `subarray`
        arr.subarray(1, 1).byteLength === 0 // ie10 has broken `subarray`
  } catch (e) {
    return false
  }
}

function kMaxLength () {
  return Buffer.TYPED_ARRAY_SUPPORT
    ? 0x7fffffff
    : 0x3fffffff
}

function createBuffer (that, length) {
  if (kMaxLength() < length) {
    throw new RangeError('Invalid typed array length')
  }
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    // Return an augmented `Uint8Array` instance, for best performance
    that = new Uint8Array(length)
    that.__proto__ = Buffer.prototype
  } else {
    // Fallback: Return an object instance of the Buffer class
    if (that === null) {
      that = new Buffer(length)
    }
    that.length = length
  }

  return that
}

/**
 * The Buffer constructor returns instances of `Uint8Array` that have their
 * prototype changed to `Buffer.prototype`. Furthermore, `Buffer` is a subclass of
 * `Uint8Array`, so the returned instances will have all the node `Buffer` methods
 * and the `Uint8Array` methods. Square bracket notation works as expected -- it
 * returns a single octet.
 *
 * The `Uint8Array` prototype remains unmodified.
 */

function Buffer (arg, encodingOrOffset, length) {
  if (!Buffer.TYPED_ARRAY_SUPPORT && !(this instanceof Buffer)) {
    return new Buffer(arg, encodingOrOffset, length)
  }

  // Common case.
  if (typeof arg === 'number') {
    if (typeof encodingOrOffset === 'string') {
      throw new Error(
        'If encoding is specified then the first argument must be a string'
      )
    }
    return allocUnsafe(this, arg)
  }
  return from(this, arg, encodingOrOffset, length)
}

Buffer.poolSize = 8192 // not used by this implementation

// TODO: Legacy, not needed anymore. Remove in next major version.
Buffer._augment = function (arr) {
  arr.__proto__ = Buffer.prototype
  return arr
}

function from (that, value, encodingOrOffset, length) {
  if (typeof value === 'number') {
    throw new TypeError('"value" argument must not be a number')
  }

  if (typeof ArrayBuffer !== 'undefined' && value instanceof ArrayBuffer) {
    return fromArrayBuffer(that, value, encodingOrOffset, length)
  }

  if (typeof value === 'string') {
    return fromString(that, value, encodingOrOffset)
  }

  return fromObject(that, value)
}

/**
 * Functionally equivalent to Buffer(arg, encoding) but throws a TypeError
 * if value is a number.
 * Buffer.from(str[, encoding])
 * Buffer.from(array)
 * Buffer.from(buffer)
 * Buffer.from(arrayBuffer[, byteOffset[, length]])
 **/
Buffer.from = function (value, encodingOrOffset, length) {
  return from(null, value, encodingOrOffset, length)
}

if (Buffer.TYPED_ARRAY_SUPPORT) {
  Buffer.prototype.__proto__ = Uint8Array.prototype
  Buffer.__proto__ = Uint8Array
  if (typeof Symbol !== 'undefined' && Symbol.species &&
      Buffer[Symbol.species] === Buffer) {
    // Fix subarray() in ES2016. See: https://github.com/feross/buffer/pull/97
    Object.defineProperty(Buffer, Symbol.species, {
      value: null,
      configurable: true
    })
  }
}

function assertSize (size) {
  if (typeof size !== 'number') {
    throw new TypeError('"size" argument must be a number')
  } else if (size < 0) {
    throw new RangeError('"size" argument must not be negative')
  }
}

function alloc (that, size, fill, encoding) {
  assertSize(size)
  if (size <= 0) {
    return createBuffer(that, size)
  }
  if (fill !== undefined) {
    // Only pay attention to encoding if it's a string. This
    // prevents accidentally sending in a number that would
    // be interpretted as a start offset.
    return typeof encoding === 'string'
      ? createBuffer(that, size).fill(fill, encoding)
      : createBuffer(that, size).fill(fill)
  }
  return createBuffer(that, size)
}

/**
 * Creates a new filled Buffer instance.
 * alloc(size[, fill[, encoding]])
 **/
Buffer.alloc = function (size, fill, encoding) {
  return alloc(null, size, fill, encoding)
}

function allocUnsafe (that, size) {
  assertSize(size)
  that = createBuffer(that, size < 0 ? 0 : checked(size) | 0)
  if (!Buffer.TYPED_ARRAY_SUPPORT) {
    for (var i = 0; i < size; ++i) {
      that[i] = 0
    }
  }
  return that
}

/**
 * Equivalent to Buffer(num), by default creates a non-zero-filled Buffer instance.
 * */
Buffer.allocUnsafe = function (size) {
  return allocUnsafe(null, size)
}
/**
 * Equivalent to SlowBuffer(num), by default creates a non-zero-filled Buffer instance.
 */
Buffer.allocUnsafeSlow = function (size) {
  return allocUnsafe(null, size)
}

function fromString (that, string, encoding) {
  if (typeof encoding !== 'string' || encoding === '') {
    encoding = 'utf8'
  }

  if (!Buffer.isEncoding(encoding)) {
    throw new TypeError('"encoding" must be a valid string encoding')
  }

  var length = byteLength(string, encoding) | 0
  that = createBuffer(that, length)

  var actual = that.write(string, encoding)

  if (actual !== length) {
    // Writing a hex string, for example, that contains invalid characters will
    // cause everything after the first invalid character to be ignored. (e.g.
    // 'abxxcd' will be treated as 'ab')
    that = that.slice(0, actual)
  }

  return that
}

function fromArrayLike (that, array) {
  var length = array.length < 0 ? 0 : checked(array.length) | 0
  that = createBuffer(that, length)
  for (var i = 0; i < length; i += 1) {
    that[i] = array[i] & 255
  }
  return that
}

function fromArrayBuffer (that, array, byteOffset, length) {
  array.byteLength // this throws if `array` is not a valid ArrayBuffer

  if (byteOffset < 0 || array.byteLength < byteOffset) {
    throw new RangeError('\'offset\' is out of bounds')
  }

  if (array.byteLength < byteOffset + (length || 0)) {
    throw new RangeError('\'length\' is out of bounds')
  }

  if (byteOffset === undefined && length === undefined) {
    array = new Uint8Array(array)
  } else if (length === undefined) {
    array = new Uint8Array(array, byteOffset)
  } else {
    array = new Uint8Array(array, byteOffset, length)
  }

  if (Buffer.TYPED_ARRAY_SUPPORT) {
    // Return an augmented `Uint8Array` instance, for best performance
    that = array
    that.__proto__ = Buffer.prototype
  } else {
    // Fallback: Return an object instance of the Buffer class
    that = fromArrayLike(that, array)
  }
  return that
}

function fromObject (that, obj) {
  if (Buffer.isBuffer(obj)) {
    var len = checked(obj.length) | 0
    that = createBuffer(that, len)

    if (that.length === 0) {
      return that
    }

    obj.copy(that, 0, 0, len)
    return that
  }

  if (obj) {
    if ((typeof ArrayBuffer !== 'undefined' &&
        obj.buffer instanceof ArrayBuffer) || 'length' in obj) {
      if (typeof obj.length !== 'number' || isnan(obj.length)) {
        return createBuffer(that, 0)
      }
      return fromArrayLike(that, obj)
    }

    if (obj.type === 'Buffer' && isArray(obj.data)) {
      return fromArrayLike(that, obj.data)
    }
  }

  throw new TypeError('First argument must be a string, Buffer, ArrayBuffer, Array, or array-like object.')
}

function checked (length) {
  // Note: cannot use `length < kMaxLength()` here because that fails when
  // length is NaN (which is otherwise coerced to zero.)
  if (length >= kMaxLength()) {
    throw new RangeError('Attempt to allocate Buffer larger than maximum ' +
                         'size: 0x' + kMaxLength().toString(16) + ' bytes')
  }
  return length | 0
}

function SlowBuffer (length) {
  if (+length != length) { // eslint-disable-line eqeqeq
    length = 0
  }
  return Buffer.alloc(+length)
}

Buffer.isBuffer = function isBuffer (b) {
  return !!(b != null && b._isBuffer)
}

Buffer.compare = function compare (a, b) {
  if (!Buffer.isBuffer(a) || !Buffer.isBuffer(b)) {
    throw new TypeError('Arguments must be Buffers')
  }

  if (a === b) return 0

  var x = a.length
  var y = b.length

  for (var i = 0, len = Math.min(x, y); i < len; ++i) {
    if (a[i] !== b[i]) {
      x = a[i]
      y = b[i]
      break
    }
  }

  if (x < y) return -1
  if (y < x) return 1
  return 0
}

Buffer.isEncoding = function isEncoding (encoding) {
  switch (String(encoding).toLowerCase()) {
    case 'hex':
    case 'utf8':
    case 'utf-8':
    case 'ascii':
    case 'latin1':
    case 'binary':
    case 'base64':
    case 'ucs2':
    case 'ucs-2':
    case 'utf16le':
    case 'utf-16le':
      return true
    default:
      return false
  }
}

Buffer.concat = function concat (list, length) {
  if (!isArray(list)) {
    throw new TypeError('"list" argument must be an Array of Buffers')
  }

  if (list.length === 0) {
    return Buffer.alloc(0)
  }

  var i
  if (length === undefined) {
    length = 0
    for (i = 0; i < list.length; ++i) {
      length += list[i].length
    }
  }

  var buffer = Buffer.allocUnsafe(length)
  var pos = 0
  for (i = 0; i < list.length; ++i) {
    var buf = list[i]
    if (!Buffer.isBuffer(buf)) {
      throw new TypeError('"list" argument must be an Array of Buffers')
    }
    buf.copy(buffer, pos)
    pos += buf.length
  }
  return buffer
}

function byteLength (string, encoding) {
  if (Buffer.isBuffer(string)) {
    return string.length
  }
  if (typeof ArrayBuffer !== 'undefined' && typeof ArrayBuffer.isView === 'function' &&
      (ArrayBuffer.isView(string) || string instanceof ArrayBuffer)) {
    return string.byteLength
  }
  if (typeof string !== 'string') {
    string = '' + string
  }

  var len = string.length
  if (len === 0) return 0

  // Use a for loop to avoid recursion
  var loweredCase = false
  for (;;) {
    switch (encoding) {
      case 'ascii':
      case 'latin1':
      case 'binary':
        return len
      case 'utf8':
      case 'utf-8':
      case undefined:
        return utf8ToBytes(string).length
      case 'ucs2':
      case 'ucs-2':
      case 'utf16le':
      case 'utf-16le':
        return len * 2
      case 'hex':
        return len >>> 1
      case 'base64':
        return base64ToBytes(string).length
      default:
        if (loweredCase) return utf8ToBytes(string).length // assume utf8
        encoding = ('' + encoding).toLowerCase()
        loweredCase = true
    }
  }
}
Buffer.byteLength = byteLength

function slowToString (encoding, start, end) {
  var loweredCase = false

  // No need to verify that "this.length <= MAX_UINT32" since it's a read-only
  // property of a typed array.

  // This behaves neither like String nor Uint8Array in that we set start/end
  // to their upper/lower bounds if the value passed is out of range.
  // undefined is handled specially as per ECMA-262 6th Edition,
  // Section 13.3.3.7 Runtime Semantics: KeyedBindingInitialization.
  if (start === undefined || start < 0) {
    start = 0
  }
  // Return early if start > this.length. Done here to prevent potential uint32
  // coercion fail below.
  if (start > this.length) {
    return ''
  }

  if (end === undefined || end > this.length) {
    end = this.length
  }

  if (end <= 0) {
    return ''
  }

  // Force coersion to uint32. This will also coerce falsey/NaN values to 0.
  end >>>= 0
  start >>>= 0

  if (end <= start) {
    return ''
  }

  if (!encoding) encoding = 'utf8'

  while (true) {
    switch (encoding) {
      case 'hex':
        return hexSlice(this, start, end)

      case 'utf8':
      case 'utf-8':
        return utf8Slice(this, start, end)

      case 'ascii':
        return asciiSlice(this, start, end)

      case 'latin1':
      case 'binary':
        return latin1Slice(this, start, end)

      case 'base64':
        return base64Slice(this, start, end)

      case 'ucs2':
      case 'ucs-2':
      case 'utf16le':
      case 'utf-16le':
        return utf16leSlice(this, start, end)

      default:
        if (loweredCase) throw new TypeError('Unknown encoding: ' + encoding)
        encoding = (encoding + '').toLowerCase()
        loweredCase = true
    }
  }
}

// The property is used by `Buffer.isBuffer` and `is-buffer` (in Safari 5-7) to detect
// Buffer instances.
Buffer.prototype._isBuffer = true

function swap (b, n, m) {
  var i = b[n]
  b[n] = b[m]
  b[m] = i
}

Buffer.prototype.swap16 = function swap16 () {
  var len = this.length
  if (len % 2 !== 0) {
    throw new RangeError('Buffer size must be a multiple of 16-bits')
  }
  for (var i = 0; i < len; i += 2) {
    swap(this, i, i + 1)
  }
  return this
}

Buffer.prototype.swap32 = function swap32 () {
  var len = this.length
  if (len % 4 !== 0) {
    throw new RangeError('Buffer size must be a multiple of 32-bits')
  }
  for (var i = 0; i < len; i += 4) {
    swap(this, i, i + 3)
    swap(this, i + 1, i + 2)
  }
  return this
}

Buffer.prototype.swap64 = function swap64 () {
  var len = this.length
  if (len % 8 !== 0) {
    throw new RangeError('Buffer size must be a multiple of 64-bits')
  }
  for (var i = 0; i < len; i += 8) {
    swap(this, i, i + 7)
    swap(this, i + 1, i + 6)
    swap(this, i + 2, i + 5)
    swap(this, i + 3, i + 4)
  }
  return this
}

Buffer.prototype.toString = function toString () {
  var length = this.length | 0
  if (length === 0) return ''
  if (arguments.length === 0) return utf8Slice(this, 0, length)
  return slowToString.apply(this, arguments)
}

Buffer.prototype.equals = function equals (b) {
  if (!Buffer.isBuffer(b)) throw new TypeError('Argument must be a Buffer')
  if (this === b) return true
  return Buffer.compare(this, b) === 0
}

Buffer.prototype.inspect = function inspect () {
  var str = ''
  var max = exports.INSPECT_MAX_BYTES
  if (this.length > 0) {
    str = this.toString('hex', 0, max).match(/.{2}/g).join(' ')
    if (this.length > max) str += ' ... '
  }
  return '<Buffer ' + str + '>'
}

Buffer.prototype.compare = function compare (target, start, end, thisStart, thisEnd) {
  if (!Buffer.isBuffer(target)) {
    throw new TypeError('Argument must be a Buffer')
  }

  if (start === undefined) {
    start = 0
  }
  if (end === undefined) {
    end = target ? target.length : 0
  }
  if (thisStart === undefined) {
    thisStart = 0
  }
  if (thisEnd === undefined) {
    thisEnd = this.length
  }

  if (start < 0 || end > target.length || thisStart < 0 || thisEnd > this.length) {
    throw new RangeError('out of range index')
  }

  if (thisStart >= thisEnd && start >= end) {
    return 0
  }
  if (thisStart >= thisEnd) {
    return -1
  }
  if (start >= end) {
    return 1
  }

  start >>>= 0
  end >>>= 0
  thisStart >>>= 0
  thisEnd >>>= 0

  if (this === target) return 0

  var x = thisEnd - thisStart
  var y = end - start
  var len = Math.min(x, y)

  var thisCopy = this.slice(thisStart, thisEnd)
  var targetCopy = target.slice(start, end)

  for (var i = 0; i < len; ++i) {
    if (thisCopy[i] !== targetCopy[i]) {
      x = thisCopy[i]
      y = targetCopy[i]
      break
    }
  }

  if (x < y) return -1
  if (y < x) return 1
  return 0
}

// Finds either the first index of `val` in `buffer` at offset >= `byteOffset`,
// OR the last index of `val` in `buffer` at offset <= `byteOffset`.
//
// Arguments:
// - buffer - a Buffer to search
// - val - a string, Buffer, or number
// - byteOffset - an index into `buffer`; will be clamped to an int32
// - encoding - an optional encoding, relevant is val is a string
// - dir - true for indexOf, false for lastIndexOf
function bidirectionalIndexOf (buffer, val, byteOffset, encoding, dir) {
  // Empty buffer means no match
  if (buffer.length === 0) return -1

  // Normalize byteOffset
  if (typeof byteOffset === 'string') {
    encoding = byteOffset
    byteOffset = 0
  } else if (byteOffset > 0x7fffffff) {
    byteOffset = 0x7fffffff
  } else if (byteOffset < -0x80000000) {
    byteOffset = -0x80000000
  }
  byteOffset = +byteOffset  // Coerce to Number.
  if (isNaN(byteOffset)) {
    // byteOffset: it it's undefined, null, NaN, "foo", etc, search whole buffer
    byteOffset = dir ? 0 : (buffer.length - 1)
  }

  // Normalize byteOffset: negative offsets start from the end of the buffer
  if (byteOffset < 0) byteOffset = buffer.length + byteOffset
  if (byteOffset >= buffer.length) {
    if (dir) return -1
    else byteOffset = buffer.length - 1
  } else if (byteOffset < 0) {
    if (dir) byteOffset = 0
    else return -1
  }

  // Normalize val
  if (typeof val === 'string') {
    val = Buffer.from(val, encoding)
  }

  // Finally, search either indexOf (if dir is true) or lastIndexOf
  if (Buffer.isBuffer(val)) {
    // Special case: looking for empty string/buffer always fails
    if (val.length === 0) {
      return -1
    }
    return arrayIndexOf(buffer, val, byteOffset, encoding, dir)
  } else if (typeof val === 'number') {
    val = val & 0xFF // Search for a byte value [0-255]
    if (Buffer.TYPED_ARRAY_SUPPORT &&
        typeof Uint8Array.prototype.indexOf === 'function') {
      if (dir) {
        return Uint8Array.prototype.indexOf.call(buffer, val, byteOffset)
      } else {
        return Uint8Array.prototype.lastIndexOf.call(buffer, val, byteOffset)
      }
    }
    return arrayIndexOf(buffer, [ val ], byteOffset, encoding, dir)
  }

  throw new TypeError('val must be string, number or Buffer')
}

function arrayIndexOf (arr, val, byteOffset, encoding, dir) {
  var indexSize = 1
  var arrLength = arr.length
  var valLength = val.length

  if (encoding !== undefined) {
    encoding = String(encoding).toLowerCase()
    if (encoding === 'ucs2' || encoding === 'ucs-2' ||
        encoding === 'utf16le' || encoding === 'utf-16le') {
      if (arr.length < 2 || val.length < 2) {
        return -1
      }
      indexSize = 2
      arrLength /= 2
      valLength /= 2
      byteOffset /= 2
    }
  }

  function read (buf, i) {
    if (indexSize === 1) {
      return buf[i]
    } else {
      return buf.readUInt16BE(i * indexSize)
    }
  }

  var i
  if (dir) {
    var foundIndex = -1
    for (i = byteOffset; i < arrLength; i++) {
      if (read(arr, i) === read(val, foundIndex === -1 ? 0 : i - foundIndex)) {
        if (foundIndex === -1) foundIndex = i
        if (i - foundIndex + 1 === valLength) return foundIndex * indexSize
      } else {
        if (foundIndex !== -1) i -= i - foundIndex
        foundIndex = -1
      }
    }
  } else {
    if (byteOffset + valLength > arrLength) byteOffset = arrLength - valLength
    for (i = byteOffset; i >= 0; i--) {
      var found = true
      for (var j = 0; j < valLength; j++) {
        if (read(arr, i + j) !== read(val, j)) {
          found = false
          break
        }
      }
      if (found) return i
    }
  }

  return -1
}

Buffer.prototype.includes = function includes (val, byteOffset, encoding) {
  return this.indexOf(val, byteOffset, encoding) !== -1
}

Buffer.prototype.indexOf = function indexOf (val, byteOffset, encoding) {
  return bidirectionalIndexOf(this, val, byteOffset, encoding, true)
}

Buffer.prototype.lastIndexOf = function lastIndexOf (val, byteOffset, encoding) {
  return bidirectionalIndexOf(this, val, byteOffset, encoding, false)
}

function hexWrite (buf, string, offset, length) {
  offset = Number(offset) || 0
  var remaining = buf.length - offset
  if (!length) {
    length = remaining
  } else {
    length = Number(length)
    if (length > remaining) {
      length = remaining
    }
  }

  // must be an even number of digits
  var strLen = string.length
  if (strLen % 2 !== 0) throw new TypeError('Invalid hex string')

  if (length > strLen / 2) {
    length = strLen / 2
  }
  for (var i = 0; i < length; ++i) {
    var parsed = parseInt(string.substr(i * 2, 2), 16)
    if (isNaN(parsed)) return i
    buf[offset + i] = parsed
  }
  return i
}

function utf8Write (buf, string, offset, length) {
  return blitBuffer(utf8ToBytes(string, buf.length - offset), buf, offset, length)
}

function asciiWrite (buf, string, offset, length) {
  return blitBuffer(asciiToBytes(string), buf, offset, length)
}

function latin1Write (buf, string, offset, length) {
  return asciiWrite(buf, string, offset, length)
}

function base64Write (buf, string, offset, length) {
  return blitBuffer(base64ToBytes(string), buf, offset, length)
}

function ucs2Write (buf, string, offset, length) {
  return blitBuffer(utf16leToBytes(string, buf.length - offset), buf, offset, length)
}

Buffer.prototype.write = function write (string, offset, length, encoding) {
  // Buffer#write(string)
  if (offset === undefined) {
    encoding = 'utf8'
    length = this.length
    offset = 0
  // Buffer#write(string, encoding)
  } else if (length === undefined && typeof offset === 'string') {
    encoding = offset
    length = this.length
    offset = 0
  // Buffer#write(string, offset[, length][, encoding])
  } else if (isFinite(offset)) {
    offset = offset | 0
    if (isFinite(length)) {
      length = length | 0
      if (encoding === undefined) encoding = 'utf8'
    } else {
      encoding = length
      length = undefined
    }
  // legacy write(string, encoding, offset, length) - remove in v0.13
  } else {
    throw new Error(
      'Buffer.write(string, encoding, offset[, length]) is no longer supported'
    )
  }

  var remaining = this.length - offset
  if (length === undefined || length > remaining) length = remaining

  if ((string.length > 0 && (length < 0 || offset < 0)) || offset > this.length) {
    throw new RangeError('Attempt to write outside buffer bounds')
  }

  if (!encoding) encoding = 'utf8'

  var loweredCase = false
  for (;;) {
    switch (encoding) {
      case 'hex':
        return hexWrite(this, string, offset, length)

      case 'utf8':
      case 'utf-8':
        return utf8Write(this, string, offset, length)

      case 'ascii':
        return asciiWrite(this, string, offset, length)

      case 'latin1':
      case 'binary':
        return latin1Write(this, string, offset, length)

      case 'base64':
        // Warning: maxLength not taken into account in base64Write
        return base64Write(this, string, offset, length)

      case 'ucs2':
      case 'ucs-2':
      case 'utf16le':
      case 'utf-16le':
        return ucs2Write(this, string, offset, length)

      default:
        if (loweredCase) throw new TypeError('Unknown encoding: ' + encoding)
        encoding = ('' + encoding).toLowerCase()
        loweredCase = true
    }
  }
}

Buffer.prototype.toJSON = function toJSON () {
  return {
    type: 'Buffer',
    data: Array.prototype.slice.call(this._arr || this, 0)
  }
}

function base64Slice (buf, start, end) {
  if (start === 0 && end === buf.length) {
    return base64.fromByteArray(buf)
  } else {
    return base64.fromByteArray(buf.slice(start, end))
  }
}

function utf8Slice (buf, start, end) {
  end = Math.min(buf.length, end)
  var res = []

  var i = start
  while (i < end) {
    var firstByte = buf[i]
    var codePoint = null
    var bytesPerSequence = (firstByte > 0xEF) ? 4
      : (firstByte > 0xDF) ? 3
      : (firstByte > 0xBF) ? 2
      : 1

    if (i + bytesPerSequence <= end) {
      var secondByte, thirdByte, fourthByte, tempCodePoint

      switch (bytesPerSequence) {
        case 1:
          if (firstByte < 0x80) {
            codePoint = firstByte
          }
          break
        case 2:
          secondByte = buf[i + 1]
          if ((secondByte & 0xC0) === 0x80) {
            tempCodePoint = (firstByte & 0x1F) << 0x6 | (secondByte & 0x3F)
            if (tempCodePoint > 0x7F) {
              codePoint = tempCodePoint
            }
          }
          break
        case 3:
          secondByte = buf[i + 1]
          thirdByte = buf[i + 2]
          if ((secondByte & 0xC0) === 0x80 && (thirdByte & 0xC0) === 0x80) {
            tempCodePoint = (firstByte & 0xF) << 0xC | (secondByte & 0x3F) << 0x6 | (thirdByte & 0x3F)
            if (tempCodePoint > 0x7FF && (tempCodePoint < 0xD800 || tempCodePoint > 0xDFFF)) {
              codePoint = tempCodePoint
            }
          }
          break
        case 4:
          secondByte = buf[i + 1]
          thirdByte = buf[i + 2]
          fourthByte = buf[i + 3]
          if ((secondByte & 0xC0) === 0x80 && (thirdByte & 0xC0) === 0x80 && (fourthByte & 0xC0) === 0x80) {
            tempCodePoint = (firstByte & 0xF) << 0x12 | (secondByte & 0x3F) << 0xC | (thirdByte & 0x3F) << 0x6 | (fourthByte & 0x3F)
            if (tempCodePoint > 0xFFFF && tempCodePoint < 0x110000) {
              codePoint = tempCodePoint
            }
          }
      }
    }

    if (codePoint === null) {
      // we did not generate a valid codePoint so insert a
      // replacement char (U+FFFD) and advance only 1 byte
      codePoint = 0xFFFD
      bytesPerSequence = 1
    } else if (codePoint > 0xFFFF) {
      // encode to utf16 (surrogate pair dance)
      codePoint -= 0x10000
      res.push(codePoint >>> 10 & 0x3FF | 0xD800)
      codePoint = 0xDC00 | codePoint & 0x3FF
    }

    res.push(codePoint)
    i += bytesPerSequence
  }

  return decodeCodePointsArray(res)
}

// Based on http://stackoverflow.com/a/22747272/680742, the browser with
// the lowest limit is Chrome, with 0x10000 args.
// We go 1 magnitude less, for safety
var MAX_ARGUMENTS_LENGTH = 0x1000

function decodeCodePointsArray (codePoints) {
  var len = codePoints.length
  if (len <= MAX_ARGUMENTS_LENGTH) {
    return String.fromCharCode.apply(String, codePoints) // avoid extra slice()
  }

  // Decode in chunks to avoid "call stack size exceeded".
  var res = ''
  var i = 0
  while (i < len) {
    res += String.fromCharCode.apply(
      String,
      codePoints.slice(i, i += MAX_ARGUMENTS_LENGTH)
    )
  }
  return res
}

function asciiSlice (buf, start, end) {
  var ret = ''
  end = Math.min(buf.length, end)

  for (var i = start; i < end; ++i) {
    ret += String.fromCharCode(buf[i] & 0x7F)
  }
  return ret
}

function latin1Slice (buf, start, end) {
  var ret = ''
  end = Math.min(buf.length, end)

  for (var i = start; i < end; ++i) {
    ret += String.fromCharCode(buf[i])
  }
  return ret
}

function hexSlice (buf, start, end) {
  var len = buf.length

  if (!start || start < 0) start = 0
  if (!end || end < 0 || end > len) end = len

  var out = ''
  for (var i = start; i < end; ++i) {
    out += toHex(buf[i])
  }
  return out
}

function utf16leSlice (buf, start, end) {
  var bytes = buf.slice(start, end)
  var res = ''
  for (var i = 0; i < bytes.length; i += 2) {
    res += String.fromCharCode(bytes[i] + bytes[i + 1] * 256)
  }
  return res
}

Buffer.prototype.slice = function slice (start, end) {
  var len = this.length
  start = ~~start
  end = end === undefined ? len : ~~end

  if (start < 0) {
    start += len
    if (start < 0) start = 0
  } else if (start > len) {
    start = len
  }

  if (end < 0) {
    end += len
    if (end < 0) end = 0
  } else if (end > len) {
    end = len
  }

  if (end < start) end = start

  var newBuf
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    newBuf = this.subarray(start, end)
    newBuf.__proto__ = Buffer.prototype
  } else {
    var sliceLen = end - start
    newBuf = new Buffer(sliceLen, undefined)
    for (var i = 0; i < sliceLen; ++i) {
      newBuf[i] = this[i + start]
    }
  }

  return newBuf
}

/*
 * Need to make sure that buffer isn't trying to write out of bounds.
 */
function checkOffset (offset, ext, length) {
  if ((offset % 1) !== 0 || offset < 0) throw new RangeError('offset is not uint')
  if (offset + ext > length) throw new RangeError('Trying to access beyond buffer length')
}

Buffer.prototype.readUIntLE = function readUIntLE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) checkOffset(offset, byteLength, this.length)

  var val = this[offset]
  var mul = 1
  var i = 0
  while (++i < byteLength && (mul *= 0x100)) {
    val += this[offset + i] * mul
  }

  return val
}

Buffer.prototype.readUIntBE = function readUIntBE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) {
    checkOffset(offset, byteLength, this.length)
  }

  var val = this[offset + --byteLength]
  var mul = 1
  while (byteLength > 0 && (mul *= 0x100)) {
    val += this[offset + --byteLength] * mul
  }

  return val
}

Buffer.prototype.readUInt8 = function readUInt8 (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 1, this.length)
  return this[offset]
}

Buffer.prototype.readUInt16LE = function readUInt16LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  return this[offset] | (this[offset + 1] << 8)
}

Buffer.prototype.readUInt16BE = function readUInt16BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  return (this[offset] << 8) | this[offset + 1]
}

Buffer.prototype.readUInt32LE = function readUInt32LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return ((this[offset]) |
      (this[offset + 1] << 8) |
      (this[offset + 2] << 16)) +
      (this[offset + 3] * 0x1000000)
}

Buffer.prototype.readUInt32BE = function readUInt32BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return (this[offset] * 0x1000000) +
    ((this[offset + 1] << 16) |
    (this[offset + 2] << 8) |
    this[offset + 3])
}

Buffer.prototype.readIntLE = function readIntLE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) checkOffset(offset, byteLength, this.length)

  var val = this[offset]
  var mul = 1
  var i = 0
  while (++i < byteLength && (mul *= 0x100)) {
    val += this[offset + i] * mul
  }
  mul *= 0x80

  if (val >= mul) val -= Math.pow(2, 8 * byteLength)

  return val
}

Buffer.prototype.readIntBE = function readIntBE (offset, byteLength, noAssert) {
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) checkOffset(offset, byteLength, this.length)

  var i = byteLength
  var mul = 1
  var val = this[offset + --i]
  while (i > 0 && (mul *= 0x100)) {
    val += this[offset + --i] * mul
  }
  mul *= 0x80

  if (val >= mul) val -= Math.pow(2, 8 * byteLength)

  return val
}

Buffer.prototype.readInt8 = function readInt8 (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 1, this.length)
  if (!(this[offset] & 0x80)) return (this[offset])
  return ((0xff - this[offset] + 1) * -1)
}

Buffer.prototype.readInt16LE = function readInt16LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  var val = this[offset] | (this[offset + 1] << 8)
  return (val & 0x8000) ? val | 0xFFFF0000 : val
}

Buffer.prototype.readInt16BE = function readInt16BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 2, this.length)
  var val = this[offset + 1] | (this[offset] << 8)
  return (val & 0x8000) ? val | 0xFFFF0000 : val
}

Buffer.prototype.readInt32LE = function readInt32LE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return (this[offset]) |
    (this[offset + 1] << 8) |
    (this[offset + 2] << 16) |
    (this[offset + 3] << 24)
}

Buffer.prototype.readInt32BE = function readInt32BE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)

  return (this[offset] << 24) |
    (this[offset + 1] << 16) |
    (this[offset + 2] << 8) |
    (this[offset + 3])
}

Buffer.prototype.readFloatLE = function readFloatLE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)
  return ieee754.read(this, offset, true, 23, 4)
}

Buffer.prototype.readFloatBE = function readFloatBE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 4, this.length)
  return ieee754.read(this, offset, false, 23, 4)
}

Buffer.prototype.readDoubleLE = function readDoubleLE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 8, this.length)
  return ieee754.read(this, offset, true, 52, 8)
}

Buffer.prototype.readDoubleBE = function readDoubleBE (offset, noAssert) {
  if (!noAssert) checkOffset(offset, 8, this.length)
  return ieee754.read(this, offset, false, 52, 8)
}

function checkInt (buf, value, offset, ext, max, min) {
  if (!Buffer.isBuffer(buf)) throw new TypeError('"buffer" argument must be a Buffer instance')
  if (value > max || value < min) throw new RangeError('"value" argument is out of bounds')
  if (offset + ext > buf.length) throw new RangeError('Index out of range')
}

Buffer.prototype.writeUIntLE = function writeUIntLE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) {
    var maxBytes = Math.pow(2, 8 * byteLength) - 1
    checkInt(this, value, offset, byteLength, maxBytes, 0)
  }

  var mul = 1
  var i = 0
  this[offset] = value & 0xFF
  while (++i < byteLength && (mul *= 0x100)) {
    this[offset + i] = (value / mul) & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeUIntBE = function writeUIntBE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  byteLength = byteLength | 0
  if (!noAssert) {
    var maxBytes = Math.pow(2, 8 * byteLength) - 1
    checkInt(this, value, offset, byteLength, maxBytes, 0)
  }

  var i = byteLength - 1
  var mul = 1
  this[offset + i] = value & 0xFF
  while (--i >= 0 && (mul *= 0x100)) {
    this[offset + i] = (value / mul) & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeUInt8 = function writeUInt8 (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 1, 0xff, 0)
  if (!Buffer.TYPED_ARRAY_SUPPORT) value = Math.floor(value)
  this[offset] = (value & 0xff)
  return offset + 1
}

function objectWriteUInt16 (buf, value, offset, littleEndian) {
  if (value < 0) value = 0xffff + value + 1
  for (var i = 0, j = Math.min(buf.length - offset, 2); i < j; ++i) {
    buf[offset + i] = (value & (0xff << (8 * (littleEndian ? i : 1 - i)))) >>>
      (littleEndian ? i : 1 - i) * 8
  }
}

Buffer.prototype.writeUInt16LE = function writeUInt16LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0xffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value & 0xff)
    this[offset + 1] = (value >>> 8)
  } else {
    objectWriteUInt16(this, value, offset, true)
  }
  return offset + 2
}

Buffer.prototype.writeUInt16BE = function writeUInt16BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0xffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 8)
    this[offset + 1] = (value & 0xff)
  } else {
    objectWriteUInt16(this, value, offset, false)
  }
  return offset + 2
}

function objectWriteUInt32 (buf, value, offset, littleEndian) {
  if (value < 0) value = 0xffffffff + value + 1
  for (var i = 0, j = Math.min(buf.length - offset, 4); i < j; ++i) {
    buf[offset + i] = (value >>> (littleEndian ? i : 3 - i) * 8) & 0xff
  }
}

Buffer.prototype.writeUInt32LE = function writeUInt32LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0xffffffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset + 3] = (value >>> 24)
    this[offset + 2] = (value >>> 16)
    this[offset + 1] = (value >>> 8)
    this[offset] = (value & 0xff)
  } else {
    objectWriteUInt32(this, value, offset, true)
  }
  return offset + 4
}

Buffer.prototype.writeUInt32BE = function writeUInt32BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0xffffffff, 0)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 24)
    this[offset + 1] = (value >>> 16)
    this[offset + 2] = (value >>> 8)
    this[offset + 3] = (value & 0xff)
  } else {
    objectWriteUInt32(this, value, offset, false)
  }
  return offset + 4
}

Buffer.prototype.writeIntLE = function writeIntLE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) {
    var limit = Math.pow(2, 8 * byteLength - 1)

    checkInt(this, value, offset, byteLength, limit - 1, -limit)
  }

  var i = 0
  var mul = 1
  var sub = 0
  this[offset] = value & 0xFF
  while (++i < byteLength && (mul *= 0x100)) {
    if (value < 0 && sub === 0 && this[offset + i - 1] !== 0) {
      sub = 1
    }
    this[offset + i] = ((value / mul) >> 0) - sub & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeIntBE = function writeIntBE (value, offset, byteLength, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) {
    var limit = Math.pow(2, 8 * byteLength - 1)

    checkInt(this, value, offset, byteLength, limit - 1, -limit)
  }

  var i = byteLength - 1
  var mul = 1
  var sub = 0
  this[offset + i] = value & 0xFF
  while (--i >= 0 && (mul *= 0x100)) {
    if (value < 0 && sub === 0 && this[offset + i + 1] !== 0) {
      sub = 1
    }
    this[offset + i] = ((value / mul) >> 0) - sub & 0xFF
  }

  return offset + byteLength
}

Buffer.prototype.writeInt8 = function writeInt8 (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 1, 0x7f, -0x80)
  if (!Buffer.TYPED_ARRAY_SUPPORT) value = Math.floor(value)
  if (value < 0) value = 0xff + value + 1
  this[offset] = (value & 0xff)
  return offset + 1
}

Buffer.prototype.writeInt16LE = function writeInt16LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0x7fff, -0x8000)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value & 0xff)
    this[offset + 1] = (value >>> 8)
  } else {
    objectWriteUInt16(this, value, offset, true)
  }
  return offset + 2
}

Buffer.prototype.writeInt16BE = function writeInt16BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 2, 0x7fff, -0x8000)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 8)
    this[offset + 1] = (value & 0xff)
  } else {
    objectWriteUInt16(this, value, offset, false)
  }
  return offset + 2
}

Buffer.prototype.writeInt32LE = function writeInt32LE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0x7fffffff, -0x80000000)
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value & 0xff)
    this[offset + 1] = (value >>> 8)
    this[offset + 2] = (value >>> 16)
    this[offset + 3] = (value >>> 24)
  } else {
    objectWriteUInt32(this, value, offset, true)
  }
  return offset + 4
}

Buffer.prototype.writeInt32BE = function writeInt32BE (value, offset, noAssert) {
  value = +value
  offset = offset | 0
  if (!noAssert) checkInt(this, value, offset, 4, 0x7fffffff, -0x80000000)
  if (value < 0) value = 0xffffffff + value + 1
  if (Buffer.TYPED_ARRAY_SUPPORT) {
    this[offset] = (value >>> 24)
    this[offset + 1] = (value >>> 16)
    this[offset + 2] = (value >>> 8)
    this[offset + 3] = (value & 0xff)
  } else {
    objectWriteUInt32(this, value, offset, false)
  }
  return offset + 4
}

function checkIEEE754 (buf, value, offset, ext, max, min) {
  if (offset + ext > buf.length) throw new RangeError('Index out of range')
  if (offset < 0) throw new RangeError('Index out of range')
}

function writeFloat (buf, value, offset, littleEndian, noAssert) {
  if (!noAssert) {
    checkIEEE754(buf, value, offset, 4, 3.4028234663852886e+38, -3.4028234663852886e+38)
  }
  ieee754.write(buf, value, offset, littleEndian, 23, 4)
  return offset + 4
}

Buffer.prototype.writeFloatLE = function writeFloatLE (value, offset, noAssert) {
  return writeFloat(this, value, offset, true, noAssert)
}

Buffer.prototype.writeFloatBE = function writeFloatBE (value, offset, noAssert) {
  return writeFloat(this, value, offset, false, noAssert)
}

function writeDouble (buf, value, offset, littleEndian, noAssert) {
  if (!noAssert) {
    checkIEEE754(buf, value, offset, 8, 1.7976931348623157E+308, -1.7976931348623157E+308)
  }
  ieee754.write(buf, value, offset, littleEndian, 52, 8)
  return offset + 8
}

Buffer.prototype.writeDoubleLE = function writeDoubleLE (value, offset, noAssert) {
  return writeDouble(this, value, offset, true, noAssert)
}

Buffer.prototype.writeDoubleBE = function writeDoubleBE (value, offset, noAssert) {
  return writeDouble(this, value, offset, false, noAssert)
}

// copy(targetBuffer, targetStart=0, sourceStart=0, sourceEnd=buffer.length)
Buffer.prototype.copy = function copy (target, targetStart, start, end) {
  if (!start) start = 0
  if (!end && end !== 0) end = this.length
  if (targetStart >= target.length) targetStart = target.length
  if (!targetStart) targetStart = 0
  if (end > 0 && end < start) end = start

  // Copy 0 bytes; we're done
  if (end === start) return 0
  if (target.length === 0 || this.length === 0) return 0

  // Fatal error conditions
  if (targetStart < 0) {
    throw new RangeError('targetStart out of bounds')
  }
  if (start < 0 || start >= this.length) throw new RangeError('sourceStart out of bounds')
  if (end < 0) throw new RangeError('sourceEnd out of bounds')

  // Are we oob?
  if (end > this.length) end = this.length
  if (target.length - targetStart < end - start) {
    end = target.length - targetStart + start
  }

  var len = end - start
  var i

  if (this === target && start < targetStart && targetStart < end) {
    // descending copy from end
    for (i = len - 1; i >= 0; --i) {
      target[i + targetStart] = this[i + start]
    }
  } else if (len < 1000 || !Buffer.TYPED_ARRAY_SUPPORT) {
    // ascending copy from start
    for (i = 0; i < len; ++i) {
      target[i + targetStart] = this[i + start]
    }
  } else {
    Uint8Array.prototype.set.call(
      target,
      this.subarray(start, start + len),
      targetStart
    )
  }

  return len
}

// Usage:
//    buffer.fill(number[, offset[, end]])
//    buffer.fill(buffer[, offset[, end]])
//    buffer.fill(string[, offset[, end]][, encoding])
Buffer.prototype.fill = function fill (val, start, end, encoding) {
  // Handle string cases:
  if (typeof val === 'string') {
    if (typeof start === 'string') {
      encoding = start
      start = 0
      end = this.length
    } else if (typeof end === 'string') {
      encoding = end
      end = this.length
    }
    if (val.length === 1) {
      var code = val.charCodeAt(0)
      if (code < 256) {
        val = code
      }
    }
    if (encoding !== undefined && typeof encoding !== 'string') {
      throw new TypeError('encoding must be a string')
    }
    if (typeof encoding === 'string' && !Buffer.isEncoding(encoding)) {
      throw new TypeError('Unknown encoding: ' + encoding)
    }
  } else if (typeof val === 'number') {
    val = val & 255
  }

  // Invalid ranges are not set to a default, so can range check early.
  if (start < 0 || this.length < start || this.length < end) {
    throw new RangeError('Out of range index')
  }

  if (end <= start) {
    return this
  }

  start = start >>> 0
  end = end === undefined ? this.length : end >>> 0

  if (!val) val = 0

  var i
  if (typeof val === 'number') {
    for (i = start; i < end; ++i) {
      this[i] = val
    }
  } else {
    var bytes = Buffer.isBuffer(val)
      ? val
      : utf8ToBytes(new Buffer(val, encoding).toString())
    var len = bytes.length
    for (i = 0; i < end - start; ++i) {
      this[i + start] = bytes[i % len]
    }
  }

  return this
}

// HELPER FUNCTIONS
// ================

var INVALID_BASE64_RE = /[^+\/0-9A-Za-z-_]/g

function base64clean (str) {
  // Node strips out invalid characters like \n and \t from the string, base64-js does not
  str = stringtrim(str).replace(INVALID_BASE64_RE, '')
  // Node converts strings with length < 2 to ''
  if (str.length < 2) return ''
  // Node allows for non-padded base64 strings (missing trailing ===), base64-js does not
  while (str.length % 4 !== 0) {
    str = str + '='
  }
  return str
}

function stringtrim (str) {
  if (str.trim) return str.trim()
  return str.replace(/^\s+|\s+$/g, '')
}

function toHex (n) {
  if (n < 16) return '0' + n.toString(16)
  return n.toString(16)
}

function utf8ToBytes (string, units) {
  units = units || Infinity
  var codePoint
  var length = string.length
  var leadSurrogate = null
  var bytes = []

  for (var i = 0; i < length; ++i) {
    codePoint = string.charCodeAt(i)

    // is surrogate component
    if (codePoint > 0xD7FF && codePoint < 0xE000) {
      // last char was a lead
      if (!leadSurrogate) {
        // no lead yet
        if (codePoint > 0xDBFF) {
          // unexpected trail
          if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
          continue
        } else if (i + 1 === length) {
          // unpaired lead
          if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
          continue
        }

        // valid lead
        leadSurrogate = codePoint

        continue
      }

      // 2 leads in a row
      if (codePoint < 0xDC00) {
        if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
        leadSurrogate = codePoint
        continue
      }

      // valid surrogate pair
      codePoint = (leadSurrogate - 0xD800 << 10 | codePoint - 0xDC00) + 0x10000
    } else if (leadSurrogate) {
      // valid bmp char, but last char was a lead
      if ((units -= 3) > -1) bytes.push(0xEF, 0xBF, 0xBD)
    }

    leadSurrogate = null

    // encode utf8
    if (codePoint < 0x80) {
      if ((units -= 1) < 0) break
      bytes.push(codePoint)
    } else if (codePoint < 0x800) {
      if ((units -= 2) < 0) break
      bytes.push(
        codePoint >> 0x6 | 0xC0,
        codePoint & 0x3F | 0x80
      )
    } else if (codePoint < 0x10000) {
      if ((units -= 3) < 0) break
      bytes.push(
        codePoint >> 0xC | 0xE0,
        codePoint >> 0x6 & 0x3F | 0x80,
        codePoint & 0x3F | 0x80
      )
    } else if (codePoint < 0x110000) {
      if ((units -= 4) < 0) break
      bytes.push(
        codePoint >> 0x12 | 0xF0,
        codePoint >> 0xC & 0x3F | 0x80,
        codePoint >> 0x6 & 0x3F | 0x80,
        codePoint & 0x3F | 0x80
      )
    } else {
      throw new Error('Invalid code point')
    }
  }

  return bytes
}

function asciiToBytes (str) {
  var byteArray = []
  for (var i = 0; i < str.length; ++i) {
    // Node's code seems to be doing this and not & 0x7F..
    byteArray.push(str.charCodeAt(i) & 0xFF)
  }
  return byteArray
}

function utf16leToBytes (str, units) {
  var c, hi, lo
  var byteArray = []
  for (var i = 0; i < str.length; ++i) {
    if ((units -= 2) < 0) break

    c = str.charCodeAt(i)
    hi = c >> 8
    lo = c % 256
    byteArray.push(lo)
    byteArray.push(hi)
  }

  return byteArray
}

function base64ToBytes (str) {
  return base64.toByteArray(base64clean(str))
}

function blitBuffer (src, dst, offset, length) {
  for (var i = 0; i < length; ++i) {
    if ((i + offset >= dst.length) || (i >= src.length)) break
    dst[i + offset] = src[i]
  }
  return i
}

function isnan (val) {
  return val !== val // eslint-disable-line no-self-compare
}

/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(56)))

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _createForOfIteratorHelper(o, allowArrayLike) { var it; if (typeof Symbol === "undefined" || o[Symbol.iterator] == null) { if (Array.isArray(o) || (it = _unsupportedIterableToArray(o)) || allowArrayLike && o && typeof o.length === "number") { if (it) o = it; var i = 0; var F = function F() {}; return { s: F, n: function n() { if (i >= o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = o[Symbol.iterator](); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var ContainerAtom = /*#__PURE__*/function (_Atom) {
  _inherits(ContainerAtom, _Atom);

  var _super = _createSuper(ContainerAtom);

  function ContainerAtom() {
    var _this;

    _classCallCheck(this, ContainerAtom);

    _this = _super.call(this);
    _this.atoms = [];
    return _this;
  }

  _createClass(ContainerAtom, [{
    key: "availableAtoms",
    value: function availableAtoms() {
      return [];
    }
  }, {
    key: "addAtom",
    value: function addAtom(atom) {
      this.atoms.push(atom);
    }
  }, {
    key: "createAtom",
    value: function createAtom(type) {
      var atom = Utils.createAtom(type);
      this.addAtom(atom);
      return atom;
    }
  }, {
    key: "getAtoms",
    value: function getAtoms(type) {
      var atoms = [];

      var _iterator = _createForOfIteratorHelper(this.atoms),
          _step;

      try {
        for (_iterator.s(); !(_step = _iterator.n()).done;) {
          var atom = _step.value;

          if (atom.type() === type) {
            atoms.push(atom);
          }
        }
      } catch (err) {
        _iterator.e(err);
      } finally {
        _iterator.f();
      }

      return atoms;
    }
  }, {
    key: "getAtom",
    value: function getAtom(type) {
      var _iterator2 = _createForOfIteratorHelper(this.atoms),
          _step2;

      try {
        for (_iterator2.s(); !(_step2 = _iterator2.n()).done;) {
          var atom = _step2.value;

          if (atom.type() === type) {
            return atom;
          }
        }
      } catch (err) {
        _iterator2.e(err);
      } finally {
        _iterator2.f();
      }

      return null;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var limit = buffer.length;
      var offset = 0;

      while (offset < limit) {
        var size = buffer.readUInt32BE(offset);
        var name = buffer.toString('ascii', offset + 4, offset + 8);

        if (size === 0) {
          break;
        }

        offset += 8;

        if (this.availableAtoms().indexOf(name) !== -1) {
          var atom = Utils.createAtom(name);

          if (atom !== null) {
            atom.parse(buffer.slice(offset, offset + size - 8));
            this.addAtom(atom);
          }
        }

        if (offset + size - 8 <= limit) {
          offset += size - 8;
        } else {
          break;
        }
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // atoms

      offset += 8;

      var _iterator3 = _createForOfIteratorHelper(this.atoms),
          _step3;

      try {
        for (_iterator3.s(); !(_step3 = _iterator3.n()).done;) {
          var atom = _step3.value;
          atom.build(buffer, offset);
          offset += atom.bufferSize();
        }
      } catch (err) {
        _iterator3.e(err);
      } finally {
        _iterator3.f();
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 8 + this.atoms.reduce(function (size, atom) {
        return size + atom.bufferSize();
      }, 0);
    }
  }]);

  return ContainerAtom;
}(Atom);

module.exports = ContainerAtom;

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Sample = __webpack_require__(14);

var VideoSample = /*#__PURE__*/function (_Sample) {
  _inherits(VideoSample, _Sample);

  var _super = _createSuper(VideoSample);

  function VideoSample() {
    var _this;

    _classCallCheck(this, VideoSample);

    _this = _super.call(this);
    _this.compositionOffset = 0;
    _this.keyframe = false;
    return _this;
  }

  return VideoSample;
}(Sample);

module.exports = VideoSample;

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Sample = __webpack_require__(14);

var AudioSample = /*#__PURE__*/function (_Sample) {
  _inherits(AudioSample, _Sample);

  var _super = _createSuper(AudioSample);

  function AudioSample() {
    _classCallCheck(this, AudioSample);

    return _super.call(this);
  }

  return AudioSample;
}(Sample);

module.exports = AudioSample;

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var VAL32 = 0xFFFFFFFF;

var BufferUtils = /*#__PURE__*/function () {
  function BufferUtils() {
    _classCallCheck(this, BufferUtils);
  }

  _createClass(BufferUtils, null, [{
    key: "readUInt64BE",
    value: function readUInt64BE(buffer, offset) {
      var hi = buffer.readUInt32BE(offset);
      var value = buffer.readUInt32BE(offset + 4);

      if (hi > 0) {
        value += hi * (VAL32 + 1);
      }

      return value;
    }
  }, {
    key: "writeUInt64BE",
    value: function writeUInt64BE(buffer, value, offset) {
      var hi = 0;
      var lo = value;

      if (value > VAL32) {
        hi = value / (VAL32 + 1) << 0;
        lo = value % (VAL32 + 1);
      }

      buffer.writeUInt32BE(hi, offset);
      buffer.writeUInt32BE(lo, offset + 4);
    }
  }]);

  return BufferUtils;
}();

module.exports = BufferUtils;

/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var SampleTableAtom = /*#__PURE__*/function (_Atom) {
  _inherits(SampleTableAtom, _Atom);

  var _super = _createSuper(SampleTableAtom);

  function SampleTableAtom() {
    var _this;

    _classCallCheck(this, SampleTableAtom);

    _this = _super.call(this);
    _this.entries = [];
    return _this;
  }

  _createClass(SampleTableAtom, [{
    key: "countMultiplier",
    value: function countMultiplier() {
      return 1;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var entryCount = buffer.readUInt32BE(4);
      this.entries = new Array(entryCount * this.countMultiplier());

      for (var i = 0, l = this.entries.length; i < l; i++) {
        this.entries[i] = buffer.readUInt32BE(8 + 4 * i);
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // entry count

      buffer.writeUInt32BE(this.entries.length / this.countMultiplier() << 0, offset + 12); // entries

      for (var i = 0, l = this.entries.length; i < l; i++) {
        buffer.writeUInt32BE(this.entries[i], offset + 16 + 4 * i);
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 16 + 4 * this.entries.length;
    }
  }]);

  return SampleTableAtom;
}(Atom);

module.exports = SampleTableAtom;

/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Track = __webpack_require__(13);

var AudioTrack = /*#__PURE__*/function (_Track) {
  _inherits(AudioTrack, _Track);

  var _super = _createSuper(AudioTrack);

  function AudioTrack() {
    var _this;

    _classCallCheck(this, AudioTrack);

    _this = _super.call(this);
    _this.channels = null;
    _this.sampleRate = null;
    _this.sampleSize = null;
    return _this;
  }

  return AudioTrack;
}(Track);

module.exports = AudioTrack;

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Track = __webpack_require__(13);

var VideoTrack = /*#__PURE__*/function (_Track) {
  _inherits(VideoTrack, _Track);

  var _super = _createSuper(VideoTrack);

  function VideoTrack() {
    var _this;

    _classCallCheck(this, VideoTrack);

    _this = _super.call(this);
    _this.width = 0;
    _this.height = 0;
    return _this;
  }

  _createClass(VideoTrack, [{
    key: "resolution",
    value: function resolution() {
      if (this.width && this.height) {
        return "".concat(this.width, "x").concat(this.height);
      }

      return '';
    }
  }]);

  return VideoTrack;
}(Track);

module.exports = VideoTrack;

/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Reader = __webpack_require__(16);

var FileReader = __webpack_require__(60);

var BufferReader = __webpack_require__(61);

var SourceReader = /*#__PURE__*/function () {
  function SourceReader() {
    _classCallCheck(this, SourceReader);
  }

  _createClass(SourceReader, null, [{
    key: "create",
    value:
    /**
     * Create source reader
     * @param source
     * @returns Reader
     */
    function create(source) {
      if (source instanceof Reader) {
        return source;
      } else if (source instanceof Buffer) {
        return new BufferReader(source);
      } else {
        return new FileReader(source);
      }
    }
  }]);

  return SourceReader;
}();

module.exports = SourceReader;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = {
  CODEC_AAC: 'aac',
  CODEC_H264: 'h264',
  CODEC_H265: 'h265'
};

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _createForOfIteratorHelper(o, allowArrayLike) { var it; if (typeof Symbol === "undefined" || o[Symbol.iterator] == null) { if (Array.isArray(o) || (it = _unsupportedIterableToArray(o)) || allowArrayLike && o && typeof o.length === "number") { if (it) o = it; var i = 0; var F = function F() {}; return { s: F, n: function n() { if (i >= o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = o[Symbol.iterator](); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var AudioTrack = __webpack_require__(8);

var VideoTrack = __webpack_require__(9);

var Movie = /*#__PURE__*/function () {
  function Movie() {
    _classCallCheck(this, Movie);

    this.duration = 0;
    this.timescale = 0;
    this.tracks = [];
  }

  _createClass(Movie, [{
    key: "relativeDuration",
    value: function relativeDuration() {
      if (this.timescale) {
        return this.duration / this.timescale;
      }

      return this.duration || 0;
    }
  }, {
    key: "resolution",
    value: function resolution() {
      var videoTrack = this.videoTrack();

      if (videoTrack !== null) {
        return videoTrack.resolution();
      }

      return '';
    }
  }, {
    key: "size",
    value: function size() {
      return this.tracks.reduce(function (size, track) {
        return size + track.size();
      }, 0);
    }
  }, {
    key: "addTrack",
    value: function addTrack(track) {
      this.tracks.push(track);
    }
  }, {
    key: "videoTrack",
    value: function videoTrack() {
      var _iterator = _createForOfIteratorHelper(this.tracks),
          _step;

      try {
        for (_iterator.s(); !(_step = _iterator.n()).done;) {
          var track = _step.value;

          if (track instanceof VideoTrack) {
            return track;
          }
        }
      } catch (err) {
        _iterator.e(err);
      } finally {
        _iterator.f();
      }

      return null;
    }
  }, {
    key: "audioTrack",
    value: function audioTrack() {
      var _iterator2 = _createForOfIteratorHelper(this.tracks),
          _step2;

      try {
        for (_iterator2.s(); !(_step2 = _iterator2.n()).done;) {
          var track = _step2.value;

          if (track instanceof AudioTrack) {
            return track;
          }
        }
      } catch (err) {
        _iterator2.e(err);
      } finally {
        _iterator2.f();
      }

      return null;
    }
  }, {
    key: "samples",
    value: function samples() {
      return [this.videoTrack(), this.audioTrack()].filter(function (track) {
        return track !== null;
      }).map(function (track) {
        return track.samples;
      }).reduce(function (a, b) {
        return a.concat(b);
      }, []).sort(function (a, b) {
        if (a.timescale === b.timescale) {
          return a.timestamp - b.timestamp;
        } else {
          return a.timestamp * b.timescale - b.timestamp * a.timescale;
        }
      });
    }
  }, {
    key: "ensureDuration",
    value: function ensureDuration() {
      var _this = this;

      if (this.duration === 0) {
        this.duration = this.tracks.reduce(function (duration, track) {
          return Math.max(duration, _this.timescale * track.relativeDuration());
        }, 0);
      }

      return this.duration;
    }
  }]);

  return Movie;
}();

module.exports = Movie;

/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Track = /*#__PURE__*/function () {
  function Track() {
    _classCallCheck(this, Track);

    this.duration = 0;
    this.timescale = 0;
    this.extraData = null;
    this.codec = null;
    this.samples = [];
  }

  _createClass(Track, [{
    key: "relativeDuration",
    value: function relativeDuration() {
      if (this.timescale) {
        return this.duration / this.timescale;
      }

      return this.duration || 0;
    }
  }, {
    key: "size",
    value: function size() {
      return this.samples.reduce(function (size, sample) {
        return size + sample.size;
      }, 0);
    }
  }, {
    key: "ensureDuration",
    value: function ensureDuration() {
      if (this.duration === 0) {
        this.duration = this.samples.reduce(function (duration, sample) {
          return Math.max(duration, sample.duration);
        }, 0);
      }

      return this.duration;
    }
  }, {
    key: "sortSamples",
    value: function sortSamples() {
      this.samples.sort(function (sample1, sample2) {
        return sample1.timestamp - sample2.timestamp;
      });
    }
  }]);

  return Track;
}();

module.exports = Track;

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Sample = /*#__PURE__*/function () {
  function Sample() {
    _classCallCheck(this, Sample);

    this.timestamp = 0;
    this.timescale = 0;
    this.size = 0;
    this.offset = 0;
  }

  _createClass(Sample, [{
    key: "relativeTimestamp",
    value: function relativeTimestamp() {
      if (this.timescale) {
        return this.timestamp / this.timescale;
      } else {
        return this.timestamp;
      }
    }
  }]);

  return Sample;
}();

module.exports = Sample;

/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Fragment = /*#__PURE__*/function () {
  function Fragment() {
    _classCallCheck(this, Fragment);

    this.timestamp = 0;
    this.duration = 0;
    this.timescale = 0;
    this.videoExtraData = null;
    this.audioExtraData = null;
    this.samples = [];
  }

  _createClass(Fragment, [{
    key: "hasVideo",
    value: function hasVideo() {
      return this.videoExtraData !== null;
    }
  }, {
    key: "hasAudio",
    value: function hasAudio() {
      return this.audioExtraData !== null;
    }
  }, {
    key: "relativeTimestamp",
    value: function relativeTimestamp() {
      if (this.timescale) {
        return this.timestamp / this.timescale;
      } else {
        return this.timestamp;
      }
    }
  }, {
    key: "relativeDuration",
    value: function relativeDuration() {
      if (this.timescale) {
        return this.duration / this.timescale;
      }

      return this.duration || 0;
    }
  }]);

  return Fragment;
}();

module.exports = Fragment;

/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Reader = /*#__PURE__*/function () {
  function Reader() {
    _classCallCheck(this, Reader);
  }

  _createClass(Reader, [{
    key: "size",
    value: function size() {}
  }, {
    key: "read",
    value: function read() {}
  }]);

  return Reader;
}();

module.exports = Reader;

/***/ }),
/* 17 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var VIDEO_DPI = 72 << 16;
var VIDEO_DEPTH = 24;

var VideoSampleAtom = /*#__PURE__*/function (_Atom) {
  _inherits(VideoSampleAtom, _Atom);

  var _super = _createSuper(VideoSampleAtom);

  function VideoSampleAtom() {
    var _this;

    _classCallCheck(this, VideoSampleAtom);

    _this = _super.call(this);
    _this.width = null;
    _this.height = null;
    _this.extraData = null;
    return _this;
  }

  _createClass(VideoSampleAtom, [{
    key: "extraType",
    value: function extraType() {}
  }, {
    key: "parse",
    value: function parse(buffer) {
      var offset = 24;
      this.width = buffer.readUInt16BE(offset);
      offset += 2;
      this.height = buffer.readUInt16BE(offset);
      offset += 52;

      while (offset < buffer.length - 8) {
        var size = buffer.readUInt32BE(offset);
        offset += 4;
        var type = buffer.toString('ascii', offset, offset + 4);
        offset += 4;

        if (size === 0) {
          break;
        }

        if (type === this.extraType()) {
          this.extraData = buffer.slice(offset - 4, offset + size - 4);
          break;
        }

        offset += size - 8;
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // data reference index

      buffer.writeUInt16BE(1, offset + 14); // vendor

      buffer.writeUInt32BE(1, offset + 20); // width and height

      buffer.writeUInt16BE(this.width, offset + 32);
      buffer.writeUInt16BE(this.height, offset + 34); // horizontal and vertical resolution

      buffer.writeUInt32BE(VIDEO_DPI, offset + 36);
      buffer.writeUInt32BE(VIDEO_DPI, offset + 40); // frame count

      buffer.writeUInt16BE(1, offset + 48); // compressor name

      buffer.write(Utils.COMPRESSOR_NAME.substring(0, 16), offset + 50); // depth

      buffer.writeUInt16BE(VIDEO_DEPTH, offset + 82); // color table id

      buffer.writeUInt16BE(65535, offset + 84); // default color table
      // extra data

      buffer.writeUInt32BE(this.extraData.length + 4, offset + 86);
      buffer.write(this.extraType(), offset + 90);
      this.extraData.copy(buffer, offset + 94, 4);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 90 + this.extraData.length;
    }
  }]);

  return VideoSampleAtom;
}(Atom);

module.exports = VideoSampleAtom;

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var PARSERS = {
  mp4a: __webpack_require__(65),
  avcC: __webpack_require__(66),
  hvcC: __webpack_require__(67)
};

var Parser = /*#__PURE__*/function () {
  function Parser() {
    _classCallCheck(this, Parser);
  }

  _createClass(Parser, null, [{
    key: "parse",
    value: function parse(extraData) {
      var codecName = extraData.toString('ascii', 0, 4);
      var ParserClass = PARSERS[codecName];

      if (ParserClass) {
        var parser = new ParserClass(extraData.slice(4, extraData.length));
        parser.parse();
        return parser;
      }

      throw new Error("Unknown codec name ".concat(codecName));
    }
  }]);

  return Parser;
}();

module.exports = Parser;

/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Codec = /*#__PURE__*/function () {
  function Codec() {
    _classCallCheck(this, Codec);
  }

  _createClass(Codec, [{
    key: "type",
    value: function type() {}
  }, {
    key: "parse",
    value: function parse() {}
  }, {
    key: "codec",
    value: function codec() {}
  }]);

  return Codec;
}();

module.exports = Codec;

/***/ }),
/* 20 */
/***/ (function(module, exports) {

module.exports = function() {
  return new Worker(vedioRootPath+"module/" + "audioWorker.worker.js");
};

/***/ }),
/* 21 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Utils = __webpack_require__(0);

var ParserImpl = __webpack_require__(64);

var Parser = /*#__PURE__*/function () {
  function Parser() {
    _classCallCheck(this, Parser);
  }

  _createClass(Parser, null, [{
    key: "parse",
    value:
    /**
     * Parse MP4 file
     * @param {(int|Buffer)} source
     * @returns {Movie}
     */
    function parse(source) {
      var parser = new ParserImpl(source);
      return parser.parse();
    }
    /**
     * Check MP4 file
     * @param {Buffer} buffer
     * @returns {boolean}
     * @private
     */

  }, {
    key: "check",
    value: function check(buffer) {
      return buffer.readUInt32BE(0) > 0 && [Utils.ATOM_FTYP, Utils.ATOM_MOOV, Utils.ATOM_MDAT].indexOf(buffer.toString('ascii', 4, 8)) !== -1;
    }
  }]);

  return Parser;
}();

module.exports = Parser;

/***/ }),
/* 22 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var VideoSampleAtom = __webpack_require__(17);

var Utils = __webpack_require__(0);

var AtomAVC1 = /*#__PURE__*/function (_VideoSampleAtom) {
  _inherits(AtomAVC1, _VideoSampleAtom);

  var _super = _createSuper(AtomAVC1);

  function AtomAVC1() {
    _classCallCheck(this, AtomAVC1);

    return _super.apply(this, arguments);
  }

  _createClass(AtomAVC1, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_AVC1;
    }
  }, {
    key: "extraType",
    value: function extraType() {
      return Utils.ATOM_AVCC;
    }
  }]);

  return AtomAVC1;
}(VideoSampleAtom);

module.exports = AtomAVC1;

/***/ }),
/* 23 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var BufferUtils = __webpack_require__(6);

var Utils = __webpack_require__(0);

var AtomCO64 = /*#__PURE__*/function (_Atom) {
  _inherits(AtomCO64, _Atom);

  var _super = _createSuper(AtomCO64);

  function AtomCO64() {
    var _this;

    _classCallCheck(this, AtomCO64);

    _this = _super.call(this);
    _this.entries = [];
    return _this;
  }

  _createClass(AtomCO64, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_CO64;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var entryCount = buffer.readUInt32BE(4);
      this.entries = new Array(entryCount);

      for (var i = 0; i < entryCount; i++) {
        this.entries[i] = BufferUtils.readUInt64BE(buffer, 8 + 8 * i);
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // entry count

      buffer.writeUInt32BE(this.entries.length, offset + 12); // entries

      for (var i = 0, l = this.entries.length; i < l; i++) {
        BufferUtils.writeUInt64BE(buffer, this.entries[i], offset + 16 + 8 * i);
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 16 + 8 * this.entries.length;
    }
  }]);

  return AtomCO64;
}(Atom);

module.exports = AtomCO64;

/***/ }),
/* 24 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var SampleTableAtom = __webpack_require__(7);

var Utils = __webpack_require__(0);

var AtomCTTS = /*#__PURE__*/function (_SampleTableAtom) {
  _inherits(AtomCTTS, _SampleTableAtom);

  var _super = _createSuper(AtomCTTS);

  function AtomCTTS() {
    _classCallCheck(this, AtomCTTS);

    return _super.apply(this, arguments);
  }

  _createClass(AtomCTTS, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_CTTS;
    }
  }, {
    key: "countMultiplier",
    value: function countMultiplier() {
      return 2;
    }
  }]);

  return AtomCTTS;
}(SampleTableAtom);

module.exports = AtomCTTS;

/***/ }),
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

function readSize(buffer, offset) {
  var s = 0,
      i;

  for (i = 0; i < 4; i++) {
    var b = buffer[offset + i] & 0xff;
    s <<= 7;
    s |= b & 0x7f;

    if ((b & 0x80) === 0) {
      break;
    }
  }

  return {
    size: s,
    read: i + 1
  };
}

var AtomESDS = /*#__PURE__*/function (_Atom) {
  _inherits(AtomESDS, _Atom);

  var _super = _createSuper(AtomESDS);

  function AtomESDS() {
    var _this;

    _classCallCheck(this, AtomESDS);

    _this = _super.call(this);
    _this.streamId = null;
    _this.extraData = null;
    return _this;
  }

  _createClass(AtomESDS, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_ESDS;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var offset = 5; // ES_Length

      var esSize = readSize(buffer, offset);
      offset += esSize.read; // ES_ID

      this.streamId = buffer.readUInt16BE(offset);
      offset += 2; // Flags

      var flags = buffer[offset++]; // streamDependenceFlag

      if ((flags >> 7 & 0x1) === 0x1) {
        offset += 2;
      } // URL_Flag


      if ((flags >> 6 & 0x1) === 0x1) {
        offset += buffer[offset] + 1;
      } // OCRstreamFlag


      if ((flags >> 5 & 0x1) === 0x1) {
        offset += 2;
      }

      while (offset < buffer.length) {
        var descriptorTag = buffer[offset++];
        var tagInfo = readSize(buffer, offset);
        offset += tagInfo.read; // Skip optional tags

        if (descriptorTag !== 4) {
          offset += tagInfo.size;
          continue;
        } // Skip DecoderConfigDescrTag parameters


        offset += 13; // Read DecoderSpecificInfo

        if (tagInfo.size > 13 && buffer[offset++] === 5) {
          tagInfo = readSize(buffer, offset);
          offset += tagInfo.read;
          this.extraData = Buffer.allocUnsafe(tagInfo.size);
          buffer.copy(this.extraData, 0, offset, offset + tagInfo.size);
        }

        break;
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4);
      offset += 8; // ES_DescrTag

      offset += 4;
      buffer[offset++] = 0x3; // tag type

      buffer[offset++] = 23 + this.extraData.length; // tag length (by the end of the tag)

      buffer.writeUInt16BE(this.streamId, offset); // ES_ID

      offset += 2;
      buffer[offset++] = 0; // ES_Flags
      // DecoderConfigDescrTag

      buffer[offset++] = 0x4; // tag type

      buffer[offset++] = 15 + this.extraData.length; // tag length

      buffer[offset++] = 0x40; // objectTypeIndication - Audio ISO/IEC 14496-3

      buffer[offset++] = 0x15; // Flags - streamType - AudioStream

      offset += 11; // Other optional tags
      // DecSpecificInfoTag (part of DecoderConfigDescrTag)

      buffer[offset++] = 0x5; // tag type

      buffer[offset++] = this.extraData.length; // tag length

      this.extraData.copy(buffer, offset);
      offset += this.extraData.length; // SLConfigDescrTag

      buffer[offset++] = 0x6; // tag type

      buffer[offset++] = 1; // tag length

      buffer[offset++] = 0x2; // tag length
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 37 + this.extraData.length;
    }
  }]);

  return AtomESDS;
}(Atom);

module.exports = AtomESDS;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var AtomFTYP = /*#__PURE__*/function (_Atom) {
  _inherits(AtomFTYP, _Atom);

  var _super = _createSuper(AtomFTYP);

  function AtomFTYP() {
    var _this;

    _classCallCheck(this, AtomFTYP);

    _this = _super.call(this);
    _this.majorBrand = null;
    _this.minorVersion = 0;
    _this.compatibleBrands = [];
    return _this;
  }

  _createClass(AtomFTYP, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_FTYP;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      this.majorBrand = buffer.toString('ascii', 0, 4);
      this.minorVersion = buffer.readUInt32BE(4);

      for (var i = 0; i < (buffer.length - 8) / 4; i++) {
        this.compatibleBrands.push(buffer.toString('ascii', 8 + i * 4, 12 + i * 4));
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // major brand

      buffer.write(this.majorBrand, offset + 8); // minor version

      buffer.writeUInt32BE(this.minorVersion, offset + 12); // compatible brands

      for (var i = 0; i < this.compatibleBrands.length; i++) {
        buffer.write(this.compatibleBrands[i], offset + 16 + i * 4);
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 16 + 4 * this.compatibleBrands.length;
    }
  }]);

  return AtomFTYP;
}(Atom);

module.exports = AtomFTYP;

/***/ }),
/* 27 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var AtomHDLR = /*#__PURE__*/function (_Atom) {
  _inherits(AtomHDLR, _Atom);

  var _super = _createSuper(AtomHDLR);

  function AtomHDLR() {
    var _this;

    _classCallCheck(this, AtomHDLR);

    _this = _super.call(this);
    _this.handlerType = null;
    _this.componentName = null;
    return _this;
  }

  _createClass(AtomHDLR, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_HDLR;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      this.handlerType = buffer.toString('ascii', 8, 12);
      this.componentName = buffer.toString('ascii', 16);
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // handler name

      buffer.write(this.handlerType.substring(0, 4), offset + 16); // component name

      buffer.write(this.componentName.substring(0, 16), offset + 24);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 48;
    }
  }]);

  return AtomHDLR;
}(Atom);

module.exports = AtomHDLR;

/***/ }),
/* 28 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var VideoSampleAtom = __webpack_require__(17);

var Utils = __webpack_require__(0);

var AtomHEV1 = /*#__PURE__*/function (_VideoSampleAtom) {
  _inherits(AtomHEV1, _VideoSampleAtom);

  var _super = _createSuper(AtomHEV1);

  function AtomHEV1() {
    _classCallCheck(this, AtomHEV1);

    return _super.apply(this, arguments);
  }

  _createClass(AtomHEV1, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_HEV1;
    }
  }, {
    key: "extraType",
    value: function extraType() {
      return Utils.ATOM_HVCC;
    }
  }]);

  return AtomHEV1;
}(VideoSampleAtom);

module.exports = AtomHEV1;

/***/ }),
/* 29 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var VideoSampleAtom = __webpack_require__(17);

var Utils = __webpack_require__(0);

var AtomHVC1 = /*#__PURE__*/function (_VideoSampleAtom) {
  _inherits(AtomHVC1, _VideoSampleAtom);

  var _super = _createSuper(AtomHVC1);

  function AtomHVC1() {
    _classCallCheck(this, AtomHVC1);

    return _super.apply(this, arguments);
  }

  _createClass(AtomHVC1, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_HVC1;
    }
  }, {
    key: "extraType",
    value: function extraType() {
      return Utils.ATOM_HVCC;
    }
  }]);

  return AtomHVC1;
}(VideoSampleAtom);

module.exports = AtomHVC1;

/***/ }),
/* 30 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var BufferUtils = __webpack_require__(6);

var AtomMDHD = /*#__PURE__*/function (_Atom) {
  _inherits(AtomMDHD, _Atom);

  var _super = _createSuper(AtomMDHD);

  function AtomMDHD() {
    _classCallCheck(this, AtomMDHD);

    return _super.apply(this, arguments);
  }

  _createClass(AtomMDHD, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_MDHD;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var version = buffer[0];

      if (version === 1) {
        this.timescale = buffer.readUInt32BE(20);
        this.duration = BufferUtils.readUInt64BE(buffer, 24);
      } else {
        this.timescale = buffer.readUInt32BE(12);
        this.duration = buffer.readUInt32BE(16);
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // timescale

      buffer.writeUInt32BE(this.timescale, offset + 20); // duration

      buffer.writeUInt32BE(this.duration, offset + 24);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 32;
    }
  }]);

  return AtomMDHD;
}(Atom);

module.exports = AtomMDHD;

/***/ }),
/* 31 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var ContainerAtom = __webpack_require__(3);

var Utils = __webpack_require__(0);

var AtomMDIA = /*#__PURE__*/function (_ContainerAtom) {
  _inherits(AtomMDIA, _ContainerAtom);

  var _super = _createSuper(AtomMDIA);

  function AtomMDIA() {
    _classCallCheck(this, AtomMDIA);

    return _super.apply(this, arguments);
  }

  _createClass(AtomMDIA, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_MDIA;
    }
  }, {
    key: "availableAtoms",
    value: function availableAtoms() {
      return [Utils.ATOM_MDHD, Utils.ATOM_MINF, Utils.ATOM_HDLR];
    }
  }]);

  return AtomMDIA;
}(ContainerAtom);

module.exports = AtomMDIA;

/***/ }),
/* 32 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var ContainerAtom = __webpack_require__(3);

var Utils = __webpack_require__(0);

var AtomMINF = /*#__PURE__*/function (_ContainerAtom) {
  _inherits(AtomMINF, _ContainerAtom);

  var _super = _createSuper(AtomMINF);

  function AtomMINF() {
    _classCallCheck(this, AtomMINF);

    return _super.apply(this, arguments);
  }

  _createClass(AtomMINF, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_MINF;
    }
  }, {
    key: "availableAtoms",
    value: function availableAtoms() {
      return [Utils.ATOM_VMHD, Utils.ATOM_SMHD, Utils.ATOM_STBL];
    }
  }]);

  return AtomMINF;
}(ContainerAtom);

module.exports = AtomMINF;

/***/ }),
/* 33 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var ContainerAtom = __webpack_require__(3);

var Utils = __webpack_require__(0);

var AtomMOOV = /*#__PURE__*/function (_ContainerAtom) {
  _inherits(AtomMOOV, _ContainerAtom);

  var _super = _createSuper(AtomMOOV);

  function AtomMOOV() {
    _classCallCheck(this, AtomMOOV);

    return _super.apply(this, arguments);
  }

  _createClass(AtomMOOV, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_MOOV;
    }
  }, {
    key: "availableAtoms",
    value: function availableAtoms() {
      return [Utils.ATOM_MVHD, Utils.ATOM_TRAK];
    }
  }]);

  return AtomMOOV;
}(ContainerAtom);

module.exports = AtomMOOV;

/***/ }),
/* 34 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var AtomMP4A = /*#__PURE__*/function (_Atom) {
  _inherits(AtomMP4A, _Atom);

  var _super = _createSuper(AtomMP4A);

  function AtomMP4A() {
    var _this;

    _classCallCheck(this, AtomMP4A);

    _this = _super.call(this);
    _this.channels = null;
    _this.sampleSize = null;
    _this.sampleRate = null;
    _this.streamId = null;
    _this.extraData = null;
    return _this;
  }

  _createClass(AtomMP4A, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_MP4A;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var offset = 8;
      var version = buffer.readUInt16BE(offset);
      offset += 8;
      this.channels = buffer.readUInt16BE(offset);
      offset += 2;
      this.sampleSize = buffer.readUInt16BE(offset);
      offset += 4;
      this.sampleRate = buffer.readUInt32BE(offset);
      offset += 6;

      if (version > 0) {
        offset += 16;
      }

      while (offset < buffer.length - 8) {
        var size = buffer.readUInt32BE(offset);
        var name = buffer.toString('ascii', offset + 4, offset + 8);

        if (size === 0) {
          break;
        }

        offset += 8;

        if (name === Utils.ATOM_ESDS) {
          var atom = Utils.createAtom(name);

          if (atom !== null) {
            atom.parse(buffer.slice(offset, offset + size - 8));
            this.streamId = atom.streamId;

            if (atom.extraData) {
              this.extraData = Buffer.allocUnsafe(4 + atom.extraData.length);
              this.extraData.write(Utils.ATOM_MP4A);
              atom.extraData.copy(this.extraData, 4, 0);
            }
          }

          break;
        }

        offset += size - 8;
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // data reference index

      buffer.writeUInt16BE(1, offset + 14); // number of channels

      buffer.writeUInt16BE(this.channels, offset + 24); // sample size

      buffer.writeUInt16BE(this.sampleSize, offset + 26); // sample rate

      buffer.writeUInt32BE(this.sampleRate, offset + 30); // ESDS atom

      var atom = Utils.createAtom(Utils.ATOM_ESDS);
      atom.streamId = this.streamId;
      atom.extraData = Buffer.allocUnsafe(this.extraData.length - 4);
      this.extraData.copy(atom.extraData, 0, 4);
      atom.build(buffer, offset + 36);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 36 + 37 + this.extraData.length;
    }
  }]);

  return AtomMP4A;
}(Atom);

module.exports = AtomMP4A;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 35 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var BufferUtils = __webpack_require__(6);

var MATRIX = [0x10000, 0, 0, 0, 0x10000, 0, 0, 0, 0x40000000];

var AtomMVHD = /*#__PURE__*/function (_Atom) {
  _inherits(AtomMVHD, _Atom);

  var _super = _createSuper(AtomMVHD);

  function AtomMVHD() {
    var _this;

    _classCallCheck(this, AtomMVHD);

    _this = _super.call(this);
    _this.timescale = null;
    _this.duration = null;
    _this.nextTrackId = null;
    return _this;
  }

  _createClass(AtomMVHD, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_MVHD;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var version = buffer[0];

      if (version === 1) {
        this.timescale = buffer.readUInt32BE(20);
        this.duration = BufferUtils.readUInt64BE(buffer, 24);
        this.nextTrackId = buffer.readUInt32BE(104);
      } else {
        this.timescale = buffer.readUInt32BE(12);
        this.duration = buffer.readUInt32BE(16);
        this.nextTrackId = buffer.readUInt32BE(96);
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // timescale

      buffer.writeUInt32BE(this.timescale, offset + 20); // duration

      buffer.writeUInt32BE(this.duration, offset + 24); // preferred rate

      buffer.writeUInt32BE(0x10000, offset + 28); // preferred volume

      buffer.writeUInt16BE(0x100, offset + 32); // matrix

      for (var i = 0; i < MATRIX.length; i++) {
        buffer.writeUInt32BE(MATRIX[i], offset + 44 + i * 4);
      } // next track id


      buffer.writeUInt32BE(this.nextTrackId, offset + 104);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 108;
    }
  }]);

  return AtomMVHD;
}(Atom);

module.exports = AtomMVHD;

/***/ }),
/* 36 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var AtomSMHD = /*#__PURE__*/function (_Atom) {
  _inherits(AtomSMHD, _Atom);

  var _super = _createSuper(AtomSMHD);

  function AtomSMHD() {
    _classCallCheck(this, AtomSMHD);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSMHD, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_SMHD;
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 16;
    }
  }]);

  return AtomSMHD;
}(Atom);

module.exports = AtomSMHD;

/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var ContainerAtom = __webpack_require__(3);

var Utils = __webpack_require__(0);

var AtomSTBL = /*#__PURE__*/function (_ContainerAtom) {
  _inherits(AtomSTBL, _ContainerAtom);

  var _super = _createSuper(AtomSTBL);

  function AtomSTBL() {
    _classCallCheck(this, AtomSTBL);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSTBL, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STBL;
    }
  }, {
    key: "availableAtoms",
    value: function availableAtoms() {
      return [Utils.ATOM_STSZ, Utils.ATOM_STCO, Utils.ATOM_STSS, Utils.ATOM_STTS, Utils.ATOM_STSC, Utils.ATOM_CO64, Utils.ATOM_STSD, Utils.ATOM_CTTS];
    }
  }]);

  return AtomSTBL;
}(ContainerAtom);

module.exports = AtomSTBL;

/***/ }),
/* 38 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var SampleTableAtom = __webpack_require__(7);

var Utils = __webpack_require__(0);

var AtomSTCO = /*#__PURE__*/function (_SampleTableAtom) {
  _inherits(AtomSTCO, _SampleTableAtom);

  var _super = _createSuper(AtomSTCO);

  function AtomSTCO() {
    _classCallCheck(this, AtomSTCO);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSTCO, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STCO;
    }
  }]);

  return AtomSTCO;
}(SampleTableAtom);

module.exports = AtomSTCO;

/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var SampleTableAtom = __webpack_require__(7);

var Utils = __webpack_require__(0);

var AtomSTSC = /*#__PURE__*/function (_SampleTableAtom) {
  _inherits(AtomSTSC, _SampleTableAtom);

  var _super = _createSuper(AtomSTSC);

  function AtomSTSC() {
    _classCallCheck(this, AtomSTSC);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSTSC, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STSC;
    }
  }, {
    key: "countMultiplier",
    value: function countMultiplier() {
      return 3;
    }
  }]);

  return AtomSTSC;
}(SampleTableAtom);

module.exports = AtomSTSC;

/***/ }),
/* 40 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _createForOfIteratorHelper(o, allowArrayLike) { var it; if (typeof Symbol === "undefined" || o[Symbol.iterator] == null) { if (Array.isArray(o) || (it = _unsupportedIterableToArray(o)) || allowArrayLike && o && typeof o.length === "number") { if (it) o = it; var i = 0; var F = function F() {}; return { s: F, n: function n() { if (i >= o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = o[Symbol.iterator](); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _get(target, property, receiver) { if (typeof Reflect !== "undefined" && Reflect.get) { _get = Reflect.get; } else { _get = function _get(target, property, receiver) { var base = _superPropBase(target, property); if (!base) return; var desc = Object.getOwnPropertyDescriptor(base, property); if (desc.get) { return desc.get.call(receiver); } return desc.value; }; } return _get(target, property, receiver || target); }

function _superPropBase(object, property) { while (!Object.prototype.hasOwnProperty.call(object, property)) { object = _getPrototypeOf(object); if (object === null) break; } return object; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var ContainerAtom = __webpack_require__(3);

var Utils = __webpack_require__(0);

var AtomSTSD = /*#__PURE__*/function (_ContainerAtom) {
  _inherits(AtomSTSD, _ContainerAtom);

  var _super = _createSuper(AtomSTSD);

  function AtomSTSD() {
    _classCallCheck(this, AtomSTSD);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSTSD, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STSD;
    }
  }, {
    key: "availableAtoms",
    value: function availableAtoms() {
      return [Utils.ATOM_AVC1, Utils.ATOM_HEV1, Utils.ATOM_HVC1, Utils.ATOM_MP4A];
    }
  }, {
    key: "getVideoAtom",
    value: function getVideoAtom() {
      return this.getAtom(Utils.ATOM_AVC1) || this.getAtom(Utils.ATOM_HEV1) || this.getAtom(Utils.ATOM_HVC1);
    }
  }, {
    key: "getAudioAtom",
    value: function getAudioAtom() {
      return this.getAtom(Utils.ATOM_MP4A);
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      _get(_getPrototypeOf(AtomSTSD.prototype), "parse", this).call(this, buffer.slice(8));
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4);
      buffer.writeUInt32BE(1, offset + 12); // atoms

      offset += 16;

      var _iterator = _createForOfIteratorHelper(this.atoms),
          _step;

      try {
        for (_iterator.s(); !(_step = _iterator.n()).done;) {
          var atom = _step.value;
          atom.build(buffer, offset);
          offset += atom.bufferSize();
        }
      } catch (err) {
        _iterator.e(err);
      } finally {
        _iterator.f();
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 8 + _get(_getPrototypeOf(AtomSTSD.prototype), "bufferSize", this).call(this);
    }
  }]);

  return AtomSTSD;
}(ContainerAtom);

module.exports = AtomSTSD;

/***/ }),
/* 41 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var SampleTableAtom = __webpack_require__(7);

var Utils = __webpack_require__(0);

var AtomSTSS = /*#__PURE__*/function (_SampleTableAtom) {
  _inherits(AtomSTSS, _SampleTableAtom);

  var _super = _createSuper(AtomSTSS);

  function AtomSTSS() {
    _classCallCheck(this, AtomSTSS);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSTSS, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STSS;
    }
  }]);

  return AtomSTSS;
}(SampleTableAtom);

module.exports = AtomSTSS;

/***/ }),
/* 42 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var AtomSTSZ = /*#__PURE__*/function (_Atom) {
  _inherits(AtomSTSZ, _Atom);

  var _super = _createSuper(AtomSTSZ);

  function AtomSTSZ() {
    var _this;

    _classCallCheck(this, AtomSTSZ);

    _this = _super.call(this);
    _this.entries = [];
    return _this;
  }

  _createClass(AtomSTSZ, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STSZ;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      var sampleSize = buffer.readUInt32BE(4);
      var entryCount = buffer.readUInt32BE(8);
      this.entries = new Array(entryCount);

      if (sampleSize === 0) {
        for (var i = 0; i < entryCount; i++) {
          this.entries[i] = buffer.readUInt32BE(12 + 4 * i);
        }
      } else {
        this.entries.fill(sampleSize);
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // entry count

      buffer.writeUInt32BE(this.entries.length, offset + 16); // entries

      for (var i = 0, l = this.entries.length; i < l; i++) {
        buffer.writeUInt32BE(this.entries[i], offset + 20 + 4 * i);
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 20 + 4 * this.entries.length;
    }
  }]);

  return AtomSTSZ;
}(Atom);

module.exports = AtomSTSZ;

/***/ }),
/* 43 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var SampleTableAtom = __webpack_require__(7);

var Utils = __webpack_require__(0);

var AtomSTTS = /*#__PURE__*/function (_SampleTableAtom) {
  _inherits(AtomSTTS, _SampleTableAtom);

  var _super = _createSuper(AtomSTTS);

  function AtomSTTS() {
    _classCallCheck(this, AtomSTTS);

    return _super.apply(this, arguments);
  }

  _createClass(AtomSTTS, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_STTS;
    }
  }, {
    key: "countMultiplier",
    value: function countMultiplier() {
      return 2;
    }
  }]);

  return AtomSTTS;
}(SampleTableAtom);

module.exports = AtomSTTS;

/***/ }),
/* 44 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var BufferUtils = __webpack_require__(6);

var Utils = __webpack_require__(0);

var MATRIX = [0x10000, 0, 0, 0, 0x10000, 0, 0, 0, 0x40000000];

var AtomTKHD = /*#__PURE__*/function (_Atom) {
  _inherits(AtomTKHD, _Atom);

  var _super = _createSuper(AtomTKHD);

  function AtomTKHD() {
    var _this;

    _classCallCheck(this, AtomTKHD);

    _this = _super.call(this);
    _this.duration = null;
    _this.trackId = null;
    _this.width = null;
    _this.height = null;
    return _this;
  }

  _createClass(AtomTKHD, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_TKHD;
    }
  }, {
    key: "parse",
    value: function parse(buffer) {
      this.trackId = buffer.readUInt32BE(12);

      if (buffer[0] === 1) {
        this.duration = BufferUtils.readUInt64BE(buffer, 28);
        this.width = buffer.readUInt16BE(88);
        this.height = buffer.readUInt16BE(92);
      } else {
        this.duration = buffer.readUInt32BE(20);
        this.width = buffer.readUInt16BE(76);
        this.height = buffer.readUInt16BE(80);
      }
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // flags

      buffer.writeUInt32BE(3, offset + 8); // track id

      buffer.writeUInt32BE(this.trackId, offset + 20); // duration

      buffer.writeUInt32BE(this.duration, offset + 28);

      if (this.width === null || this.height === null) {
        // alternative group
        buffer.writeUInt16BE(1, offset + 42); // volume

        buffer.writeUInt16BE(256, offset + 44);
      } else {
        // width
        buffer.writeUInt16BE(this.width, offset + 84); // height

        buffer.writeUInt16BE(this.height, offset + 88);
      } // matrix


      for (var i = 0; i < MATRIX.length; i++) {
        buffer.writeUInt32BE(MATRIX[i], offset + 48 + i * 4);
      }
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 92;
    }
  }]);

  return AtomTKHD;
}(Atom);

module.exports = AtomTKHD;

/***/ }),
/* 45 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var ContainerAtom = __webpack_require__(3);

var Utils = __webpack_require__(0);

var AtomTRAK = /*#__PURE__*/function (_ContainerAtom) {
  _inherits(AtomTRAK, _ContainerAtom);

  var _super = _createSuper(AtomTRAK);

  function AtomTRAK() {
    _classCallCheck(this, AtomTRAK);

    return _super.apply(this, arguments);
  }

  _createClass(AtomTRAK, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_TRAK;
    }
  }, {
    key: "availableAtoms",
    value: function availableAtoms() {
      return [Utils.ATOM_TKHD, Utils.ATOM_MDIA];
    }
  }]);

  return AtomTRAK;
}(ContainerAtom);

module.exports = AtomTRAK;

/***/ }),
/* 46 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Atom = __webpack_require__(1);

var Utils = __webpack_require__(0);

var AtomVMHD = /*#__PURE__*/function (_Atom) {
  _inherits(AtomVMHD, _Atom);

  var _super = _createSuper(AtomVMHD);

  function AtomVMHD() {
    _classCallCheck(this, AtomVMHD);

    return _super.apply(this, arguments);
  }

  _createClass(AtomVMHD, [{
    key: "type",
    value: function type() {
      return Utils.ATOM_VMHD;
    }
  }, {
    key: "build",
    value: function build(buffer, offset) {
      // header
      buffer.writeUInt32BE(this.bufferSize(), offset);
      buffer.write(this.type(), offset + 4); // flags

      buffer.writeUInt32BE(1, offset + 8);
    }
  }, {
    key: "bufferSize",
    value: function bufferSize() {
      return 20;
    }
  }]);

  return AtomVMHD;
}(Atom);

module.exports = AtomVMHD;

/***/ }),
/* 47 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Utils = __webpack_require__(48);

var ParserImpl = __webpack_require__(68);

var Parser = /*#__PURE__*/function () {
  function Parser() {
    _classCallCheck(this, Parser);
  }

  _createClass(Parser, null, [{
    key: "parse",
    value:
    /**
     * Parse FLV file
     * @param {(int|Buffer)} source
     * @returns {Movie}
     */
    function parse(source) {
      var parser = new ParserImpl(source);
      return parser.parse();
    }
    /**
     * Check FLV file
     * @param {Buffer} buffer
     * @returns {boolean}
     * @private
     */

  }, {
    key: "check",
    value: function check(buffer) {
      return buffer.toString('ascii', 0, 3) === Utils.HEADER_PREFIX && buffer[3] === Utils.HEADER_VERSION;
    }
  }]);

  return Parser;
}();

module.exports = Parser;

/***/ }),
/* 48 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = {
  MOVIE_TIMESCALE: 1000,
  HEADER_SIZE: 9,
  HEADER_PREFIX: 'FLV',
  HEADER_VERSION: 1,
  TYPE_SCRIPT: 18,
  TYPE_VIDEO: 9,
  TYPE_AUDIO: 8,
  AUDIO_FORMAT_AAC: 10,
  VIDEO_FORMAT_H264: 7
};

/***/ }),
/* 49 */
/***/ (function(module, exports) {

module.exports = function() {
  return new Worker(vedioRootPath+"module/" + "videoWorker.worker.js");
};

/***/ }),
/* 50 */
/***/ (function(module, exports) {

module.exports = function() {
  return new Worker(vedioRootPath+"/module/" + "audioTalkWorker.worker.js");
};

/***/ }),
/* 51 */
/***/ (function(module, exports) {

module.exports = function() {
  return new Worker("./module/" + "videoWorkerTrain.worker.js");
};

/***/ }),
/* 52 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = __webpack_require__(53);

/***/ }),
/* 53 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var Movie = __webpack_require__(12);

var Track = __webpack_require__(13);

var VideoTrack = __webpack_require__(9);

var AudioTrack = __webpack_require__(8);

var Sample = __webpack_require__(14);

var VideoSample = __webpack_require__(4);

var AudioSample = __webpack_require__(5);

var Fragment = __webpack_require__(15);

var FragmentList = __webpack_require__(54); // const FragmentListBuilder = require('./fragment-list-builder');


var FragmentReader = __webpack_require__(55); // const FragmentListIndexer = require('./index/fragment-list-indexer');


var MovieParser = __webpack_require__(62);

var MP4Parser = __webpack_require__(21); // const MP4Builder = require('./mp4/builder');


var FLVParser = __webpack_require__(47);

var HLSPacketizer = __webpack_require__(70);

module.exports = {
  Movie: Movie,
  Track: Track,
  VideoTrack: VideoTrack,
  AudioTrack: AudioTrack,
  Sample: Sample,
  VideoSample: VideoSample,
  AudioSample: AudioSample,
  Fragment: Fragment,
  FragmentList: FragmentList,
  // FragmentListBuilder,
  FragmentReader: FragmentReader,
  // FragmentListIndexer,
  MovieParser: MovieParser,
  // MP4Builder,
  MP4Parser: MP4Parser,
  FLVParser: FLVParser,
  HLSPacketizer: HLSPacketizer
};

/***/ }),
/* 54 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Fragment = __webpack_require__(15);

var FragmentList = /*#__PURE__*/function () {
  function FragmentList() {
    _classCallCheck(this, FragmentList);

    this.fragmentDuration = 0;
    this.duration = 0;
    this.timescale = 0;
    this.video = null;
    this.audio = null;
    this.fragments = [];
  }

  _createClass(FragmentList, [{
    key: "createFragment",
    value: function createFragment(timestamp) {
      var fragment = {
        timestamp: timestamp,
        duration: 0,
        samples: []
      };
      this.fragments.push(fragment);
      return fragment;
    }
  }, {
    key: "chop",
    value: function chop() {
      if (this.fragments.length > 0 && this.fragments[this.fragments.length - 1].duration === 0) {
        this.fragments.splice(this.fragments.length - 2, 1);
      }
    }
  }, {
    key: "relativeDuration",
    value: function relativeDuration() {
      if (this.timescale) {
        return this.duration / this.timescale;
      }

      return this.duration || 0;
    }
  }, {
    key: "size",
    value: function size() {
      return [this.video, this.audio].filter(function (info) {
        return info !== null;
      }).reduce(function (sum, info) {
        return sum + info.size;
      }, 0);
    }
  }, {
    key: "count",
    value: function count() {
      return this.fragments.length;
    }
  }, {
    key: "get",
    value: function get(index) {
      var fragment = this.fragments[index];

      if (fragment) {
        var result = new Fragment();
        result.timestamp = fragment.timestamp;
        result.duration = fragment.duration;
        result.samples = fragment.samples;
        result.timescale = this.timescale;

        if (this.video) {
          result.videoExtraData = this.video.extraData;
        }

        if (this.audio) {
          result.audioExtraData = this.audio.extraData;
        }

        return result;
      }
    }
  }]);

  return FragmentList;
}();

module.exports = FragmentList;

/***/ }),
/* 55 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var SourceReader = __webpack_require__(10);

var BUFFER_SIZE = 1048576; // 1Mb

var FragmentReader = /*#__PURE__*/function () {
  function FragmentReader() {
    _classCallCheck(this, FragmentReader);
  }

  _createClass(FragmentReader, null, [{
    key: "readSamples",
    value:
    /**
     * Read samples
     * @param {Fragment} fragment
     * @param {(int|Buffer)} source
     * @returns {Array}
     */
    function readSamples(fragment, source) {
      // Collect entries
      var entries = fragment.samples.map(function (sample, i) {
        return {
          index: i,
          offset: sample.offset,
          size: sample.size,
          bufferIndex: 0,
          bufferOffset: 0
        };
      }).sort(function (ent1, ent2) {
        return ent1.offset - ent2.offset;
      }); // Build buffers

      var buffers = [];
      var buffer = null;

      for (var i = 0, l = entries.length; i < l; i++) {
        var entry = entries[i];

        if (buffer && buffer.offset + buffer.size >= entry.offset + entry.size) {
          entry.bufferIndex = buffers.length - 1;
          entry.bufferOffset = entry.offset - buffer.offset;
        } else {
          buffer = {
            offset: entry.offset,
            size: BUFFER_SIZE,
            buffer: Buffer.allocUnsafe(BUFFER_SIZE)
          };
          buffers.push(buffer);
          entry.bufferIndex = buffers.length - 1;
          entry.bufferOffset = 0;
        }
      } // Load buffers


      var reader = SourceReader.create(source);

      for (var _i = 0, _l = buffers.length; _i < _l; _i++) {
        var _buffer = buffers[_i];
        reader.read(_buffer.buffer, _buffer.offset);
      } // Return array of buffers


      entries.sort(function (ent1, ent2) {
        return ent1.index - ent2.index;
      });
      return fragment.samples.map(function (sample, i) {
        var entry = entries[i];
        return buffers[entry.bufferIndex].buffer.slice(entry.bufferOffset, entry.bufferOffset + entry.size);
      });
    }
  }]);

  return FragmentReader;
}();

module.exports = FragmentReader;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 56 */
/***/ (function(module, exports) {

var g;

// This works in non-strict mode
g = (function() {
	return this;
})();

try {
	// This works if eval is allowed (see CSP)
	g = g || new Function("return this")();
} catch (e) {
	// This works if the window reference is available
	if (typeof window === "object") g = window;
}

// g can still be undefined, but nothing to do about it...
// We return undefined, instead of nothing here, so it's
// easier to handle this case. if(!global) { ...}

module.exports = g;


/***/ }),
/* 57 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


exports.byteLength = byteLength
exports.toByteArray = toByteArray
exports.fromByteArray = fromByteArray

var lookup = []
var revLookup = []
var Arr = typeof Uint8Array !== 'undefined' ? Uint8Array : Array

var code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
for (var i = 0, len = code.length; i < len; ++i) {
  lookup[i] = code[i]
  revLookup[code.charCodeAt(i)] = i
}

// Support decoding URL-safe base64 strings, as Node.js does.
// See: https://en.wikipedia.org/wiki/Base64#URL_applications
revLookup['-'.charCodeAt(0)] = 62
revLookup['_'.charCodeAt(0)] = 63

function getLens (b64) {
  var len = b64.length

  if (len % 4 > 0) {
    throw new Error('Invalid string. Length must be a multiple of 4')
  }

  // Trim off extra bytes after placeholder bytes are found
  // See: https://github.com/beatgammit/base64-js/issues/42
  var validLen = b64.indexOf('=')
  if (validLen === -1) validLen = len

  var placeHoldersLen = validLen === len
    ? 0
    : 4 - (validLen % 4)

  return [validLen, placeHoldersLen]
}

// base64 is 4/3 + up to two characters of the original data
function byteLength (b64) {
  var lens = getLens(b64)
  var validLen = lens[0]
  var placeHoldersLen = lens[1]
  return ((validLen + placeHoldersLen) * 3 / 4) - placeHoldersLen
}

function _byteLength (b64, validLen, placeHoldersLen) {
  return ((validLen + placeHoldersLen) * 3 / 4) - placeHoldersLen
}

function toByteArray (b64) {
  var tmp
  var lens = getLens(b64)
  var validLen = lens[0]
  var placeHoldersLen = lens[1]

  var arr = new Arr(_byteLength(b64, validLen, placeHoldersLen))

  var curByte = 0

  // if there are placeholders, only get up to the last complete 4 chars
  var len = placeHoldersLen > 0
    ? validLen - 4
    : validLen

  var i
  for (i = 0; i < len; i += 4) {
    tmp =
      (revLookup[b64.charCodeAt(i)] << 18) |
      (revLookup[b64.charCodeAt(i + 1)] << 12) |
      (revLookup[b64.charCodeAt(i + 2)] << 6) |
      revLookup[b64.charCodeAt(i + 3)]
    arr[curByte++] = (tmp >> 16) & 0xFF
    arr[curByte++] = (tmp >> 8) & 0xFF
    arr[curByte++] = tmp & 0xFF
  }

  if (placeHoldersLen === 2) {
    tmp =
      (revLookup[b64.charCodeAt(i)] << 2) |
      (revLookup[b64.charCodeAt(i + 1)] >> 4)
    arr[curByte++] = tmp & 0xFF
  }

  if (placeHoldersLen === 1) {
    tmp =
      (revLookup[b64.charCodeAt(i)] << 10) |
      (revLookup[b64.charCodeAt(i + 1)] << 4) |
      (revLookup[b64.charCodeAt(i + 2)] >> 2)
    arr[curByte++] = (tmp >> 8) & 0xFF
    arr[curByte++] = tmp & 0xFF
  }

  return arr
}

function tripletToBase64 (num) {
  return lookup[num >> 18 & 0x3F] +
    lookup[num >> 12 & 0x3F] +
    lookup[num >> 6 & 0x3F] +
    lookup[num & 0x3F]
}

function encodeChunk (uint8, start, end) {
  var tmp
  var output = []
  for (var i = start; i < end; i += 3) {
    tmp =
      ((uint8[i] << 16) & 0xFF0000) +
      ((uint8[i + 1] << 8) & 0xFF00) +
      (uint8[i + 2] & 0xFF)
    output.push(tripletToBase64(tmp))
  }
  return output.join('')
}

function fromByteArray (uint8) {
  var tmp
  var len = uint8.length
  var extraBytes = len % 3 // if we have 1 byte left, pad 2 bytes
  var parts = []
  var maxChunkLength = 16383 // must be multiple of 3

  // go through the array every three bytes, we'll deal with trailing stuff later
  for (var i = 0, len2 = len - extraBytes; i < len2; i += maxChunkLength) {
    parts.push(encodeChunk(uint8, i, (i + maxChunkLength) > len2 ? len2 : (i + maxChunkLength)))
  }

  // pad the end with zeros, but make sure to not forget the extra bytes
  if (extraBytes === 1) {
    tmp = uint8[len - 1]
    parts.push(
      lookup[tmp >> 2] +
      lookup[(tmp << 4) & 0x3F] +
      '=='
    )
  } else if (extraBytes === 2) {
    tmp = (uint8[len - 2] << 8) + uint8[len - 1]
    parts.push(
      lookup[tmp >> 10] +
      lookup[(tmp >> 4) & 0x3F] +
      lookup[(tmp << 2) & 0x3F] +
      '='
    )
  }

  return parts.join('')
}


/***/ }),
/* 58 */
/***/ (function(module, exports) {

/*! ieee754. BSD-3-Clause License. Feross Aboukhadijeh <https://feross.org/opensource> */
exports.read = function (buffer, offset, isLE, mLen, nBytes) {
  var e, m
  var eLen = (nBytes * 8) - mLen - 1
  var eMax = (1 << eLen) - 1
  var eBias = eMax >> 1
  var nBits = -7
  var i = isLE ? (nBytes - 1) : 0
  var d = isLE ? -1 : 1
  var s = buffer[offset + i]

  i += d

  e = s & ((1 << (-nBits)) - 1)
  s >>= (-nBits)
  nBits += eLen
  for (; nBits > 0; e = (e * 256) + buffer[offset + i], i += d, nBits -= 8) {}

  m = e & ((1 << (-nBits)) - 1)
  e >>= (-nBits)
  nBits += mLen
  for (; nBits > 0; m = (m * 256) + buffer[offset + i], i += d, nBits -= 8) {}

  if (e === 0) {
    e = 1 - eBias
  } else if (e === eMax) {
    return m ? NaN : ((s ? -1 : 1) * Infinity)
  } else {
    m = m + Math.pow(2, mLen)
    e = e - eBias
  }
  return (s ? -1 : 1) * m * Math.pow(2, e - mLen)
}

exports.write = function (buffer, value, offset, isLE, mLen, nBytes) {
  var e, m, c
  var eLen = (nBytes * 8) - mLen - 1
  var eMax = (1 << eLen) - 1
  var eBias = eMax >> 1
  var rt = (mLen === 23 ? Math.pow(2, -24) - Math.pow(2, -77) : 0)
  var i = isLE ? 0 : (nBytes - 1)
  var d = isLE ? 1 : -1
  var s = value < 0 || (value === 0 && 1 / value < 0) ? 1 : 0

  value = Math.abs(value)

  if (isNaN(value) || value === Infinity) {
    m = isNaN(value) ? 1 : 0
    e = eMax
  } else {
    e = Math.floor(Math.log(value) / Math.LN2)
    if (value * (c = Math.pow(2, -e)) < 1) {
      e--
      c *= 2
    }
    if (e + eBias >= 1) {
      value += rt / c
    } else {
      value += rt * Math.pow(2, 1 - eBias)
    }
    if (value * c >= 2) {
      e++
      c /= 2
    }

    if (e + eBias >= eMax) {
      m = 0
      e = eMax
    } else if (e + eBias >= 1) {
      m = ((value * c) - 1) * Math.pow(2, mLen)
      e = e + eBias
    } else {
      m = value * Math.pow(2, eBias - 1) * Math.pow(2, mLen)
      e = 0
    }
  }

  for (; mLen >= 8; buffer[offset + i] = m & 0xff, i += d, m /= 256, mLen -= 8) {}

  e = (e << mLen) | m
  eLen += mLen
  for (; eLen > 0; buffer[offset + i] = e & 0xff, i += d, e /= 256, eLen -= 8) {}

  buffer[offset + i - d] |= s * 128
}


/***/ }),
/* 59 */
/***/ (function(module, exports) {

var toString = {}.toString;

module.exports = Array.isArray || function (arr) {
  return toString.call(arr) == '[object Array]';
};


/***/ }),
/* 60 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) { // const fs = require('fs');

function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Reader = __webpack_require__(16);

var pos = 0;

var FileReader = /*#__PURE__*/function (_Reader) {
  _inherits(FileReader, _Reader);

  var _super = _createSuper(FileReader);

  function FileReader(fd) {
    var _this;

    _classCallCheck(this, FileReader);

    _this = _super.call(this);
    _this.fd = fd;
    return _this;
  }

  _createClass(FileReader, [{
    key: "size",
    value: function size() {
      return this.fd.byteLength;
    }
  }, {
    key: "read",
    value: function read(buffer, offset, targetOffset) {
      targetOffset = targetOffset || 0; // return fs.readSync(this.fd, buffer, targetOffset, buffer.length - targetOffset, offset);

      var arrbuffer = this.fd.slice(offset, offset + buffer.length - targetOffset);
      return this.toBuffer(arrbuffer);
    }
  }, {
    key: "toBuffer",
    value: function toBuffer(ab) {
      var buf = new Buffer(ab.byteLength);
      var view = new Uint8Array(ab);

      for (var i = 0; i < buf.length; ++i) {
        buf[i] = view[i];
      }

      return buf;
    }
  }]);

  return FileReader;
}(Reader);

module.exports = FileReader;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 61 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Reader = __webpack_require__(16);

var BufferReader = /*#__PURE__*/function (_Reader) {
  _inherits(BufferReader, _Reader);

  var _super = _createSuper(BufferReader);

  function BufferReader(buffer) {
    var _this;

    _classCallCheck(this, BufferReader);

    _this = _super.call(this);
    _this.buffer = buffer;
    return _this;
  }

  _createClass(BufferReader, [{
    key: "size",
    value: function size() {
      return this.buffer.length;
    }
  }, {
    key: "read",
    value: function read(buffer, offset, targetOffset) {
      targetOffset = targetOffset || 0;
      return this.buffer.copy(buffer, targetOffset, offset, offset + buffer.length - targetOffset);
    }
  }]);

  return BufferReader;
}(Reader);

module.exports = BufferReader;

/***/ }),
/* 62 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var SourceReader = __webpack_require__(10);

var PARSERS = [__webpack_require__(21), __webpack_require__(47)];
var HEADER_SIZE = 8;

var MovieParser = /*#__PURE__*/function () {
  function MovieParser() {
    _classCallCheck(this, MovieParser);
  }

  _createClass(MovieParser, null, [{
    key: "parse",
    value: function parse(source) {
      var reader = SourceReader.create(source);
      var header = Buffer.allocUnsafe(HEADER_SIZE); //reader.read(header, 0);
      // for (let parser of PARSERS) {
      //     if (parser.check(header)) {

      return PARSERS[0].parse(source); //     }
      // }

      throw new Error('Cannot parse movie file');
    }
  }]);

  return MovieParser;
}();

module.exports = MovieParser;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 63 */
/***/ (function(module, exports, __webpack_require__) {

var map = {
	"./atom-avc1": 22,
	"./atom-avc1.js": 22,
	"./atom-co64": 23,
	"./atom-co64.js": 23,
	"./atom-ctts": 24,
	"./atom-ctts.js": 24,
	"./atom-esds": 25,
	"./atom-esds.js": 25,
	"./atom-ftyp": 26,
	"./atom-ftyp.js": 26,
	"./atom-hdlr": 27,
	"./atom-hdlr.js": 27,
	"./atom-hev1": 28,
	"./atom-hev1.js": 28,
	"./atom-hvc1": 29,
	"./atom-hvc1.js": 29,
	"./atom-mdhd": 30,
	"./atom-mdhd.js": 30,
	"./atom-mdia": 31,
	"./atom-mdia.js": 31,
	"./atom-minf": 32,
	"./atom-minf.js": 32,
	"./atom-moov": 33,
	"./atom-moov.js": 33,
	"./atom-mp4a": 34,
	"./atom-mp4a.js": 34,
	"./atom-mvhd": 35,
	"./atom-mvhd.js": 35,
	"./atom-smhd": 36,
	"./atom-smhd.js": 36,
	"./atom-stbl": 37,
	"./atom-stbl.js": 37,
	"./atom-stco": 38,
	"./atom-stco.js": 38,
	"./atom-stsc": 39,
	"./atom-stsc.js": 39,
	"./atom-stsd": 40,
	"./atom-stsd.js": 40,
	"./atom-stss": 41,
	"./atom-stss.js": 41,
	"./atom-stsz": 42,
	"./atom-stsz.js": 42,
	"./atom-stts": 43,
	"./atom-stts.js": 43,
	"./atom-tkhd": 44,
	"./atom-tkhd.js": 44,
	"./atom-trak": 45,
	"./atom-trak.js": 45,
	"./atom-vmhd": 46,
	"./atom-vmhd.js": 46
};


function webpackContext(req) {
	var id = webpackContextResolve(req);
	return __webpack_require__(id);
}
function webpackContextResolve(req) {
	if(!__webpack_require__.o(map, req)) {
		var e = new Error("Cannot find module '" + req + "'");
		e.code = 'MODULE_NOT_FOUND';
		throw e;
	}
	return map[req];
}
webpackContext.keys = function webpackContextKeys() {
	return Object.keys(map);
};
webpackContext.resolve = webpackContextResolve;
module.exports = webpackContext;
webpackContext.id = 63;

/***/ }),
/* 64 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _createForOfIteratorHelper(o, allowArrayLike) { var it; if (typeof Symbol === "undefined" || o[Symbol.iterator] == null) { if (Array.isArray(o) || (it = _unsupportedIterableToArray(o)) || allowArrayLike && o && typeof o.length === "number") { if (it) o = it; var i = 0; var F = function F() {}; return { s: F, n: function n() { if (i >= o.length) return { done: true }; return { done: false, value: o[i++] }; }, e: function e(_e) { throw _e; }, f: F }; } throw new TypeError("Invalid attempt to iterate non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); } var normalCompletion = true, didErr = false, err; return { s: function s() { it = o[Symbol.iterator](); }, n: function n() { var step = it.next(); normalCompletion = step.done; return step; }, e: function e(_e2) { didErr = true; err = _e2; }, f: function f() { try { if (!normalCompletion && it["return"] != null) it["return"](); } finally { if (didErr) throw err; } } }; }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Utils = __webpack_require__(0);

var Movie = __webpack_require__(12);

var AudioTrack = __webpack_require__(8);

var VideoTrack = __webpack_require__(9);

var AudioSample = __webpack_require__(5);

var VideoSample = __webpack_require__(4);

var SourceReader = __webpack_require__(10);

var CodecParser = __webpack_require__(18);

var BufferUtils = __webpack_require__(6);

var ParserImpl = /*#__PURE__*/function () {
  function ParserImpl(source) {
    _classCallCheck(this, ParserImpl);

    this.source = source;
    this.isFullMoov = false;
    this.reader = SourceReader.create(this.source);
  }

  _createClass(ParserImpl, [{
    key: "parse",
    value: function parse() {
      // Get moov atom
      this._findMoovAtom();

      if (this.isFullMoov) {
        // Create movie
        this._createMovie(); // Create tracks


        var trakAtoms = this.moovAtom.getAtoms(Utils.ATOM_TRAK);

        var _iterator = _createForOfIteratorHelper(trakAtoms),
            _step;

        try {
          for (_iterator.s(); !(_step = _iterator.n()).done;) {
            var trakAtom = _step.value;

            this._createTrack(trakAtom);
          } // Complete movie object

        } catch (err) {
          _iterator.e(err);
        } finally {
          _iterator.f();
        }

        this.movie.tracks.forEach(function (track) {
          track.sortSamples();
          track.ensureDuration();
        });
        this.movie.ensureDuration();
      } // Return movie object


      return this.movie;
    }
  }, {
    key: "_findMoovAtom",
    value: function _findMoovAtom() {
      this.moovAtom = null;
      var pos = 0;
      var size = this.reader.size();
      var buffer = Buffer.allocUnsafe(8);

      while (pos < size) {
        buffer = this.reader.read(buffer, pos);
        var headerSize = 8;
        var atomSize = buffer.readUInt32BE(0);
        var atomType = buffer.toString('ascii', 4);

        if (atomSize === 0) {
          atomSize = size - pos;
        } else if (atomSize === 1) {
          buffer = this.reader.read(buffer, pos + buffer.length);
          atomSize = BufferUtils.readUInt64BE(buffer, 0);
          headerSize += 8;
        }

        if (Utils.ATOM_MOOV === atomType) {
          var _buffer = Buffer.allocUnsafe(atomSize - headerSize);

          _buffer = this.reader.read(_buffer, pos + headerSize);

          if (_buffer.byteLength === _buffer.length) {
            try {
              this.moovAtom = Utils.createAtom(atomType);
              this.moovAtom.parse(_buffer);
              this.isFullMoov = true;
            } catch (_unused) {
              console.log('moov 不全');
            }

            break;
          }
        } else {
          pos += atomSize;
        }
      }

      if (!this.moovAtom) {
        // throw new Error('MOOV atom not found');
        console.log('MOOV atom not found');
      }
    }
  }, {
    key: "_createMovie",
    value: function _createMovie() {
      // Create movie
      this.movie = new Movie(); // Add meta information

      var mvhdAtom = this.moovAtom.getAtom(Utils.ATOM_MVHD);

      if (mvhdAtom) {
        this.movie.timescale = mvhdAtom.timescale;
        this.movie.duration = mvhdAtom.duration;
      }
    }
  }, {
    key: "_createTrack",
    value: function _createTrack(trakAtom) {
      var mdiaAtom = trakAtom.getAtom(Utils.ATOM_MDIA);

      if (mdiaAtom === null) {
        return;
      }

      var hdlrAtom = mdiaAtom.getAtom(Utils.ATOM_HDLR);
      var mdhdAtom = mdiaAtom.getAtom(Utils.ATOM_MDHD);
      var minfAtom = mdiaAtom.getAtom(Utils.ATOM_MINF);

      if (hdlrAtom === null || mdhdAtom === null || minfAtom === null) {
        return;
      }

      var stblAtom = minfAtom.getAtom(Utils.ATOM_STBL);

      if (stblAtom === null) {
        return;
      }

      var stsdAtom = stblAtom.getAtom(Utils.ATOM_STSD);
      var track = null;
      var samplePrototype = null;

      if (Utils.TRACK_TYPE_AUDIO === hdlrAtom.handlerType) {
        var audioAtom = stsdAtom.getAudioAtom();

        if (audioAtom !== null) {
          track = new AudioTrack();
          samplePrototype = AudioSample.prototype;
          track.channels = audioAtom.channels;
          track.sampleRate = audioAtom.sampleRate;
          track.sampleSize = audioAtom.sampleSize;
          track.extraData = audioAtom.extraData;
        }
      } else if (Utils.TRACK_TYPE_VIDEO === hdlrAtom.handlerType) {
        var videoAtom = stsdAtom.getVideoAtom();

        if (videoAtom !== null) {
          track = new VideoTrack();
          samplePrototype = VideoSample.prototype;
          track.width = videoAtom.width;
          track.height = videoAtom.height;
          track.extraData = videoAtom.extraData;
        }
      }

      if (track === null) {
        return;
      }

      track.duration = mdhdAtom.duration;
      track.timescale = mdhdAtom.timescale;
      var codecInfo = CodecParser.parse(track.extraData);

      if (codecInfo !== null) {
        track.codec = codecInfo.codec();
      } // Get needed data to build samples


      var compositions = ParserImpl._getEntries(stblAtom, Utils.ATOM_CTTS);

      var sampleSizes = ParserImpl._getEntries(stblAtom, Utils.ATOM_STSZ);

      var samplesToChunk = ParserImpl._getEntries(stblAtom, Utils.ATOM_STSC);

      var syncSamples = ParserImpl._getEntries(stblAtom, Utils.ATOM_STSS);

      var timeSamples = ParserImpl._getEntries(stblAtom, Utils.ATOM_STTS);

      var chunkOffsets = ParserImpl._getEntries(stblAtom, Utils.ATOM_STCO);

      if (chunkOffsets.length === 0) {
        chunkOffsets = ParserImpl._getEntries(stblAtom, Utils.ATOM_CO64);
      }

      var currentTimestamp = 0;
      var currentChunk = 0;
      var currentChunkOffset = 0;
      var currentChunkNumbers = 0;
      var currentSampleChunk = 0;
      var currentCompositionIndex = 0;
      var currentCompositionCount = 0;
      var index = 0;
      var indexKeyframe = 0;
      var samplesPerChunk = 0;

      if (samplesToChunk.length > 0) {
        currentSampleChunk = samplesToChunk[0];
        samplesPerChunk = samplesToChunk[1];
      } // Build samples


      var samples = new Array(sampleSizes.length);
      var pos = 0;

      for (var i = 0, l = timeSamples.length; i < l; i += 2) {
        var sampleDuration = timeSamples[i + 1] || 0;

        for (var j = 0; j < timeSamples[i]; j++) {
          var sample = Object.create(samplePrototype);
          sample.timestamp = currentTimestamp;
          sample.timescale = track.timescale;
          sample.size = sampleSizes[index];
          sample.offset = chunkOffsets[currentChunk] + currentChunkOffset;

          if (track instanceof VideoTrack) {
            sample.width = track.width;
            sample.height = track.height;
            sample.type = 'video';
            var compositionOffset = 0;

            if (2 * currentCompositionIndex + 1 < compositions.length) {
              compositionOffset = compositions[2 * currentCompositionIndex + 1] || 0;
              currentCompositionCount++;

              if (currentCompositionCount >= compositions[2 * currentCompositionIndex]) {
                currentCompositionIndex++;
                currentCompositionCount = 0;
              }
            }

            sample.compositionOffset = compositionOffset;

            if (indexKeyframe < syncSamples.length && syncSamples[indexKeyframe] === index + 1) {
              sample.keyframe = true;
              indexKeyframe++;
            } else {
              sample.keyframe = false;
            }
          } else {
            sample.type = 'audio';
          }

          if (sample.size > 0) {
            samples[pos++] = sample;
          }

          currentChunkNumbers++;

          if (currentChunkNumbers < samplesPerChunk) {
            currentChunkOffset += sampleSizes[index];
          } else {
            currentChunkNumbers = 0;
            currentChunkOffset = 0;
            currentChunk++;

            if (currentSampleChunk * 3 + 1 < samplesToChunk.length) {
              if (currentChunk + 1 >= samplesToChunk[3 * currentSampleChunk]) {
                samplesPerChunk = samplesToChunk[3 * currentSampleChunk + 1];
                currentSampleChunk++;
              }
            }
          }

          currentTimestamp += sampleDuration;
          index++;
        }
      }

      if (pos < samples.length) {
        track.samples = samples.slice(0, pos);
      } else {
        track.samples = samples;
      }

      if (track.extraData && track.samples.length > 0) {
        this.movie.addTrack(track);
      }
    }
  }], [{
    key: "_getEntries",
    value: function _getEntries(stblAtom, type) {
      var entries = [];
      var atom = stblAtom.getAtom(type);

      if (atom !== null) {
        entries = atom.entries;
      }

      return entries;
    }
  }]);

  return ParserImpl;
}();

module.exports = ParserImpl;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 65 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Codec = __webpack_require__(19);

var Utils = __webpack_require__(11);

var AAC_SAMPLE_RATES = [96000, 88200, 64000, 48000, 44100, 32000, 24000, 22050, 16000, 12000, 11025, 8000, 7350];
var AAC_CHANNELS = [0, 1, 2, 3, 4, 5, 6, 8];

var CodecAac = /*#__PURE__*/function (_Codec) {
  _inherits(CodecAac, _Codec);

  var _super = _createSuper(CodecAac);

  function CodecAac(extraData) {
    var _this;

    _classCallCheck(this, CodecAac);

    _this = _super.call(this);
    _this.extraData = extraData;
    _this.rateIndex = null;
    _this.sampleRate = null;
    _this.channelsIndex = null;
    _this.channels = null;
    _this.profileObjectType = null;
    return _this;
  }

  _createClass(CodecAac, [{
    key: "type",
    value: function type() {
      return Utils.CODEC_AAC;
    }
  }, {
    key: "parse",
    value: function parse() {
      var flags1 = this.extraData[0];
      var flags2 = this.extraData[1];
      this.profileObjectType = (flags1 & 0xf8) >> 3;
      this.rateIndex = ((flags1 & 7) << 1) + ((flags2 & 0x80) >> 7 & 1);
      this.sampleRate = AAC_SAMPLE_RATES[this.rateIndex] || null;
      this.channelsIndex = (flags2 & 0x7f) >> 3;
      this.channels = AAC_CHANNELS[this.channelsIndex] || null;
    }
  }, {
    key: "codec",
    value: function codec() {
      return "mp4a.40.".concat(this.profileObjectType);
    }
  }]);

  return CodecAac;
}(Codec);

module.exports = CodecAac;

/***/ }),
/* 66 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Codec = __webpack_require__(19);

var Utils = __webpack_require__(11);

function pad(string, _char, length) {
  return _char.repeat(Math.max(0, length - string.length)) + string;
}

var CodecH264 = /*#__PURE__*/function (_Codec) {
  _inherits(CodecH264, _Codec);

  var _super = _createSuper(CodecH264);

  function CodecH264(extraData) {
    var _this;

    _classCallCheck(this, CodecH264);

    _this = _super.call(this);
    _this.extraData = extraData;
    _this._units = [];
    _this._pos = 0;
    return _this;
  }

  _createClass(CodecH264, [{
    key: "type",
    value: function type() {
      return Utils.CODEC_H264;
    }
  }, {
    key: "parse",
    value: function parse() {
      this._pos = 5;
      var spsFlags = this.extraData[this._pos++];
      var spsCount = spsFlags & 0x1f;

      for (var i = 0; i < spsCount; i++) {
        this._units.push(this._readNalUnit());
      }

      var ppsCount = this.extraData[this._pos++];

      for (var _i = 0; _i < ppsCount; _i++) {
        this._units.push(this._readNalUnit());
      }
    }
  }, {
    key: "units",
    value: function units() {
      return this._units;
    }
  }, {
    key: "codec",
    value: function codec() {
      var info = '';

      for (var i = 1; i < 4; i++) {
        info += pad(this.extraData[i].toString(16), '0', 2);
      }

      return "avc1.".concat(info);
    }
  }, {
    key: "_readNalUnit",
    value: function _readNalUnit() {
      var length = this.extraData.readUInt16BE(this._pos);
      this._pos += 2;
      var unit = this.extraData.slice(this._pos, this._pos + length);
      this._pos += length;
      return unit;
    }
  }]);

  return CodecH264;
}(Codec);

module.exports = CodecH264;

/***/ }),
/* 67 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _createSuper(Derived) { var hasNativeReflectConstruct = _isNativeReflectConstruct(); return function _createSuperInternal() { var Super = _getPrototypeOf(Derived), result; if (hasNativeReflectConstruct) { var NewTarget = _getPrototypeOf(this).constructor; result = Reflect.construct(Super, arguments, NewTarget); } else { result = Super.apply(this, arguments); } return _possibleConstructorReturn(this, result); }; }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Boolean.prototype.valueOf.call(Reflect.construct(Boolean, [], function () {})); return true; } catch (e) { return false; } }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

var Codec = __webpack_require__(19);

var Utils = __webpack_require__(11);

var TYPE_VPS = 32;
var TYPE_SPS = 33;
var TYPE_PPS = 34;

var CodecH265 = /*#__PURE__*/function (_Codec) {
  _inherits(CodecH265, _Codec);

  var _super = _createSuper(CodecH265);

  function CodecH265(extraData) {
    var _this;

    _classCallCheck(this, CodecH265);

    _this = _super.call(this);
    _this.extraData = extraData;
    _this._units = [];
    _this._pos = 0;
    return _this;
  }

  _createClass(CodecH265, [{
    key: "type",
    value: function type() {
      return Utils.CODEC_H265;
    }
  }, {
    key: "parse",
    value: function parse() {
      this._pos = 22;
      var nalSequences = this.extraData[this._pos++];

      for (var i = 0; i < nalSequences; i++) {
        var nalType = this.extraData[this._pos++] & 0x3f;
        var count = this.extraData.readUInt16BE(this._pos);
        this._pos += 2;

        for (var j = 0; j < count; j++) {
          var nalUnit = this._readNalUnit();

          if (nalType === TYPE_VPS || nalType === TYPE_SPS || nalType === TYPE_PPS) {
            this._units.push(nalUnit);
          }
        }
      }
    }
  }, {
    key: "units",
    value: function units() {
      return this._units;
    }
  }, {
    key: "codec",
    value: function codec() {
      var profileIndication = this.extraData[1];
      var generalTierFlag = (profileIndication >> 5 & 1) === 1;
      var generalCompatibilityFlags = this.extraData.readUInt32LE(2).toString(16).replace(/0+$/, '');
      var generalLevel = this.extraData[12];
      var generalConstraintFlags = [];

      for (var i = 6; i < 12; i++) {
        generalConstraintFlags.push(this.extraData[i]);
      }

      var size = 0;

      for (var _i = generalConstraintFlags.length - 1; _i > 0; _i--) {
        if (generalConstraintFlags[_i] > 0) {
          size = _i;
          break;
        }
      }

      var fields = ['hvc1', (profileIndication >> 6) + (profileIndication & 0x1f), generalCompatibilityFlags, "".concat(generalTierFlag ? 'H' : 'L').concat(generalLevel)];

      for (var _i2 = 0; _i2 <= size; _i2++) {
        fields.push(generalConstraintFlags[_i2].toString(16).replace(/0+$/, ''));
      }

      return fields.join('.');
    }
  }, {
    key: "_readNalUnit",
    value: function _readNalUnit() {
      var length = this.extraData.readUInt16BE(this._pos);
      this._pos += 2;
      var unit = this.extraData.slice(this._pos, this._pos + length);
      this._pos += length;
      return unit;
    }
  }]);

  return CodecH265;
}(Codec);

module.exports = CodecH265;

/***/ }),
/* 68 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var AmfParser = __webpack_require__(69);

var Utils = __webpack_require__(48);

var Movie = __webpack_require__(12);

var AudioTrack = __webpack_require__(8);

var VideoTrack = __webpack_require__(9);

var AudioSample = __webpack_require__(5);

var VideoSample = __webpack_require__(4);

var SourceReader = __webpack_require__(10);

var CodecParser = __webpack_require__(18);

var ParserImpl = /*#__PURE__*/function () {
  function ParserImpl(source) {
    _classCallCheck(this, ParserImpl);

    this.source = source;
    this.reader = SourceReader.create(this.source);
  }

  _createClass(ParserImpl, [{
    key: "parse",
    value: function parse() {
      var _this = this;

      // Parse header
      this._parseHeader(); // Create movie


      this._createMovie(); // Parse body


      this._parseBody(); // Complete movie object


      [this.videoTrack, this.audioTrack].forEach(function (track) {
        if (track.extraData && track.samples.length > 0) {
          track.sortSamples();
          track.ensureDuration();

          _this.movie.addTrack(track);
        }
      });
      this.movie.ensureDuration(); // Return movie object

      return this.movie;
    }
  }, {
    key: "_parseHeader",
    value: function _parseHeader() {
      var buffer = Buffer.allocUnsafe(Utils.HEADER_SIZE);
      this.reader.read(buffer, 0);

      if (buffer.toString('ascii', 0, 3) !== Utils.HEADER_PREFIX || buffer[3] !== Utils.HEADER_VERSION) {
        throw new Error('FLV header not found');
      }

      this.pos = buffer[8];
    }
  }, {
    key: "_createMovie",
    value: function _createMovie() {
      // Create movie
      this.movie = new Movie();
      this.movie.timescale = Utils.MOVIE_TIMESCALE; // Create video track

      this.videoTrack = new VideoTrack();
      this.videoTrack.timescale = Utils.MOVIE_TIMESCALE; // Create audio track

      this.audioTrack = new AudioTrack();
      this.audioTrack.timescale = Utils.MOVIE_TIMESCALE;
    }
  }, {
    key: "_parseBody",
    value: function _parseBody() {
      var buffer = Buffer.allocUnsafe(15);
      var size = this.reader.size();

      while (this.pos < size) {
        this.pos += this.reader.read(buffer, this.pos);
        var type = buffer[4];

        if (undefined === type) {
          break;
        }

        var dataSize = buffer.readUIntBE(5, 3);
        var timestamp = (buffer[11] << 24) + buffer.readUIntBE(8, 3);

        if (Utils.TYPE_SCRIPT === type) {
          this._parseScript(dataSize);
        } else if (Utils.TYPE_AUDIO === type) {
          this._parseAudio(dataSize, timestamp);
        } else if (Utils.TYPE_VIDEO === type) {
          this._parseVideo(dataSize, timestamp);
        }

        this.pos += dataSize;
      }
    }
  }, {
    key: "_parseScript",
    value: function _parseScript(dataSize) {
      var buffer = Buffer.allocUnsafe(dataSize);
      this.reader.read(buffer, this.pos);
      var data = AmfParser.parse(buffer);

      if (data && data.length > 1) {
        var metaData = data[1];

        if (metaData['duration'] !== undefined) {
          var duration = metaData['duration'] * Utils.MOVIE_TIMESCALE;
          this.movie.duration = duration;
          this.videoTrack.duration = duration;
          this.audioTrack.duration = duration;
        }

        if (metaData['width'] !== undefined) {
          this.videoTrack.width = metaData['width'];
        }

        if (metaData['height'] !== undefined) {
          this.videoTrack.height = metaData['height'];
        }
      }
    }
  }, {
    key: "_parseAudio",
    value: function _parseAudio(dataSize, timestamp) {
      // Read header
      var headerSize = 2;
      var buffer = Buffer.allocUnsafe(headerSize);
      this.reader.read(buffer, this.pos); // Metadata

      var flags = buffer[0];
      var soundType = flags & 0x01;
      var soundSize = (flags & 0x02) >> 1;
      var soundRate = (flags & 0x0c) >> 2;
      var soundFormat = (flags & 0xf0) >> 4;

      if (Utils.AUDIO_FORMAT_AAC !== soundFormat) {
        return;
      }

      if (0 === buffer[1]) {
        // Update audio track
        this.audioTrack.channels = 1 === soundType ? 2 : 1;
        this.audioTrack.sampleRate = 5512.5 * (1 << soundRate) << 0;
        this.audioTrack.sampleSize = 1 === soundSize ? 16 : 8; // Get codec info

        var extraData = Buffer.allocUnsafe(4 + dataSize - headerSize);
        extraData.write('mp4a');
        this.reader.read(extraData, this.pos + headerSize, 4);
        this.audioTrack.extraData = extraData;
        this.audioTrack.codec = CodecParser.parse(extraData).codec();
      } else {
        // Get sample info
        var sample = Object.create(AudioSample.prototype);
        sample.timestamp = timestamp;
        sample.timescale = this.audioTrack.timescale;
        sample.size = dataSize - headerSize;
        sample.offset = this.pos + headerSize;

        if (0 < sample.size) {
          this.audioTrack.samples.push(sample);
        }
      }
    }
  }, {
    key: "_parseVideo",
    value: function _parseVideo(dataSize, timestamp) {
      // Read header
      var headerSize = 5;
      var buffer = Buffer.allocUnsafe(headerSize);
      this.reader.read(buffer, this.pos); // Metadata

      var flags = buffer[0];
      var videoFormat = flags & 0x0f;
      var frameType = (flags & 0xf0) >> 4;
      var compTime = buffer.readUIntBE(2, 3);

      if (Utils.VIDEO_FORMAT_H264 !== videoFormat) {
        return;
      }

      if (0 === buffer[1]) {
        // Get codec info
        var extraData = Buffer.allocUnsafe(4 + dataSize - headerSize);
        extraData.write('avcC');
        this.reader.read(extraData, this.pos + headerSize, 4);
        this.videoTrack.extraData = extraData;
        this.videoTrack.codec = CodecParser.parse(extraData).codec();
      } else {
        // Get sample info
        var sample = Object.create(VideoSample.prototype);
        sample.timestamp = timestamp;
        sample.timescale = this.videoTrack.timescale;
        sample.size = dataSize - headerSize;
        sample.offset = this.pos + headerSize;
        sample.compositionOffset = compTime;
        sample.keyframe = 1 === frameType;

        if (0 < sample.size) {
          this.videoTrack.samples.push(sample);
        }
      }
    }
  }]);

  return ParserImpl;
}();

module.exports = ParserImpl;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 69 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var TYPE_NUMBER = 0x00;
var TYPE_BOOLEAN = 0x01;
var TYPE_STRING = 0x02;
var TYPE_OBJECT = 0x03; // const TYPE_MOVIECLIP         = 0x04; // reserved, not supported

var TYPE_NULL = 0x05;
var TYPE_UNDEFINED = 0x06;
var TYPE_REFERENCE = 0x07;
var TYPE_ECMA_ARRAY = 0x08;
var TYPE_OBJECT_END = 0x09;
var TYPE_STRICT_ARRAY = 0x0a;
var TYPE_DATE = 0x0b;
var TYPE_LONG_STRING = 0x0c;
var TYPE_UNSUPPORTED = 0x0d; // const TYPE_RECORDSET         = 0x0e; // reserved, not supported

var TYPE_XML_DOCUMENT = 0x0f; // const TYPE_TYPED_OBJECT      = 0x10; // not implemented
// const TYPE_AVMPLUS_OBJECT    = 0x11; // not implemented

var AmfReader = /*#__PURE__*/function () {
  function AmfReader(buffer) {
    _classCallCheck(this, AmfReader);

    this.buffer = buffer;
    this.pos = 0;
  }

  _createClass(AmfReader, [{
    key: "read",
    value: function read() {
      var data = [];

      while (this.pos < this.buffer.length) {
        data.push(this._readByType(this._readByte()));
      }

      return data;
    }
  }, {
    key: "_readByType",
    value: function _readByType(type) {
      switch (type) {
        case TYPE_NUMBER:
          {
            return this._readDouble();
          }

        case TYPE_BOOLEAN:
          {
            return this._readBoolean();
          }

        case TYPE_STRING:
          {
            return this._readString();
          }

        case TYPE_OBJECT:
          {
            return this._readObject();
          }

        case TYPE_NULL:
          {
            return null;
          }

        case TYPE_UNDEFINED:
          {
            return undefined;
          }

        case TYPE_UNSUPPORTED:
          {
            return null;
          }

        case TYPE_REFERENCE:
          {
            return this._readReference();
          }

        case TYPE_ECMA_ARRAY:
          {
            return this._readEcmaArray();
          }

        case TYPE_STRICT_ARRAY:
          {
            return this._readStrictArray();
          }

        case TYPE_DATE:
          {
            return this._readDate();
          }

        case TYPE_LONG_STRING:
          {
            return this._readLongString();
          }

        case TYPE_XML_DOCUMENT:
          {
            return this._readXmlDocument();
          }
      }
    }
  }, {
    key: "_readByte",
    value: function _readByte() {
      return this.buffer[this.pos++];
    }
  }, {
    key: "_readDouble",
    value: function _readDouble() {
      var value = this.buffer.readDoubleBE(this.pos);
      this.pos += 8;
      return value;
    }
  }, {
    key: "_readBoolean",
    value: function _readBoolean() {
      return 0 !== this._readByte();
    }
  }, {
    key: "_readString",
    value: function _readString() {
      var size = this.buffer.readUInt16BE(this.pos);
      this.pos += 2;
      var value = this.buffer.toString('utf8', this.pos, this.pos + size);
      this.pos += size;
      return value;
    }
  }, {
    key: "_readObject",
    value: function _readObject() {
      var object = {};
      var key, type;

      do {
        key = this._readString();
        type = this._readByte();

        if (type !== TYPE_OBJECT_END) {
          object[key] = this._readByType(type);
        }
      } while (type !== TYPE_OBJECT_END);

      return object;
    }
  }, {
    key: "_readReference",
    value: function _readReference() {
      var index = this.buffer.readUInt16BE(this.pos);
      this.pos += 2;
      return "Reference #".concat(index);
    }
  }, {
    key: "_readEcmaArray",
    value: function _readEcmaArray() {
      this.pos += 4;
      return this._readObject();
    }
  }, {
    key: "_readStrictArray",
    value: function _readStrictArray() {
      var size = this.buffer.readUInt32BE(this.pos);
      this.pos += 4;
      var array = [];

      for (var i = 0; i < size; i++) {
        array.push(this._readByType(this._readByte()));
      }

      return array;
    }
  }, {
    key: "_readDate",
    value: function _readDate() {
      var value = this.buffer.readDoubleBE(this.pos + 2);
      this.pos += 10;
      return value;
    }
  }, {
    key: "_readLongString",
    value: function _readLongString() {
      var size = this.buffer.readUInt32BE(this.pos);
      this.pos += 4;
      var value = this.buffer.toString('utf8', this.pos, this.pos + size);
      this.pos += size;
      return value;
    }
  }, {
    key: "_readXmlDocument",
    value: function _readXmlDocument() {
      return this._readLongString();
    }
  }]);

  return AmfReader;
}();

var AmfParser = /*#__PURE__*/function () {
  function AmfParser() {
    _classCallCheck(this, AmfParser);
  }

  _createClass(AmfParser, null, [{
    key: "parse",
    value: function parse(buffer) {
      var reader = new AmfReader(buffer);
      return reader.read();
    }
  }]);

  return AmfParser;
}();

module.exports = AmfParser;

/***/ }),
/* 70 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Fragment = __webpack_require__(15);

var PacketizerImpl = __webpack_require__(71);

var Packetizer = /*#__PURE__*/function () {
  function Packetizer() {
    _classCallCheck(this, Packetizer);
  }

  _createClass(Packetizer, null, [{
    key: "packetize",
    value: function packetize(fragment, sampleBuffers) {
      if (!(fragment instanceof Fragment)) {
        throw new Error('Argument 1 should be instance of Fragment');
      }

      var packetizer = new PacketizerImpl(fragment, sampleBuffers);
      return packetizer.packFragment();
    }
  }]);

  return Packetizer;
}();

module.exports = Packetizer;

/***/ }),
/* 71 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(Buffer) {

var _STREAM_TYPES;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

var crc32 = __webpack_require__(72);

var SampleCounter = __webpack_require__(73);

var VideoSample = __webpack_require__(4);

var AudioSample = __webpack_require__(5);

var CodecParser = __webpack_require__(18);

var CodecUtils = __webpack_require__(11);

var SYNC_BYTE = 0x47;
var PACKET_SIZE = 188;
var MAX_AUDIO_SAMPLES_PACK = 5;
var PAT_PID = 0x0;
var PMP_PID = 0xfff;
var VIDEO_PID = 0x100;
var AUDIO_PID = 0x101;
var STREAM_TYPES = (_STREAM_TYPES = {}, _defineProperty(_STREAM_TYPES, CodecUtils.CODEC_AAC, 0x0f), _defineProperty(_STREAM_TYPES, CodecUtils.CODEC_H264, 0x1b), _defineProperty(_STREAM_TYPES, CodecUtils.CODEC_H265, 0x24), _STREAM_TYPES);

var PacketizerImpl = /*#__PURE__*/function () {
  function PacketizerImpl(fragment, sampleBuffers) {
    _classCallCheck(this, PacketizerImpl);

    this.fragment = fragment;
    this.sampleBuffers = sampleBuffers;
    this._counter = new SampleCounter();

    if (this.fragment.hasAudio()) {
      this._audioCodecInfo = CodecParser.parse(this.fragment.audioExtraData);
    } else {
      this._audioCodecInfo = null;
    }

    if (this.fragment.hasVideo()) {
      this._videoCodecInfo = CodecParser.parse(this.fragment.videoExtraData);
      this._videoConfig = this._buildVideoConfig();
    } else {
      this._videoCodecInfo = null;
      this._videoConfig = Buffer.allocUnsafe(0);
    }
  }

  _createClass(PacketizerImpl, [{
    key: "packFragment",
    value: function packFragment() {
      var buffers = [];
      var buffersLength = 0;
      var packetTimescale = 90 * this.fragment.timescale; // Write header

      var header = this._buildHeader();

      buffers.push(header);
      buffersLength += header.length; // Audio samples pack

      var audioPackets = [];
      var audioPacketsLength = 0;
      var audioPacketsSample = null;
      var audioPacketsTime = 0;

      var packAudio = function () {
        var audioBuffer = this._packAudioPayload(Buffer.concat(audioPackets, audioPacketsLength), audioPacketsSample, audioPacketsTime);

        buffers.push(audioBuffer);
        buffersLength += audioBuffer.length;
        audioPackets = [];
        audioPacketsLength = 0;
      }.bind(this); // Write samples


      for (var i = 0, l = this.fragment.samples.length; i < l; i++) {
        var sample = this.fragment.samples[i];
        var buffer = this.sampleBuffers[i];
        var dtsTime = packetTimescale * sample.timestamp / sample.timescale << 0;

        if (sample instanceof AudioSample) {
          var packet = this._convertAudioSample(buffer);

          if (audioPackets.length === MAX_AUDIO_SAMPLES_PACK) {
            packAudio();
          }

          if (audioPackets.length === 0) {
            audioPacketsSample = sample;
            audioPacketsTime = dtsTime;
          }

          audioPackets.push(packet);
          audioPacketsLength += packet.length;
        } else if (sample instanceof VideoSample) {
          if (audioPackets.length > 0) {
            packAudio();
          }

          var sampleCompTime = packetTimescale * sample.compositionOffset / sample.timescale << 0;
          var ptsTime = dtsTime + sampleCompTime;

          var _packet = this._convertVideoSample(buffer, sample.keyframe);

          var videoBuffer = this._packVideoPayload(_packet, sample, ptsTime, dtsTime);

          buffers.push(videoBuffer);
          buffersLength += videoBuffer.length;
        }
      }

      if (audioPackets.length > 0) {
        packAudio();
      }

      return Buffer.concat(buffers, buffersLength);
    }
  }, {
    key: "_convertAudioSample",
    value: function _convertAudioSample(buffer) {
      var packetLength = 7 + buffer.length;
      var packet = Buffer.allocUnsafe(packetLength); // Write header

      packet[0] = 0xff;
      packet[1] = 0xf1;
      packet[2] = ((this._audioCodecInfo.profileObjectType - 1 & 0x3) << 6) + (this._audioCodecInfo.rateIndex << 2 & 0x3c) + (this._audioCodecInfo.channelsIndex >> 2 & 0x1) & 0xff;
      packet[3] = (this._audioCodecInfo.channelsIndex & 0x3) << 6 & 0xff;
      packet[5] = ((packetLength & 0x7) << 5) + 0x5 & 0xff;
      packetLength >>= 3;
      packet[4] = packetLength & 0xff;
      packetLength >>= 8;
      packet[3] += packetLength & 0x3;
      packet[6] = 0xffc; // Copy buffer

      buffer.copy(packet, 7);
      return packet;
    }
  }, {
    key: "_convertVideoSample",
    value: function _convertVideoSample(buffer, isKeyframe) {
      var packetLength = 6 + buffer.length + (isKeyframe ? this._videoConfig.length : 0);

      if (this._videoCodecInfo.type() === CodecUtils.CODEC_H265) {
        packetLength++;
      }

      var packet = Buffer.allocUnsafe(packetLength);
      var pos = 0; // Write header

      packet.writeUInt32BE(1, pos);
      pos += 4;

      if (this._videoCodecInfo.type() === CodecUtils.CODEC_H265) {
        packet[pos++] = 70;
        packet[pos++] = 0x01;
      } else {
        packet[pos++] = 9;
      }

      packet[pos++] = 0x10;

      if (isKeyframe) {
        this._videoConfig.copy(packet, pos);

        pos += this._videoConfig.length;
      } // Copy NAL units


      buffer.copy(packet, pos);

      while (pos < packet.length) {
        var nalSize = packet.readInt32BE(pos);
        packet.writeUInt32BE(1, pos);
        pos += 4 + nalSize;
      }

      return packet;
    }
  }, {
    key: "_packAudioPayload",
    value: function _packAudioPayload(payload, sample, dtsTime) {
      var data = Buffer.allocUnsafe(14 + payload.length);
      var pos = 0;
      var pesPacketLength = 8 + payload.length;
      data[pos++] = 0; // packet_start_code_prefix

      data[pos++] = 0; // packet_start_code_prefix

      data[pos++] = 1; // packet_start_code_prefix

      data[pos++] = 0xc0; // stream_id

      data[pos++] = pesPacketLength >> 8 & 0xff; // PES_packet_length

      data[pos++] = pesPacketLength & 0xff; // PES_packet_length

      data[pos++] = 0x80; // optional PES header - binary stream

      data[pos++] = 0x80; // optional PES header - PTS DTS indicator

      data[pos++] = 5; // length of the remainder of the PES header in bytes
      // DTS

      pos += PacketizerImpl._writeTime(data, pos, dtsTime, 0x20); // Copy payload to data

      payload.copy(data, pos); // Pack payload

      return this._packPayload(data, sample, AUDIO_PID, dtsTime);
    }
  }, {
    key: "_packVideoPayload",
    value: function _packVideoPayload(payload, sample, ptsTime, dtsTime) {
      var data = Buffer.allocUnsafe(19 + payload.length);
      var pos = 0;
      data[pos++] = 0; // packet_start_code_prefix

      data[pos++] = 0; // packet_start_code_prefix

      data[pos++] = 1; // packet_start_code_prefix

      data[pos++] = 0xe0; // stream_id

      data[pos++] = 0; // PES_packet_length

      data[pos++] = 0; // PES_packet_length

      data[pos++] = 0x80; // optional PES header - binary stream

      data[pos++] = 0xc0; // optional PES header - PTS DTS indicator

      data[pos++] = 10; // length of the remainder of the PES header in bytes
      // PTS & DTS

      pos += PacketizerImpl._writeTime(data, pos, ptsTime, 0x30);
      pos += PacketizerImpl._writeTime(data, pos, dtsTime, 0x10); // Copy payload to data

      payload.copy(data, pos);
      return this._packPayload(data, sample, VIDEO_PID, dtsTime);
    }
  }, {
    key: "_packPayload",
    value: function _packPayload(payload, sample, pid, dtsTime) {
      // Number of packets
      var numPackets = Math.ceil(payload.length / (PACKET_SIZE - 4));

      if (sample instanceof VideoSample && numPackets * (PACKET_SIZE - 4) - 8 < payload.length) {
        // Take into account adaptation field
        numPackets++;
      } // Allocate a buffer


      var buffer = Buffer.allocUnsafe(PACKET_SIZE * numPackets); // Fill the buffer

      var payloadPos = 0;

      for (var index = 0; index < numPackets; index++) {
        var lastBytes = payload.length - payloadPos;
        var adaptationFields = false;

        if (0 === index && sample instanceof VideoSample || lastBytes < PACKET_SIZE - 4) {
          adaptationFields = true;
        }

        var pos = index * PACKET_SIZE;
        buffer[pos++] = SYNC_BYTE;
        buffer[pos++] = (0 === index ? 0x40 : 0) + (pid >> 8 & 0x1f);
        buffer[pos++] = pid & 0xff;
        buffer[pos++] = this._counter.next(sample) + (adaptationFields ? 0x30 : 0x10);

        if (adaptationFields) {
          var adaptationLength = 0;

          if (sample instanceof VideoSample && 0 === index) {
            adaptationLength = 7;
          }

          if (lastBytes < PACKET_SIZE - 5) {
            adaptationLength = Math.max(adaptationLength, PACKET_SIZE - 5 - lastBytes);
          }

          buffer[pos++] = adaptationLength;

          if (0 < adaptationLength) {
            var usedAdaptationLength = 1;
            var adaptationFlags = 0;

            if (sample instanceof VideoSample && 0 === index) {
              adaptationFlags = sample.keyframe ? 0x50 : 0x10;
              usedAdaptationLength += 6;
              buffer[pos + 1] = dtsTime >> 25 & 0xff;
              buffer[pos + 2] = dtsTime >> 17 & 0xff;
              buffer[pos + 3] = dtsTime >> 9 & 0xff;
              buffer[pos + 4] = dtsTime >> 1 & 0xff;
              buffer[pos + 5] = (dtsTime & 0x1) << 7 | 0x7e;
              buffer[pos + 6] = 0;
            }

            buffer[pos] = adaptationFlags;
            pos += usedAdaptationLength;

            if (usedAdaptationLength < adaptationLength) {
              buffer.fill(-1, pos, pos + adaptationLength - usedAdaptationLength);
              pos += adaptationLength - usedAdaptationLength;
            }
          }
        }

        var capacity = (index + 1) * PACKET_SIZE - pos;

        if (0 < capacity) {
          payload.copy(buffer, pos, payloadPos, payloadPos + capacity);
          payloadPos += capacity;
        }
      }

      return buffer;
    }
  }, {
    key: "_buildHeader",
    value: function _buildHeader() {
      var buffer = Buffer.allocUnsafe(2 * PACKET_SIZE);
      var pos = 0; // Write PAT packet

      buffer[pos++] = SYNC_BYTE;
      buffer[pos++] = (PAT_PID >> 8 & 0x1f) + 0x40;
      buffer[pos++] = PAT_PID & 0xff;
      buffer[pos++] = 0x10; // 0x1f

      buffer[pos++] = 0;
      var sectionLength = 13;
      buffer[pos++] = 0;
      buffer[pos++] = (sectionLength >> 8 & 0x0f) + 0xb0;
      buffer[pos++] = sectionLength & 0xff;
      buffer[pos++] = 0;
      buffer[pos++] = 1;
      buffer[pos++] = 0xc1;
      buffer[pos++] = 0;
      buffer[pos++] = 0;
      buffer[pos++] = 0;
      buffer[pos++] = 1;
      buffer[pos++] = (PMP_PID >> 8 & 0x1f) + 0xe0;
      buffer[pos++] = PMP_PID & 0xff;
      buffer.writeInt32BE(crc32.checksum(buffer, pos - sectionLength + 1, pos), pos);
      pos += 4;

      if (pos < PACKET_SIZE) {
        buffer.fill(-1, pos, PACKET_SIZE);
        pos += PACKET_SIZE - pos;
      } // Write PMT packet


      buffer[pos++] = SYNC_BYTE;
      buffer[pos++] = (PMP_PID >> 8 & 0x1f) + 0x40;
      buffer[pos++] = PMP_PID & 0xff;
      buffer[pos++] = 0x10; // 0x1f

      buffer[pos++] = 0;
      sectionLength = 13;
      var nextPid = 0;

      if (this.fragment.hasAudio()) {
        sectionLength += 5;
        nextPid = AUDIO_PID;
      }

      if (this.fragment.hasVideo()) {
        sectionLength += 5;
        nextPid = VIDEO_PID;
      }

      buffer[pos++] = 2;
      buffer[pos++] = (sectionLength >> 8 & 0x0f) + 0xb0;
      buffer[pos++] = sectionLength & 0xff;
      buffer[pos++] = 0;
      buffer[pos++] = 1;
      buffer[pos++] = 0xc1;
      buffer[pos++] = 0;
      buffer[pos++] = 0;
      pos += PacketizerImpl._writePid(buffer, pos, nextPid); // Video data

      if (this.fragment.hasVideo()) {
        buffer[pos++] = STREAM_TYPES[this._videoCodecInfo.type()] || 0;
        pos += PacketizerImpl._writePid(buffer, pos, VIDEO_PID);
      } // Audio data


      if (this.fragment.hasAudio()) {
        buffer[pos++] = STREAM_TYPES[this._audioCodecInfo.type()] || 0;
        pos += PacketizerImpl._writePid(buffer, pos, AUDIO_PID);
      }

      buffer.writeInt32BE(crc32.checksum(buffer, pos - sectionLength + 1, pos), pos);
      pos += 4;

      if (pos < 2 * PACKET_SIZE) {
        buffer.fill(-1, pos);
      }

      return buffer;
    }
  }, {
    key: "_buildVideoConfig",
    value: function _buildVideoConfig() {
      var units = this._videoCodecInfo.units();

      var data = Buffer.allocUnsafe(4 * units.length + units.reduce(function (size, unit) {
        return size + unit.length;
      }, 0));
      var pos = 0;

      for (var i = 0, l = units.length; i < l; i++) {
        var unit = units[i];
        data.writeUInt32BE(1, pos);
        unit.copy(data, pos + 4);
        pos += unit.length + 4;
      }

      return data;
    }
  }], [{
    key: "_writeTime",
    value: function _writeTime(buffer, pos, time, base) {
      buffer[pos + 0] = time >> 29 & 0x0e | base & 0xf0 | 0x1;
      buffer[pos + 1] = time >> 22;
      buffer[pos + 2] = time >> 14 | 0x1;
      buffer[pos + 3] = time >> 7;
      buffer[pos + 4] = time << 1 | 0x1;
      return 5;
    }
  }, {
    key: "_writePid",
    value: function _writePid(buffer, pos, pid) {
      buffer[pos + 0] = (pid >> 8 & 0x1f) + 0xe0;
      buffer[pos + 1] = pid & 0xff;
      buffer[pos + 2] = 0xf0;
      buffer[pos + 3] = 0;
      return 4;
    }
  }]);

  return PacketizerImpl;
}();

module.exports = PacketizerImpl;
/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(2).Buffer))

/***/ }),
/* 72 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var CRC_TABLE = [0, 0xb71dc104, 0x6e3b8209, 0xd926430d, 0xdc760413, 0x6b6bc517, 0xb24d861a, 0x550471e, 0xb8ed0826, 0xff0c922, 0xd6d68a2f, 0x61cb4b2b, 0x649b0c35, 0xd386cd31, 0xaa08e3c, 0xbdbd4f38, 0x70db114c, 0xc7c6d048, 0x1ee09345, 0xa9fd5241, 0xacad155f, 0x1bb0d45b, 0xc2969756, 0x758b5652, 0xc836196a, 0x7f2bd86e, 0xa60d9b63, 0x11105a67, 0x14401d79, 0xa35ddc7d, 0x7a7b9f70, 0xcd665e74, 0xe0b62398, 0x57abe29c, 0x8e8da191, 0x39906095, 0x3cc0278b, 0x8bdde68f, 0x52fba582, 0xe5e66486, 0x585b2bbe, 0xef46eaba, 0x3660a9b7, 0x817d68b3, 0x842d2fad, 0x3330eea9, 0xea16ada4, 0x5d0b6ca0, 0x906d32d4, 0x2770f3d0, 0xfe56b0dd, 0x494b71d9, 0x4c1b36c7, 0xfb06f7c3, 0x2220b4ce, 0x953d75ca, 0x28803af2, 0x9f9dfbf6, 0x46bbb8fb, 0xf1a679ff, 0xf4f63ee1, 0x43ebffe5, 0x9acdbce8, 0x2dd07dec, 0x77708634, 0xc06d4730, 0x194b043d, 0xae56c539, 0xab068227, 0x1c1b4323, 0xc53d002e, 0x7220c12a, 0xcf9d8e12, 0x78804f16, 0xa1a60c1b, 0x16bbcd1f, 0x13eb8a01, 0xa4f64b05, 0x7dd00808, 0xcacdc90c, 0x7ab9778, 0xb0b6567c, 0x69901571, 0xde8dd475, 0xdbdd936b, 0x6cc0526f, 0xb5e61162, 0x2fbd066, 0xbf469f5e, 0x85b5e5a, 0xd17d1d57, 0x6660dc53, 0x63309b4d, 0xd42d5a49, 0xd0b1944, 0xba16d840, 0x97c6a5ac, 0x20db64a8, 0xf9fd27a5, 0x4ee0e6a1, 0x4bb0a1bf, 0xfcad60bb, 0x258b23b6, 0x9296e2b2, 0x2f2bad8a, 0x98366c8e, 0x41102f83, 0xf60dee87, 0xf35da999, 0x4440689d, 0x9d662b90, 0x2a7bea94, 0xe71db4e0, 0x500075e4, 0x892636e9, 0x3e3bf7ed, 0x3b6bb0f3, 0x8c7671f7, 0x555032fa, 0xe24df3fe, 0x5ff0bcc6, 0xe8ed7dc2, 0x31cb3ecf, 0x86d6ffcb, 0x8386b8d5, 0x349b79d1, 0xedbd3adc, 0x5aa0fbd8, 0xeee00c69, 0x59fdcd6d, 0x80db8e60, 0x37c64f64, 0x3296087a, 0x858bc97e, 0x5cad8a73, 0xebb04b77, 0x560d044f, 0xe110c54b, 0x38368646, 0x8f2b4742, 0x8a7b005c, 0x3d66c158, 0xe4408255, 0x535d4351, 0x9e3b1d25, 0x2926dc21, 0xf0009f2c, 0x471d5e28, 0x424d1936, 0xf550d832, 0x2c769b3f, 0x9b6b5a3b, 0x26d61503, 0x91cbd407, 0x48ed970a, 0xfff0560e, 0xfaa01110, 0x4dbdd014, 0x949b9319, 0x2386521d, 0xe562ff1, 0xb94beef5, 0x606dadf8, 0xd7706cfc, 0xd2202be2, 0x653deae6, 0xbc1ba9eb, 0xb0668ef, 0xb6bb27d7, 0x1a6e6d3, 0xd880a5de, 0x6f9d64da, 0x6acd23c4, 0xddd0e2c0, 0x4f6a1cd, 0xb3eb60c9, 0x7e8d3ebd, 0xc990ffb9, 0x10b6bcb4, 0xa7ab7db0, 0xa2fb3aae, 0x15e6fbaa, 0xccc0b8a7, 0x7bdd79a3, 0xc660369b, 0x717df79f, 0xa85bb492, 0x1f467596, 0x1a163288, 0xad0bf38c, 0x742db081, 0xc3307185, 0x99908a5d, 0x2e8d4b59, 0xf7ab0854, 0x40b6c950, 0x45e68e4e, 0xf2fb4f4a, 0x2bdd0c47, 0x9cc0cd43, 0x217d827b, 0x9660437f, 0x4f460072, 0xf85bc176, 0xfd0b8668, 0x4a16476c, 0x93300461, 0x242dc565, 0xe94b9b11, 0x5e565a15, 0x87701918, 0x306dd81c, 0x353d9f02, 0x82205e06, 0x5b061d0b, 0xec1bdc0f, 0x51a69337, 0xe6bb5233, 0x3f9d113e, 0x8880d03a, 0x8dd09724, 0x3acd5620, 0xe3eb152d, 0x54f6d429, 0x7926a9c5, 0xce3b68c1, 0x171d2bcc, 0xa000eac8, 0xa550add6, 0x124d6cd2, 0xcb6b2fdf, 0x7c76eedb, 0xc1cba1e3, 0x76d660e7, 0xaff023ea, 0x18ede2ee, 0x1dbda5f0, 0xaaa064f4, 0x738627f9, 0xc49be6fd, 0x9fdb889, 0xbee0798d, 0x67c63a80, 0xd0dbfb84, 0xd58bbc9a, 0x62967d9e, 0xbbb03e93, 0xcadff97, 0xb110b0af, 0x60d71ab, 0xdf2b32a6, 0x6836f3a2, 0x6d66b4bc, 0xda7b75b8, 0x35d36b5, 0xb440f7b1, 1];

function reverseBytes(value) {
  return value >>> 24 | value >> 8 & 0xFF00 | value << 8 & 0xFF0000 | value << 24;
}

function getChecksum(buf, start, end) {
  start = start || 0;
  end = end || buf.length;
  var checksumVal = -1,
      res;

  for (var i = start; i < end; i++) {
    res = (checksumVal ^ buf[i]) & 0xff;
    checksumVal = CRC_TABLE[res] ^ checksumVal >> 8 & 0xffffff;
  }

  return reverseBytes(checksumVal);
}

module.exports = {
  checksum: getChecksum
};

/***/ }),
/* 73 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var AudioSample = __webpack_require__(5);

var VideoSample = __webpack_require__(4);

var SampleCounter = /*#__PURE__*/function () {
  function SampleCounter() {
    _classCallCheck(this, SampleCounter);

    this._audioCounter = 0;
    this._videoCounter = 0;
  }

  _createClass(SampleCounter, [{
    key: "next",
    value: function next(sample) {
      var counter = 0;

      if (sample instanceof AudioSample) {
        counter = this._audioCounter;
        this._audioCounter = this._audioCounter + 1 & 0xf;
      } else if (sample instanceof VideoSample) {
        counter = this._videoCounter;
        this._videoCounter = this._videoCounter + 1 & 0xf;
      }

      return counter;
    }
  }]);

  return SampleCounter;
}();

module.exports = SampleCounter;

/***/ }),
/* 74 */,
/* 75 */
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


var public_base64ArrayBuffer = function base64ArrayBuffer(arrayBuffer) {
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

var public_Queue = /*#__PURE__*/function () {
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


// CONCATENATED MODULE: ./src/Sylvester.js
var Sylvester = {
  version: '0.1.3',
  precision: 1e-6
};

function Vector() {}

Vector.prototype = {
  e: function e(i) {
    return i < 1 || i > this.elements.length ? null : this.elements[i - 1];
  },
  dimensions: function dimensions() {
    return this.elements.length;
  },
  modulus: function modulus() {
    return Math.sqrt(this.dot(this));
  },
  eql: function eql(a) {
    var n = this.elements.length;
    var V = a.elements || a;

    if (n != V.length) {
      return false;
    }

    do {
      if (Math.abs(this.elements[n - 1] - V[n - 1]) > Sylvester.precision) {
        return false;
      }
    } while (--n);

    return true;
  },
  dup: function dup() {
    return Vector.create(this.elements);
  },
  map: function map(a) {
    var b = [];
    this.each(function (x, i) {
      b.push(a(x, i));
    });
    return Vector.create(b);
  },
  each: function each(a) {
    var n = this.elements.length,
        k = n,
        i;

    do {
      i = k - n;
      a(this.elements[i], i + 1);
    } while (--n);
  },
  toUnitVector: function toUnitVector() {
    var r = this.modulus();

    if (r === 0) {
      return this.dup();
    }

    return this.map(function (x) {
      return x / r;
    });
  },
  angleFrom: function angleFrom(a) {
    var V = a.elements || a;
    var n = this.elements.length,
        k = n,
        i;

    if (n != V.length) {
      return null;
    }

    var b = 0,
        mod1 = 0,
        mod2 = 0;
    this.each(function (x, i) {
      b += x * V[i - 1];
      mod1 += x * x;
      mod2 += V[i - 1] * V[i - 1];
    });
    mod1 = Math.sqrt(mod1);
    mod2 = Math.sqrt(mod2);

    if (mod1 * mod2 === 0) {
      return null;
    }

    var c = b / (mod1 * mod2);

    if (c < -1) {
      c = -1;
    }

    if (c > 1) {
      c = 1;
    }

    return Math.acos(c);
  },
  isParallelTo: function isParallelTo(a) {
    var b = this.angleFrom(a);
    return b === null ? null : b <= Sylvester.precision;
  },
  isAntiparallelTo: function isAntiparallelTo(a) {
    var b = this.angleFrom(a);
    return b === null ? null : Math.abs(b - Math.PI) <= Sylvester.precision;
  },
  isPerpendicularTo: function isPerpendicularTo(a) {
    var b = this.dot(a);
    return b === null ? null : Math.abs(b) <= Sylvester.precision;
  },
  add: function add(a) {
    var V = a.elements || a;

    if (this.elements.length != V.length) {
      return null;
    }

    return this.map(function (x, i) {
      return x + V[i - 1];
    });
  },
  subtract: function subtract(a) {
    var V = a.elements || a;

    if (this.elements.length != V.length) {
      return null;
    }

    return this.map(function (x, i) {
      return x - V[i - 1];
    });
  },
  multiply: function multiply(k) {
    return this.map(function (x) {
      return x * k;
    });
  },
  x: function x(k) {
    return this.multiply(k);
  },
  dot: function dot(a) {
    var V = a.elements || a;
    var i,
        product = 0,
        n = this.elements.length;

    if (n != V.length) {
      return null;
    }

    do {
      product += this.elements[n - 1] * V[n - 1];
    } while (--n);

    return product;
  },
  cross: function cross(a) {
    var B = a.elements || a;

    if (this.elements.length != 3 || B.length != 3) {
      return null;
    }

    var A = this.elements;
    return Vector.create([A[1] * B[2] - A[2] * B[1], A[2] * B[0] - A[0] * B[2], A[0] * B[1] - A[1] * B[0]]);
  },
  max: function max() {
    var m = 0,
        n = this.elements.length,
        k = n,
        i;

    do {
      i = k - n;

      if (Math.abs(this.elements[i]) > Math.abs(m)) {
        m = this.elements[i];
      }
    } while (--n);

    return m;
  },
  indexOf: function indexOf(x) {
    var a = null,
        n = this.elements.length,
        k = n,
        i;

    do {
      i = k - n;

      if (a === null && this.elements[i] == x) {
        a = i + 1;
      }
    } while (--n);

    return a;
  },
  toDiagonalMatrix: function toDiagonalMatrix() {
    return Matrix.Diagonal(this.elements);
  },
  round: function round() {
    return this.map(function (x) {
      return Math.round(x);
    });
  },
  snapTo: function snapTo(x) {
    return this.map(function (y) {
      return Math.abs(y - x) <= Sylvester.precision ? x : y;
    });
  },
  distanceFrom: function distanceFrom(a) {
    if (a.anchor) {
      return a.distanceFrom(this);
    }

    var V = a.elements || a;

    if (V.length != this.elements.length) {
      return null;
    }

    var b = 0,
        part;
    this.each(function (x, i) {
      part = x - V[i - 1];
      b += part * part;
    });
    return Math.sqrt(b);
  },
  liesOn: function liesOn(a) {
    return a.contains(this);
  },
  liesIn: function liesIn(a) {
    return a.contains(this);
  },
  rotate: function rotate(t, a) {
    var V, R, x, y, z;

    switch (this.elements.length) {
      case 2:
        V = a.elements || a;

        if (V.length != 2) {
          return null;
        }

        R = Matrix.Rotation(t).elements;
        x = this.elements[0] - V[0];
        y = this.elements[1] - V[1];
        return Vector.create([V[0] + R[0][0] * x + R[0][1] * y, V[1] + R[1][0] * x + R[1][1] * y]);
        break;

      case 3:
        if (!a.direction) {
          return null;
        }

        var C = a.pointClosestTo(this).elements;
        R = Matrix.Rotation(t, a.direction).elements;
        x = this.elements[0] - C[0];
        y = this.elements[1] - C[1];
        z = this.elements[2] - C[2];
        return Vector.create([C[0] + R[0][0] * x + R[0][1] * y + R[0][2] * z, C[1] + R[1][0] * x + R[1][1] * y + R[1][2] * z, C[2] + R[2][0] * x + R[2][1] * y + R[2][2] * z]);
        break;

      default:
        return null;
    }
  },
  reflectionIn: function reflectionIn(a) {
    if (a.anchor) {
      var P = this.elements.slice();
      var C = a.pointClosestTo(P).elements;
      return Vector.create([C[0] + (C[0] - P[0]), C[1] + (C[1] - P[1]), C[2] + (C[2] - (P[2] || 0))]);
    } else {
      var Q = a.elements || a;

      if (this.elements.length != Q.length) {
        return null;
      }

      return this.map(function (x, i) {
        return Q[i - 1] + (Q[i - 1] - x);
      });
    }
  },
  to3D: function to3D() {
    var V = this.dup();

    switch (V.elements.length) {
      case 3:
        break;

      case 2:
        V.elements.push(0);
        break;

      default:
        return null;
    }

    return V;
  },
  inspect: function inspect() {
    return '[' + this.elements.join(', ') + ']';
  },
  setElements: function setElements(a) {
    this.elements = (a.elements || a).slice();
    return this;
  }
};

Vector.create = function (a) {
  var V = new Vector();
  return V.setElements(a);
};

Vector.i = Vector.create([1, 0, 0]);
Vector.j = Vector.create([0, 1, 0]);
Vector.k = Vector.create([0, 0, 1]);

Vector.Random = function (n) {
  var a = [];

  do {
    a.push(Math.random());
  } while (--n);

  return Vector.create(a);
};

Vector.Zero = function (n) {
  var a = [];

  do {
    a.push(0);
  } while (--n);

  return Vector.create(a);
};

function Matrix() {}

Matrix.prototype = {
  e: function e(i, j) {
    if (i < 1 || i > this.elements.length || j < 1 || j > this.elements[0].length) {
      return null;
    }

    return this.elements[i - 1][j - 1];
  },
  row: function row(i) {
    if (i > this.elements.length) {
      return null;
    }

    return Vector.create(this.elements[i - 1]);
  },
  col: function col(j) {
    if (j > this.elements[0].length) {
      return null;
    }

    var a = [],
        n = this.elements.length,
        k = n,
        i;

    do {
      i = k - n;
      a.push(this.elements[i][j - 1]);
    } while (--n);

    return Vector.create(a);
  },
  dimensions: function dimensions() {
    return {
      rows: this.elements.length,
      cols: this.elements[0].length
    };
  },
  rows: function rows() {
    return this.elements.length;
  },
  cols: function cols() {
    return this.elements[0].length;
  },
  eql: function eql(a) {
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    if (this.elements.length != M.length || this.elements[0].length != M[0].length) {
      return false;
    }

    var b = this.elements.length,
        ki = b,
        i,
        nj,
        kj = this.elements[0].length,
        j;

    do {
      i = ki - b;
      nj = kj;

      do {
        j = kj - nj;

        if (Math.abs(this.elements[i][j] - M[i][j]) > Sylvester.precision) {
          return false;
        }
      } while (--nj);
    } while (--b);

    return true;
  },
  dup: function dup() {
    return Matrix.create(this.elements);
  },
  map: function map(a) {
    var b = [],
        ni = this.elements.length,
        ki = ni,
        i,
        nj,
        kj = this.elements[0].length,
        j;

    do {
      i = ki - ni;
      nj = kj;
      b[i] = [];

      do {
        j = kj - nj;
        b[i][j] = a(this.elements[i][j], i + 1, j + 1);
      } while (--nj);
    } while (--ni);

    return Matrix.create(b);
  },
  isSameSizeAs: function isSameSizeAs(a) {
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    return this.elements.length == M.length && this.elements[0].length == M[0].length;
  },
  add: function add(a) {
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    if (!this.isSameSizeAs(M)) {
      return null;
    }

    return this.map(function (x, i, j) {
      return x + M[i - 1][j - 1];
    });
  },
  subtract: function subtract(a) {
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    if (!this.isSameSizeAs(M)) {
      return null;
    }

    return this.map(function (x, i, j) {
      return x - M[i - 1][j - 1];
    });
  },
  canMultiplyFromLeft: function canMultiplyFromLeft(a) {
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    return this.elements[0].length == M.length;
  },
  multiply: function multiply(a) {
    if (!a.elements) {
      return this.map(function (x) {
        return x * a;
      });
    }

    var b = a.modulus ? true : false;
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    if (!this.canMultiplyFromLeft(M)) {
      return null;
    }

    var d = this.elements.length,
        ki = d,
        i,
        nj,
        kj = M[0].length,
        j;
    var e = this.elements[0].length,
        elements = [],
        sum,
        nc,
        c;

    do {
      i = ki - d;
      elements[i] = [];
      nj = kj;

      do {
        j = kj - nj;
        sum = 0;
        nc = e;

        do {
          c = e - nc;
          sum += this.elements[i][c] * M[c][j];
        } while (--nc);

        elements[i][j] = sum;
      } while (--nj);
    } while (--d);

    var M = Matrix.create(elements);
    return b ? M.col(1) : M;
  },
  x: function x(a) {
    return this.multiply(a);
  },
  minor: function minor(a, b, c, d) {
    var e = [],
        ni = c,
        i,
        nj,
        j;
    var f = this.elements.length,
        cols = this.elements[0].length;

    do {
      i = c - ni;
      e[i] = [];
      nj = d;

      do {
        j = d - nj;
        e[i][j] = this.elements[(a + i - 1) % f][(b + j - 1) % cols];
      } while (--nj);
    } while (--ni);

    return Matrix.create(e);
  },
  transpose: function transpose() {
    var a = this.elements.length,
        cols = this.elements[0].length;
    var b = [],
        ni = cols,
        i,
        nj,
        j;

    do {
      i = cols - ni;
      b[i] = [];
      nj = a;

      do {
        j = a - nj;
        b[i][j] = this.elements[j][i];
      } while (--nj);
    } while (--ni);

    return Matrix.create(b);
  },
  isSquare: function isSquare() {
    return this.elements.length == this.elements[0].length;
  },
  max: function max() {
    var m = 0,
        ni = this.elements.length,
        ki = ni,
        i,
        nj,
        kj = this.elements[0].length,
        j;

    do {
      i = ki - ni;
      nj = kj;

      do {
        j = kj - nj;

        if (Math.abs(this.elements[i][j]) > Math.abs(m)) {
          m = this.elements[i][j];
        }
      } while (--nj);
    } while (--ni);

    return m;
  },
  indexOf: function indexOf(x) {
    var a = null,
        ni = this.elements.length,
        ki = ni,
        i,
        nj,
        kj = this.elements[0].length,
        j;

    do {
      i = ki - ni;
      nj = kj;

      do {
        j = kj - nj;

        if (this.elements[i][j] == x) {
          return {
            i: i + 1,
            j: j + 1
          };
        }
      } while (--nj);
    } while (--ni);

    return null;
  },
  diagonal: function diagonal() {
    if (!this.isSquare) {
      return null;
    }

    var a = [],
        n = this.elements.length,
        k = n,
        i;

    do {
      i = k - n;
      a.push(this.elements[i][i]);
    } while (--n);

    return Vector.create(a);
  },
  toRightTriangular: function toRightTriangular() {
    var M = this.dup(),
        els;
    var n = this.elements.length,
        k = n,
        i,
        np,
        kp = this.elements[0].length,
        p;

    do {
      i = k - n;

      if (M.elements[i][i] == 0) {
        for (j = i + 1; j < k; j++) {
          if (M.elements[j][i] != 0) {
            els = [];
            np = kp;

            do {
              p = kp - np;
              els.push(M.elements[i][p] + M.elements[j][p]);
            } while (--np);

            M.elements[i] = els;
            break;
          }
        }
      }

      if (M.elements[i][i] != 0) {
        for (j = i + 1; j < k; j++) {
          var a = M.elements[j][i] / M.elements[i][i];
          els = [];
          np = kp;

          do {
            p = kp - np;
            els.push(p <= i ? 0 : M.elements[j][p] - M.elements[i][p] * a);
          } while (--np);

          M.elements[j] = els;
        }
      }
    } while (--n);

    return M;
  },
  toUpperTriangular: function toUpperTriangular() {
    return this.toRightTriangular();
  },
  determinant: function determinant() {
    if (!this.isSquare()) {
      return null;
    }

    var M = this.toRightTriangular();
    var a = M.elements[0][0],
        n = M.elements.length - 1,
        k = n,
        i;

    do {
      i = k - n + 1;
      a = a * M.elements[i][i];
    } while (--n);

    return a;
  },
  det: function det() {
    return this.determinant();
  },
  isSingular: function isSingular() {
    return this.isSquare() && this.determinant() === 0;
  },
  trace: function trace() {
    if (!this.isSquare()) {
      return null;
    }

    var a = this.elements[0][0],
        n = this.elements.length - 1,
        k = n,
        i;

    do {
      i = k - n + 1;
      a += this.elements[i][i];
    } while (--n);

    return a;
  },
  tr: function tr() {
    return this.trace();
  },
  rank: function rank() {
    var M = this.toRightTriangular(),
        rank = 0;
    var a = this.elements.length,
        ki = a,
        i,
        nj,
        kj = this.elements[0].length,
        j;

    do {
      i = ki - a;
      nj = kj;

      do {
        j = kj - nj;

        if (Math.abs(M.elements[i][j]) > Sylvester.precision) {
          rank++;
          break;
        }
      } while (--nj);
    } while (--a);

    return rank;
  },
  rk: function rk() {
    return this.rank();
  },
  augment: function augment(a) {
    var M = a.elements || a;

    if (typeof M[0][0] == 'undefined') {
      M = Matrix.create(M).elements;
    }

    var T = this.dup(),
        cols = T.elements[0].length;
    var b = T.elements.length,
        ki = b,
        i,
        nj,
        kj = M[0].length,
        j;

    if (b != M.length) {
      return null;
    }

    do {
      i = ki - b;
      nj = kj;

      do {
        j = kj - nj;
        T.elements[i][cols + j] = M[i][j];
      } while (--nj);
    } while (--b);

    return T;
  },
  inverse: function inverse() {
    if (!this.isSquare() || this.isSingular()) {
      return null;
    }

    var a = this.elements.length,
        ki = a,
        i,
        j;
    var M = this.augment(Matrix.I(a)).toRightTriangular();
    var b,
        kp = M.elements[0].length,
        p,
        els,
        divisor;
    var c = [],
        new_element;

    do {
      i = a - 1;
      els = [];
      b = kp;
      c[i] = [];
      divisor = M.elements[i][i];

      do {
        p = kp - b;
        new_element = M.elements[i][p] / divisor;
        els.push(new_element);

        if (p >= ki) {
          c[i].push(new_element);
        }
      } while (--b);

      M.elements[i] = els;

      for (j = 0; j < i; j++) {
        els = [];
        b = kp;

        do {
          p = kp - b;
          els.push(M.elements[j][p] - M.elements[i][p] * M.elements[j][i]);
        } while (--b);

        M.elements[j] = els;
      }
    } while (--a);

    return Matrix.create(c);
  },
  inv: function inv() {
    return this.inverse();
  },
  round: function round() {
    return this.map(function (x) {
      return Math.round(x);
    });
  },
  snapTo: function snapTo(x) {
    return this.map(function (p) {
      return Math.abs(p - x) <= Sylvester.precision ? x : p;
    });
  },
  inspect: function inspect() {
    var a = [];
    var n = this.elements.length,
        k = n,
        i;

    do {
      i = k - n;
      a.push(Vector.create(this.elements[i]).inspect());
    } while (--n);

    return a.join('\n');
  },
  setElements: function setElements(a) {
    var i,
        elements = a.elements || a;

    if (typeof elements[0][0] != 'undefined') {
      var b = elements.length,
          ki = b,
          nj,
          kj,
          j;
      this.elements = [];

      do {
        i = ki - b;
        nj = elements[i].length;
        kj = nj;
        this.elements[i] = [];

        do {
          j = kj - nj;
          this.elements[i][j] = elements[i][j];
        } while (--nj);
      } while (--b);

      return this;
    }

    var n = elements.length,
        k = n;
    this.elements = [];

    do {
      i = k - n;
      this.elements.push([elements[i]]);
    } while (--n);

    return this;
  }
};

Matrix.create = function (a) {
  var M = new Matrix();
  return M.setElements(a);
};

Matrix.I = function (n) {
  var a = [],
      k = n,
      i,
      nj,
      j;

  do {
    i = k - n;
    a[i] = [];
    nj = k;

    do {
      j = k - nj;
      a[i][j] = i == j ? 1 : 0;
    } while (--nj);
  } while (--n);

  return Matrix.create(a);
};

Matrix.Diagonal = function (a) {
  var n = a.length,
      k = n,
      i;
  var M = Matrix.I(n);

  do {
    i = k - n;
    M.elements[i][i] = a[i];
  } while (--n);

  return M;
};

Matrix.Rotation = function (b, a) {
  if (!a) {
    return Matrix.create([[Math.cos(b), -Math.sin(b)], [Math.sin(b), Math.cos(b)]]);
  }

  var d = a.dup();

  if (d.elements.length != 3) {
    return null;
  }

  var e = d.modulus();
  var x = d.elements[0] / e,
      y = d.elements[1] / e,
      z = d.elements[2] / e;
  var s = Math.sin(b),
      c = Math.cos(b),
      t = 1 - c;
  return Matrix.create([[t * x * x + c, t * x * y - s * z, t * x * z + s * y], [t * x * y + s * z, t * y * y + c, t * y * z - s * x], [t * x * z - s * y, t * y * z + s * x, t * z * z + c]]);
};

Matrix.RotationX = function (t) {
  var c = Math.cos(t),
      s = Math.sin(t);
  return Matrix.create([[1, 0, 0], [0, c, -s], [0, s, c]]);
};

Matrix.RotationY = function (t) {
  var c = Math.cos(t),
      s = Math.sin(t);
  return Matrix.create([[c, 0, s], [0, 1, 0], [-s, 0, c]]);
};

Matrix.RotationZ = function (t) {
  var c = Math.cos(t),
      s = Math.sin(t);
  return Matrix.create([[c, -s, 0], [s, c, 0], [0, 0, 1]]);
};

Matrix.Random = function (n, m) {
  return Matrix.Zero(n, m).map(function () {
    return Math.random();
  });
};

Matrix.Zero = function (n, m) {
  var a = [],
      ni = n,
      i,
      nj,
      j;

  do {
    i = n - ni;
    a[i] = [];
    nj = m;

    do {
      j = m - nj;
      a[i][j] = 0;
    } while (--nj);
  } while (--ni);

  return Matrix.create(a);
};

function Line() {}

Line.prototype = {
  eql: function eql(a) {
    return this.isParallelTo(a) && this.contains(a.anchor);
  },
  dup: function dup() {
    return Line.create(this.anchor, this.direction);
  },
  translate: function translate(a) {
    var V = a.elements || a;
    return Line.create([this.anchor.elements[0] + V[0], this.anchor.elements[1] + V[1], this.anchor.elements[2] + (V[2] || 0)], this.direction);
  },
  isParallelTo: function isParallelTo(a) {
    if (a.normal) {
      return a.isParallelTo(this);
    }

    var b = this.direction.angleFrom(a.direction);
    return Math.abs(b) <= Sylvester.precision || Math.abs(b - Math.PI) <= Sylvester.precision;
  },
  distanceFrom: function distanceFrom(a) {
    if (a.normal) {
      return a.distanceFrom(this);
    }

    if (a.direction) {
      if (this.isParallelTo(a)) {
        return this.distanceFrom(a.anchor);
      }

      var N = this.direction.cross(a.direction).toUnitVector().elements;
      var A = this.anchor.elements,
          B = a.anchor.elements;
      return Math.abs((A[0] - B[0]) * N[0] + (A[1] - B[1]) * N[1] + (A[2] - B[2]) * N[2]);
    } else {
      var P = a.elements || a;
      var A = this.anchor.elements,
          D = this.direction.elements;
      var b = P[0] - A[0],
          PA2 = P[1] - A[1],
          PA3 = (P[2] || 0) - A[2];
      var c = Math.sqrt(b * b + PA2 * PA2 + PA3 * PA3);
      if (c === 0) return 0;
      var d = (b * D[0] + PA2 * D[1] + PA3 * D[2]) / c;
      var e = 1 - d * d;
      return Math.abs(c * Math.sqrt(e < 0 ? 0 : e));
    }
  },
  contains: function contains(a) {
    var b = this.distanceFrom(a);
    return b !== null && b <= Sylvester.precision;
  },
  liesIn: function liesIn(a) {
    return a.contains(this);
  },
  intersects: function intersects(a) {
    if (a.normal) {
      return a.intersects(this);
    }

    return !this.isParallelTo(a) && this.distanceFrom(a) <= Sylvester.precision;
  },
  intersectionWith: function intersectionWith(a) {
    if (a.normal) {
      return a.intersectionWith(this);
    }

    if (!this.intersects(a)) {
      return null;
    }

    var P = this.anchor.elements,
        X = this.direction.elements,
        Q = a.anchor.elements,
        Y = a.direction.elements;
    var b = X[0],
        X2 = X[1],
        X3 = X[2],
        Y1 = Y[0],
        Y2 = Y[1],
        Y3 = Y[2];
    var c = P[0] - Q[0],
        PsubQ2 = P[1] - Q[1],
        PsubQ3 = P[2] - Q[2];
    var d = -b * c - X2 * PsubQ2 - X3 * PsubQ3;
    var e = Y1 * c + Y2 * PsubQ2 + Y3 * PsubQ3;
    var f = b * b + X2 * X2 + X3 * X3;
    var g = Y1 * Y1 + Y2 * Y2 + Y3 * Y3;
    var h = b * Y1 + X2 * Y2 + X3 * Y3;
    var k = (d * g / f + h * e) / (g - h * h);
    return Vector.create([P[0] + k * b, P[1] + k * X2, P[2] + k * X3]);
  },
  pointClosestTo: function pointClosestTo(a) {
    if (a.direction) {
      if (this.intersects(a)) {
        return this.intersectionWith(a);
      }

      if (this.isParallelTo(a)) {
        return null;
      }

      var D = this.direction.elements,
          E = a.direction.elements;
      var b = D[0],
          D2 = D[1],
          D3 = D[2],
          E1 = E[0],
          E2 = E[1],
          E3 = E[2];
      var x = D3 * E1 - b * E3,
          y = b * E2 - D2 * E1,
          z = D2 * E3 - D3 * E2;
      var N = Vector.create([x * E3 - y * E2, y * E1 - z * E3, z * E2 - x * E1]);
      var P = Plane.create(a.anchor, N);
      return P.intersectionWith(this);
    } else {
      var P = a.elements || a;

      if (this.contains(P)) {
        return Vector.create(P);
      }

      var A = this.anchor.elements,
          D = this.direction.elements;
      var b = D[0],
          D2 = D[1],
          D3 = D[2],
          A1 = A[0],
          A2 = A[1],
          A3 = A[2];
      var x = b * (P[1] - A2) - D2 * (P[0] - A1),
          y = D2 * ((P[2] || 0) - A3) - D3 * (P[1] - A2),
          z = D3 * (P[0] - A1) - b * ((P[2] || 0) - A3);
      var V = Vector.create([D2 * x - D3 * z, D3 * y - b * x, b * z - D2 * y]);
      var k = this.distanceFrom(P) / V.modulus();
      return Vector.create([P[0] + V.elements[0] * k, P[1] + V.elements[1] * k, (P[2] || 0) + V.elements[2] * k]);
    }
  },
  rotate: function rotate(t, a) {
    if (typeof a.direction == 'undefined') {
      a = Line.create(a.to3D(), Vector.k);
    }

    var R = Matrix.Rotation(t, a.direction).elements;
    var C = a.pointClosestTo(this.anchor).elements;
    var A = this.anchor.elements,
        D = this.direction.elements;
    var b = C[0],
        C2 = C[1],
        C3 = C[2],
        A1 = A[0],
        A2 = A[1],
        A3 = A[2];
    var x = A1 - b,
        y = A2 - C2,
        z = A3 - C3;
    return Line.create([b + R[0][0] * x + R[0][1] * y + R[0][2] * z, C2 + R[1][0] * x + R[1][1] * y + R[1][2] * z, C3 + R[2][0] * x + R[2][1] * y + R[2][2] * z], [R[0][0] * D[0] + R[0][1] * D[1] + R[0][2] * D[2], R[1][0] * D[0] + R[1][1] * D[1] + R[1][2] * D[2], R[2][0] * D[0] + R[2][1] * D[1] + R[2][2] * D[2]]);
  },
  reflectionIn: function reflectionIn(a) {
    if (a.normal) {
      var A = this.anchor.elements,
          D = this.direction.elements;
      var b = A[0],
          A2 = A[1],
          A3 = A[2],
          D1 = D[0],
          D2 = D[1],
          D3 = D[2];
      var c = this.anchor.reflectionIn(a).elements;
      var d = b + D1,
          AD2 = A2 + D2,
          AD3 = A3 + D3;
      var Q = a.pointClosestTo([d, AD2, AD3]).elements;
      var e = [Q[0] + (Q[0] - d) - c[0], Q[1] + (Q[1] - AD2) - c[1], Q[2] + (Q[2] - AD3) - c[2]];
      return Line.create(c, e);
    } else if (a.direction) {
      return this.rotate(Math.PI, a);
    } else {
      var P = a.elements || a;
      return Line.create(this.anchor.reflectionIn([P[0], P[1], P[2] || 0]), this.direction);
    }
  },
  setVectors: function setVectors(a, b) {
    a = Vector.create(a);
    b = Vector.create(b);

    if (a.elements.length == 2) {
      a.elements.push(0);
    }

    if (b.elements.length == 2) {
      b.elements.push(0);
    }

    if (a.elements.length > 3 || b.elements.length > 3) {
      return null;
    }

    var c = b.modulus();

    if (c === 0) {
      return null;
    }

    this.anchor = a;
    this.direction = Vector.create([b.elements[0] / c, b.elements[1] / c, b.elements[2] / c]);
    return this;
  }
};

Line.create = function (a, b) {
  var L = new Line();
  return L.setVectors(a, b);
};

Line.X = Line.create(Vector.Zero(3), Vector.i);
Line.Y = Line.create(Vector.Zero(3), Vector.j);
Line.Z = Line.create(Vector.Zero(3), Vector.k);

function Plane() {}

Plane.prototype = {
  eql: function eql(a) {
    return this.contains(a.anchor) && this.isParallelTo(a);
  },
  dup: function dup() {
    return Plane.create(this.anchor, this.normal);
  },
  translate: function translate(a) {
    var V = a.elements || a;
    return Plane.create([this.anchor.elements[0] + V[0], this.anchor.elements[1] + V[1], this.anchor.elements[2] + (V[2] || 0)], this.normal);
  },
  isParallelTo: function isParallelTo(a) {
    var b;

    if (a.normal) {
      b = this.normal.angleFrom(a.normal);
      return Math.abs(b) <= Sylvester.precision || Math.abs(Math.PI - b) <= Sylvester.precision;
    } else if (a.direction) {
      return this.normal.isPerpendicularTo(a.direction);
    }

    return null;
  },
  isPerpendicularTo: function isPerpendicularTo(a) {
    var b = this.normal.angleFrom(a.normal);
    return Math.abs(Math.PI / 2 - b) <= Sylvester.precision;
  },
  distanceFrom: function distanceFrom(a) {
    if (this.intersects(a) || this.contains(a)) {
      return 0;
    }

    if (a.anchor) {
      var A = this.anchor.elements,
          B = a.anchor.elements,
          N = this.normal.elements;
      return Math.abs((A[0] - B[0]) * N[0] + (A[1] - B[1]) * N[1] + (A[2] - B[2]) * N[2]);
    } else {
      var P = a.elements || a;
      var A = this.anchor.elements,
          N = this.normal.elements;
      return Math.abs((A[0] - P[0]) * N[0] + (A[1] - P[1]) * N[1] + (A[2] - (P[2] || 0)) * N[2]);
    }
  },
  contains: function contains(a) {
    if (a.normal) {
      return null;
    }

    if (a.direction) {
      return this.contains(a.anchor) && this.contains(a.anchor.add(a.direction));
    } else {
      var P = a.elements || a;
      var A = this.anchor.elements,
          N = this.normal.elements;
      var b = Math.abs(N[0] * (A[0] - P[0]) + N[1] * (A[1] - P[1]) + N[2] * (A[2] - (P[2] || 0)));
      return b <= Sylvester.precision;
    }
  },
  intersects: function intersects(a) {
    if (typeof a.direction == 'undefined' && typeof a.normal == 'undefined') {
      return null;
    }

    return !this.isParallelTo(a);
  },
  intersectionWith: function intersectionWith(a) {
    if (!this.intersects(a)) {
      return null;
    }

    if (a.direction) {
      var A = a.anchor.elements,
          D = a.direction.elements,
          P = this.anchor.elements,
          N = this.normal.elements;
      var b = (N[0] * (P[0] - A[0]) + N[1] * (P[1] - A[1]) + N[2] * (P[2] - A[2])) / (N[0] * D[0] + N[1] * D[1] + N[2] * D[2]);
      return Vector.create([A[0] + D[0] * b, A[1] + D[1] * b, A[2] + D[2] * b]);
    } else if (a.normal) {
      var c = this.normal.cross(a.normal).toUnitVector();
      var N = this.normal.elements,
          A = this.anchor.elements,
          O = a.normal.elements,
          B = a.anchor.elements;
      var d = Matrix.Zero(2, 2),
          i = 0;

      while (d.isSingular()) {
        i++;
        d = Matrix.create([[N[i % 3], N[(i + 1) % 3]], [O[i % 3], O[(i + 1) % 3]]]);
      }

      var e = d.inverse().elements;
      var x = N[0] * A[0] + N[1] * A[1] + N[2] * A[2];
      var y = O[0] * B[0] + O[1] * B[1] + O[2] * B[2];
      var f = [e[0][0] * x + e[0][1] * y, e[1][0] * x + e[1][1] * y];
      var g = [];

      for (var j = 1; j <= 3; j++) {
        g.push(i == j ? 0 : f[(j + (5 - i) % 3) % 3]);
      }

      return Line.create(g, c);
    }
  },
  pointClosestTo: function pointClosestTo(a) {
    var P = a.elements || a;
    var A = this.anchor.elements,
        N = this.normal.elements;
    var b = (A[0] - P[0]) * N[0] + (A[1] - P[1]) * N[1] + (A[2] - (P[2] || 0)) * N[2];
    return Vector.create([P[0] + N[0] * b, P[1] + N[1] * b, (P[2] || 0) + N[2] * b]);
  },
  rotate: function rotate(t, a) {
    var R = Matrix.Rotation(t, a.direction).elements;
    var C = a.pointClosestTo(this.anchor).elements;
    var A = this.anchor.elements,
        N = this.normal.elements;
    var b = C[0],
        C2 = C[1],
        C3 = C[2],
        A1 = A[0],
        A2 = A[1],
        A3 = A[2];
    var x = A1 - b,
        y = A2 - C2,
        z = A3 - C3;
    return Plane.create([b + R[0][0] * x + R[0][1] * y + R[0][2] * z, C2 + R[1][0] * x + R[1][1] * y + R[1][2] * z, C3 + R[2][0] * x + R[2][1] * y + R[2][2] * z], [R[0][0] * N[0] + R[0][1] * N[1] + R[0][2] * N[2], R[1][0] * N[0] + R[1][1] * N[1] + R[1][2] * N[2], R[2][0] * N[0] + R[2][1] * N[1] + R[2][2] * N[2]]);
  },
  reflectionIn: function reflectionIn(a) {
    if (a.normal) {
      var A = this.anchor.elements,
          N = this.normal.elements;
      var b = A[0],
          A2 = A[1],
          A3 = A[2],
          N1 = N[0],
          N2 = N[1],
          N3 = N[2];
      var c = this.anchor.reflectionIn(a).elements;
      var d = b + N1,
          AN2 = A2 + N2,
          AN3 = A3 + N3;
      var Q = a.pointClosestTo([d, AN2, AN3]).elements;
      var e = [Q[0] + (Q[0] - d) - c[0], Q[1] + (Q[1] - AN2) - c[1], Q[2] + (Q[2] - AN3) - c[2]];
      return Plane.create(c, e);
    } else if (a.direction) {
      return this.rotate(Math.PI, a);
    } else {
      var P = a.elements || a;
      return Plane.create(this.anchor.reflectionIn([P[0], P[1], P[2] || 0]), this.normal);
    }
  },
  setVectors: function setVectors(a, b, c) {
    a = Vector.create(a);
    a = a.to3D();

    if (a === null) {
      return null;
    }

    b = Vector.create(b);
    b = b.to3D();

    if (b === null) {
      return null;
    }

    if (typeof c == 'undefined') {
      c = null;
    } else {
      c = Vector.create(c);
      c = c.to3D();

      if (c === null) {
        return null;
      }
    }

    var d = a.elements[0],
        A2 = a.elements[1],
        A3 = a.elements[2];
    var e = b.elements[0],
        v12 = b.elements[1],
        v13 = b.elements[2];
    var f, mod;

    if (c !== null) {
      var g = c.elements[0],
          v22 = c.elements[1],
          v23 = c.elements[2];
      f = Vector.create([(v12 - A2) * (v23 - A3) - (v13 - A3) * (v22 - A2), (v13 - A3) * (g - d) - (e - d) * (v23 - A3), (e - d) * (v22 - A2) - (v12 - A2) * (g - d)]);
      mod = f.modulus();

      if (mod === 0) {
        return null;
      }

      f = Vector.create([f.elements[0] / mod, f.elements[1] / mod, f.elements[2] / mod]);
    } else {
      mod = Math.sqrt(e * e + v12 * v12 + v13 * v13);

      if (mod === 0) {
        return null;
      }

      f = Vector.create([b.elements[0] / mod, b.elements[1] / mod, b.elements[2] / mod]);
    }

    this.anchor = a;
    this.normal = f;
    return this;
  }
};

Matrix.Translation = function (v) {
  var r;

  if (v.elements.length === 2) {
    r = Matrix.I(3);
    r.elements[2][0] = v.elements[0];
    r.elements[2][1] = v.elements[1];
    return r;
  }

  if (v.elements.length === 3) {
    r = Matrix.I(4);
    r.elements[0][3] = v.elements[0];
    r.elements[1][3] = v.elements[1];
    r.elements[2][3] = v.elements[2];
    return r;
  }

  throw "Invalid length for Translation";
};

Matrix.prototype.flatten = function () {
  var result = [];
  if (this.elements.length === 0) return [];

  for (var j = 0; j < this.elements[0].length; j++) {
    for (var i = 0; i < this.elements.length; i++) {
      result.push(this.elements[i][j]);
    }
  }

  return result;
};

Matrix.prototype.ensure4x4 = function () {
  var i;
  if (this.elements.length === 4 && this.elements[0].length === 4) return this;
  if (this.elements.length > 4 || this.elements[0].length > 4) return null;

  for (i = 0; i < this.elements.length; i++) {
    for (var j = this.elements[i].length; j < 4; j++) {
      if (i === j) this.elements[i].push(1);else this.elements[i].push(0);
    }
  }

  for (i = this.elements.length; i < 4; i++) {
    if (i === 0) this.elements.push([1, 0, 0, 0]);else if (i === 1) this.elements.push([0, 1, 0, 0]);else if (i === 2) this.elements.push([0, 0, 1, 0]);else if (i === 3) this.elements.push([0, 0, 0, 1]);
  }

  return this;
};

Matrix.prototype.make3x3 = function () {
  if (this.elements.length !== 4 || this.elements[0].length !== 4) return null;
  return Matrix.create([[this.elements[0][0], this.elements[0][1], this.elements[0][2]], [this.elements[1][0], this.elements[1][1], this.elements[1][2]], [this.elements[2][0], this.elements[2][1], this.elements[2][2]]]);
};

Plane.create = function (a, b, c) {
  var P = new Plane();
  return P.setVectors(a, b, c);
};

Plane.XY = Plane.create(Vector.Zero(3), Vector.k);
Plane.YZ = Plane.create(Vector.Zero(3), Vector.i);
Plane.ZX = Plane.create(Vector.Zero(3), Vector.j);
Plane.YX = Plane.XY;
Plane.ZY = Plane.YZ;
Plane.XZ = Plane.ZX;
var $V = Vector.create;
var $M = Matrix.create;
var $L = Line.create;
var $P = Plane.create;

// CONCATENATED MODULE: ./src/WebGLCanvas.js
/*
    webGL库，用户在canvas上绘制视频
 */



var ImageTexture = function () {
  function Constructor(gl, size, format) {
    Texture.call(this, gl, size, format);
  }

  Constructor.prototype = inherit(Texture, {
    fill: function fill(textureData, useTexSubImage2D) {
      var gl = this.gl;
      gl.bindTexture(gl.TEXTURE_2D, this.texture);

      if (useTexSubImage2D) {
        gl.texSubImage2D(gl.TEXTURE_2D, 0, 0, 0, this.size.w, this.size.h, this.format, gl.UNSIGNED_BYTE, textureData);
      } else {
        gl.texImage2D(gl.TEXTURE_2D, 0, this.format, this.format, gl.UNSIGNED_BYTE, textureData);
      }
    }
  });
  return Constructor;
}();

var WebGLCanvas = function () {
  var vertexShaderScript = Script.createFromSource("x-shader/x-vertex", WebGLCanvas_text(["attribute vec3 aVertexPosition;", "attribute vec2 aTextureCoord;", "uniform mat4 uMVMatrix;", "uniform mat4 uPMatrix;", "varying highp vec2 vTextureCoord;", "void main(void) {", "  gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);", "  vTextureCoord = aTextureCoord;", "}"]));
  var fragmentShaderScript = Script.createFromSource("x-shader/x-fragment", WebGLCanvas_text(["precision highp float;", "varying highp vec2 vTextureCoord;", "uniform sampler2D texture;", "void main(void) {", "  gl_FragColor = texture2D(texture, vTextureCoord);", "}"]));
  var specialWidth = [192, 368, 608, 1088, 1472, 1952, 3008];

  function Constructor(canvas, size, useFrameBuffer) {
    this.canvas = canvas;
    this.size = size;
    var isDevideBy16 = true;

    for (var i in specialWidth) {
      if (size.w === specialWidth[i]) {
        isDevideBy16 = false;
      }
    }

    if (!isDevideBy16) {
      if (size.w === 192) {
        this.canvas.width = size.w - 12;
      } else {
        this.canvas.width = size.w - 8;
      }
    } else {
      this.canvas.width = size.w;
    }

    this.canvas.height = size.h;
    this.onInitWebGL();
    this.onInitShaders();
    initBuffers.call(this);

    if (useFrameBuffer) {
      initFramebuffer.call(this);
    }

    this.onInitTextures();
    initScene.call(this);
  }

  function initFramebuffer() {
    var gl = this.gl;
    this.framebuffer = gl.createFramebuffer();
    gl.bindFramebuffer(gl.FRAMEBUFFER, this.framebuffer);
    this.framebufferTexture = new Texture(this.gl, this.size, gl.RGBA);
    var renderbuffer = gl.createRenderbuffer();
    gl.bindRenderbuffer(gl.RENDERBUFFER, renderbuffer);
    gl.renderbufferStorage(gl.RENDERBUFFER, gl.DEPTH_COMPONENT16, this.size.w, this.size.h);
    gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, gl.TEXTURE_2D, this.framebufferTexture.texture, 0);
    gl.framebufferRenderbuffer(gl.FRAMEBUFFER, gl.DEPTH_ATTACHMENT, gl.RENDERBUFFER, renderbuffer);
  }

  function initBuffers() {
    var tmp = [1, 1, 0, -1, 1, 0, 1, -1, 0, -1, -1, 0];
    var gl = this.gl;
    this.quadVPBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, this.quadVPBuffer);
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(tmp), gl.STATIC_DRAW);
    this.quadVPBuffer.itemSize = 3;
    this.quadVPBuffer.numItems = 4;
    var scaleX = 1;
    var scaleY = 1;
    this.quadVTCBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, this.quadVTCBuffer);
    tmp = [scaleX, 0, 0, 0, scaleX, scaleY, 0, scaleY];
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(tmp), gl.STATIC_DRAW);
  }

  function mvIdentity() {
    this.mvMatrix = Matrix.I(4);
  }

  function mvMultiply(matrix) {
    this.mvMatrix = this.mvMatrix.x(matrix);
  }

  function mvTranslate(matrix) {
    mvMultiply.call(this, Matrix.Translation($V([matrix[0], matrix[1], matrix[2]])).ensure4x4());
  }

  function setMatrixUniforms() {
    this.program.setMatrixUniform("uPMatrix", new Float32Array(this.perspectiveMatrix.flatten()));
    this.program.setMatrixUniform("uMVMatrix", new Float32Array(this.mvMatrix.flatten()));
  }

  function initScene() {
    var gl = this.gl;
    this.perspectiveMatrix = makePerspective(45, 1, .1, 100);
    mvIdentity.call(this);
    mvTranslate.call(this, [0, 0, -2.415]);
    gl.bindBuffer(gl.ARRAY_BUFFER, this.quadVPBuffer);
    gl.vertexAttribPointer(this.vertexPositionAttribute, 3, gl.FLOAT, false, 0, 0);
    gl.bindBuffer(gl.ARRAY_BUFFER, this.quadVTCBuffer);
    gl.vertexAttribPointer(this.textureCoordAttribute, 2, gl.FLOAT, false, 0, 0);
    this.onInitSceneTextures();
    setMatrixUniforms.call(this);

    if (this.framebuffer) {
      gl.bindFramebuffer(gl.FRAMEBUFFER, this.framebuffer);
    }
  }

  Constructor.prototype = {
    toString: function toString() {
      return "WebGLCanvas Size: " + this.size;
    },
    checkLastError: function checkLastError(operation) {
      var err = this.gl.getError();

      if (err !== this.gl.NO_ERROR) {
        var name = this.glNames[err];
        name = typeof name !== "undefined" ? name + "(" + err + ")" : "Unknown WebGL ENUM (0x" + value.toString(16) + ")";

        if (operation) {
          debug.log("WebGL Error: %s, %s", operation, name);
        } else {
          debug.log("WebGL Error: %s", name);
        }

        debug.trace();
      }
    },
    onInitWebGL: function onInitWebGL() {
      try {
        this.gl = this.canvas.getContext("experimental-webgl");
      } catch (error) {
        debug.log("inInitWebGL error = " + error);
      }

      if (!this.gl) {
        debug.error("Unable to initialize WebGL. Your browser may not support it.");
      }

      if (this.glNames) {
        return;
      }

      this.glNames = {};

      for (var propertyName in this.gl) {
        if (typeof this.gl[propertyName] === "number") {
          this.glNames[this.gl[propertyName]] = propertyName;
        }
      }
    },
    onInitShaders: function onInitShaders() {
      this.program = new Program(this.gl);
      this.program.attach(new Shader(this.gl, vertexShaderScript));
      this.program.attach(new Shader(this.gl, fragmentShaderScript));
      this.program.link();
      this.program.use();
      this.vertexPositionAttribute = this.program.getAttributeLocation("aVertexPosition");
      this.gl.enableVertexAttribArray(this.vertexPositionAttribute);
      this.textureCoordAttribute = this.program.getAttributeLocation("aTextureCoord");
      this.gl.enableVertexAttribArray(this.textureCoordAttribute);
    },
    onInitTextures: function onInitTextures() {
      var gl = this.gl;
      gl.viewport(0, 0, this.canvas.width, this.canvas.height);
      this.texture = new Texture(gl, this.size, gl.RGBA);
    },
    onInitSceneTextures: function onInitSceneTextures() {
      this.texture.bind(0, this.program, "texture");
    },
    drawScene: function drawScene() {
      this.gl.drawArrays(this.gl.TRIANGLE_STRIP, 0, 4);
    },
    updateVertexArray: function updateVertexArray(vertexArray) {
      this.zoomScene(vertexArray);
    },
    readPixels: function readPixels(buffer) {
      var gl = this.gl;
      gl.readPixels(0, 0, this.size.w, this.size.h, gl.RGBA, gl.UNSIGNED_BYTE, buffer);
    },
    zoomScene: function zoomScene(data) {
      mvIdentity.call(this);
      mvTranslate.call(this, [data[0], data[1], data[2]]);
      setMatrixUniforms.call(this);
      this.drawScene();
    },
    setViewport: function setViewport(toWidth, toHeight) {
      debug.log("toWidth=" + toWidth + ",toHeight=" + toHeight);
      var w, h;

      if (this.gl.drawingBufferWidth < toWidth || this.gl.drawingBufferHeight < toHeight) {
        w = this.gl.drawingBufferWidth;
        h = this.gl.drawingBufferHeight;
        this.canvas.width = w;
        this.canvas.height = h;
      } else {
        w = toWidth;
        h = toHeight;
      }

      this.gl.viewport(0, 0, w, h);
    },
    clearCanvas: function clearCanvas() {
      this.gl.clearColor(0, 0, 0, 1);
      this.gl.clear(this.gl.DEPTH_BUFFER_BIT | this.gl.COLOR_BUFFER_BIT);
    }
  };
  return Constructor;
}();

var ImageWebGLCanvas = function () {
  function Constructor(canvas, size) {
    WebGLCanvas.call(this, canvas, size);
  }

  Constructor.prototype = inherit(WebGLCanvas, {
    drawCanvas: function drawCanvas(objImage) {
      this.texture.fill(objImage);
      this.drawScene();
    },
    onInitTextures: function onInitTextures() {
      var gl = this.gl;
      this.setViewport(this.canvas.width, this.canvas.height);
      this.texture = new ImageTexture(gl, this.size, gl.RGBA);
    },
    initCanvas: function initCanvas() {
      this.gl.clear(this.gl.DEPTH_BUFFER_BIT | this.gl.COLOR_BUFFER_BIT);
    }
  });
  return Constructor;
}();

var YUVWebGLCanvas = function () {
  var vertexShaderScript = Script.createFromSource("x-shader/x-vertex", WebGLCanvas_text(["attribute vec3 aVertexPosition;", "attribute vec2 aTextureCoord;", "uniform mat4 uMVMatrix;", "uniform mat4 uPMatrix;", "varying highp vec2 vTextureCoord;", "void main(void) {", "  gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);", "  vTextureCoord = aTextureCoord;", "}"]));
  var fragmentShaderScript = Script.createFromSource("x-shader/x-fragment", WebGLCanvas_text(["precision highp float;", "varying highp vec2 vTextureCoord;", "uniform sampler2D YTexture;", "uniform sampler2D UTexture;", "uniform sampler2D VTexture;", "const mat4 YUV2RGB = mat4", "(", " 1.16438, 0.00000, 1.59603, -.87079,", " 1.16438, -.39176, -.81297, .52959,", " 1.16438, 2.01723, 0, -1.08139,", " 0, 0, 0, 1", ");", "void main(void) {", " gl_FragColor = vec4( texture2D(YTexture,  vTextureCoord).x, texture2D(UTexture, vTextureCoord).x, texture2D(VTexture, vTextureCoord).x, 1) * YUV2RGB;", "}"]));

  function Constructor(canvas, size) {
    WebGLCanvas.call(this, canvas, size);
  }

  Constructor.prototype = inherit(WebGLCanvas, {
    onInitShaders: function onInitShaders() {
      this.program = new Program(this.gl);
      this.program.attach(new Shader(this.gl, vertexShaderScript));
      this.program.attach(new Shader(this.gl, fragmentShaderScript));
      this.program.link();
      this.program.use();
      this.vertexPositionAttribute = this.program.getAttributeLocation("aVertexPosition");
      this.gl.enableVertexAttribArray(this.vertexPositionAttribute);
      this.textureCoordAttribute = this.program.getAttributeLocation("aTextureCoord");
      this.gl.enableVertexAttribArray(this.textureCoordAttribute);
    },
    onInitTextures: function onInitTextures() {
      this.setViewport(this.size.w, this.size.h);
      this.YTexture = new Texture(this.gl, this.size);
      this.UTexture = new Texture(this.gl, this.size.getHalfSize());
      this.VTexture = new Texture(this.gl, this.size.getHalfSize());
    },
    onInitSceneTextures: function onInitSceneTextures() {
      this.YTexture.bind(0, this.program, "YTexture");
      this.UTexture.bind(1, this.program, "UTexture");
      this.VTexture.bind(2, this.program, "VTexture");
    },
    fillYUVTextures: function fillYUVTextures(yT, uT, vT) {
      this.YTexture.fill(yT);
      this.UTexture.fill(uT);
      this.VTexture.fill(vT);
      this.drawScene();
    },
    drawCanvas: function drawCanvas(bufferData, option) {
      var ybuffer = new Uint8Array(bufferData.buffer, bufferData.byteOffset, option.ylen * option.height);
      var ubuffer = new Uint8Array(bufferData.buffer, bufferData.byteOffset + option.ylen * option.height, option.ylen * option.height / 4);
      var vbuffer = new Uint8Array(bufferData.buffer, bufferData.byteOffset + option.ylen * option.height * 1.25, option.ylen * option.height / 4);
      this.YTexture.fill(ybuffer);
      this.UTexture.fill(ubuffer);
      this.VTexture.fill(vbuffer);
      this.drawScene();
    },
    updateVertexArray: function updateVertexArray(vertexArray) {
      this.zoomScene(vertexArray);
    },
    toString: function toString() {
      return "YUVCanvas Size: " + this.size;
    },
    initCanvas: function initCanvas() {
      this.gl.clear(this.gl.DEPTH_BUFFER_BIT | this.gl.COLOR_BUFFER_BIT);
    }
  });
  return Constructor;
}();

function inherit(base, properties) {
  var prot = Object.create(base.prototype);
  var keyList = Object.keys(properties);

  for (var i = 0; i < keyList.length; i++) {
    prot[keyList[i]] = properties[keyList[i]];
  }

  return prot;
}

function WebGLCanvas_text(lines) {
  return lines.join("\n");
} ///创建透视投影矩阵
///fovy: 视场角
///aspect: 裁截面宽高比
///znear: 眼睛到近裁截面距离
///zfar: 眼睛到 远裁截面距离


function makePerspective(fovy, aspect, znear, zfar) {
  var ymax = znear * Math.tan(fovy * Math.PI / 360);
  var ymin = -ymax;
  var xmin = ymin * aspect;
  var xmax = ymax * aspect;
  return makeFrustum(xmin, xmax, ymin, ymax, znear, zfar);
}

function makeFrustum(left, right, bottom, top, znear, zfar) {
  var X = 2 * znear / (right - left);
  var Y = 2 * znear / (top - bottom);
  var A = (right + left) / (right - left);
  var B = (top + bottom) / (top - bottom);
  var C = -(zfar + znear) / (zfar - znear);
  var D = -2 * zfar * znear / (zfar - znear);
  return $M([[X, 0, A, 0], [0, Y, B, 0], [0, 0, C, D], [0, 0, -1, 0]]);
}


// CONCATENATED MODULE: ./src/streamDrawer.js
/*
    YUV数据的缓存，canvas播放视频
    frame duration的控制
 */



function BufferNode(buffer) {
  this.buffer = buffer; //new Uint8Array(buffer.length);
  //    this.buffer.set(buffer, 0);

  this.previous = null;
  this.next = null;
}

function StreamDrawer(id, workerM, _canvas, _maxLength) {
  var workerManager = workerM;
  var bufferQueueMaxLength = _maxLength;
  var Uniformity = true;
  var channelId = id;
  var canvas = _canvas;
  var drawer = null;
  var preWidth = null;
  var preHeight = null;
  var drawingStrategy = null;
  var frameInterval = null;
  var prevCodecType = null;
  var resizeCallback = null;
  var beginDrawCallback = null;
  var updateCanvasCallback = null;
  var startTimestamp = 0;
  var frameTimestamp = null;
  var preFrameTimeStamp = 0; // 上一帧时间戳

  var preTimestamp = 0;
  var progressTime = 0;
  var curTime = 0;
  var imagePool = new ImagePool();
  var bufferNode = null;
  var fileName = "";
  var captureFlag = false;
  var isRendering = false;
  var defaultInterval = 16.7;
  var defaultMaxDelay = 20;
  var milisecond = 1e3;
  var maxDelay = null;
  var realFrameInterval = 0;
  var rtspOver = false; //判断RTSP信令结束

  var seekCheckTime = 3; //用于判断是否拖动进度条

  var curFrameInfo = {}; // 当前帧的信息

  var OtherCanvas = []; //需要额外抓图的canvas对象

  var captureTypeFormat = "png"; //图片格式

  var captureQuality = 1.0; //图片质量

  var VideoBufferNode = function () {
    function Constructor(data, width, height, codecType, frameType, timeStamp, frameIndex, option) {
      BufferNode.call(this, data);
      this.width = width;
      this.height = height;
      this.codecType = codecType;
      this.frameType = frameType;
      this.timeStamp = timeStamp;
      this.frameIndex = frameIndex; // 帧序号

      this.option = {};

      for (var item in option) {
        this.option[item] = option[item];
      }
    }

    return Constructor;
  }();

  var videoBufferQueue = null;

  function VideoBufferQueue() {
    var MAX_LENGTH = bufferQueueMaxLength || 15;

    function Constructor() {
      //BufferQueue.call(this)
      this.first = null;
      this.size = 0;
    }

    Constructor.prototype = {
      enqueue: function enqueue(data, width, height, codecType, frameType, timeStamp, frameIndex, option) {
        //debug.log('frameType:  ' + frameType)
        this.size >= MAX_LENGTH ? this.clear() : 0;
        var node = new VideoBufferNode(data, width, height, codecType, frameType, timeStamp, frameIndex, option);

        if (this.first === null) {
          this.first = node;
        } else {
          var tempNode = this.first;

          while (tempNode.next !== null) {
            tempNode = tempNode.next;
          }

          tempNode.next = node;
        }

        this.size += 1; //debug.log('VideoBufferQueue.length:  ' + this.size);

        return node;
      },
      dequeue: function dequeue() {
        var temp = null;

        if (this.first !== null) {
          temp = this.first;
          this.first = this.first.next;
          this.size -= 1;
        }

        return temp;
      },
      clear: function clear() {
        debug.log('BufferQueue clear!');
        var temp = null;

        while (this.first !== null) {
          temp = this.first;
          this.first = this.first.next;
          this.size -= 1;
          temp.buffer = null;
          temp = null;
        }

        this.size = 0;
        this.first = null;
      }
    };
    return new Constructor();
  }

  function Constructor() {
    drawingStrategy = "rgb2d";
    prevCodecType = null;
    videoBufferQueue = new VideoBufferQueue();
    frameInterval = defaultInterval;
    isRendering = false;
  }

  var resize = function resize(width, height) {
    var size = new Size(width, height);

    switch (drawingStrategy) {
      case "RGB2d":
        drawer = new RGB2dCanvas(canvas, size);
        break;

      case "YUVWebGL":
        drawer = new YUVWebGLCanvas(canvas, size);
        break;

      case "ImageWebGL":
        drawer = new ImageWebGLCanvas(canvas, size);
        break;

      case "WebGL":
        drawer = new WebGLCanvas(canvas, size);
        break;

      default:
        break;
    }
  };

  function doCapture(canvasArr, filename) {
    console.log('触发doCapture');
    var width = canvas.width;
    var height = canvas.height;
    var cvs = document.createElement('canvas');
    cvs.width = width;
    cvs.height = height;
    var ctx = cvs.getContext('2d');

    for (var _i = 0; _i < canvasArr.length; _i++) {
      //把canvas数组的全部绘制到同一张canvas
      ctx.drawImage(canvasArr[_i], 0, 0, width, height);
    }

    var data = cvs.toDataURL();
    var dataAtob = atob(data.substring("data:image/png;base64,".length));
    var asArray = new Uint8Array(dataAtob.length);

    for (var i = 0, len = dataAtob.length; i < len; ++i) {
      asArray[i] = dataAtob.charCodeAt(i);
    }

    console.log(asArray);
    var blob = new Blob([asArray.buffer], {
      type: "image/png"
    });
    saveAs(blob, filename + ".png");
  }

  var saveAs = function (view) {
    var doc = view.document;

    var get_URL = function get_URL() {
      return view.URL || view.webkitURL || view;
    };

    var save_link = doc.createElementNS("http://www.w3.org/1999/xhtml", "a");
    var can_use_save_link = ("download" in save_link);

    var click = function click(node) {
      var event = new MouseEvent("click");
      node.dispatchEvent(event);
    };

    var is_safari = /constructor/i.test(view.HTMLElement);
    var is_chrome_ios = /CriOS\/[\d]+/.test(navigator.userAgent);

    var throw_outside = function throw_outside(ex) {
      (view.setImmediate || view.setTimeout)(function () {
        throw ex;
      }, 0);
    };

    var force_saveable_type = "application/octet-stream",
        arbitrary_revoke_timeout = 1e3 * 40,
        revoke = function revoke(file) {
      console.log('revoke');

      var revoker = function revoker() {
        if (typeof file === "string") {
          get_URL().revokeObjectURL(file);
        } else {
          file.remove();
        }
      };

      setTimeout(revoker, arbitrary_revoke_timeout);
    };

    var dispatch = function dispatch(filesaver, event_types, event) {
      console.log('dispatch');
      event_types = [].concat(event_types);
      var i = event_types.length;

      while (i--) {
        var listener = filesaver["on" + event_types[i]];

        if (typeof listener === "function") {
          try {
            listener.call(filesaver, event || filesaver);
          } catch (ex) {
            throw_outside(ex);
          }
        }
      }
    };

    var auto_bom = function auto_bom(blob) {
      console.log('auto_bom');

      if (/^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(blob.type)) {
        return new Blob([String.fromCharCode(65279), blob], {
          type: blob.type
        });
      }

      return blob;
    };

    var FileSaver = function FileSaver(blob, name, no_auto_bom) {
      console.log('FileSaver');

      if (!no_auto_bom) {
        blob = auto_bom(blob);
      }

      var filesaver = this,
          type = blob.type,
          force = type === force_saveable_type,
          object_url,
          dispatch_all = function dispatch_all() {
        dispatch(filesaver, "writestart progress write writeend".split(" "));
      },
          fs_error = function fs_error() {
        if ((is_chrome_ios || force && is_safari) && view.FileReader) {
          var reader = new FileReader();

          reader.onloadend = function () {
            var url = is_chrome_ios ? reader.result : reader.result.replace(/^data:[^;]*;/, "data:attachment/file;");
            var popup = view.open(url, "_blank");
            if (!popup) view.location.href = url;
            url = undefined;
            filesaver.readyState = filesaver.DONE;
            dispatch_all();
          };

          reader.readAsDataURL(blob);
          filesaver.readyState = filesaver.INIT;
          return;
        }

        if (!object_url) {
          object_url = get_URL().createObjectURL(blob);
        }

        if (force) {
          view.location.href = object_url;
        } else {
          var opened = view.open(object_url, "_blank");

          if (!opened) {
            view.location.href = object_url;
          }
        }

        filesaver.readyState = filesaver.DONE;
        dispatch_all();
        revoke(object_url);
      };

      filesaver.readyState = filesaver.INIT;

      if (can_use_save_link) {
        console.log('can_use_save_link');
        object_url = get_URL().createObjectURL(blob);
        setTimeout(function () {
          save_link.href = object_url;
          save_link.download = name;
          click(save_link);
          dispatch_all();
          revoke(object_url);
          filesaver.readyState = filesaver.DONE;
        });
        return;
      }

      fs_error();
    };

    var FS_proto = FileSaver.prototype;

    var saveAs = function saveAs(blob, name, no_auto_bom) {
      console.log('saveAs');
      return new FileSaver(blob, name || blob.name || "download", no_auto_bom);
    };

    if (typeof navigator !== "undefined" && navigator.msSaveOrOpenBlob) {
      return function (blob, name, no_auto_bom) {
        name = name || blob.name || "download";

        if (!no_auto_bom) {
          blob = auto_bom(blob);
        }

        return navigator.msSaveOrOpenBlob(blob, name);
      };
    }

    FS_proto.readyState = FS_proto.INIT = 0;
    FS_proto.WRITING = 1;
    FS_proto.DONE = 2;
    FS_proto.error = FS_proto.onwritestart = FS_proto.onprogress = FS_proto.onwrite = FS_proto.onabort = FS_proto.onerror = FS_proto.onwriteend = null;
    return saveAs;
  }(window);

  var drawFrame = function drawFrame(stepValue) {
    if (videoBufferQueue.size == 0 && rtspOver === true) {
      //帧绘完了，且RTSP已经结束
      workerManager.fileOverCallback();
      Constructor.prototype.stopRendering();
      return;
    }

    bufferNode = videoBufferQueue.dequeue(); //debug.log('bufferNode��' + bufferNode)

    if (bufferNode !== null && bufferNode.buffer !== null && (bufferNode.codecType === "mjpeg" || bufferNode.buffer.length > 0)) {
      if (typeof preWidth === "undefined" || typeof preHeight === "undefined" || preWidth !== bufferNode.width || preHeight !== bufferNode.height || prevCodecType !== bufferNode.codecType) {
        drawingStrategy = bufferNode.codecType === "h264" || bufferNode.codecType === "h265" ? "YUVWebGL" : "ImageWebGL";
        resize(bufferNode.width, bufferNode.height);

        if (preWidth == 'undefined' || preWidth == null || preWidth == 0) {
          beginDrawCallback('PlayStart');
        } else if (typeof resizeCallback !== "undefined" && resizeCallback !== null) {//resizeCallback({width: bufferNode.width, height: bufferNode.height});
        }

        preWidth = bufferNode.width;
        preHeight = bufferNode.height;
        prevCodecType = bufferNode.codecType;
      }

      frameTimestamp = bufferNode.timeStamp;
      workerManager.timeStamp(frameTimestamp);

      if (typeof drawer !== "undefined") {
        drawer.drawCanvas(bufferNode.buffer, bufferNode.option);
        canvas.updatedCanvas = true;
        updateCanvasCallback(frameTimestamp);

        if (Math.abs(frameTimestamp.timestamp - preFrameTimeStamp) > seekCheckTime) {
          //开始绘制拖动进度条后的帧
          workerManager.waitingCallback(false);
        } // 处理播放过程中获取不到图片的base64图片的问题，只有在暂停的时候才保存
        // 暂停时drawFrame不执行，不会走到这个判断逻辑中，为了getCapture抓图获取到当前帧图片数据，此处放开if判断逻辑


        if (!isRendering) {
          //回退至11103535版本，1122852版本增加的该行代码有问题，会导致播放卡顿，浏览器包警告信息-[Violation] 'requestAnimationFrame' handler took [n]s
          curFrameInfo = bufferNode;
          curFrameInfo.src = canvas.toDataURL("image/" + captureTypeFormat, captureQuality);
        }

        preFrameTimeStamp = frameTimestamp.timestamp;

        if (captureFlag) {
          captureFlag = false;
          doCapture([canvas].concat(OtherCanvas), fileName);
        }

        if (bufferNode.codecType === "mjpeg") {
          imagePool.free(bufferNode.buffer);
        } else {
          delete bufferNode.buffer;
          bufferNode.buffer = null;
        }

        bufferNode.previous = null;
        bufferNode.next = null;
        bufferNode = null;
        return true;
      } else {
        debug.log("drawer is undefined in StreamDrawer!");
      }
    } else {}

    return false;
  };

  var drawingInTime = function drawingInTime(timestamp) {
    var stampCheckTime = 200;

    if (isRendering === true) {
      if (startTimestamp === 0 || timestamp - startTimestamp < stampCheckTime) {
        if (startTimestamp === 0) {
          startTimestamp = timestamp;
        }

        if (videoBufferQueue !== null) {
          window.requestAnimationFrame(drawingInTime);
        }

        return;
      }

      curTime += timestamp - preTimestamp; //debug.log('timestamp: ' + timestamp  + ' preTimestamp: ' + preTimestamp + ' curTime: ' + curTime + ' progressTime: ' + progressTime);

      if (curTime > progressTime) {
        drawFrame() ? progressTime += frameInterval : 0;
      }

      if (curTime > milisecond) {
        progressTime = 0;
        curTime = 0;
      }

      preTimestamp = timestamp;
      window.requestAnimationFrame(drawingInTime);
    }
  };

  function drawImage(data) {
    if (typeof preWidth === "undefined" || typeof preHeight === "undefined" || preWidth !== data.width || preHeight !== data.height) {
      drawingStrategy = "ImageWebGL";
      resize(data.width, data.height);
      preWidth = data.width;
      preHeight = data.height;

      if (!(preWidth == 'undefined' || preWidth == null || preWidth == 0)) {//resizeCallback({width: data.width, height: data.height});
      }
    }

    frameTimestamp = data.time;

    if (frameTimestamp !== null) {
      workerManager.timeStamp(frameTimestamp);
    }

    if (typeof drawer !== "undefined") {
      drawer.drawCanvas(data);

      if (captureFlag) {
        captureFlag = false;
        doCapture([canvas].concat(OtherCanvas), fileName);
      }

      imagePool.free(data);
      return true;
    } else {
      debug.log("drawer is undefined in StreamDrawer!");
    }

    return false;
  }

  function startRendering() {
    window.requestAnimationFrame(drawingInTime);
  }

  function base64ArrayBuffer(arrayBuffer) {
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
  }

  ;
  Constructor.prototype = {
    getDrawingStrategy: function getDrawingStrategy() {
      return drawingStrategy;
    },
    reassignCanvas: function reassignCanvas() {
      var tempcanvas = $('canvas[kind-channel-id="' + channelId + '"]')[0];

      if (canvas !== tempcanvas) {
        preWidth = 0;
        preHeight = 0;
      }
    },
    drawMJPEG: function drawMJPEG(data, width, height, codecType, frameType, timeStamp, frameIndex, option) {
      var image = imagePool.alloc();
      image.width = width;
      image.height = height;
      image.codecType = codecType;
      image.frameType = frameType;
      image.frameIndex = frameIndex;
      image.time = timeStamp;

      image.onload = function () {
        if (Uniformity === false) {
          drawImage(this);
        } else {
          if (videoBufferQueue !== null) {
            videoBufferQueue.enqueue(this, this.width, this.height, this.codecType, this.frameType, this.time, this.frameIndex, this.option);
          }
        }
      };

      image.setAttribute("src", "data:image/jpeg;base64," + base64ArrayBuffer(data));
    },
    draw: function draw(data, width, height, codecType, frameType, timeStamp, frameIndex, option) {
      if (Uniformity === false) {
        if (typeof preWidth === "undefined" || typeof preHeight === "undefined" || preWidth !== width || preHeight !== height || prevCodecType !== codecType) {
          drawingStrategy = codecType === "h264" || codecType === "h265" ? "YUVWebGL" : "ImageWebGL";
          resize(width, height);
          preWidth = width;
          preHeight = height;
          prevCodecType = codecType; //resizeCallback({width: width, height: height});
        }

        frameTimestamp = timeStamp;

        if (frameTimestamp !== null) {
          workerManager.timeStamp(frameTimestamp);
        }

        if (typeof drawer !== "undefined") {
          drawer.drawCanvas(data);
          canvas.updatedCanvas = true;

          if (captureFlag) {
            captureFlag = false;
            doCapture([canvas].concat(OtherCanvas), fileName);
          }

          return true;
        } else {
          debug.log("drawer is undefined in StreamDrawer!");
        }

        return false;
      } else {
        if (videoBufferQueue !== null) {
          if (document.hidden && videoBufferQueue.size >= 15) {
            // 当浏览器最小化或者web视频播放窗口的tab页面切换的时候，只需要缓存15帧的数据就行。不然会出现tab页面切回来，时间轴不走的问题
            videoBufferQueue.clear();
          } else {
            videoBufferQueue.enqueue(data, width, height, codecType, frameType, timeStamp, frameIndex, option);
          }
        }
      }
    },
    capture: function capture(name, options) {
      fileName = name;
      captureFlag = true;
      OtherCanvas = options != undefined ? options.ivsCanvasArr : [];
    },
    getCapture: function getCapture(fileName, type, quality) {
      captureQuality = quality || 1.0;
      captureTypeFormat = "png";

      if (type === "jpg" || type === "jpeg") {
        captureTypeFormat = "jpeg";
      }

      return curFrameInfo.src || '';
    },
    digitalZoom: function digitalZoom(bufferData) {
      if (typeof drawer !== "undefined" && drawer !== null) {
        drawer.updateVertexArray(bufferData);
      }
    },
    setResizeCallback: function setResizeCallback(callback) {
      resizeCallback = callback;
    },
    getCodecType: function getCodecType() {
      return prevCodecType;
    },
    getFrameTimestamp: function getFrameTimestamp() {
      return frameTimestamp;
    },
    initStartTime: function initStartTime() {
      if (startTimestamp === 0 && Uniformity !== false) {
        startRendering();
      }
    },
    startRendering: function startRendering() {
      /*if (videoBufferQueue !== null) {
          videoBufferQueue.clear();
      }*/
      if (startTimestamp === 0 && Uniformity !== false) {
        isRendering = true;
        window.requestAnimationFrame(drawingInTime);
      }
    },
    pause: function pause() {
      isRendering = false;
    },
    play: function play() {
      isRendering = true;
    },
    stopRendering: function stopRendering() {
      isRendering = false;
      startTimestamp = 0;
    },
    setFPS: function setFPS(fps) {
      if (typeof fps === "undefined") {
        frameInterval = defaultInterval;
        maxDelay = defaultMaxDelay;
      } else if (fps === 0) {
        frameInterval = defaultInterval;
        maxDelay = defaultMaxDelay;
      } else {
        frameInterval = milisecond / fps;
        maxDelay = fps * 1;
      }

      realFrameInterval = frameInterval;
    },
    setFrameInterval: function setFrameInterval(speed) {
      frameInterval = speed * realFrameInterval;
    },
    getCanvas: function getCanvas() {
      return canvas;
    },
    renewCanvas: function renewCanvas() {
      resize(preWidth, preHeight);

      if (typeof drawer !== "undefined" && drawer !== null) {
        drawer.initCanvas();
      }
    },
    setBeginDrawCallback: function setBeginDrawCallback(callback) {
      beginDrawCallback = callback;
    },
    setupdateCanvasCallback: function setupdateCanvasCallback(callback) {
      updateCanvasCallback = callback;
    },
    terminate: function terminate() {
      startTimestamp = 0;
      frameTimestamp = null;

      if (videoBufferQueue !== null) {
        videoBufferQueue.clear();
        videoBufferQueue = null;
      } //清空canvas


      drawer && drawer.clearCanvas();
      drawer = null;
      rtspOver = false;
    },
    setRtspOver: function setRtspOver() {
      rtspOver = true;
    },
    playNextFrame: drawFrame,
    // 下一帧回放，手动触发drawFrame
    // 获取队列的长度
    getVideoBufferQueueSize: function getVideoBufferQueueSize() {
      return videoBufferQueue.size;
    },
    // 获取当前帧的信息
    getCurFrameInfo: function getCurFrameInfo() {
      return curFrameInfo;
    }
  };
  return new Constructor();
}

var ImagePool = function ImagePool() {
  this.metrics = {};

  this._clearMetrics();

  this._objpool = [];
};

ImagePool.prototype.alloc = function alloc() {
  var obj = null;

  if (this._objpool.length === 0) {
    obj = new Image();
    this.metrics.totalalloc++;
  } else {
    obj = this._objpool.pop();
    this.metrics.totalfree--;
  }

  return obj;
};

ImagePool.prototype.free = function (obj) {
  if (obj.length > 0) {
    debug.log("It is not zero length = " + obj.length);
  } else {
    return;
  }

  this._objpool.push(obj);

  this.metrics.totalfree++;
};

ImagePool.prototype.collect = function (cls) {
  this._objpool = [];
  var inUse = this.metrics.totalalloc - this.metrics.totalfree;

  this._clearMetrics(inUse);
};

ImagePool.prototype._clearMetrics = function (allocated) {
  this.metrics.totalalloc = allocated || 0;
  this.metrics.totalfree = 0;
};

function Size(width, height) {
  function Constructor(width, height) {
    Constructor.prototype.w = width;
    Constructor.prototype.h = height;
  }

  Constructor.prototype = {
    toString: function toString() {
      return "(" + Constructor.prototype.w + ", " + Constructor.prototype.h + ")";
    },
    getHalfSize: function getHalfSize() {
      return new Size(Constructor.prototype.w >>> 1, Constructor.prototype.h >>> 1);
    },
    length: function length() {
      return Constructor.prototype.w * Constructor.prototype.h;
    }
  };
  return new Constructor(width, height);
}

/* harmony default export */ var streamDrawer = (StreamDrawer);
// EXTERNAL MODULE: ./src/videoWorker.worker.js
var videoWorker_worker = __webpack_require__(49);
var videoWorker_worker_default = /*#__PURE__*/__webpack_require__.n(videoWorker_worker);

// EXTERNAL MODULE: ./src/audioWorker.worker.js
var audioWorker_worker = __webpack_require__(20);
var audioWorker_worker_default = /*#__PURE__*/__webpack_require__.n(audioWorker_worker);

// CONCATENATED MODULE: ./src/videoMediaSource.js
/*
    MSE相关，用于控制video播放以及延时优化
 */


function VideoMediaSource(manager) {
  var initSegmentFunc = null;
  var codecInfo = ""; //var videoDigitalPtz = new VideoDigitalPTZ;

  var playbackTimeStamp = null;
  var videoSizeCallback = null;
  var startAudioCallback = null;
  var beginDrawCallback = null;
  var browserType = null;
  var speedValue = 1;
  var receiveTimeStamp = {
    timestamp: 0,
    timestamp_usec: 0,
    timezone: 0
  };
  var changeTimeStampFlag = false;
  var firstTimeStamp = {
    timestamp: 0,
    timestamp_usec: 0,
    timezone: 0
  };
  var preVideoTimeStamp = null;
  var playbackFlag = false;
  var bufferEventListenerArray = null;
  var videoEventListenerArray = null;
  var mediaSourceEventListenerArray = null;
  var isPlaying = false;
  var isPause = true;
  var audioStartNum = 0;
  var workerManager = manager;
  var ctrDelayFlag = false;
  var segmentWaitDecode = [];
  var delay = 0.5;
  var videoElement = null;
  var mediaSource = null;
  var sourceBuffer = null;
  var firstWaitingTime = 0;
  var waitCount = 0;
  var playStart = false;
  var captureTimer = null; //抓图定时器

  var captureTypeFormat = "png"; //图片格式

  var captureQuality = 1.0; //图片质量

  var browser = BrowserDetect();
  var checkTimer = null; //检查播放是否结束定时器

  var preCurTime = 0; //之前的currentTime

  var preDuration = 0;
  var MAX_SAME_TIME = 10; //连续10次currentTime没有变化

  var sameTime = 0; //记录currentTime次数相同的次数

  var MAX_DELAYTIME = 8; //允许最大时间差

  var errorCallback = null;
  var sliderIsPause = false; //进度条暂停状态

  var hasPlayed = false;
  var videoBufferQueue = []; // 录像回放帧存储的队列

  var frameIndexArr = []; // 用来存储帧序号

  var curFrameInfo = {}; // 当前帧的信息

  var fps = 25; //记录帧率

  var delayPlay = 0.5; //用于控制缓冲的视频长度来触发播放

  function Constructor() {}

  function onSourceOpen() {
    //mediaSource = event.target;
    appendInitSegment();
  }

  function addBufferEventListener(sourceBuffer) {
    bufferEventListenerArray = [];
    bufferEventListenerArray.push({
      type: "error",
      "function": onSourceBufferError
    });
    bufferEventListenerArray.push({
      type: "updateend",
      "function": onSourceUpdateend
    });
    bufferEventListenerArray.push({
      type: "update",
      "function": onSourceUpdate
    });

    for (var i = 0; i < bufferEventListenerArray.length; i++) {
      sourceBuffer.addEventListener(bufferEventListenerArray[i].type, bufferEventListenerArray[i]["function"]);
    }
  }

  function addVideoEventListener(videoTag) {
    videoEventListenerArray = [];
    videoEventListenerArray.push({
      type: "durationchange",
      "function": onDurationchange
    });
    videoEventListenerArray.push({
      type: "playing",
      "function": onPlaying
    });
    videoEventListenerArray.push({
      type: "error",
      "function": onError
    });
    videoEventListenerArray.push({
      type: "pause",
      "function": onPause
    });
    videoEventListenerArray.push({
      type: "timeupdate",
      "function": onTimeupdate
    });
    videoEventListenerArray.push({
      type: "resize",
      "function": onResize
    });
    videoEventListenerArray.push({
      type: "seeked",
      "function": onSeeked
    });
    videoEventListenerArray.push({
      type: "waiting",
      "function": onWaiting
    });
    videoEventListenerArray.push({
      type: "canplaythrough",
      "function": canplayThrough
    });
    videoEventListenerArray.push({
      type: "canplay",
      "function": canplay
    });
    videoEventListenerArray.push({
      type: "loadedmetadata",
      "function": loadedmetadata
    });

    for (var i = 0; i < videoEventListenerArray.length; i++) {
      videoTag.addEventListener(videoEventListenerArray[i].type, videoEventListenerArray[i]["function"]);
    }
  }

  function addMediaSourceEventListener(mediaSource) {
    mediaSourceEventListenerArray = [];
    mediaSourceEventListenerArray.push({
      type: "sourceopen",
      "function": onSourceOpen
    });
    mediaSourceEventListenerArray.push({
      type: "error",
      "function": onSourceError
    });

    for (var i = 0; i < mediaSourceEventListenerArray.length; i++) {
      mediaSource.addEventListener(mediaSourceEventListenerArray[i].type, mediaSourceEventListenerArray[i]["function"]);
    }
  }

  function removeEventListener() {
    var i = 0;

    if (bufferEventListenerArray !== null) {
      for (i = 0; i < bufferEventListenerArray.length; i++) {
        sourceBuffer.removeEventListener(bufferEventListenerArray[i].type, bufferEventListenerArray[i]["function"]);
      }
    }

    if (mediaSourceEventListenerArray !== null) {
      for (i = 0; i < mediaSourceEventListenerArray.length; i++) {
        mediaSource.removeEventListener(mediaSourceEventListenerArray[i].type, mediaSourceEventListenerArray[i]["function"]);
      }
    }

    if (videoEventListenerArray !== null) {
      for (i = 0; i < videoEventListenerArray.length; i++) {
        videoElement.removeEventListener(videoEventListenerArray[i].type, videoEventListenerArray[i]["function"]);
      }
    }
  }

  function appendInitSegment() {
    if (mediaSource === null || mediaSource.readyState === "ended") {
      mediaSource = new MediaSource();
      addMediaSourceEventListener(mediaSource);
      videoElement.src = window.URL.createObjectURL(mediaSource);
      debug.log("videoMediaSource::appendInitSegment new MediaSource()");
      return;
    }

    debug.log("videoMediaSource::appendInitSegment start");

    if (mediaSource.sourceBuffers.length === 0) {
      mediaSource.duration = 0;
      var codecs = 'video/mp4;codecs="avc1.' + codecInfo + '"';

      if (MediaSource.isTypeSupported(codecs)) {
        sourceBuffer = mediaSource.addSourceBuffer(codecs);
        addBufferEventListener(sourceBuffer);
      } else {
        debug.log('not support' + codecs);
        errorCallback && errorCallback({
          errorCode: 101
        }); //该浏览器不支持该MIME类型

        return;
      }
    }

    var initSegment = initSegmentFunc();

    if (initSegment === null) {
      mediaSource.endOfStream("network");
      return;
    }

    sourceBuffer.appendBuffer(initSegment);
    debug.log("videoMediaSource::appendInitSegment end, codecInfo = " + codecInfo); //videoElement.play();
  }

  function appendBuffer(buffer1, buffer2) {
    var tmp = new Uint8Array(buffer1.length + buffer2.length);
    tmp.set(buffer1, 0);
    tmp.set(buffer2, buffer1.length);
    return tmp;
  }

  var preTimeCount = 0;

  function appendNextMediaSegment(mediaData, frameIndex) {
    if (sourceBuffer === null) {
      return;
    }

    if (mediaSource.readyState === "closed" || mediaSource.readyState === "ended") {
      return;
    }

    try {
      if (segmentWaitDecode.length > 0) {
        debug.count('1.segmentWaitDecode.length: ' + segmentWaitDecode.length);
        segmentWaitDecode.push(mediaData);
        debug.count('2.segmentWaitDecode.length: ' + segmentWaitDecode.length);
        return;
      } else {
        if (!sourceBuffer.updating) {
          sourceBuffer.appendBuffer(mediaData); // 处理播放过程中获取不到图片的base64图片的问题，只有在暂停的时候才保存
          // 因为暂停时不会走到这个判断逻辑中，为了获取到当前帧图片数据，此处放开if判断逻辑
          // if (sliderIsPause) {

          curFrameInfo.frameIndex = frameIndex;
          curFrameInfo.buffer = mediaData;
          curFrameInfo.src = getBase64URL(); // }
        } else {
          debug.log('updating..........');
          segmentWaitDecode.push(mediaData);
        }
      }
    } catch (error) {
      debug.log("videoMediaSource::appendNextMediaSegment error >> initVideo");
      segmentWaitDecode.length = 0;
      workerManager.initVideo(false);
      errorCallback && errorCallback({
        errorCode: 101
      });
    }
  }

  function videoPlay() {
    if (videoElement.paused) {
      videoSizeCallback();

      if (!isPlaying && !sliderIsPause) {
        //进度条状态不是暂停才能播放
        videoElement.play();
      }
    }
  }

  function videoPause() {
    if (!videoElement.paused) {
      if (!isPause) {
        debug.log('pause');
        videoElement.pause();
      }
    }
  } // 自动播放下一帧


  function autoPlayNextMediaSegment() {
    if (videoBufferQueue.length) {
      appendNextMediaSegment(videoBufferQueue.shift(), frameIndexArr.shift());
    }
  } // 获取当前帧的base64图片地址


  function getBase64URL() {
    var canvas = document.createElement('canvas');
    canvas.width = videoElement.videoWidth;
    canvas.height = videoElement.videoHeight;
    canvas.getContext('2d').drawImage(videoElement, 0, 0, canvas.width, canvas.height);
    return canvas.toDataURL();
  }

  function checkBufferSize() {
    var minute = 60;
    var bufferTime = 10;
    var startTime = sourceBuffer.buffered.start(sourceBuffer.buffered.length - 1) * 1;
    var endTime = sourceBuffer.buffered.end(sourceBuffer.buffered.length - 1) * 1;

    if (endTime - startTime > minute) {
      sourceBuffer.remove(startTime, endTime - bufferTime);
    }
  }

  function videoUpdatingEx() {
    if (mediaSource === null) {
      return;
    }

    try {
      if (sourceBuffer && sourceBuffer.buffered.length > 0) {
        checkBufferSize();

        if (!hasPlayed || sliderIsPause) {
          //还未开始播放
          if (videoElement.duration > delayPlay) {
            videoElement.currentTime = (videoElement.duration - delayPlay).toFixed(3);

            if (fps < 10) {
              delayPlay += 0.5;
            } else {
              delayPlay += 0.1;
            }
          }
        }

        if (videoElement && videoElement.duration - videoElement.currentTime > MAX_DELAYTIME) {
          //视频已经生成，但是不出现视频
          errorCallback && errorCallback({
            errorCode: 101
          });
        }

        if (ctrDelayFlag && !playbackFlag) {
          //视频可以播放无需缓冲,回放不需要控制延时
          var startTime = sourceBuffer.buffered.start(sourceBuffer.buffered.length - 1) * 1;
          var endTime = sourceBuffer.buffered.end(sourceBuffer.buffered.length - 1) * 1;
          var diffTime = 0;
          diffTime = videoElement.currentTime === 0 ? endTime - startTime : endTime - videoElement.currentTime;

          if (diffTime >= delay + 0.1) {
            // 当diffTime和delay相差极小时，跳转到tempCurrentTime会造成卡顿，故加上0.1保证每次跳秒都增加0.1s以上
            debug.log('跳秒');

            if (sourceBuffer.updating) {
              return;
            }

            var tempCurrentTime = endTime - delay; //if (tempCurrentTime < endTime) {
            //debug.log('tempCurrentTime - videoElement.currentTime:　' + (tempCurrentTime - videoElement.currentTime));
            //debug.log('当前时间为: ' +　 videoElement.currentTime)

            videoElement.currentTime = tempCurrentTime.toFixed(3); //debug.log('当前时间跳转到: ' +　tempCurrentTime.toFixed(3));
            //}
          } //debug.log('diffTime:' +diffTime)

        }
      }
    } catch (e) {
      debug.log('sourceBuffer has been removed');
    }
  }

  function onSourceUpdateend() {//debug.log("onSourceUpdate::onSourceUpdateend");
  }

  function onSourceUpdate() {
    //debug.log("videoMediaSource::onSourceUpdate");
    if (segmentWaitDecode.length > 0) {
      //for(var i = 0 ; i< segmentWaitDecode.length; ){
      debug.count('1. onSourceUpdate .segmentWaitDecode.length: ' + segmentWaitDecode.length);

      if (!sourceBuffer.updating) {
        debug.count('2. onSourceUpdate .appendBuffer: ' + segmentWaitDecode.length + '  ' + segmentWaitDecode[0].length);
        sourceBuffer.appendBuffer(segmentWaitDecode[0]);
        segmentWaitDecode.shift();
      } // }

    }
  }

  function onSourceError() {
    debug.log("videoMediaSource::onSourceError");
  }

  function onSourceBufferError() {
    debug.log("videoMediaSource::onSourceBufferErrormsg");
  }

  function onError() {
    debug.log("videoMediaSource::onError");
    videoPause();
    errorCallback && errorCallback({
      errorCode: 101
    });
  }

  function onPlaying() {
    isPlaying = true;
    isPause = false;
    hasPlayed = true;
    debug.log('playing ');

    if (!playStart) {
      playStart = true;
      beginDrawCallback('PlayStart');
    }
  }

  function onPause() {
    isPlaying = false;
    isPause = true;
    debug.log('暂停播放----------------------------------------------');
  }

  function onTimeupdate() {
    //debug.log('onTimeupdateeeeeeeeeeeeeeeeeeeeeeeeeee')
    //debug.log(event);
    var audioStartCheckNum = 4;
    var timeCheckNum = 4;
    var duration = parseInt(mediaSource.duration, 10);
    var currentTime = parseInt(videoElement.currentTime, 10);
    var calcTimeStamp = receiveTimeStamp.timestamp - speedValue * (duration - currentTime + (speedValue !== 1 ? 1 : 0));
    var sendTimeStamp = {
      timestamp: calcTimeStamp,
      timestamp_usec: 0,
      timezone: receiveTimeStamp.timezone
    };

    if (currentTime === 0 || isNaN(duration)) {
      return;
    }

    if (playbackFlag) {
      //秒数动了说明视频开始播放了
      workerManager.waitingCallback(false);
    }

    if (!playbackFlag && Math.abs(duration - currentTime) > timeCheckNum && speedValue === 1) {
      return;
    }

    if (!videoElement.paused) {
      if (preVideoTimeStamp === null) {
        preVideoTimeStamp = sendTimeStamp; // 实际音频已经准备完毕,需要触发一次callback，用来将audioPlayer.js中的bufferingFlag置为false;

        startAudioCallback(0, "currentTime");
      } else if (preVideoTimeStamp.timestamp <= sendTimeStamp.timestamp && speedValue >= 1 || preVideoTimeStamp.timestamp > sendTimeStamp.timestamp && speedValue < 1) {
        if (playbackFlag) {
          workerManager.timeStamp(sendTimeStamp);
        }

        preVideoTimeStamp = sendTimeStamp;
        audioStartNum++;

        if (audioStartNum > audioStartCheckNum) {
          //debug.log('传递给audio: ' + sendTimeStamp.timestamp)
          startAudioCallback(sendTimeStamp.timestamp, "currentTime");
        }
      }
    }
  }

  function onDurationchange() {
    videoPlay(); //由定制修改移植过来，MAC电脑回放经常无法拉流

    videoUpdatingEx();
  }

  function onResize() {
    videoSizeCallback();
  }

  function onSeeked() {
    videoPlay();
  }

  function onWaiting() {
    debug.log('需要缓冲下一帧'); //debug.log(event)
    //debug.log('当前时间：' + videoElement.currentTime);
    //debug.log(sourceBuffer.buffered.start(sourceBuffer.buffered.length - 1) + ' ' + sourceBuffer.buffered.end(sourceBuffer.buffered.length - 1))

    ctrDelayFlag = false;

    if (playbackFlag && isPlaying) {
      //回放,拖完进度条后传出卡顿事件
      workerManager.waitingCallback(true);
    } //一分钟内缓冲五次时，增大delay，但不能超过1.5


    if (waitCount == 0) {
      firstWaitingTime = Date.now();
      waitCount++;
    } else {
      waitCount++;
      var diffTime = Date.now() - firstWaitingTime;
      debug.log('diffTime: ' + diffTime + '  Count: ' + waitCount);

      if (waitCount >= 5 && diffTime < 60000 && delay <= 1.8) {
        delay = delay + 0.1;
        waitCount = 0;
        firstWaitingTime = 0;
        debug.log('delay + 0.1 = ' + delay);
      }
    }
  }
  /**
   * 该视频已准备好开始播放
   */


  function canplay() {
    debug.log('Can play !');
  }

  function canplayThrough() {
    debug.log('Can play without waiting'); //debug.log(event)

    ctrDelayFlag = true;
  }
  /**
   *  音视频元数据已加载时，会发生该事件
   *  元数据包括: 时长、分辨率以及文本轨道
   */


  function loadedmetadata() {
    debug.log('loadedmetadata');
  }

  Constructor.prototype = {
    init: function init(element) {
      browserType = BrowserDetect();
      debug.log("videoMediaSource::init browserType = " + browserType);
      videoElement = element;

      if (browserType === "safari") {
        videoElement.autoplay = false;
      } else {
        videoElement.autoplay = true;
      } //var img = "./base/images/loading.gif";
      // if ($("channel_player.full-screen").length || $("#channellist-containner").length) {
      //    img = "./base/images/loading_b.gif"
      // }


      videoElement.controls = false;
      videoElement.preload = "auto"; //videoElement.poster = "./base/images/video_poster.png";
      //videoElement.style.background = "url(" + img + ") no-repeat center center";
      //videoElement.style.backgroundSize = "48px 48px";
      //videoDigitalPtz.setVideoElement(videoElement);

      addVideoEventListener(videoElement);
      appendInitSegment();
    },
    setInitSegmentFunc: function setInitSegmentFunc(func) {
      initSegmentFunc = func;
    },
    getVideoElement: function getVideoElement() {
      return videoElement;
    },
    setCodecInfo: function setCodecInfo(info) {
      codecInfo = info;
    },
    setMediaSegment: function setMediaSegment(mediaSegment, frameIndex) {
      // 首先把一帧帧的数据，塞到队列中，如果在播放过程中，会把数据appendBuffer到sourceBuffer中；
      // 当暂停的时候，点击下一帧会触发拉流，塞到videoBufferQueue队列中，需要手动播放一帧数据
      videoBufferQueue.push(mediaSegment);
      frameIndexArr.push(frameIndex);

      if (!sliderIsPause) {
        autoPlayNextMediaSegment();
      }
    },
    capture: function capture(fileName, options) {
      if (captureTimer) {
        clearInterval(captureTimer);
      }

      var canvas = document.createElement("canvas");
      canvas.width = videoElement.videoWidth;
      canvas.height = videoElement.videoHeight;
      var ivsCanvasArr = options.ivsCanvasArr;

      if (ctrDelayFlag || browser === "edge") {
        //edge不支持canplaythrough事件
        canvas.getContext("2d").drawImage(videoElement, 0, 0, canvas.width, canvas.height);
        doCapture(canvas, ivsCanvasArr, fileName);
      } else {
        captureTimer = setInterval(function () {
          if (ctrDelayFlag) {
            canvas.getContext("2d").drawImage(videoElement, 0, 0, canvas.width, canvas.height);
            doCapture(canvas, ivsCanvasArr, fileName);
            clearInterval(captureTimer);
          }
        }, 200);
      }
    },
    getCapture: function getCapture(fileName, type, quality) {
      if (captureTimer) {
        clearInterval(captureTimer);
      }

      captureQuality = quality || 1.0;
      captureTypeFormat = "png";

      if (type === "jpg" || type === "jpeg") {
        captureTypeFormat = "jpeg";
      }

      var canvas = document.createElement("canvas");
      var img = null;
      canvas.width = videoElement.videoWidth;
      canvas.height = videoElement.videoHeight;

      if (ctrDelayFlag || browser === "edge") {
        //edge不支持canplaythrough事件
        canvas.getContext("2d").drawImage(videoElement, 0, 0, canvas.width, canvas.height);
        img = canvas.toDataURL("image/" + captureTypeFormat, captureQuality);
      } else {
        if (ctrDelayFlag) {
          canvas.getContext("2d").drawImage(videoElement, 0, 0, canvas.width, canvas.height);
          img = canvas.toDataURL("image/" + captureTypeFormat, captureQuality);
        }
      }

      return img;
    },
    setInitSegment: function setInitSegment() {
      appendInitSegment();
    },
    setTimeStamp: function setTimeStamp(timeStamp, callback) {
      playbackTimeStamp = timeStamp;
    },
    setVideoSizeCallback: function setVideoSizeCallback(func) {
      videoSizeCallback = func;
    },
    setAudioStartCallback: function setAudioStartCallback(func) {
      startAudioCallback = func;
    },
    getPlaybackTimeStamp: function getPlaybackTimeStamp() {
      return playbackTimeStamp;
    },
    setSpeedPlay: function setSpeedPlay(value) {
      speedValue = value;
    },
    setvideoTimeStamp: function setvideoTimeStamp(timestamp) {
      var seekCheckTime = 3;
      var seekCheck = Math.abs(receiveTimeStamp.timestamp - timestamp.timestamp) > seekCheckTime;

      if (firstTimeStamp.timestamp === 0) {
        //第一帧
        workerManager.timeStamp(timestamp);
      }

      if (seekCheck === true) {
        audioStartNum = 0;
        firstTimeStamp = timestamp;
        startAudioCallback(firstTimeStamp.timestamp, "init");

        if (receiveTimeStamp.timestamp !== 0 && playbackFlag) {
          //第一帧会触发seekCheck
          videoElement.currentTime = mediaSource.duration - 0.1;
          workerManager.waitingCallback(false); //表示收到了进度条拖动后的帧
        }

        preVideoTimeStamp = null;
      }

      receiveTimeStamp = timestamp;
    },
    pause: function pause() {
      //进度条暂停
      sliderIsPause = true;
      videoPause();
    },
    play: function play() {
      //进度条开始
      sliderIsPause = false; //videoPlay()
    },
    setPlaybackFlag: function setPlaybackFlag(value) {
      playbackFlag = value;
    },
    setTimeStampInit: function setTimeStampInit() {
      preVideoTimeStamp = null;
      firstTimeStamp = {
        timestamp: 0,
        timestamp_usec: 0,
        timezone: 0
      };
    },
    close: function close() {
      removeEventListener();
      videoPause();
    },
    setBeginDrawCallback: function setBeginDrawCallback(callback) {
      beginDrawCallback = callback;
    },
    setErrorCallback: function setErrorCallback(callback) {
      errorCallback = callback;
    },
    terminate: function terminate() {
      if (videoElement === null) return; //视频已经关闭

      removeEventListener();

      if (mediaSource.readyState === "open") {
        sourceBuffer && mediaSource.removeSourceBuffer(sourceBuffer);
        mediaSource.endOfStream();
      }

      sourceBuffer = null; //videoElement.src = null;
      //mediaSource.removeSourceBuffer(sourceBuffer);

      sourceBuffer = null;
      mediaSource = null;
      videoElement = null;

      if (captureTimer) {
        clearInterval(captureTimer);
        captureTimer = null;
      }

      if (checkTimer) {
        clearInterval(checkTimer);
        checkTimer = null;
      }

      sameTime = 0;
      preDuration = 0;
      preCurTime = 0;
    },
    getDuration: function getDuration() {
      return videoElement.duration - videoElement.currentTime;
    },
    setFPS: function setFPS(rate) {
      if (rate) {
        fps = rate;
      }
    },
    setRtspOver: function setRtspOver() {
      if (videoElement.duration.toFixed(4) - 0 === videoElement.currentTime.toFixed(4) - 0) {
        workerManager.timeStamp(receiveTimeStamp);
        workerManager.fileOverCallback();
      } else {
        //收到RTSP结束信令后，video缓存的视频需要播放完毕才能传出fileOver事件
        preCurTime = parseInt(videoElement.currentTime);
        preDuration = parseInt(videoElement.duration);
        checkTimer = setInterval(function () {
          if (preCurTime === parseInt(videoElement.currentTime) && preDuration === parseInt(videoElement.duration)) {
            if (sameTime++ > MAX_SAME_TIME) {
              //连续currentTime相同，表示回放已经结束
              checkTimer && clearInterval(checkTimer);
              checkTimer = null;
              workerManager.timeStamp(receiveTimeStamp);
              workerManager.fileOverCallback();
            }
          } else if (parseInt(videoElement.currentTime) >= parseInt(videoElement.duration)) {
            //Edge的currentTime会不停增加
            checkTimer && clearInterval(checkTimer);
            checkTimer = null;
            workerManager.timeStamp(receiveTimeStamp);
            workerManager.fileOverCallback();
          } else {
            preCurTime = parseInt(videoElement.currentTime);
            preDuration = parseInt(videoElement.duration);
            sameTime = 0;
          }
        }, 150);
      }
    },
    // 获取当前队列的长度
    getVideoBufferQueueSize: function getVideoBufferQueueSize() {
      return videoBufferQueue.length;
    },
    // 播放下一帧数据
    playNextFrame: function playNextFrame() {
      autoPlayNextMediaSegment();
    },
    // 获取当前帧的信息
    getCurFrameInfo: function getCurFrameInfo() {
      return curFrameInfo;
    }
  };

  function doCapture(orginCanvas, ivsCanvasArr, filename) {
    var width = orginCanvas.width;
    var height = orginCanvas.height;
    var ctx = orginCanvas.getContext('2d');

    for (var _i = 0; _i < ivsCanvasArr.length; _i++) {
      //把canvas数组的全部绘制到同一张canvas
      ctx.drawImage(ivsCanvasArr[_i], 0, 0, width, height);
    }

    var data = orginCanvas.toDataURL();
    var dataAtob = atob(data.substring("data:image/png;base64,".length));
    var asArray = new Uint8Array(dataAtob.length);

    for (var i = 0, len = dataAtob.length; i < len; ++i) {
      asArray[i] = dataAtob.charCodeAt(i);
    }

    var blob = new Blob([asArray.buffer], {
      type: "image/png"
    });
    saveAs(blob, filename + ".png");
  }

  var saveAs = function (view) {
    var doc = view.document;

    var get_URL = function get_URL() {
      return view.URL || view.webkitURL || view;
    };

    var save_link = doc.createElementNS("http://www.w3.org/1999/xhtml", "a");
    var can_use_save_link = ("download" in save_link);

    var click = function click(node) {
      var event = new MouseEvent("click");
      node.dispatchEvent(event);
    };

    var is_safari = /constructor/i.test(view.HTMLElement);
    var is_chrome_ios = /CriOS\/[\d]+/.test(navigator.userAgent);

    var throw_outside = function throw_outside(ex) {
      (view.setImmediate || view.setTimeout)(function () {
        throw ex;
      }, 0);
    };

    var force_saveable_type = "application/octet-stream",
        arbitrary_revoke_timeout = 1e3 * 40,
        revoke = function revoke(file) {
      var revoker = function revoker() {
        if (typeof file === "string") {
          get_URL().revokeObjectURL(file);
        } else {
          file.remove();
        }
      };

      setTimeout(revoker, arbitrary_revoke_timeout);
    };

    var dispatch = function dispatch(filesaver, event_types, event) {
      event_types = [].concat(event_types);
      var i = event_types.length;

      while (i--) {
        var listener = filesaver["on" + event_types[i]];

        if (typeof listener === "function") {
          try {
            listener.call(filesaver, event || filesaver);
          } catch (ex) {
            throw_outside(ex);
          }
        }
      }
    };

    var auto_bom = function auto_bom(blob) {
      if (/^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(blob.type)) {
        return new Blob([String.fromCharCode(65279), blob], {
          type: blob.type
        });
      }

      return blob;
    };

    var FileSaver = function FileSaver(blob, name, no_auto_bom) {
      if (!no_auto_bom) {
        blob = auto_bom(blob);
      }

      var filesaver = this,
          type = blob.type,
          force = type === force_saveable_type,
          object_url,
          dispatch_all = function dispatch_all() {
        dispatch(filesaver, "writestart progress write writeend".split(" "));
      },
          fs_error = function fs_error() {
        if ((is_chrome_ios || force && is_safari) && view.FileReader) {
          var reader = new FileReader();

          reader.onloadend = function () {
            var url = is_chrome_ios ? reader.result : reader.result.replace(/^data:[^;]*;/, "data:attachment/file;");
            var popup = view.open(url, "_blank");
            if (!popup) view.location.href = url;
            url = undefined;
            filesaver.readyState = filesaver.DONE;
            dispatch_all();
          };

          reader.readAsDataURL(blob);
          filesaver.readyState = filesaver.INIT;
          return;
        }

        if (!object_url) {
          object_url = get_URL().createObjectURL(blob);
        }

        if (force) {
          view.location.href = object_url;
        } else {
          var opened = view.open(object_url, "_blank");

          if (!opened) {
            view.location.href = object_url;
          }
        }

        filesaver.readyState = filesaver.DONE;
        dispatch_all();
        revoke(object_url);
      };

      filesaver.readyState = filesaver.INIT;

      if (can_use_save_link) {
        object_url = get_URL().createObjectURL(blob);
        setTimeout(function () {
          save_link.href = object_url;
          save_link.download = name;
          click(save_link);
          dispatch_all();
          revoke(object_url);
          filesaver.readyState = filesaver.DONE;
        });
        return;
      }

      fs_error();
    };

    var FS_proto = FileSaver.prototype;

    var saveAs = function saveAs(blob, name, no_auto_bom) {
      return new FileSaver(blob, name || blob.name || "download", no_auto_bom);
    };

    if (typeof navigator !== "undefined" && navigator.msSaveOrOpenBlob) {
      return function (blob, name, no_auto_bom) {
        name = name || blob.name || "download";

        if (!no_auto_bom) {
          blob = auto_bom(blob);
        }

        return navigator.msSaveOrOpenBlob(blob, name);
      };
    }

    FS_proto.readyState = FS_proto.INIT = 0;
    FS_proto.WRITING = 1;
    FS_proto.DONE = 2;
    FS_proto.error = FS_proto.onwritestart = FS_proto.onprogress = FS_proto.onwrite = FS_proto.onabort = FS_proto.onerror = FS_proto.onwriteend = null;
    return saveAs;
  }(window);

  return new Constructor();
}

/* harmony default export */ var videoMediaSource = (VideoMediaSource);
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
// CONCATENATED MODULE: ./src/ivs.js
function ivs_typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { ivs_typeof = function _typeof(obj) { return typeof obj; }; } else { ivs_typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return ivs_typeof(obj); }



function IvsDraw() {
  var objectMap = {};
  var ivsCallback = null;
  var ivsQueue = Queue(); //生成队列

  var eventQueue = Queue(); //生成报警事件队列

  var LIFE_CYCLE = 500; //生命周期为500ms

  function QueueNode(data, timeStamp) {
    this.data = data;
    this.timeStamp = timeStamp;
    this.next = null;
  }

  function Queue() {
    function Constructor() {
      this.first = null;
      this.size = 0;
    }

    Constructor.prototype = {
      enqueue: function enqueue(node) {
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
      },
      dequeue: function dequeue() {
        var temp = null;

        if (this.first !== null) {
          temp = this.first;
          this.first = this.first.next;
          this.size -= 1;
        }

        return temp;
      },
      clear: function clear() {
        this.size = 0;
        this.first = null;
      }
    };
    return new Constructor();
  }

  function drawTrack(videoTime, queue) {
    var node = queue.first;

    if (!!node) {
      if (videoTime > node.timeStamp) {
        //视频相比智能帧超前，就从队列取，直到两者时间相等位置
        while (node && videoTime > node.timeStamp) {
          node = queue.dequeue();

          if (node && node.data && node.data.type === 2) {
            ivsCallback && ivsCallback(node.data); //报警事件不能丢弃	
          }
        }

        node && ivsCallback && ivsCallback(node.data);
      } else if (videoTime < node.timeStamp) {
        //智能帧超前，就重复绘制
        if (node.data && node.data.type !== 2) {
          //报警事件触发一次即可
          ivsCallback && ivsCallback(node.data);
        }
      } else {
        ivsCallback && ivsCallback(node.data);
        queue.dequeue();
      }
    }
  }

  function Constructor() {}

  Constructor.prototype = {
    draw: function draw(data, videoTime, timeStamp, channel) {
      debug.log('type:' + data.type + '   jsondata:' + JSON.stringify(data.params));
      var params = data.params;

      if (!params) {
        return;
      }

      var drawData = {
        type: 0,
        //0 元数据，1 跟踪框,2 事件,3 聚焦
        data: null,
        channel: channel
      };

      if (params.hasOwnProperty('VideoAnalyseRule')) {
        drawData.type = 0;
        drawData.data = params.VideoAnalyseRule;
        ivsCallback && ivsCallback(drawData);
      }

      if (params.hasOwnProperty('FocusStatus')) {
        drawData.type = 3;
        drawData.data = params.FocusStatus;
        ivsCallback && ivsCallback(drawData);
      }

      if (params.hasOwnProperty('Event')) {
        drawData.type = 2;
        drawData.data = params.Event;
        eventQueue.enqueue(new QueueNode(JSON.parse(JSON.stringify(drawData)), timeStamp));
      }

      drawTrack(videoTime, eventQueue);

      if (data.type === 0x05) {
        var object = params.object;
        var coordinate = params.coordinate;

        for (var i = 0; i < object.length; i++) {
          (function (i) {
            var uniqueId = object[i].classID + object[i].objectId;

            switch (object[i].operateType) {
              case 1:
                {
                  ///新增
                  objectMap[uniqueId] = {};
                  objectMap[uniqueId].show = true;

                  if (object[i].hasOwnProperty('track')) {
                    objectMap[uniqueId].pos = object[i].track[0];
                  }

                  objectMap[uniqueId].type = object[i].objectType;
                  objectMap[uniqueId].coordinate = coordinate;
                  objectMap[uniqueId].timeout = setTimeout(function () {
                    //每个规则设置了500ms的生命周期
                    objectMap[uniqueId].show = false;
                  }, LIFE_CYCLE);
                }
                break;

              case 2:
                ///更新
                if (!objectMap.hasOwnProperty(uniqueId)) {
                  objectMap[uniqueId] = {};
                  objectMap[uniqueId].coordinate = coordinate;
                }

                if (object[i].hasOwnProperty('track')) {
                  objectMap[uniqueId].pos = object[i].track[0];
                  objectMap[uniqueId].show = true;
                }

                objectMap[uniqueId].type = object[i].objectType;

                if (objectMap[uniqueId].timeout) {
                  clearTimeout(objectMap[uniqueId].timeout);
                }

                objectMap[uniqueId].timeout = setTimeout(function () {
                  objectMap[uniqueId].show = false;
                }, LIFE_CYCLE);
                break;

              case 3:
                ///删除
                if (objectMap.hasOwnProperty(uniqueId)) {
                  if (objectMap[uniqueId].timeout) {
                    clearTimeout(objectMap[uniqueId].timeout);
                  }

                  delete objectMap[uniqueId];
                }

                break;

              case 4:
                //隐藏
                if (objectMap.hasOwnProperty(uniqueId)) {
                  objectMap[uniqueId].show = false;
                }

                break;

              default:
                break;
            }
          })(i);
        }
      } else if (data.type === 0x0e) {
        for (var j = 0; j < params.length; j++) {
          var coordinate = params[j].coordinate;
          var object = []; // 20220401-中心网络微中心项目：返回数据object中除了通用目标commonObject还返回了vehicleObject类型，格式如下：
          // 由于之前只取了commonObject造成vehicleObject没有处理，表现为页面预览是车辆类型没有叠加智能目标框
          // object:{
          // 	commonObject:[],
          // 	vehicleObject:[{
          // 	objectId:87865,
          // 	operateType:2,
          // 	track:[[4997, 1146, 7443, 4184]] // track层级与通用目标格式不同，通用目标放在了attribute84里面一层
          // 	type:2,
          // 	valid:1
          // }]
          // }

          if (params[j].object) {
            for (var objType in params[j].object) {
              // 如果取object下的全部类型不确定会不会给其他项目造成影响，因为之前只取了commonObject一种类型，所以现在只新增需要的vehicleObject类型
              if (objType === 'commonObject' || objType === 'vehicleObject') {
                object = object.concat(params[j].object[objType]);
              }
            }
          }

          for (var i = 0; i < object.length; i++) {
            (function (i) {
              var uniqueId = params[j].classID + object[i].objectId;

              for (var key in object[i]) {
                if (ivs_typeof(object[i][key]) !== 'object') continue;

                switch (object[i].operateType) {
                  case 1:
                    // 新增
                    objectMap[uniqueId] = {};
                    objectMap[uniqueId].show = true;

                    if (object[i].hasOwnProperty('track')) {
                      objectMap[uniqueId].pos = object[i].track[0]; // 兼容vehicleObject数据类型
                    } else {
                      objectMap[uniqueId].pos = object[i][key][0].track[0];
                    }

                    objectMap[uniqueId].type = object[i].type;
                    objectMap[uniqueId].coordinate = coordinate;
                    objectMap[uniqueId].timeout = setTimeout(function () {
                      //每个规则设置了500ms的生命周期
                      delete objectMap[uniqueId];
                    }, LIFE_CYCLE);
                    break;

                  case 2:
                    // 更新
                    if (!objectMap.hasOwnProperty(uniqueId)) {
                      objectMap[uniqueId] = {};
                      objectMap[uniqueId].coordinate = coordinate;
                    }

                    if (object[i].hasOwnProperty('track')) {
                      objectMap[uniqueId].pos = object[i].track[0]; //兼容vehicleObject数据类型
                    } else {
                      objectMap[uniqueId].pos = object[i][key][0].track[0];
                    }

                    objectMap[uniqueId].show = true;
                    objectMap[uniqueId].type = object[i].type;

                    if (objectMap[uniqueId].timeout) {
                      clearTimeout(objectMap[uniqueId].timeout);
                    }

                    objectMap[uniqueId].timeout = setTimeout(function () {
                      delete objectMap[uniqueId];
                    }, LIFE_CYCLE);
                    break;

                  default:
                    break;
                }
              }
            })(i);
          }
        }
      } else if (data.type === 0x14) {
        for (var i = 0; i < params.length; i++) {
          var curObject = params[i]; // 当前对象

          var initObj = {
            show: true,
            type: 0x14
          };
          var uniqueId = String('0x14_') + curObject.objectId;
          objectMap = {}; // 当前设备中，数据一直是增加的，

          switch (curObject.objectStatus) {
            case 0:
              // 创建
              objectMap[uniqueId] = initObj;
              objectMap[uniqueId].data = curObject.params.object; // 图形数组

              objectMap[uniqueId].timeout = setTimeout(function () {//每个规则设置了500ms的生命周期
                // objectMap[uniqueId].show = false;
              }, LIFE_CYCLE);
              break;

            case 1:
              // 隐藏
              if (objectMap.hasOwnProperty(uniqueId)) {
                objectMap[uniqueId].show = false;
              }

              break;

            case 2:
              // 更新
              if (!objectMap.hasOwnProperty(uniqueId)) {
                objectMap[uniqueId] = initObj;
              }

              objectMap[uniqueId].data = curObject.params.object;

              if (objectMap[uniqueId].timeout) {
                clearTimeout(objectMap[uniqueId].timeout);
              }

              objectMap[uniqueId].timeout = setTimeout(function () {// objectMap[uniqueId].show = false;
              }, LIFE_CYCLE);
              break;

            case 3:
              // 销毁
              if (objectMap.hasOwnProperty(uniqueId)) {
                if (objectMap[uniqueId].timeout) {// clearTimeout(objectMap[uniqueId].timeout);
                }

                delete objectMap[uniqueId];
              }

              break;

            default:
              break;
          }
        }
      }

      drawData.type = 1;
      drawData.data = objectMap;
      ivsQueue.enqueue(new QueueNode(JSON.parse(JSON.stringify(drawData)), timeStamp));
      drawTrack(videoTime, ivsQueue);
    },
    setCallback: function setCallback(func) {
      if (ivsCallback) return;
      ivsCallback = func;
    }
  };
  return new Constructor();
}

/* harmony default export */ var ivs = (IvsDraw);
// CONCATENATED MODULE: ./src/audioPlayer.js
/*
   音频播放控制器
   G711 G726走AudioContext播放
   AAC走audio播放，通过mse控制
   音视频同步通过bufferAudio函数控制，目前还没搞清楚，所以音视频存在几百毫秒的不同步问题
 */

function AudioPlayer() {
  var MAXBUFFERSIZE = 8e4;
  var MAXTIMEGAP_LIMIT = 200;
  var SAMPLINGRATE = 8000;
  var MAX_VOLUME = 1;
  var audioContext = null;
  var gainInNode = null;
  var biquadFilter = null;
  var saveVol = 0;
  var codecInfo = {
    type: "G.711",
    samplingRate: SAMPLINGRATE,
    bitrate: "8000"
  };
  var nextStartTime = 0;
  var isRunning = false;
  var preTimeStamp = 0;
  var initVideoTimeStamp = 0;
  var videoDiffTime = null;
  var bufferingFlag = false;
  var playBuffer = new Float32Array(MAXBUFFERSIZE);
  var readLength = 0;
  var sourceNode = null;
  var triggerAudioPlay = false; // 当数据达到一定层度的时候，自动触发音频播放

  var sourceNodeList = [];
  var isStop = false; // 音频是否停止

  var instance = null;
  var audioTime = 0; // 已经播放的音频时间

  var step = 0; //步长

  var rtspOver = false;

  function playAudioIn(data, rtpTimestamp) {
    var timegap = rtpTimestamp - preTimeStamp;

    if (timegap > MAXTIMEGAP_LIMIT || timegap < 0) {
      nextStartTime = 0;
      readLength = 0;
      bufferingFlag = true;

      if (sourceNode !== null) {
        sourceNode.stop();
      }
    }

    if (nextStartTime - audioContext.currentTime < 0) {
      nextStartTime = 0;
    } //debug.log('data1:   ' + data)
    //data = test(data)
    //debug.log('data2:   ' + data)


    preTimeStamp = rtpTimestamp;
    playBuffer = appendBufferFloat32(playBuffer, data, readLength);
    readLength += data.length;

    if (!bufferingFlag) {
      var startPos = 0;

      if (readLength / data.length > 1) {
        if (videoDiffTime !== null) {
          startPos = videoDiffTime * SAMPLINGRATE;
        }

        if (startPos >= readLength || videoDiffTime === null) {
          readLength = 0;
          return;
        }
      }

      var audioBuffer = null;

      if (/Apple Computer/.test(navigator.vendor)) {
        if (codecInfo.samplingRate < 32e3) {
          if (codecInfo.samplingRate == 8e3) {
            playBuffer = Upsampling8Kto32K(playBuffer.subarray(startPos, readLength));
          } else if (codecInfo.samplingRate == 16e3) {
            playBuffer = Upsampling16Kto32K(playBuffer.subarray(startPos, readLength));
          }

          var sampling = 32e3;
          audioBuffer = audioContext.createBuffer(1, playBuffer.length, sampling);
          audioBuffer.getChannelData(0).set(playBuffer);
        } else {
          audioBuffer = audioContext.createBuffer(1, readLength - startPos, codecInfo.samplingRate);
          audioBuffer.getChannelData(0).set(playBuffer.subarray(startPos, readLength));
        }
      } else {
        audioBuffer = audioContext.createBuffer(1, readLength - startPos, codecInfo.samplingRate);
        audioBuffer.getChannelData(0).set(playBuffer.subarray(startPos, readLength));
      }

      readLength = 0;
      sourceNode = audioContext.createBufferSource();
      sourceNode.buffer = audioBuffer;
      sourceNode.connect(biquadFilter); //sourceNode.connect(audioContext.destination);

      if (!nextStartTime) {
        nextStartTime = audioContext.currentTime + 0.1;
      }

      sourceNode.start(nextStartTime);
      nextStartTime += audioBuffer.duration;
    }
  }
  /**
   * 接收音频数据，push到一个list中，当有5条的时候，开始进行播放
   * @param {object} data 音频数据
   */


  function recevieAudioData(data) {
    if (!bufferingFlag) {
      if (!triggerAudioPlay) {
        if (sourceNodeList.length === 5) {
          triggerAudioPlay = true;
          playAudioList(sourceNodeList.shift());
          instance.audioPlayBegin();
        }
      }

      sourceNodeList.push(createSourceNodeList(data, codecInfo));
    }
  }
  /**
   * 创建sourceNode
   * @param {object} data 音频数据
   * @param {object} codecInfo 编码信息
   */


  function createSourceNodeList(data, codecInfo) {
    var audioBuffer = audioContext.createBuffer(1, data.length, codecInfo.samplingRate);
    step = data.length / codecInfo.samplingRate; // 帧数 / 采样率 = 当前片段的播放时间

    audioBuffer.getChannelData(0).set(data);
    sourceNode = audioContext.createBufferSource();
    sourceNode.buffer = audioBuffer;
    return sourceNode;
  }
  /**
   * 播放音频片段的递归函数
   * @param {object} nodeItem sourceNode的item
   */


  function playAudioList(nodeItem) {
    if (nodeItem) {
      nodeItem.connect(biquadFilter);
      nodeItem.start();

      nodeItem.onended = function () {
        nodeItem.disconnect();
        audioTime += step;
        instance.timeUpdate(audioTime);

        if (!isStop) {
          if (sourceNodeList.length) {
            playAudioList(sourceNodeList.shift());
          } else {
            instance.audioPlayEnd();
          }
        }
      };
    }
  }

  function appendBufferFloat32(_currentBuffer, newBuffer, readLength) {
    var BUFFER_SIZE = 8e4;
    var currentBuffer = _currentBuffer;

    if (readLength + newBuffer.length >= currentBuffer.length) {
      currentBuffer = new Float32Array(currentBuffer.length + BUFFER_SIZE);
      currentBuffer.set(currentBuffer, 0);
    }

    currentBuffer.set(newBuffer, readLength);
    return currentBuffer;
  }

  function Upsampling8Kto32K(inputBuffer) {
    var point1 = 0,
        point2 = 0,
        point3 = 0,
        point4 = 0,
        mu = 0.2,
        mu2 = (1 - Math.cos(mu * Math.PI)) / 2;
    var buf = new Float32Array(inputBuffer.length * 4);

    for (var i = 0, j = 0; i < inputBuffer.length; i++) {
      j = i * 4;
      point1 = inputBuffer[i];
      point2 = i < inputBuffer.length - 1 ? inputBuffer[i + 1] : point1;
      point3 = i < inputBuffer.length - 2 ? inputBuffer[i + 2] : point1;
      point4 = i < inputBuffer.length - 3 ? inputBuffer[i + 3] : point1;
      point2 = point1 * (1 - mu2) + point2 * mu2;
      point3 = point2 * (1 - mu2) + point3 * mu2;
      point4 = point3 * (1 - mu2) + point4 * mu2;
      buf[j] = point1;
      buf[j + 1] = point2;
      buf[j + 2] = point3;
      buf[j + 3] = point4;
    }

    return buf;
  }

  function Upsampling16Kto32K(inputBuffer) {
    var point1 = 0,
        point2 = 0;
    var buf = new Float32Array(inputBuffer.length * 2);

    for (var i = 0, j = 0; i < inputBuffer.length; i++) {
      j = i * 2;
      point1 = inputBuffer[i];
      point2 = i < inputBuffer.length - 1 ? inputBuffer[i + 1] : point1;
      buf[j] = point1;
      buf[j + 1] = (point1 + point2) / 2;
    }

    return buf;
  }

  function Constructor() {}

  Constructor.prototype = {
    audioInit: function audioInit(volume) {
      nextStartTime = 0;

      if (audioContext !== null && isRunning) {
        debug.info("Audio context already defined!");
      } else {
        try {
          if (audioContext && !isRunning && /Apple Computer/.test(navigator.vendor)) {
            //safari audioContext 只能用3次
            audioContext.close();
          }

          window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext || window.oAudioContext || window.msAudioContext;
          audioContext = new AudioContext();

          audioContext.onstatechange = function () {
            debug.info("Audio Context State changed :: " + audioContext.state);

            if (audioContext.state === "running") {
              isRunning = true;
            }
          };

          gainInNode = audioContext.createGain();
          biquadFilter = audioContext.createBiquadFilter();
          biquadFilter.connect(gainInNode);
          biquadFilter.type = "lowpass"; //低通滤波

          biquadFilter.frequency.value = 4e3;
          biquadFilter.gain.value = 40;
          gainInNode.connect(audioContext.destination);
          this.controlVolumn(volume);
          console.log('audioPlayer1', this.getVolume());
          return true;
        } catch (error) {
          debug.error("Web Audio API is not supported in this web browser! : " + error);
          return false;
        }
      }
    },
    play: function play() {
      this.controlVolumn(saveVol);
      console.log('audioPlayerPlay', this.getVolume());
      isStop = false;
      playAudioList(sourceNodeList.shift());
    },
    stop: function stop() {
      saveVol = 0;
      gainInNode.gain.value = 0;
      nextStartTime = 0;
    },
    bufferAudio: function bufferAudio(data, rtpTimestamp, codecType, audioOnly) {
      if (isRunning) {
        if (audioOnly) {
          // 单纯播放音频的时候，只需要接口数据就行，时间由内部自己管理
          recevieAudioData(data);
        } else {
          playAudioIn(data, rtpTimestamp);
        }
      }
    },
    controlVolumn: function controlVolumn(vol, flag) {
      console.log('audioPlayer-controlVolumn', vol);

      if (flag && /Apple Computer/.test(navigator.vendor)) {
        //safari 点击按钮后才能生成audioContext 否则无法播放声音
        this.audioInit(1);
      }

      saveVol = vol;
      var tVol = vol / MAX_VOLUME;

      if (tVol <= 0) {
        gainInNode.gain.value = 0;
        nextStartTime = 0;
      } else {
        if (tVol >= 1) {
          gainInNode.gain.value = 1;
        } else {
          gainInNode.gain.value = tVol;
        }
      }
    },
    getVolume: function getVolume() {
      return saveVol;
    },
    terminate: function terminate() {
      if (audioContext && audioContext.state !== "closed") {
        nextStartTime = 0;
        isRunning = false;
        audioContext.close();
      }
    },
    setBufferingFlag: function setBufferingFlag(videoTime, videoStatus) {
      if (videoStatus === "init") {
        initVideoTimeStamp = videoTime;
      } else {
        if (bufferingFlag) {
          if (videoTime === 0 || typeof videoTime === "undefined" || videoTime === null) {
            videoDiffTime = null;
          } else {
            videoDiffTime = videoTime - initVideoTimeStamp;
            initVideoTimeStamp = 0;
          }

          bufferingFlag = false;
        }
      }
    },
    getBufferingFlag: function getBufferingFlag() {
      return bufferingFlag;
    },
    setInitVideoTimeStamp: function setInitVideoTimeStamp(time) {
      initVideoTimeStamp = time;
    },
    getInitVideoTimeStamp: function getInitVideoTimeStamp() {
      return initVideoTimeStamp;
    },
    setSamplingRate: function setSamplingRate(samplingRate) {
      codecInfo.samplingRate = samplingRate;
    },
    // 纯音频播放时的暂停
    pause: function pause() {
      isStop = true;
    },
    // 接收音频播放的时间回调
    timeUpdate: function timeUpdate() {},
    setRtspOver: function setRtspOver() {
      rtspOver = true;
    },
    audioPlayBegin: function audioPlayBegin() {},
    // 音频播放开始
    audioPlayEnd: function audioPlayEnd() {} // 音频播放结束，纯音频播放的时候使用，触发下一首播放

  };
  return instance = new Constructor();
}
// CONCATENATED MODULE: ./src/talk.js
/*
    获取本地音频数据，主要是MediaDevices.getUserMedia()的使用。
    getUserMedia获取音视频接口，但是其有使用限制，目前最基础的是，如果调用该方法，浏览器会弹出是否允许网页使用麦克风，如果用户未选择
    或者，选择了不允许，则获取音视频接口失败。另外，因为基于用户隐私的保护，该接口调用必须在https下，或则127.0.0.1这种，也就认为目标是从一个安全源加载的。
    调用该接口后，浏览器会以醒目的标志提醒用户，该网页目前正在使用麦克风或摄像头等硬件。
    具体参考:https://developer.mozilla.org/zh-CN/docs/Web/API/MediaDevices/getUserMedia
 */


var talk_Talk = function Talk() {
  //var audioOutVolume = 0;
  var audioContext = null;
  var gainOutNode = null;
  var bufferSize = 4096; //大约0.085s

  var scriptNode = null;
  var localSampleRate = null;
  var isStreaming = false;
  var currentLocalStream = null; //var biquadFilter = null;

  var streamNode = null;
  var constraints = {
    audio: true,
    video: false
  }; //只请求音频数据

  var sendAudioBufferCallback = null;
  /*function cleanBuffer() {
      chunkCounter = 0;
      bufferedArray = null;
  }*/

  function Constructor() {}

  Constructor.prototype = {
    init: function init() {
      if (audioContext === undefined || audioContext === null) {
        try {
          window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext || window.oAudioContext || window.msAudioContext;
          audioContext = new AudioContext();

          audioContext.onstatechange = function () {
            debug.info('Audio Context State changed :: ' + audioContext.state);
          };
        } catch (error) {
          debug.error('Web Audio API is not supported in this web browser! : ' + error);
          return;
        }
      }
    },
    initAudioOut: function initAudioOut() {
      if (gainOutNode === null || scriptNode === null) {
        gainOutNode = audioContext.createGain(); //biquadFilter = audioContext.createBiquadFilter();

        scriptNode = audioContext.createScriptProcessor(bufferSize, 1, 1);

        scriptNode.onaudioprocess = function (e) {
          if (currentLocalStream !== null) {
            var recordChunk = e.inputBuffer.getChannelData(0);

            if (sendAudioBufferCallback !== null && isStreaming === true) {
              sendAudioBufferCallback(recordChunk);
            }
          }
        };

        gainOutNode.connect(scriptNode);
        scriptNode.connect(audioContext.destination);
        localSampleRate = audioContext.sampleRate;
        gainOutNode.gain.value = 1;
      }

      if (navigator.mediaDevices === undefined) {
        navigator.mediaDevices = {};
      }

      if (navigator.mediaDevices.getUserMedia === undefined) {
        navigator.mediaDevices.getUserMedia = function (constraints, successCallback, errorCallback) {
          var getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;

          if (!getUserMedia) {
            errorCallback();
            return Promise.reject(new Error('getUserMedia is not implemented in this browser'));
          } else {
            return new Promise(function (successCallback, errorCallback) {
              getUserMedia.call(navigator, constraints, successCallback, errorCallback);
            });
          }
        };
      }

      if (navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia(constraints).then(function (stream) {
          currentLocalStream = stream;
          streamNode = audioContext.createMediaStreamSource(stream);
          streamNode.connect(gainOutNode);
        })["catch"](function (error) {
          debug.error(error);
        });
      } else {
        debug.error('Cannot open local media stream! :: navigator.mediaDevices.getUserMedia is not defined!');
        return;
      }

      isStreaming = true;
      return localSampleRate;
    },
    controlVolumnOut: function controlVolumnOut(volumn) {
      var tVol = volumn / 20 * 2;

      if (tVol <= 0) {
        gainOutNode.gain.value = 0;
      } else {
        if (tVol >= 10) {
          gainOutNode.gain.value = 10;
        } else {
          gainOutNode.gain.value = tVol;
        }
      }
    },
    stopAudioOut: function stopAudioOut() {
      if (currentLocalStream !== null) {
        if (isStreaming) {
          try {
            var audioTracks = currentLocalStream.getAudioTracks();

            for (var i = 0, audioTracks_length = audioTracks.length; i < audioTracks_length; i++) {
              audioTracks[i].stop();
            }

            isStreaming = false;
            currentLocalStream = null;
          } catch (e) {
            debug.log(e);
          }
        }
      }
    },
    terminate: function terminate() {
      this.stopAudioOut();
      audioContext.close();
      gainOutNode = null;
      scriptNode = null;
    },
    setSendAudioTalkBufferCallback: function setSendAudioTalkBufferCallback(callbackFn) {
      sendAudioBufferCallback = callbackFn;
    }
  };
  return new Constructor();
};

/* harmony default export */ var src_talk = (talk_Talk);
// EXTERNAL MODULE: ./src/audioTalkWorker.worker.js
var audioTalkWorker_worker = __webpack_require__(50);
var audioTalkWorker_worker_default = /*#__PURE__*/__webpack_require__.n(audioTalkWorker_worker);

// CONCATENATED MODULE: ./src/workerManager.js
//分析RTP包类型 (视频，音频，辅助帧)
// 注册自定义事件
// 连接播放器和session，数据传入session处理后传递出来，workermanager进行相关处理放入播放器











var workerManager_WorkerManager = function WorkerManager() {
  var videoWorker = null;
  var audioWorker = null;
  var audioTalkWorker = null;
  var self = null;
  var videoRenderer = null;
  var audioRenderer = null;
  var audioTalker = null;
  var resizeCallback = null;
  var beginDrawCallback = null;
  var timeStampCallback = null;
  var sendAudioTalkCallback = null;
  var stepRequestCallback = null;
  var updateEventCallback = null;
  var setVideoModeCallback = null;
  var loadingBarCallback = null;
  var errorCallback = null;
  var decodeStartCallback = null;
  var updateCanvasCallback = null;
  var frameTypeChangeCallback = null;
  var MSEResolutionChangeCallback = null;
  var audioChangeCallback = null;
  var ivsCallback = null;
  var ivsDraw = null;
  var browser = BrowserDetect();
  var videoInfo = null;
  var SDPInfo = null;
  var frameRate = 0;
  var govLength = null;
  var isTalkService = false;
  var isPaused = true;
  var decodeMode = '';
  var checkDelay = true;
  var stepFlag = false;
  var canvasElem = null;
  var plabyackInterface = null;
  var playerMode = null;
  var fileMaker = null;
  var isPlaybackBackup = false;
  var isPlayback = false;
  var videoMS = null;
  var initSegmentData = null;
  var mediaSegmentData = null;
  var mediaInfo = {
    id: 1,
    samples: null,
    baseMediaDecodeTime: 0
  };
  var mediaSegmentNum = 0;
  var mediaFrameSize = 0;
  var mediaFrameData = null;
  var sequenseNum = 1;
  var codecInfo = '';
  var videoElem = null;
  var videoTimeStamp = null;
  var chromeBox = 4;
  var normalBox = 4;
  var normalNumBox = browser !== 'chrome' ? normalBox : chromeBox;
  var speed = 1;
  var numBox = normalNumBox;
  var preNumBox = numBox;
  var initSegmentFlag = false;
  var prebaseMediaDecodeTime = 0;
  var curbaseMediaDecoderTime = 0;
  var sumDuration = 0;
  var miliSecOne = 1e3;
  var audioCodec = null;
  var preVolume = 0;
  var initVideoTimeStamp = 0;
  var startTime = 0;
  var playCount = 0;
  var fpsCount = 1e3;
  var fpsSpanElement = null;
  var countSpanElement = null;
  var workerReadyCallback = null;
  var metaSession = null;
  var audioOnly = false; //是否只是纯音频播放

  var updateTimeCallback = null; // 纯音频播放的时间回调

  var channelId = 0;
  var currentProfile = {
    type: 'live',
    codec: '',
    width: 0,
    height: 0,
    isLimitSpeed: null
  };
  var LIMIT_SPEED_WIDTH = 1920;
  var LIMIT_SPEED_HEIGHT = 1080;
  var LIMIT_SPEED_2M = 1920 * 1080;
  var LIMIT_SPEED_5M = 5e3 * 1e3;
  var LIMIT_SPEED_8M = 8e3 * 1e3;
  var modeChangeFlag = false;
  var preFrameType = null;
  var preSamplingRate = null;
  var preAudioType = null;
  var lessRateCanvas = false;
  var workerReadyNum = 0; //准备就绪的worker数量

  var frameTypeList = {
    5: 'MJPEG',
    8: 'H264',
    12: 'H265'
  };
  var samplingRateList = {
    1: 4000,
    2: 8000,
    3: 11025,
    4: 16000,
    5: 20000,
    6: 22050,
    7: 32000,
    8: 44100,
    9: 48000,
    10: 96000,
    11: 128000,
    12: 192000,
    13: 64000
  };
  var lastVideoAnalysePos = {
    type: '',
    pos: []
  };

  function Constructor() {
    isPaused = true;
    self = this;
  }

  Constructor.prototype = {
    init: function init(canv, videoE, channel, isPlaybackFlag, isAudioOnly) {
      channelId = channel;
      canvasElem = canv;
      videoElem = videoE;
      self.channel = channel;
      audioOnly = isAudioOnly; //channelId = deviceInfo.channelId === null ? 0 : deviceInfo.channelId;

      var userAgent = window.navigator.userAgent; //if (userAgent.indexOf("Trident/") !== -1) {
      //    videoWorker = new Worker("./mjpegVideoWorker.js")
      //} else {
      // }

      if (!audioOnly) {
        videoWorker = new videoWorker_worker_default.a();
        videoWorker.onmessage = videoWorkerMessage;
        var bufferQueueMaxLength = isPlaybackFlag === true ? 50 : 25; //回放的缓存队列设置为500帧（回放基本不考虑延时，因此缓冲设置较大,25帧率 20s缓冲）

        videoRenderer = new streamDrawer(channelId, this, canvasElem, bufferQueueMaxLength);
        ivsDraw = ivs();
        countSpanElement = document.getElementById('count-fps');
        fpsSpanElement = document.getElementById('span-fps');
      }

      audioWorker = new audioWorker_worker_default.a();
      audioWorker.onmessage = audioWorkerMessage;
    },
    talkInit: function talkInit() {
      isTalkService = true;
      audioWorker = new audioWorker_worker_default.a();
      audioWorker.onmessage = audioWorkerMessage;
    },
    //mp4Codec是针对MP4视频新增的参数，可不传
    sendSdpInfo: function sendSdpInfo(sdpInfo, aacCodecInfo) {
      var mp4Codec = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : null;
      var message = {
        type: 'sdpInfo',
        data: {
          sdpInfo: sdpInfo,
          aacCodecInfo: aacCodecInfo,
          decodeMode: decodeMode,
          govLength: govLength,
          checkDelay: checkDelay,
          lessRateCanvas: lessRateCanvas,
          mp4Codec: mp4Codec //mp4Codec是针对MP4视频新增的参数，可不传

        }
      }; //metaDataParser = new MetaDataParser(updateEventCallback);
      //metaSession = new MetaSession(metaDataParser.parse);

      if (isTalkService) {
        audioWorker.postMessage(message); //客户端音频播放处理

        try {
          window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext || window.oAudioContext || window.msAudioContext;
          audioTalkWorker = new audioTalkWorker_worker_default.a(); //负责把传入的音频数据，编码成一定格式后，再返回出来

          audioTalkWorker.onmessage = audioTalkWorkerMessage;

          if (audioTalker === null) {
            audioTalker = new src_talk(); //负责搜集音频原始数据

            audioTalker.init();
            audioTalker.setSendAudioTalkBufferCallback(sendAudioTalkBuffer); //把收集到的原始数据，返回回来
          }

          audioTalkWorker.postMessage(message);
          var sampleRate = audioTalker.initAudioOut();
          message = {
            type: "sampleRate",
            data: sampleRate
          };
          audioTalkWorker.postMessage(message);
        } catch (error) {
          debug.error("Web Audio API is not supported in this web browser! : " + error);
          return;
        }
      } else {
        videoWorker.postMessage(message);
        audioWorker.postMessage(message);
      }

      audioCodec = null;
      initSegmentFlag = false;
      SDPInfo = sdpInfo;
    },
    parseRTPData: function parseRTPData(rtspinterleave, DHPacketArray) {
      //var mediaType = rtspinterleave[1];
      //var idx = parseInt(mediaType / 2, 10);
      //var markerBitHex = 128;
      var mediaType = DHPacketArray[4];
      var IMAGE_TYPE_FLAG = 0x80,
          ///> 图像尺寸-1字段
      PLAY_BACK_TYPE_FLAG = 0x81,
          ///> 回放类型字段
      IMAGE_H_TYPE_FLAG = 0x82,
          ///> 图像尺寸-2字段
      AUDIO_TYPE_FLAG = 0x83,
          ///> 音频格式字段
      IVS_EXPAND_FLAG = 0x84,
          ///> 智能扩展字段
      MODIFY_EXPAND_FLAG = 0x85,
          ///> 修定扩展字段
      DATA_VERIFY_DATA_FLAG = 0x88,
          ///> 数据校验字段
      DATA_ENCRYPT_FLAG = 0x89,
          ///> 数据加密字段
      FRACTION_FRAMERATE_FLAG = 0x8a,
          ///> 扩展回放类型分数帧率字段
      STREAM_ROTATION_ANGLE_FLAG = 0x8b,
          ///> 码流旋转角度字段
      AUDIO_TYPE_FLAG_EX = 0x8c,
          ///> 扩展音频格式字段
      METADATA_EXPAND_LEN_FLAG = 0x90,
          ///> 元数据子帧长度扩展字段
      IMAGE_IMPROVEMENT_FLAG = 0x91,
          ///> 图像优化字段
      STREAM_MANUFACTURER_FLAG = 0x92,
          ///> 码流厂商类型字段
      PENETRATE_FOG_FLAG = 0x93,
          ///> 偷雾模式标志字段
      SVC_FLAG = 0x94,
          ///> SVC-T可伸缩视频编解码字段
      FRAME_ENCRYPT_FLAG = 0x95,
          ///> 帧加密标志字段
      AUDIO_CHANNEL_FLAG = 0x96,
          ///> 音频通道扩展帧头标识字段
      PICTURE_REFORMATION_FLAG = 0x97,
          ///> 图像重组字段
      DATA_ALIGNMENT_FLAG = 0x98,
          ///> 数据对齐字段
      IMAGE_MOSAIC_FLAG = 0x99,
          ///> 图像拼接扩展字段
      FISH_EYE_FLAG = 0x9a,
          ///> 鱼眼功能字段
      IMAGE_WH_RATIO_FLAG = 0x9b,
          ///> 视频宽高比字段
      DIGITAL_SIGNATRUE_FLAG = 0x9c,
          ///> 数字签名字段
      ABSOLUTE_MILLISED_FLAG = 0xa0,
          ///>  绝对毫秒时间字段
      NET_TRANSPORT_FLAG = 0xa1,
          ///>  网络传输标识字段
      VEDIO_ENCRYPT_FRAME = 0xb0,
          ///> 录像加密帧字段
      OSD_STRING_FLAG = 0xb1,
          ///> 码流OSD 字段
      GOP_OFFSET_FLAG = 0xb2,
          ///> 解码偏移参考字段
      ENCYPT_CHECK_FLAG = 0xb3,
          ///> 加密密钥校验字段
      SENSOR_JOIN_FLAG = 0xb4,
          ///> 多目相机SENSOR 拼接字段
      STREAM_ENCRYPT_FLAG = 0xb5,
          ///> 码流加密字段
      EXTERNHEAD_FLAG_RESERVED = 0xff; ///> 大华扩展帧类型0xFF保留字段
      //debug.log('info: ' + info.encode_type)

      var message = {
        type: 'MediaData',
        data: {
          rtspInterleave: rtspinterleave,
          payload: DHPacketArray
        },
        info: null,
        channel: self.channel
      };
      var info = {};

      if (mediaType == 0xfd || mediaType == 0xfe || mediaType == 0xfc || mediaType == 0xfb) {
        //视频
        videoExtend(); //debug.log(DHPacketArray.subarray(0, 23))

        if (preFrameType != null) {
          if (preFrameType != info.encode_type && info.encode_type !== undefined) {
            preFrameType = info.encode_type;
            frameTypeChangeCallback(frameTypeList[info.encode_type]);
            return;
          }
        } else {
          preFrameType = info.encode_type;
        } // switch (info.encode_type + "") {
        //     case"5": //MJPEG
        //     case"8": //H264
        //     case"12":  //H265
        //debug.log(info)
        //实际上针对解码并没有用到info.encode_type，此变量只在这个页面上用了，而实际解码里用的编码模式，在sdpInfo就已经给videoWorker.js了


        if (videoWorker) {
          message.info = info;
          videoWorker.postMessage(message);
        } // break;
        //     default:
        //         debug.log('encode_type: ' + info.encode_type);
        //         break;
        // }

      } else if (mediaType == 0xf0) {
        //音频
        audioExtend();

        if (preAudioType != null) {
          if (preAudioType != info.audio_type) {
            preAudioType = info.audio_type;
            audioChangeCallback('audioType');
            return;
          }
        } else {
          preAudioType = info.audio_type;
        }

        if (preSamplingRate != null) {
          if (preSamplingRate != info.samplingRate) {
            preSamplingRate = info.samplingRate;
            audioChangeCallback('samplingRate');
            return;
          }
        } else {
          preSamplingRate = info.samplingRate;
        } //debug.log('audio_Type:  ' + info.encode_type)


        switch (info.audio_type + '') {
          case '8': //G729

          case '10': //G711U

          case '14': //G711A

          case '16': //PCM

          case '25': //G723.1

          case '26': //AAC

          case '27': //G726-40

          case '28': //G726-32

          case '29': //G726-24

          case '30': //G726-16

          case '31':
            //MP2
            if (audioWorker) {
              message.info = info;
              audioWorker.postMessage(message);
            }

            break;
        }
      } else if (mediaType == 0xf1) {
        ivsExtend();

        if (videoWorker) {
          message.info = info;
          videoWorker.postMessage(message);
        }
      } else {
        debug.log('mediaType:   ' + mediaType);
      }

      function videoExtend() {
        var len = DHPacketArray[22] + 24; //debug.log('len:  ' + len)
        // 帧序号

        info.frameIndex = (DHPacketArray[11] << 24) + (DHPacketArray[10] << 16) + (DHPacketArray[9] << 8) + DHPacketArray[8];

        for (var i = 24; i < len;) {
          if (IMAGE_TYPE_FLAG == DHPacketArray[i]) {
            if (i + 4 > len) {
              //DLOG_ERR_THIS("parseVideoInfo error len:%d\n",len);
              debug.log('i: ' + i);
              return -1;
            }

            info.width = DHPacketArray[i + 2] << 3;
            info.height = DHPacketArray[i + 3] << 3; //debug.log('0x80: ' + JSON.stringify(info))

            i += 4;
          } else if (PLAY_BACK_TYPE_FLAG == DHPacketArray[i]) {
            if (i + 4 > DHPacketArray.length) {
              //                            DLOG_ERR_THIS("parseVideoInfo error len:%d\n", len);
              debug.log('i: ' + i);
              return -1;
            }

            info.I_frame_interval = DHPacketArray[i + 1];
            info.encode_type = DHPacketArray[i + 2];
            info.frame_rate = DHPacketArray[i + 3];
            i += 4; //break;
          } else if (IMAGE_H_TYPE_FLAG == DHPacketArray[i]) {
            info.width = (DHPacketArray[i + 5] << 8) + DHPacketArray[i + 4];
            info.height = (DHPacketArray[i + 7] << 8) + DHPacketArray[i + 6]; //debug.log('0x82: ' + JSON.stringify(info))

            i += 8;
          } else if (AUDIO_TYPE_FLAG == DHPacketArray[i]) {
            i += 4;
          } else if (DATA_VERIFY_DATA_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (IVS_EXPAND_FLAG == DHPacketArray[i]) {
            if (i + 4 > len) {
              //DLOG_ERR_THIS("parseVideoInfo error len:%d\n", len);
              debug.log('i: ' + i);
              return -1;
            }

            var data_len = (DHPacketArray[i + 2] << 8) + DHPacketArray[i + 3];
            i += data_len;
          } else if (SVC_FLAG == DHPacketArray[i]) {
            // svc 层数忽略处理
            info.h264_svc_flag = true;
            info.svc = DHPacketArray[i + 2]; //debug.log('SVC_FLAG: ' + DHPacketArray[i + 1] + ' ' + DHPacketArray[i + 2])

            i += 4;
          } else if (FRACTION_FRAMERATE_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (IMAGE_IMPROVEMENT_FLAG == DHPacketArray[i]) {
            //                        if (NULL != feInfo) {
            //                            feInfo - > fix = DHPacketArray[uint32_t(i + 3)];
            //                        }
            i += 8;
          } else if (IMAGE_MOSAIC_FLAG == DHPacketArray[i]) {
            var n = DHPacketArray[i + 1];
            var m = DHPacketArray[i + 2];
            i += 8;
            i += n * m * 16;
          } else if (FISH_EYE_FLAG == DHPacketArray[i]) {
            //                        if (NULL != feInfo) {
            //                            feInfo - > revise = DHPacketArray[uint32_t(i + 1)];
            //                            feInfo - > x = (((uint32_t)DHPacketArray[uint32_t(i + 3)])<<8)+((uint32_t)DHPacketArray[uint32_t(i + 2)]);
            //                            feInfo - > y = (((uint32_t)DHPacketArray[uint32_t(i + 5)])<<8)+((uint32_t)DHPacketArray[uint32_t(i + 4)]);
            //                            feInfo - > radius = (((uint32_t)DHPacketArray[uint32_t(i + 7)])<<8)+((uint32_t)DHPacketArray[uint32_t(i + 6)]);
            //                        }
            i += 8;
          } else if (IMAGE_WH_RATIO_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (STREAM_MANUFACTURER_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (PENETRATE_FOG_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (FRAME_ENCRYPT_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (ABSOLUTE_MILLISED_FLAG <= DHPacketArray[i] && DHPacketArray[i] < VEDIO_ENCRYPT_FRAME) {
            info.timeStampmsw = (DHPacketArray[i + 3] << 8) + DHPacketArray[i + 2];
            i += 4;
          } else if (VEDIO_ENCRYPT_FRAME <= DHPacketArray[i] && DHPacketArray[i] < EXTERNHEAD_FLAG_RESERVED) {
            i += DHPacketArray[i + 1];
          } else if (MODIFY_EXPAND_FLAG == DHPacketArray[i]) {
            //修定扩展字段处理
            i += 4;
          } else if (DATA_ENCRYPT_FLAG == DHPacketArray[i]) {
            //数据加密字段处理
            i += 4;
          } else if (STREAM_ROTATION_ANGLE_FLAG == DHPacketArray[i]) {
            //码流旋转角度处理
            i += 4;
          } else if (METADATA_EXPAND_LEN_FLAG == DHPacketArray[i]) {
            //元数据子帧长度扩展字段处理
            i += 8;
          } else if (PICTURE_REFORMATION_FLAG == DHPacketArray[i]) {
            //图像重组字段处理
            var n = DHPacketArray[i + 1];
            i += 8;
            i += n * 16;
          } else if (DATA_ALIGNMENT_FLAG == DHPacketArray[i]) {
            //数据对齐字段处理
            i += 4;
          } else if (DIGITAL_SIGNATRUE_FLAG == DHPacketArray[i]) {
            //数字签名字段处理,已经考虑小端字节序
            var len = (DHPacketArray[i + 5] << 8) + DHPacketArray[i + 4];
            i += 8;
            i += len;
          } else {
            debug.log('parseVideoInfo error ext_type:0x' + DHPacketArray[i]);
            debug.log('i: ' + i);
            return -1;
          }
        }
      }

      function audioExtend() {
        info.ChannelCount = 0;
        var len = DHPacketArray[22] + 24; ///>加了一层循环先遍历0x96，确认编码信息的对应通道号

        for (var i = 24; i < len;) {
          // 扩展类型不做实际处理
          if (IMAGE_TYPE_FLAG == DHPacketArray[i]) {
            i += 4;
          } else if (PLAY_BACK_TYPE_FLAG == DHPacketArray[i]) {
            i += 4;
          } else if (IMAGE_H_TYPE_FLAG == DHPacketArray[i]) {
            i += 8;
          } else if (AUDIO_TYPE_FLAG == DHPacketArray[i]) {
            //                            if( i+4+(int)sizeof(DHFrameHead) > len )
            //                            {
            //                                DLOG_ERR_THIS("parseAudioInfo error len:%d\n", len);
            //                                return -1;
            //                            }
            i += 4;
          } //新增扩展音频格式，g722.1需要解析该字段码率，目前只识别不解析
          else if (AUDIO_TYPE_FLAG_EX == DHPacketArray[i]) {
              i += DHPacketArray[i + 1];
            } else if (DATA_VERIFY_DATA_FLAG == DHPacketArray[i]) {
              i += 8;
            } else if (IVS_EXPAND_FLAG == DHPacketArray[i]) {
              //                            if( i+4+(int)sizeof(DHFrameHead) > len )
              //                            {
              //                                DLOG_ERR_THIS("parseAudioInfo error len:%d\n" , len);
              //                                return -1;
              //                            }
              var data_len = DHPacketArray[i + 2] << 8 + DHPacketArray[i + 3];
              i += data_len;
            } else if (AUDIO_CHANNEL_FLAG == DHPacketArray[i]) {
              ///> 获得音频通道数目[i+1] 和该音频帧属于哪个使能音频通道[i+2]
              ///>双音频设备，只要有一个音频通道使能，音频帧获取到的ChannelCount都是2, 这样是通道数是不准确的
              ///>在这种情况下，ChannelCount只遵循配置中的size值，而不使用0x96中解析获得的ChannelCount
              info.ChannelCount = DHPacketArray[i + 1];
              info.channel = DHPacketArray[i + 2]; //                            if( channel >= MaxAudioChanelCount )
              //                            {
              //                                DLOG_ERR_THIS("parseAudioInfo error channel:%d\n" , channel);
              //                                return -1;
              //                            }
              ///>因为帧解析时，数组audioChannelEncodeInfo下标[i]并不能从外部得到，
              //                            ///>所以需要注意，此时的数组下标[i]和audioChannelNO值是一样，使用时注意区分
              //                            info.audioChannelEncodeInfo[channel].audioChannelNO = channel;

              i += 4; //break;
            } else if (FRAME_ENCRYPT_FLAG == DHPacketArray[i]) {
              i += 8;
            } else if (ABSOLUTE_MILLISED_FLAG == DHPacketArray[i]) {
              info.timeStampmsw = (DHPacketArray[i + 3] << 8) + DHPacketArray[i + 2];
              i += 4;
            } else {
              debug.log('parseAudioInfo error ext_type:0x' + DHPacketArray[i]);
              debug.log('i: ' + i);
              return -1;
            }
        } // 没有找到0x96 扩展字段,则认为只有单音频


        if (info.ChannelCount == 0) {
          info.ChannelCount = 1;
          info.channel = 0;
        }

        var count = 0; // 获得音频编码信息

        var len = DHPacketArray[22] + 24; ///>加了一层循环先遍历0x96，确认编码信息的对应通道号

        for (var i = 24; i < len;) {
          if (DHPacketArray[i] == IMAGE_TYPE_FLAG) {
            i += 4;
          } else if (DHPacketArray[i] == PLAY_BACK_TYPE_FLAG) {
            i += 4;
          } else if (DHPacketArray[i] == IMAGE_H_TYPE_FLAG) {
            i += 8;
          } else if (DHPacketArray[i] == AUDIO_TYPE_FLAG) {
            //                            if( i+4+(int)sizeof(DHFrameHead) > len )
            //                            {
            //                                DLOG_ERR_THIS("parseAudioInfo error len:%d\n", len);
            //                                return -1;
            //                            }
            info.audio_type = DHPacketArray[i + 2];
            info.samplingRate = samplingRateList[DHPacketArray[i + 3]];
            i += 4;
          } else if (DHPacketArray[i] == AUDIO_TYPE_FLAG_EX) {
            // 新增扩展音频格式,  暂未用到码率信息, 先不解析
            //info.encode_type = DHPacketArray[(i+3)];
            //info.frequency = 8000;
            i += DHPacketArray[i + 1];
          } else if (DHPacketArray[i] == DATA_VERIFY_DATA_FLAG) {
            i += 8;
          } else if (DHPacketArray[i] == IVS_EXPAND_FLAG) {
            var data_len = DHPacketArray[i + 2] << 8 + DHPacketArray[i + 3];
            i += data_len;
          } else if (DHPacketArray[i] == AUDIO_CHANNEL_FLAG) {
            i += 4; // break;
          } else if (DHPacketArray[i] == FRAME_ENCRYPT_FLAG) {
            i += 8;
          } else if (ABSOLUTE_MILLISED_FLAG == DHPacketArray[i]) {
            i += 4;
          } else if (DATA_ALIGNMENT_FLAG == DHPacketArray[i]) {
            //数据对齐字段处理
            i += 4;
          } else {
            debug.log('parseAudioInfo error ext_type:0x' + DHPacketArray[i]);
            debug.log('i: ' + i);
            return -1;
          }
        }
      }

      function ivsExtend() {//该方法用于取智能帧中的绝对毫秒时间戳，因为用不到所以现行注释
        //部分设备在聚焦缩放时，浏览器会死掉，查询是该处死循环，web用了变长的位数长度去获取，但实际智能帧08x开头的长度均为固定8位
        //同时，因为设备打的智能帧0x84，有效长度为0，也就是data_len = 0，导致 i += data_len，没有自增，死循环，
        //此处也可以直接跳过8位即可，即i = i + 8;
        // var len = DHPacketArray[22] + 24;
        // for (var i = 24; i < len; ) {
        //     if (ABSOLUTE_MILLISED_FLAG <= DHPacketArray[i] && DHPacketArray[i] < VEDIO_ENCRYPT_FRAME) {
        //         info.timeStampmsw = (DHPacketArray[i + 3] << 8) + DHPacketArray[i + 2];
        //         i += 4;
        //     }else if (IVS_EXPAND_FLAG == DHPacketArray[i]) {
        //         if (i + 4 > len)
        //         {
        //             //DLOG_ERR_THIS("parseVideoInfo error len:%d\n", len);
        //             debug.log('i: ' + i);
        //             return -1;
        //         }
        //         debug.log('智能扩展')
        //         var data_len = ((DHPacketArray[i + 2])<<8)+(DHPacketArray[i + 3]);
        //         i += data_len;
        //     }else {
        //         i++;
        //     }
        // }
      }
    },
    setCallback: function setCallback(type, func) {
      switch (type) {
        case 'timeStamp':
          timeStampCallback = func;
          break;

        case 'ResolutionChanged':
          resizeCallback = func;

          if (videoRenderer !== null) {
            videoRenderer.setResizeCallback(resizeCallback);
          }

          break;

        case 'audioTalk':
          sendAudioTalkCallback = func;
          break;

        case 'stepRequest':
          stepRequestCallback = func;
          break;

        case 'metaEvent':
          updateEventCallback = func;
          break;

        case 'videoMode':
          setVideoModeCallback = func;
          break;

        case 'loadingBar':
          loadingBarCallback = func;
          break;

        case 'Error':
          errorCallback = func;
          break;

        case 'PlayStart':
          beginDrawCallback = func;

          if (videoRenderer !== null) {
            videoRenderer.setBeginDrawCallback(beginDrawCallback);
          }

          break;

        case 'DecodeStart':
          decodeStartCallback = func;
          break;

        case 'UpdateCanvas':
          updateCanvasCallback = func;

          if (videoRenderer !== null) {
            videoRenderer.setupdateCanvasCallback(updateCanvasCallback);
          }

          break;

        case 'FrameTypeChange':
          frameTypeChangeCallback = func;
          break;

        case 'MSEResolutionChanged':
          MSEResolutionChangeCallback = func;
          break;

        case 'audioChange':
          audioChangeCallback = func;
          break;

        case 'WorkerReady':
          workerReadyCallback = func;
          break;

        case 'IvsDraw':
          ivsCallback = func;
          break;

        case 'FileOver':
          //文件结束事件
          this.fileOverCallback = func;
          break;

        case 'Waiting':
          this.waitingCallback = func;
          break;

        case 'UpdateTime':
          updateTimeCallback = func;
          break;

        default:
          debug.log(type);
          debug.log('workerManager::setCallback() : type is unknown');
          break;
      }
    },
    capture: function capture(filename, options) {
      if (decodeMode === 'canvas') {
        videoRenderer.capture(filename, options);
      } else if (decodeMode === 'video') {
        videoMS.capture(filename, options);
      }
    },
    getCapture: function getCapture(filename, type, quality) {
      if (decodeMode === 'video') {
        return videoMS.getCapture(filename, type, quality);
      } else {
        return videoRenderer.getCapture(filename, type, quality);
      }
    },
    setDeviceInfo: function setDeviceInfo(deviceInfo) {
      playerMode = deviceInfo.mode;
    },
    setFPS: function setFPS(fps) {
      var defaultFPS = 30;
      frameRate = fps === 0 ? defaultFPS : fps;

      _initVideo(speed !== 1);
    },
    setGovLength: function setGovLength(gov) {
      govLength = gov;
    },
    setLiveMode: function setLiveMode(mode) {
      if (setVideoModeCallback !== null) {
        setVideoModeCallback(mode);
      }

      decodeMode = mode === null ? 'canvas' : mode; //canvasElem = $('canvas[kind-channel-id="' + channelId + '"]')[0];
      //videoElem = $('video[kind-channel-id="' + channelId + '"]')[0];

      if (decodeMode === 'video') {
        //$(canvasElem).addClass("video-display-none");
        if (videoRenderer !== null) {
          videoRenderer.renewCanvas();
        }
      } else if (decodeMode === 'canvas') {
        //$(videoElem).parent().addClass("video-display-none");
        _initVideo(false);
      }
    },
    setPlayMode: function setPlayMode(mode) {
      isPlayback = mode;
    },
    controlAudio: function controlAudio(cmd, data) {
      debug.log(cmd + ' ' + data);

      switch (cmd) {
        case 'audioPlay':
          {
            if (data === 'start') {
              if (audioRenderer !== null) {
                audioRenderer.play();
              }
            } else if (data === 'stop') {
              preVolume = 0;

              if (audioRenderer !== null) {
                audioRenderer.stop();
              }
            } else {
              if (audioRenderer !== null) {
                audioRenderer.pause();
              }
            }
          }
          break;

        case 'volumn':
          {
            //AAC音量0-1
            preVolume = data;

            if (audioRenderer !== null) {
              audioRenderer.controlVolumn(data, true);
              console.log('audioRenderer', audioRenderer.getVolume());
            }
          }
          break;

        case 'audioSamplingRate':
          if (audioRenderer !== null) {
            audioRenderer.setSamplingRate(data);
          }

          break;
      }
    },
    controlAudioTalk: function controlAudioTalk(cmd, data) {
      if (audioTalker !== null) {
        switch (cmd) {
          case 'onOff':
            {
              if (data === 'on') {} else {
                audioTalker.stopAudioOut();
              }
            }
            break;

          case 'volumn':
            {
              audioTalker.controlVolumnOut(data);
            }
            break;
        }
      }
    },
    reassignCanvas: function reassignCanvas() {
      if (videoRenderer !== null) {
        videoRenderer.reassignCanvas();
      }
    },
    digitalZoom: function digitalZoom(zoomData) {
      if (videoRenderer !== null) {
        videoRenderer.digitalZoom(zoomData);
      }
    },
    playbackSpeed: function playbackSpeed(info) {
      speed = info; //if (videoMS !== null) {
      //    var arg = speed !== 1;
      //    videoMS.setSpeedPlay(speed);
      //    initVideo(arg)
      //}
      //var dropout = 1;
      //if (speed >= 4 || speed <= -4) {
      //    dropout = 2
      //}
      //if (videoWorker !== null) {
      //    videoWorker.postMessage({type: "setDropout", data: dropout})
      //}

      videoRenderer.setFrameInterval(speed);
    },
    timeStamp: function timeStamp(time) {
      //if (timeStampCallback && time !== null) {
      //    timeStampCallback(time, isPaused)
      //}
      //debug.log('time: ' + JSON.stringify(time))
      updateCanvasCallback && updateCanvasCallback(time); //回放抛出时间值
    },
    initVideo: function initVideo(speedMode) {
      _initVideo(speedMode);
    },
    setFpsFrame: function setFpsFrame(num) {
      fpsCount = num;
      playCount = 0;
      startTime = 0;
    },
    setCheckDelay: function setCheckDelay(delay) {
      checkDelay = delay;
    },
    initStartTime: function initStartTime() {
      var message = {
        type: 'initStartTime'
      };

      if (!audioOnly) {
        videoWorker.postMessage(message);
        videoRenderer.stopRendering();
        videoRenderer.startRendering();
      }
    },
    terminate: function terminate() {
      if (playerMode !== 'backup') {
        if (videoWorker) {
          videoWorker.terminate();
          videoWorker = null;
        }

        if (audioWorker) {
          audioWorker.terminate();
          audioWorker = null;
        }
      }

      if (audioTalkWorker) {
        audioTalkWorker.terminate();
      }

      if (audioTalker) {
        audioTalker.terminate();
        audioTalker = null;
      }

      if (videoRenderer) {
        videoRenderer.terminate();
      }

      if (audioRenderer) {
        audioRenderer.terminate();
      }

      if (videoMS) {
        videoMS.terminate();
      }

      if (workerReadyCallback) {
        workerReadyCallback = null;
      }

      videoRenderer = null;
      isPaused = true;
    },
    postRtspOver: function postRtspOver() {
      //rtsp信令结束
      if (videoWorker) {
        videoWorker.postMessage({
          type: "end"
        });
      }

      if (audioRenderer) {
        audioRenderer.setRtspOver();
      }
    },
    pause: function pause() {
      //暂停视频
      if (videoMS) {
        videoMS.pause();
      }

      if (videoWorker) {
        videoRenderer.pause();
      }
    },
    play: function play() {
      //继续视频
      if (videoMS) {
        videoMS.play();
      }

      if (videoWorker) {
        videoRenderer.play();
      }
    },
    setLessRate: function setLessRate(state) {
      lessRateCanvas = state;
    },

    /**
     * 播放下一帧
     */
    playNextFrame: function playNextFrame() {
      if (videoMS) {
        videoMS.playNextFrame();
        return;
      }

      if (videoWorker) {
        videoRenderer.playNextFrame();
      }
    },

    /**
     * 获取缓存中的帧数
     */
    getVideoBufferQueueSize: function getVideoBufferQueueSize() {
      if (videoMS) {
        return videoMS.getVideoBufferQueueSize();
      }

      if (videoWorker) {
        return videoRenderer.getVideoBufferQueueSize();
      }
    },

    /**
     * 获取当前播放的帧信息
     */
    getCurFrameInfo: function getCurFrameInfo() {
      if (videoMS) {
        return videoMS.getCurFrameInfo();
      }

      if (videoWorker) {
        return videoRenderer.getCurFrameInfo();
      }
    },

    /**
     * 通过此函数直接把websocket接收到的aac裸数据发给audioWorker
     * @param {arrayBuffer} message aac的音频二进制数据
     */
    sendBufferToAudioWorker: function sendBufferToAudioWorker(message) {
      message = {
        type: "message",
        data: {
          codec: "AAC",
          data: message,
          type: "render"
        }
      };
      audioWorkerMessage(message);
    }
  };

  function GetInitializationSegment() {
    return initSegmentData;
  }

  function videoSizeCallback() {
    //$(window).trigger("resize");
    if (loadingBarCallback !== null) {
      loadingBarCallback(false);
    }
  }

  var limitSpeedMessage = {
    errorCode: '103',
    description: 'limit speed',
    isLimit: {}
  };

  function markLimitSpeed(supportX2, supportX4, supportX8) {
    limitSpeedMessage.isLimit.X2 = !supportX2;
    limitSpeedMessage.isLimit.X4 = !supportX4;
    limitSpeedMessage.isLimit.X8 = !supportX8;
  }

  function checkValidSpeed(frameInfo) {
    if (currentProfile.type !== 'playback') {
      return;
    }

    if (frameInfo.codecType !== 'mjpeg') {
      markLimitSpeed(true, true, true);

      if (currentProfile.isLimitSpeed === null || currentProfile.isLimitSpeed === true) {
        currentProfile.isLimitSpeed = false;
        errorCallback(limitSpeedMessage);
      }
    }

    if (typeof frameInfo.codecType === 'undefined' || typeof frameInfo.width === 'undefined') {
      return;
    }

    if (currentProfile.codec === frameInfo.codecType && currentProfile.width === frameInfo.width && currentProfile.height === frameInfo.height) {
      return;
    }

    if (frameInfo.codecType === 'mjpeg' && frameInfo.width * frameInfo.height > LIMIT_SPEED_2M) {
      if (frameInfo.width * frameInfo.height <= LIMIT_SPEED_5M) {
        markLimitSpeed(true, true, false);
      } else if (frameInfo.width * frameInfo.height > LIMIT_SPEED_5M && frameInfo.width * frameInfo.height < LIMIT_SPEED_8M) {
        markLimitSpeed(true, false, false);
      } else if (frameInfo.width * frameInfo.height >= LIMIT_SPEED_8M) {
        markLimitSpeed(false, false, false);
      }

      if (currentProfile.isLimitSpeed === null || currentProfile.isLimitSpeed === false) {
        currentProfile.isLimitSpeed = true;
        errorCallback(limitSpeedMessage);
      }
    } else {
      markLimitSpeed(true, true, true);

      if (currentProfile.isLimitSpeed === null || currentProfile.isLimitSpeed === true) {
        currentProfile.isLimitSpeed = false;
        errorCallback(limitSpeedMessage);
      }
    }

    currentProfile.codec = frameInfo.codecType;
    currentProfile.width = frameInfo.width;
    currentProfile.height = frameInfo.height;
  }

  function videoWorkerMessage(event) {
    var videoMessage = event.data;
    var canvas;
    var context; //canvas = document.getElementById('draw');
    //context = canvas.getContext('2d');

    switch (videoMessage.type) {
      case "WorkerReady":
        if (++workerReadyNum >= 2 && workerReadyCallback) {
          workerReadyCallback();
        }

        break;

      case 'canvasRender':
        audioStart(0, 'currentTime');
        draw(videoMessage.data, videoMessage.option);
        playCount++;
        break;

      case 'initSegment':
        initSegmentData = videoMessage.data;
        createVideoMS();
        break;

      case 'mediaSample':
        if (mediaInfo.samples === null) {
          mediaInfo.samples = new Array(numBox);
        }

        if (videoMessage.data.frame_time_stamp === null) {
          videoMessage.data.frameDuration = Math.round(miliSecOne / frameRate);
        }

        if (speed !== 1) {
          videoMessage.data.frameDuration = miliSecOne / Math.abs(speed);
        }

        mediaInfo.samples[mediaSegmentNum++] = videoMessage.data;
        curbaseMediaDecoderTime += videoMessage.data.frameDuration;
        sumDuration += videoMessage.data.frameDuration; // if (mediaInfo.samples[0].frameDuration > 5e2 && mediaInfo.samples[0].frameDuration <= 3e3) {
        //     numBox = 1
        // } else {
        //     numBox = speed === 1 ? normalNumBox : Math.abs(speed)
        // }
        // if (preNumBox !== numBox) {
        //     initVideo(speed !== 1)
        // }

        preNumBox = numBox;
        break;

      case 'videoRender':
        var tempBuffer = new Uint8Array(videoMessage.data.length + mediaFrameSize);

        if (mediaFrameSize !== 0) {
          tempBuffer.set(mediaFrameData);
        }

        tempBuffer.set(videoMessage.data, mediaFrameSize);
        mediaFrameData = tempBuffer;
        mediaFrameSize = mediaFrameData.length;

        if (mediaSegmentNum % numBox === 0 && mediaSegmentNum !== 0) {
          if (mediaInfo.samples[0].frameDuration !== null) {
            if (sequenseNum === 1) {
              mediaInfo.baseMediaDecodeTime = 0;
            } else {
              mediaInfo.baseMediaDecodeTime = prebaseMediaDecodeTime;
            }

            prebaseMediaDecodeTime = curbaseMediaDecoderTime;
          } else {
            mediaInfo.baseMediaDecodeTime = Math.round(miliSecOne / frameRate) * numBox * (sequenseNum - 1);
          }

          if (browser == 'chrome' && speed === 1) {
            var boxlength = mediaInfo.samples.length;
            var avgDuration = sumDuration / numBox;

            for (var i = 0; i < boxlength; i++) {
              mediaInfo.samples[i].frameDuration = avgDuration;
            }
          }

          sumDuration = 0;
          mediaSegmentData = mp4remux.mediaSegment(sequenseNum, mediaInfo, mediaFrameData, mediaInfo.baseMediaDecodeTime);
          sequenseNum++;
          mediaSegmentNum = 0;
          mediaFrameData = null;
          mediaFrameSize = 0;

          if (videoMS !== null) {
            videoMS.setMediaSegment(mediaSegmentData, videoInfo.frameIndex);
          } else if (initSegmentFlag === false) {
            debug.log('workerManager::videoMS error!! recreate videoMS');
            createVideoMS();
          }

          if (videoRenderer !== null) {
            videoRenderer.stopRendering();
          }
        }

        break;

      case 'mediasegmentData':
        videoMS.setMediaSegment(videoMessage.data);

        if (initSegmentFlag === false) {
          debug.log('videoMS error!! recreate videoMS');
          createVideoMS();
        }

        break;

      case 'videoInfo':
        videoInfo = videoMessage.data;

        if (startTime === 0) {
          startTime = performance.now();

          if (decodeMode === 'canvas') {
            //canvas下前面几帧容易被丢弃，故解析的第一帧，无论是否成像，都触发回调
            updateCanvasCallback(videoInfo.timeStamp);
          }
        } //checkValidSpeed(videoInfo);


        break;

      case 'time':
        break;

      case 'videoTimeStamp':
        videoTimeStamp = videoMessage.data;

        if (videoMS !== null && videoTimeStamp !== null) {
          videoMS.setvideoTimeStamp(videoTimeStamp);
        }

        break;

      case 'firstFrame':
        if (videoRenderer) {
          videoRenderer.startRendering();

          if (typeof videoRenderer.setFPS !== 'undefined') {
            videoRenderer.setFPS(frameRate);
          }
        }

        break;

      case 'drop':
        break;

      case 'codecInfo':
        codecInfo = videoMessage.data;

        if (videoMS !== null) {
          videoMS.setCodecInfo(codecInfo);
        }

        break;

      case 'stepPlay':
        {
          switch (videoMessage.data) {
            case 'needBuffering':
              stepFlag = true;
              stepRequestCallback('request', plabyackInterface);
              break;

            case 'BufferFull':
              stepFlag = false;
              stepRequestCallback('complete');

              if (modeChangeFlag) {
                var message = {
                  type: 'stepPlay',
                  data: 'findIFrame'
                };
                videoWorker.postMessage(message);
                videoRenderer.startRendering();
                modeChangeFlag = false;
              }

              break;
          }

          break;
        }

      case 'setVideoTagMode':
        Constructor.prototype.setLiveMode(videoMessage.data);
        break;

      case 'playbackFlag':
        if (videoMessage.data === true) {
          currentProfile.type = 'playback';
        } else {
          currentProfile.type = 'live';
        }

        if (videoMS !== null) {
          videoMS.setPlaybackFlag(videoMessage.data);
        }

        break;

      case 'error':
        if (errorCallback !== null) {
          errorCallback(videoMessage.data);
        }

        break;

      case 'MSEResolutionChanged':
        //var width = videoMessage.data.width - 0;
        //var height = videoMessage.data.height - 0;
        //canvasElem.setAttribute('width', width);
        //canvasElem.setAttribute('height', height);
        MSEResolutionChangeCallback(videoMessage.data);
        break;

      case 'DecodeStart':
        var width = videoMessage.data.width - 0;
        var height = videoMessage.data.height - 0;
        canvasElem.setAttribute('width', width);
        canvasElem.setAttribute('height', height);
        Constructor.prototype.setLiveMode(videoMessage.data.decodeMode);
        decodeStartCallback(videoMessage.data);
        break;

      case 'ivsDraw':
        var data = videoMessage.data.ivsDraw;
        var channel = videoMessage.data.channel; //var timeStamp = videoMessage.data.timeStamp.timestamp * 1000 + videoMessage.data.timeStamp.timestamp_usec;

        if (decodeMode === 'canvas' && (videoInfo === undefined || videoInfo === null)) {
          break;
        }

        if (decodeMode !== 'canvas' && (videoTimeStamp === undefined || videoTimeStamp === null)) {
          break;
        }

        var timeData = decodeMode === 'canvas' ? videoInfo.timeStamp : videoTimeStamp;
        timeData = timeData.timestamp * 1000 + timeData.timestamp_usec; //video模式播放时间为时间戳减去延时

        var videoTime = decodeMode === 'canvas' ? timeData : timeData - parseInt(videoMS.getDuration() * 1000);

        if (ivsCallback !== null) {
          ivsDraw.setCallback(ivsCallback); //相对时间戳不准确，故以当前视频时间戳为IVS的时间戳(有的设备不会一直发辅助帧)

          ivsDraw.draw(data, videoTime, timeData, channel);
        }

        break;

      case 'end':
        if (videoMS) {
          videoMS.setRtspOver();
        }

        if (videoRenderer) {
          videoRenderer.setRtspOver();
        }

        break;

      default:
        debug.log('workerManager::videoWorker unknown data = ' + videoMessage.data);
        break;
    }
  }

  function audioWorkerMessage(event) {
    var message = event.data;

    switch (message.type) {
      case 'WorkerReady':
        if (++workerReadyNum >= 2 && workerReadyCallback) {
          workerReadyCallback();
        }

        break;

      case 'render':
        if (isPlaybackBackup === true) {
          break;
        }

        if (audioCodec !== message.codec) {
          if (audioRenderer !== null) {
            console.log('audioRenderer.getVolume', audioRenderer.getVolume());
            preVolume = audioRenderer.getVolume();
            initVideoTimeStamp = audioRenderer.getInitVideoTimeStamp();
            audioRenderer.terminate();
          }

          if (message.audio_type === 31 && browser === 'edge') {
            audioRenderer = null;

            if (errorCallback !== null) {
              errorCallback({
                errorCode: 201
              });
            }
          } else {
            audioRenderer = new AudioPlayer();
            audioRenderer.setSamplingRate(message.samplingRate);
          }

          if (audioRenderer !== null) {
            audioRenderer.setInitVideoTimeStamp(initVideoTimeStamp);

            if (isTalkService === true) {
              preVolume = 1;
            }

            if (!audioRenderer.audioInit(preVolume)) {
              audioRenderer = null;
            }
          }

          audioCodec = message.codec;
        }

        if (audioRenderer !== null) {
          if (isTalkService === true) {
            audioRenderer.setBufferingFlag();
          }

          if (videoInfo === null || typeof videoInfo === 'undefined') {
            audioRenderer.bufferAudio(message.data, message.rtpTimeStamp, null);
          } else {
            audioRenderer.bufferAudio(message.data, message.rtpTimeStamp, videoInfo.codecType);
          }
        }

        break;
    }
  }

  function audioTalkWorkerMessage(event) {
    var message = event.data;

    switch (message.type) {
      case 'rtpData':
        sendAudioTalkCallback(message.data);
        break;
    }
  }

  function sendAudioTalkBuffer(buffer) {
    var message = {
      type: 'getRtpData',
      data: buffer
    };
    audioTalkWorker.postMessage(message);
  }

  function _initVideo(speedMode) {
    if (videoMS !== null) {
      videoMS.close();
      videoMS = null;
    }

    numBox = speedMode === false ? normalNumBox : Math.abs(speed);
    mediaInfo.samples = new Array(numBox);
    initSegmentFlag = false;
    sequenseNum = 1;
    mediaSegmentData = null;
    mediaSegmentNum = 0;
    mediaFrameData = null;
    mediaFrameSize = 0;
  }

  function draw(frameData, option) {
    if (frameData !== null && videoRenderer !== null) {
      if (videoInfo.codecType === 'mjpeg') {
        videoRenderer.drawMJPEG(frameData, videoInfo.width, videoInfo.height, videoInfo.codecType, videoInfo.frameType, videoInfo.timeStamp, videoInfo.frameIndex, option);
      } else {
        videoRenderer.draw(frameData, videoInfo.width, videoInfo.height, videoInfo.codecType, videoInfo.frameType, videoInfo.timeStamp, videoInfo.frameIndex, option);
      }
    }
  }

  function checkChangeMode() {
    if (decodeMode !== 'canvas') {
      Constructor.prototype.setLiveMode('canvas');
      modeChangeFlag = true;
    }
  }

  function createVideoMS() {
    initSegmentFlag = true;

    if (videoMS === null) {
      videoMS = videoMediaSource(self);
      videoMS.setCodecInfo(codecInfo);
      videoMS.setInitSegmentFunc(GetInitializationSegment);
      videoMS.setVideoSizeCallback(videoSizeCallback);
      videoMS.setBeginDrawCallback(beginDrawCallback);
      videoMS.init(videoElem);
      videoMS.setErrorCallback(errorCallback);
      videoMS.setSpeedPlay(speed);
      videoMS.setPlaybackFlag(isPlayback);
      videoMS.setFPS(frameRate);
    } else {
      videoMS.getVideoElement();
      videoMS.setInitSegment();
    }

    videoMS.setAudioStartCallback(audioStart);
  }

  function audioStart(videoTime, timeStatus) {
    if (audioRenderer !== null) {
      audioRenderer.setBufferingFlag(videoTime, timeStatus);
    }
  }

  return new Constructor();
};

/* harmony default export */ var src_workerManager = (workerManager_WorkerManager);
// EXTERNAL MODULE: ./src/videoWorkerTrain.worker.js
var videoWorkerTrain_worker = __webpack_require__(51);
var videoWorkerTrain_worker_default = /*#__PURE__*/__webpack_require__.n(videoWorkerTrain_worker);

// CONCATENATED MODULE: ./src/workerManagerTrain.js
//分析RTP包类型 (视频，音频，辅助帧)
// 注册自定义事件
// 连接播放器和session，数据传入session处理后传递出来，workermanager进行相关处理放入播放器




var workerManagerTrain_WorkerManagerTrain = function WorkerManagerTrain() {
  var videoWorker = null;
  var channelId = null;
  var canvasElem = null;
  var workerReadyCallback = null;
  var drawer = null;
  var isFirstFrame = true;
  var firstFrameTime = 0;
  var secondMap = new Map(); // 以秒为key的map

  var frameMap = new Map(); // 以帧为key的map

  var isPaused = true;
  var self = this;
  var videoWorkerTrain = null;

  function Constructor() {}

  Constructor.prototype = {
    init: function init(canv, channel) {
      channelId = channel;
      canvasElem = canv;
      self.channel = channel;
      videoWorkerTrain = new videoWorkerTrain_worker_default.a(); // videoWorkerTrain = new Worker("./videoWorkerTrain.js");
      //console.log('videoWorkerTrain: ', videoWorkerTrain);

      videoWorkerTrain.onmessage = videoWorkerMessage;
    },
    parseRTPData: function parseRTPData(rtspinterleave, DHPacketArray) {
      if (isFirstFrame === true) {
        firstFrameTime = (DHPacketArray[19] << 24) + (DHPacketArray[18] << 16) + (DHPacketArray[17] << 8) + DHPacketArray[16] >>> 0;
        firstFrameTime = getDateByStream(firstFrameTime).getTime();
      }

      isFirstFrame = false;
      var mediaType = DHPacketArray[4];
      var message = {
        type: "MediaData",
        data: {
          rtspInterleave: rtspinterleave,
          payload: DHPacketArray
        },
        info: null,
        channel: self.channel
      };
      var info = {};

      if (mediaType == 0xfd || mediaType == 0xfe || mediaType == 0xfc || mediaType == 0xfb) {
        //视频
        videoWorkerTrain.postMessage(message);
      }
    },
    setCallback: function setCallback(type, func) {
      switch (type) {
        case "WorkerReady":
          workerReadyCallback = func;
          break;

        case 'FileOver':
          //文件结束事件
          this.fileOverCallback = func;
          break;

        default:
          debug.log(type);
          debug.log("workerManager::setCallback() : type is unknown");
          break;
      }
    },
    terminate: function terminate() {
      if (videoWorkerTrain) {
        videoWorkerTrain.terminate();
        videoWorkerTrain = null;
      }

      if (secondMap) {
        secondMap = null;
      }

      if (frameMap) {
        frameMap = null;
      }
    },
    play: function play() {},
    initStartTime: function initStartTime() {},
    pause: function pause() {},
    setLiveMode: function setLiveMode() {},
    setPlayMode: function setPlayMode() {},
    setFPS: function setFPS() {},
    sendSdpInfo: function sendSdpInfo() {},
    postRtspOver: function postRtspOver() {},
    gotoSecond: function gotoSecond(seek, duration) {
      seek = seek < 0 ? 0 : seek;
      seek = seek > duration ? duration : seek; //console.log('gotoSecond',secondMap)

      if (secondMap.has(seek) === true) {
        var data = secondMap.get(seek);
        drawer.drawCanvas(data.frameData, data.option);
        var pngData = canvasElem.toDataURL();
        var dataRs = {
          'pngData': pngData,
          'option': data.option
        };
        return dataRs;
      } else {
        return false;
      }
    },
    gotoFrame: function gotoFrame(frameIndex) {
      if (frameMap.has(frameIndex) === true) {
        var data = frameMap.get(frameIndex);
        drawer.drawCanvas(data.frameData, data.option);
        var pngData = canvasElem.toDataURL();
        var dataRs = {
          'pngData': pngData,
          'option': data.option
        };
        return dataRs;
      } else {
        return false;
      }
    },
    checkLeftSize: function checkLeftSize(seek, dir, duration, num) {
      var rs = false;

      if (dir === 'next') {
        for (var i = 1; i <= num; i++) {
          var seekNum = seek + i > duration ? duration : seek + i;
          rs = secondMap.has(seekNum);

          if (rs === false) {
            break;
          }
        }
      } else if (dir === 'pre') {
        for (var i = 1; i <= num; i++) {
          var seekNum = seek - i < 1 ? 1 : seek - i;
          rs = secondMap.has(seekNum);

          if (rs === false) {
            break;
          }
        }
      }

      return rs;
    },
    clearMap: function clearMap() {
      secondMap.clear();
      frameMap.clear();
    }
  };

  function videoWorkerMessage(event) {
    var videoMessage = event.data; //canvas = document.getElementById('draw');
    //context = canvas.getContext('2d');

    switch (videoMessage.type) {
      case "WorkerReady":
        workerReadyCallback && workerReadyCallback();
        break;

      case "canvasRender":
        sendIntoMap(videoMessage.data, videoMessage.option);
        break;

      default:
        debug.log("workerManager::videoWorker unknown data = " + videoMessage.data);
        break;
    }
  }

  function getDateByStream(time) {
    var year = (time >> 26) + 2000;
    var month = time >> 22 & 0x0f;
    var day = time >> 17 & 0x1f;
    var hour = time >> 12 & 0x1f;
    var min = time >> 6 & 0x3f;
    var sec = time & 0x3f;
    var date = new Date();
    date.setFullYear(year, month - 1, day);
    date.setHours(hour, min, sec, 0); //console.log(year + '/' + month + '/' + day + ' ' + hour + ':' + min + ':' + sec);

    return date;
  }

  function sendIntoMap(frameData, option) {
    if (frameData != null) {
      if (drawer === null) {
        var size = new workerManagerTrain_Size(option.ylen, option.height);
        drawer = new YUVWebGLCanvas(canvasElem, size);
      }

      var secondKey = Math.floor((getDateByStream(option.time).getTime() - firstFrameTime) / 1000);
      var frameKey = option.frameNo; // 帧序号

      var value = {
        'frameData': frameData,
        'option': option
      }; // console.log('sendIntoMap',secondMap);
      // 存储以秒为key的数据

      if (secondMap.size > 600) {
        secondMap.clear();
      }

      if (secondMap.has(secondKey) === false) {
        secondMap.set(secondKey, value);
      } // 存储以帧序号为key的数据


      if (frameMap.size > 25 * 600) {
        // 一秒25帧
        frameMap.clear();
      }

      if (frameMap.has(frameKey) === false) {
        frameMap.set(frameKey, value);
      }
    }
  }

  return new Constructor();
};

function workerManagerTrain_Size(width, height) {
  function Constructor(width, height) {
    Constructor.prototype.w = width;
    Constructor.prototype.h = height;
  }

  Constructor.prototype = {
    toString: function toString() {
      return "(" + Constructor.prototype.w + ", " + Constructor.prototype.h + ")";
    },
    getHalfSize: function getHalfSize() {
      return new workerManagerTrain_Size(Constructor.prototype.w >>> 1, Constructor.prototype.h >>> 1);
    },
    length: function length() {
      return Constructor.prototype.w * Constructor.prototype.h;
    }
  };
  return new Constructor(width, height);
}

/* harmony default export */ var workerManagerTrain = (workerManagerTrain_WorkerManagerTrain);
// CONCATENATED MODULE: ./src/sha1.js
/*
 * A JavaScript implementation of the Secure Hash Algorithm, SHA-1, as defined
 * in FIPS 180-1
 * Version 2.2 Copyright Paul Johnston 2000 - 2009.
 * Other contributors: Greg Holt, Andrew Kepert, Ydnar, Lostinet
 * Distributed under the BSD License
 * See http://pajhome.org.uk/crypt/md5 for details.
 */

/*
 * Configurable variables. You may need to tweak these to be compatible with
 * the server-side, but the defaults work in most cases.
 */
var hexcase = 0;
/* hex output format. 0 - lowercase; 1 - uppercase        */

var b64pad = "";
/* base-64 pad character. "=" for strict RFC compliance   */

/*
 * These are the functions you'll usually want to call
 * They take string arguments and return either hex or base-64 encoded strings
 */

function hex_sha1(s) {
  return rstr2hex(rstr_sha1(str2rstr_utf8(s)));
}

function b64_sha1(s) {
  return rstr2b64(rstr_sha1(str2rstr_utf8(s)));
}

function any_sha1(s, e) {
  return rstr2any(rstr_sha1(str2rstr_utf8(s)), e);
}

function hex_hmac_sha1(k, d) {
  return rstr2hex(rstr_hmac_sha1(str2rstr_utf8(k), str2rstr_utf8(d)));
}

function b64_hmac_sha1(k, d) {
  return rstr2b64(rstr_hmac_sha1(str2rstr_utf8(k), str2rstr_utf8(d)));
}

function any_hmac_sha1(k, d, e) {
  return rstr2any(rstr_hmac_sha1(str2rstr_utf8(k), str2rstr_utf8(d)), e);
}
/*
 * Perform a simple self-test to see if the VM is working
 */


function sha1_vm_test() {
  return hex_sha1("abc").toLowerCase() == "a9993e364706816aba3e25717850c26c9cd0d89d";
}
/*
 * Calculate the SHA1 of a raw string
 */


function rstr_sha1(s) {
  return binb2rstr(binb_sha1(rstr2binb(s), s.length * 8));
}
/*
 * Calculate the HMAC-SHA1 of a key and some data (raw strings)
 */


function rstr_hmac_sha1(key, data) {
  var bkey = rstr2binb(key);
  if (bkey.length > 16) bkey = binb_sha1(bkey, key.length * 8);
  var ipad = Array(16),
      opad = Array(16);

  for (var i = 0; i < 16; i++) {
    ipad[i] = bkey[i] ^ 0x36363636;
    opad[i] = bkey[i] ^ 0x5C5C5C5C;
  }

  var hash = binb_sha1(ipad.concat(rstr2binb(data)), 512 + data.length * 8);
  return binb2rstr(binb_sha1(opad.concat(hash), 512 + 160));
}
/*
 * Convert a raw string to a hex string
 */


function rstr2hex(input) {
  try {
    hexcase;
  } catch (e) {
    hexcase = 0;
  }

  var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
  var output = "";
  var x;

  for (var i = 0; i < input.length; i++) {
    x = input.charCodeAt(i);
    output += hex_tab.charAt(x >>> 4 & 0x0F) + hex_tab.charAt(x & 0x0F);
  }

  return output;
}
/*
 * Convert a raw string to a base-64 string
 */


function rstr2b64(input) {
  try {
    b64pad;
  } catch (e) {
    b64pad = '';
  }

  var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  var output = "";
  var len = input.length;

  for (var i = 0; i < len; i += 3) {
    var triplet = input.charCodeAt(i) << 16 | (i + 1 < len ? input.charCodeAt(i + 1) << 8 : 0) | (i + 2 < len ? input.charCodeAt(i + 2) : 0);

    for (var j = 0; j < 4; j++) {
      if (i * 8 + j * 6 > input.length * 8) output += b64pad;else output += tab.charAt(triplet >>> 6 * (3 - j) & 0x3F);
    }
  }

  return output;
}
/*
 * Convert a raw string to an arbitrary string encoding
 */


function rstr2any(input, encoding) {
  var divisor = encoding.length;
  var remainders = Array();
  var i, q, x, quotient;
  /* Convert to an array of 16-bit big-endian values, forming the dividend */

  var dividend = Array(Math.ceil(input.length / 2));

  for (i = 0; i < dividend.length; i++) {
    dividend[i] = input.charCodeAt(i * 2) << 8 | input.charCodeAt(i * 2 + 1);
  }
  /*
   * Repeatedly perform a long division. The binary array forms the dividend,
   * the length of the encoding is the divisor. Once computed, the quotient
   * forms the dividend for the next step. We stop when the dividend is zero.
   * All remainders are stored for later use.
   */


  while (dividend.length > 0) {
    quotient = Array();
    x = 0;

    for (i = 0; i < dividend.length; i++) {
      x = (x << 16) + dividend[i];
      q = Math.floor(x / divisor);
      x -= q * divisor;
      if (quotient.length > 0 || q > 0) quotient[quotient.length] = q;
    }

    remainders[remainders.length] = x;
    dividend = quotient;
  }
  /* Convert the remainders to the output string */


  var output = "";

  for (i = remainders.length - 1; i >= 0; i--) {
    output += encoding.charAt(remainders[i]);
  }
  /* Append leading zero equivalents */


  var full_length = Math.ceil(input.length * 8 / (Math.log(encoding.length) / Math.log(2)));

  for (i = output.length; i < full_length; i++) {
    output = encoding[0] + output;
  }

  return output;
}
/*
 * Encode a string as utf-8.
 * For efficiency, this assumes the input is valid utf-16.
 */


function str2rstr_utf8(input) {
  var output = "";
  var i = -1;
  var x, y;

  while (++i < input.length) {
    /* Decode utf-16 surrogate pairs */
    x = input.charCodeAt(i);
    y = i + 1 < input.length ? input.charCodeAt(i + 1) : 0;

    if (0xD800 <= x && x <= 0xDBFF && 0xDC00 <= y && y <= 0xDFFF) {
      x = 0x10000 + ((x & 0x03FF) << 10) + (y & 0x03FF);
      i++;
    }
    /* Encode output as utf-8 */


    if (x <= 0x7F) output += String.fromCharCode(x);else if (x <= 0x7FF) output += String.fromCharCode(0xC0 | x >>> 6 & 0x1F, 0x80 | x & 0x3F);else if (x <= 0xFFFF) output += String.fromCharCode(0xE0 | x >>> 12 & 0x0F, 0x80 | x >>> 6 & 0x3F, 0x80 | x & 0x3F);else if (x <= 0x1FFFFF) output += String.fromCharCode(0xF0 | x >>> 18 & 0x07, 0x80 | x >>> 12 & 0x3F, 0x80 | x >>> 6 & 0x3F, 0x80 | x & 0x3F);
  }

  return output;
}
/*
 * Encode a string as utf-16
 */


function str2rstr_utf16le(input) {
  var output = "";

  for (var i = 0; i < input.length; i++) {
    output += String.fromCharCode(input.charCodeAt(i) & 0xFF, input.charCodeAt(i) >>> 8 & 0xFF);
  }

  return output;
}

function str2rstr_utf16be(input) {
  var output = "";

  for (var i = 0; i < input.length; i++) {
    output += String.fromCharCode(input.charCodeAt(i) >>> 8 & 0xFF, input.charCodeAt(i) & 0xFF);
  }

  return output;
}
/*
 * Convert a raw string to an array of big-endian words
 * Characters >255 have their high-byte silently ignored.
 */


function rstr2binb(input) {
  var output = Array(input.length >> 2);

  for (var i = 0; i < output.length; i++) {
    output[i] = 0;
  }

  for (var i = 0; i < input.length * 8; i += 8) {
    output[i >> 5] |= (input.charCodeAt(i / 8) & 0xFF) << 24 - i % 32;
  }

  return output;
}
/*
 * Convert an array of big-endian words to a string
 */


function binb2rstr(input) {
  var output = "";

  for (var i = 0; i < input.length * 32; i += 8) {
    output += String.fromCharCode(input[i >> 5] >>> 24 - i % 32 & 0xFF);
  }

  return output;
}
/*
 * Calculate the SHA-1 of an array of big-endian words, and a bit length
 */


function binb_sha1(x, len) {
  /* append padding */
  x[len >> 5] |= 0x80 << 24 - len % 32;
  x[(len + 64 >> 9 << 4) + 15] = len;
  var w = Array(80);
  var a = 1732584193;
  var b = -271733879;
  var c = -1732584194;
  var d = 271733878;
  var e = -1009589776;

  for (var i = 0; i < x.length; i += 16) {
    var olda = a;
    var oldb = b;
    var oldc = c;
    var oldd = d;
    var olde = e;

    for (var j = 0; j < 80; j++) {
      if (j < 16) w[j] = x[i + j];else w[j] = bit_rol(w[j - 3] ^ w[j - 8] ^ w[j - 14] ^ w[j - 16], 1);
      var t = safe_add(safe_add(bit_rol(a, 5), sha1_ft(j, b, c, d)), safe_add(safe_add(e, w[j]), sha1_kt(j)));
      e = d;
      d = c;
      c = bit_rol(b, 30);
      b = a;
      a = t;
    }

    a = safe_add(a, olda);
    b = safe_add(b, oldb);
    c = safe_add(c, oldc);
    d = safe_add(d, oldd);
    e = safe_add(e, olde);
  }

  return Array(a, b, c, d, e);
}
/*
 * Perform the appropriate triplet combination function for the current
 * iteration
 */


function sha1_ft(t, b, c, d) {
  if (t < 20) return b & c | ~b & d;
  if (t < 40) return b ^ c ^ d;
  if (t < 60) return b & c | b & d | c & d;
  return b ^ c ^ d;
}
/*
 * Determine the appropriate additive constant for the current iteration
 */


function sha1_kt(t) {
  return t < 20 ? 1518500249 : t < 40 ? 1859775393 : t < 60 ? -1894007588 : -899497514;
}
/*
 * Add integers, wrapping at 2^32. This uses 16-bit operations internally
 * to work around bugs in some JS interpreters.
 */


function safe_add(x, y) {
  var lsw = (x & 0xFFFF) + (y & 0xFFFF);
  var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
  return msw << 16 | lsw & 0xFFFF;
}
/*
 * Bitwise rotate a 32-bit number to the left.
 */


function bit_rol(num, cnt) {
  return num << cnt | num >>> 32 - cnt;
}

/* harmony default export */ var sha1 = (hex_sha1);
// CONCATENATED MODULE: ./src/MP4Parse/PacketMP42DHAV.js
function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && Symbol.iterator in Object(iter)) return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function PacketMP42DHAV_classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function PacketMP42DHAV_defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function PacketMP42DHAV_createClass(Constructor, protoProps, staticProps) { if (protoProps) PacketMP42DHAV_defineProperties(Constructor.prototype, protoProps); if (staticProps) PacketMP42DHAV_defineProperties(Constructor, staticProps); return Constructor; }

//音频帧率对应的帧头的值
var audioSampleRate = {
  '4000': 0x01,
  '8000': 0x02,
  '11025': 0x03,
  '16000': 0x04,
  '20000': 0x05,
  '22050': 0x06,
  '32000': 0x07,
  '44100': 0x08,
  '48000': 0x09,
  '96000': 0x10,
  '128000': 0x11,
  '192000': 0x12,
  '64000': 0x13
};
/**
 * [getHexArrayDec description] 将10进制的数据，转为length个字节长度的16进制数组，可以通过参数控制大小端序
 * @param  {[number]}   num [description] 需要转化的数字
 * @param  {[big]}   length [description] 需要转为为多少个字节长度的数组，默认为4
 * @param  {[big]}   big [description] big强等于true时，为大端序，其他为小端序
 * @return {[array]}     temp [description] 4个字节长度的16进制数组
 **/

function getHexArrayDec(num) {
  var length = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 4;
  var big = arguments.length > 2 ? arguments[2] : undefined;
  var temp = [];

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
 * 将MP4视频帧的裸数据包上大华头
 */


var PacketDHAV = /*#__PURE__*/function () {
  function PacketDHAV(RtpInterlevedID, videoCodec, audioCodec) {
    PacketMP42DHAV_classCallCheck(this, PacketDHAV);

    this.RtpInterlevedID = RtpInterlevedID;
    this.timestamp = 0; //毫秒时间戳

    this.currTime = null;
    this.preTime = null;
    this.VideoCodec = videoCodec;
    this.AudioCodec = audioCodec;
    this.MAXFRAMEINTERVAL = 65535; //最大毫秒，在0-该值之间循环，可以不为0开始，设置区间主要用于节约空间。

    this.rtpDataHeadExtLength = 4 + 8; //扩展帧头的长度，扩展帧0x83 + 0x86 + 0x88

    this.rtpDataHeadLength = 24 + this.rtpDataHeadExtLength; //帧头24 + 扩展帧头

    this.rtpDataFootLength = 8; //帧尾长度

    /*
        打包格式为: 0x24($) + 交织通道(interleaved) + 4字节长度信息 + 大华帧,类似于以下数据
        00000AD5  24 0a 00 00 02 2c                                $....,
        00000ADB  44 48 41 56 f0 00 01 00  02 00 00 00 2c 02 00 00 DHAV.... ....,...
        00000AEB  ad e7 76 51 40 00 0c eb  83 01 0e 02 88 00 ce cd ..vQ@... ........
        00000AFB  cd 00 00 00
    */

    this.rtpPacketHead = [0x24, RtpInterlevedID, 0x0, 0x0, 0x0, 0x0]; //打包格式为: 0x24($) + 交织通道(interleaved) + 长度（大端序）

    this.DHAV = [0x44, 0x48, 0x41, 0x56]; //DHAV 0 - 4帧头标识

    this.dhav = [0x64, 0x68, 0x61, 0x76]; //dhav 0 - 4帧尾标识，参考大华标准码流格式定义.pptx 58页
    // this.rtpDataHead4_7 = [0xF0, 0x00, 0x01, 0x00];//4类型,5子类型,6通道号,7子帧序号
    // this.rtpDataHead8_11 = [0x00, 0x00, 0x00, 0x00];//帧序号

    this.frameNum = 0xF5; //帧序号
    // this.rtpDataHead12_15 = [0x00, 0x00, 0x00, 0x00];//帧序号
  }
  /*
   * 将MP4解出来裸的音频/视频数据，封装成大华包的格式。
   */


  PacketMP42DHAV_createClass(PacketDHAV, [{
    key: "getRTPPacket",
    value: function getRTPPacket() {
      var rtpPayload = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : new ArrayBuffer(0);
      var track = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
      var offset = 0;
      this.rtpDataHeadExtLength = (track.type === 'audio' ? 4 : track.width > 2048 || track.height > 2048 ? 8 + 4 : 4 + 4) + 8; //扩展帧头的长度，扩展帧0x83 + 0x86 + 0x88

      this.rtpDataHeadLength = 24 + this.rtpDataHeadExtLength; //帧头24 + 扩展帧头

      var rtpPacket = new Uint8Array(this.rtpPacketHead.length + this.rtpDataHeadLength + rtpPayload.byteLength + this.rtpDataFootLength); //大华私有打包格式为: 0x24($) + 交织通道(interleaved) + 4字节长度信息 + 大华帧

      rtpPacket.set([0x24, this.RtpInterlevedID], offset), offset = offset + 2; //0x24($) + 交织通道(interleaved)

      rtpPacket.set(getHexArrayDec(this.rtpDataHeadLength + rtpPayload.byteLength + this.rtpDataFootLength, 4, true), offset), offset = offset + 4; // + 4字节长度信息,使用大端序号
      //大华私有打包结束
      //以下是大华帧，大华帧参考的【大华标准码流格式定义.pptx】13页

      rtpPacket.set(this.DHAV, offset), offset = offset + 4; //帧头标识，固定为DHAV；0-3

      var type = track.type === 'audio' ? [0xF0] : track.keyframe ? [0xFD] : [0xFC]; //类型

      rtpPacket.set(type, offset), offset = offset + 1; //类型，音频固定为0xF0；视频I帧：0xFD；视频P帧：0xFC  4

      rtpPacket.set([0x00], offset), offset = offset + 1; //子类型，音频固定为0x00；MP4视频子类型都设置为0（普通I帧或者普通P帧） 5

      rtpPacket.set([0x01], offset), offset = offset + 1; //通道号，固定为0x01；6

      rtpPacket.set([0x00], offset), offset = offset + 1; //子帧序号，音频固定为0x00；7

      if (this.frameNum > 65535) {
        this.frameNum = 0xF0;
      }

      rtpPacket.set(getHexArrayDec(this.frameNum), offset), offset = offset + 4, this.frameNum++; //子帧序号，0-65535循环； 8 -11

      var frameLength = getHexArrayDec(this.rtpDataHeadLength + rtpPayload.byteLength + this.rtpDataFootLength);
      rtpPacket.set(frameLength, offset), offset = offset + 4; //帧长度 = 帧头长度 + 数据长度 + 帧尾长度；12-15
      // let currTime = (new Date()).getTime();//当前时间
      // let currTimeStamp = this.preTime === null ? 0 : currTime - this.preTime;//当前时间和上一次时间的差值,如果是第一帧，则设置为0
      // this.preTime = currTime;//将当前时间设置为上一次时间，以便下次使用
      // this.timestamp = this.timestamp + currTimeStamp;//当前帧比上一帧增加后 的时间，毫秒为单位，

      var currTime = new Date('2000-01-01 00:00:00').getTime(); //当前时间(由于MP4文件不能从码流中分析出当前视频的开始时间和结束时间，所以取'2000-01-01 00:00:00'作为初始时间)

      this.timestamp = track.timestamp * 1000 / track.timescale;

      if (this.timestamp > this.MAXFRAMEINTERVAL) {
        //如果毫秒时间戳，超过最大值，那么则顺延下去,比如当前帧为65585。比65535大，那么当前帧的时间戳为65585-65535 = 50ms
        this.timestamp = this.timestamp - this.MAXFRAMEINTERVAL;
      }

      rtpPacket.set(getHexArrayDec(Math.floor((currTime + this.timestamp) / 1000)), offset), offset = offset + 4; //时间日期，精确到秒；16-19

      rtpPacket.set(getHexArrayDec(this.timestamp, 2), offset), offset = offset + 2; //毫秒时间戳；20 -21

      rtpPacket.set([this.rtpDataHeadExtLength], offset), offset = offset + 1; //扩展字段长度；22

      var total = getTotal(rtpPacket, 6);
      rtpPacket.set([total], offset), offset = offset + 1; //校验和；23
      //大华帧头封装结束
      //以下是扩展帧

      /**
       * 参考大华码流标准格式定义.pptx，第23页
       */

      var medieType = [];

      if (track.type === 'video') {
        if (track.width > 2048 || track.height > 2048) {
          medieType = [0x82, 0x00, 0x00, 0x00].concat(_toConsumableArray(getHexArrayDec(track.width, 2)), _toConsumableArray(getHexArrayDec(track.height, 2))); //高分辨率视频扩展头
        } else {
          medieType = [0x80, 0x00, track.width / 8, track.height / 8]; //低分辨率视频扩展头
        }
      } else {
        medieType = [0x83, 0x01, 0x1A, audioSampleRate[track.timescale]]; //aac音频扩展头
      }

      rtpPacket.set(medieType, offset), offset = offset + medieType.length;

      if (track.type === 'video') {
        rtpPacket.set([0x81, 0x00, this.getHexByCodec(this.VideoCodec), 0x32], offset), offset = offset + 4;
      }

      var verify = sum_32_verify(rtpPayload, rtpPayload.byteLength);
      rtpPacket.set([0x88], offset), offset = offset + 1; //0x88，校验位

      rtpPacket.set(getHexArrayDec(verify), offset), offset = offset + 4; //校验位

      rtpPacket.set([0x00, 0x00, 0x00], offset), offset = offset + 3; //固定为0
      //扩展帧结束
      //MP4音、视频帧裸数据

      rtpPacket.set(rtpPayload, offset), offset = offset + rtpPayload.byteLength; //帧尾 帧尾 = 帧尾dhav（4） + 【帧头长度 + 数据长度 + 帧尾长度】（4）

      rtpPacket.set(this.dhav, offset), offset = offset + 4; //帧尾dhav

      rtpPacket.set(frameLength, offset); //帧尾结束

      return rtpPacket; //该数据可以直接发送给设备了。
    }
  }, {
    key: "getHexByCodec",
    value: function getHexByCodec(codec) {
      var _codec = 0x08;

      switch (codec) {
        case 'H264':
          _codec = 0x08;
          break;

        case 'H265':
          _codec = 0x0C;
          break;
      }

      return _codec;
    }
  }]);

  return PacketDHAV;
}();


// CONCATENATED MODULE: ./src/MP4Parse/MP4MovieParse.js
function MP4MovieParse_classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function MP4MovieParse_defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function MP4MovieParse_createClass(Constructor, protoProps, staticProps) { if (protoProps) MP4MovieParse_defineProperties(Constructor.prototype, protoProps); if (staticProps) MP4MovieParse_defineProperties(Constructor, staticProps); return Constructor; }



var VideoLib = __webpack_require__(52); //MP4传的数据不是一帧一帧的，所以每段数据前都有20字节，用于解释当前这段数据

/**
 * 头部信息总共有20字节。
 * 其中魔数为 “MP4D”，都是大写，相当于一个标识符
 * 长度信息是数据段的长度 + 头部长度(20字节)。
 * 标记位的最低位表示数据段是MOOV数据还是为帧数据，值为1表示负载的是MOOV数据，值为0表示负载的为帧数据。
 * 位置信息表示数据段在MP4文件中的偏移位置。
 * 保留字段有4个字节，目前全部填为0即可。
 * 全部采用小端序。
 */


var EXTEND_LENGTH = 20;

var MP4MovieParse_MP4MovieParse = /*#__PURE__*/function () {
  function MP4MovieParse() {
    MP4MovieParse_classCallCheck(this, MP4MovieParse);

    this.CodecCallback = function () {};

    this.TrackCallback = function () {};
  }
  /**
   * 初始化
   * @param {*} movie
   */


  MP4MovieParse_createClass(MP4MovieParse, [{
    key: "init",
    value: function init(movie) {
      this.MovieBuffer = new Uint8Array(0);
      this.currentFrame = 0;
      this.currentDeleteLen = 0;
      this.length = 0;
      this.position = 0;
      this.isMoov = 0;
      this.isSeek = false;
      this.track = this.concatArray(movie.tracks[0].samples, movie.tracks[1].samples); //所有通道

      this.VideoCodec = this.getCodec(movie.tracks[0].codec); //视频编码格式

      this.AudioCodec = this.getCodec(movie.tracks[1].codec); //音频编码格式

      this.Framerate = this.getFPS(movie.tracks[0].samples); //视频帧率

      this.clockFreq = movie.tracks[1].samples[0].timescale; //音频采样率
      // 这里MP4的音频暂时是默认aac格式，AACCodecInfo.config = '1408'

      this.AudioCodecInfo = {
        config: '1408',
        clockFreq: this.clockFreq,
        bitrate: undefined
      };
      this.packetDHAV = new PacketDHAV(0x00, this.VideoCodec, this.AudioCodec); //解析出moov之后，把结出来的当前MP4的视频和音频的编码格式发布出去，用于初始化解码库
      //帧率由于透传的时候没有传，暂时都写成30

      this.CodecCallback({
        VideoCodec: this.VideoCodec,
        AudioCodec: this.AudioCodec,
        Framerate: this.Framerate,
        AudioCodecInfo: this.AudioCodecInfo
      });
    }
    /**
     * 接收websocket传过来的流数据进行处理
     * @param {*} buffer 流数据
     */

  }, {
    key: "setMovieData",
    value: function setMovieData(buffer) {
      var exData = buffer.subarray(0, EXTEND_LENGTH);
      this.isMoov = exData[8];
      buffer = buffer.subarray(EXTEND_LENGTH, buffer.length); //这里目前只实现了moov一次全部推送过来的情况，如果moov也是分段推送过来的话，需要另外实现

      if (this.isMoov) {
        var movie = VideoLib.MovieParser.parse(buffer);

        if (movie) {
          this.init(movie); // 初始化

          console.log(movie);
        } else {
          console.log('moov不对');
        }
      } else {
        //MP4Box中的帧数据
        //由于设备是小端模式，所以长度和位置信息是从低位到高位的
        this.length = (exData[7] << 24 | exData[6] << 16 | exData[5] << 8 | exData[4]) - EXTEND_LENGTH; //当前段数据的长度

        this.position = exData[15] << 48 | exData[14] << 40 | exData[13] << 32 | exData[12] << 24 | exData[11] << 16 | exData[10] << 8 | exData[9]; //当前段数据在MP4裸数据中的位置
        //seek时进入if条件

        if (this.currentDeleteLen + this.MovieBuffer.length < this.position) {
          this.isSeek = true;
          this.currentDeleteLen = this.position;
          this.currentFrame = this.getCurrentSeekFrame();
          this.MovieBuffer = new Uint8Array(0);
        } //缓存流数据


        this.MovieBuffer = this.concatUint8Array(this.MovieBuffer, new Uint8Array(buffer));
        this.getFrameData();
      }
    }
    /**
     * 把裸数据解析成帧数据，并包大华头，添加nal单元
     */

  }, {
    key: "getFrameData",
    value: function getFrameData() {
      var track = this.track[this.currentFrame];

      if (this.MovieBuffer.length + this.currentDeleteLen >= track.offset + track.size) {
        var packet = null;

        if (track instanceof VideoLib.VideoSample) {
          //视频帧
          //添加nal单元
          var nalFrame = this.set_nal_unit_type(this.MovieBuffer.subarray(track.offset - this.currentDeleteLen, track.offset + track.size - this.currentDeleteLen)); //包大华头

          packet = this.packetDHAV.getRTPPacket(nalFrame, track);
        } else {
          //音频帧
          // 音频帧不用添加nal单元，直接包大华头
          packet = this.packetDHAV.getRTPPacket(this.MovieBuffer.subarray(track.offset - this.currentDeleteLen, track.offset + track.size - this.currentDeleteLen), track);
        }

        if (this.isSeek && track.keyframe || !this.isSeek) {
          //seek之后第一帧需要是关键帧i帧
          this.TrackCallback(packet);
          this.isSeek = false;
        }

        this.MovieBuffer = this.MovieBuffer.subarray(track.offset + track.size - this.currentDeleteLen, this.MovieBuffer.length);
        this.currentDeleteLen = track.offset + track.size;
        this.currentFrame++;

        if (this.currentFrame < this.track.length) {
          this.getFrameData();
        }
      }
    }
    /**
     * seek时,通过流中的position，找出当前是第几帧
     */

  }, {
    key: "getCurrentSeekFrame",
    value: function getCurrentSeekFrame() {
      var low = 0,
          high = this.track.length - 1,
          pos = this.position;

      if (this.track[0].offset >= pos) {
        return 0; //如果第一帧的偏移位置大于当前position,说明是第一帧，直接返回0
      }

      while (low <= high) {
        var mid = parseInt((high + low) / 2),
            track = this.track[mid];

        if (pos === track.offset) {
          return mid;
        } else if (pos > track.offset) {
          if (pos < track.offset + track.size) {
            return mid + 1;
          } else {
            low = mid + 1;
          }
        } else if (pos < track.offset) {
          high = mid - 1;
        } else {
          return -1;
        }
      }
    }
    /**
     * 给视频帧加nal单元
     * 帧数据的前4字节做为第一个nal，首先把帧数据的前4字节作为一个长度之后，把这四字节换成0001，然后跳转前4位的长度，找到下一个nal的位置
     * 取出下一个nal位置的四个字节作为长度之后，在换成0001，依次类推。
     * @param {*} buffer
     */

  }, {
    key: "set_nal_unit_type",
    value: function set_nal_unit_type() {
      var buffer = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : new Uint8Array();
      var nextNalLen = 0;
      var nalPos = 0;

      var getNALLength = function getNALLength(start, end) {
        var str = '';
        buffer.slice(start, end).map(function (item) {
          return str += item.toString(16).length === 1 ? '0' + item.toString(16) : item.toString(16);
        });
        return parseInt(str, 16);
      };

      while (buffer.length > 4 && nalPos < buffer.length) {
        nextNalLen = getNALLength(nalPos, nalPos + 4);
        buffer.set([0, 0, 0, 1], nalPos);
        nalPos = nalPos + nextNalLen + 4;
      }

      return buffer;
    }
    /**
     * 合并两个Uint8Array
     * @param  {...any} arrays
     */

  }, {
    key: "concatUint8Array",
    value: function concatUint8Array() {
      var totalLength = 0;

      for (var _len = arguments.length, arrays = new Array(_len), _key = 0; _key < _len; _key++) {
        arrays[_key] = arguments[_key];
      }

      for (var _i = 0, _arrays = arrays; _i < _arrays.length; _i++) {
        var arr = _arrays[_i];
        totalLength += arr.length;
      }

      var result = new Uint8Array(totalLength);
      var offset = 0;

      for (var _i2 = 0, _arrays2 = arrays; _i2 < _arrays2.length; _i2++) {
        var _arr = _arrays2[_i2];
        result.set(_arr, offset);
        offset += _arr.length;
      }

      return result;
    }
    /**
     * 把moov解析出来的视频帧和音频帧，按照偏移量（offset）顺序组成一个数组
     * @param {*} videoTrack
     * @param {*} audioTrack
     */

  }, {
    key: "concatArray",
    value: function concatArray(videoTrack, audioTrack) {
      var arr = videoTrack.concat(audioTrack);
      return arr.sort(function (m, n) {
        var a = m.offset;
        var b = n.offset;
        return a - b;
      });
    }
    /**
     * 通过moov中解析出来的视频或者音频的编码格式，转换成我们需要的编码格式。
     * 这里只列举了avc1.640028，mp4a.40.2，hvc1.1.6.L93.b这三种，后面如果有增加，可以在本方法中扩展
     * @param {*} codec 编码格式
     */

  }, {
    key: "getCodec",
    value: function getCodec(codec) {
      var _codec = ''; // 'avc1.64001f'://视频720P30fps,480P
      // 'avc1.640020'://视频720P60fps
      // 'avc1.640028'://视频1080P30fps
      // 'avc1.64002a'://视频1080P60fps
      // 'avc1.640032'://视频2K
      // 'hvc1.1.6.L90.b'://视频480P
      // 'hvc1.1.6.L93.b'://视频720P
      // 'hvc1.1.6.L120.b'://视频1080P 2K

      if (/hvc1/g.test(codec)) {
        _codec = 'H265';
      }

      if (/avc1/g.test(codec)) {
        _codec = 'H264';
      }

      if (/mp4a/g.test(codec)) {
        _codec = 'mpeg4-generic'; //aac
      }

      return _codec;
    }
    /**
     * 获取视频帧率
     */

  }, {
    key: "getFPS",
    value: function getFPS(track) {
      var fps = 60; //默认最大帧率是60帧

      for (var i = 0, len = track.length >= 60 ? 60 : track.length; i < len; i++) {
        if (track[i].timestamp <= track[i].timescale && track[i + 1].timestamp > track[i].timescale) {
          fps = i;
          break;
        }
      }

      return fps;
    }
    /**
     * 把帧数据打印出来，本方法主要用于调试用，方便看每一帧的裸数据
     * 例子如下：
        44 48 41 56 f0 00 01 00  84 01 00 00 3b 01 00 00
        03 d3 6c 38 40 0c 0c a7  83 01 1a 04 88 64 e1 92
        a6 00 00 00 01 14 35 a9  91 7d 43 df a5 5a 4a 92
        48 10 20 82 29 fe 2a ab  43 3c 7d 11 89 29 63 3f
        db cf 79 b7 05 73 5c df  cf 90 ed 5e 54 f8 b6 cd
        3d 96 74 0b fe 4e f3 ba  f5 aa 4d 76 7c 8d 8c 3a
        e3 6d ef 57 55 a1 34 5f  9a 61 f6 aa 9e 60 d2 ff
        f4 fc d9 39 70 33 77 6f  0e 54 cc 41 68 9b c5 a0
        f5 ae 85 8a ba a8 b2 a5  4f c5 b7 d7 d7 aa 3a 12
        63 26 45 24 f1 8a a3 77  16 8b 50 d5 2f c4 8d fa
        99 ae 19 2c cb 87 27 01  67 46 f6 4a d2 8f 7c 57
        02 9b 0e 20 63 47 d4 20  4b ca 4d 9c 25 32 0b 71
        d8 46 6e 5c c2 8f 00 dc  c3 12 a8 c3 11 9c 5b c5
        11 51 66 29 13 64 de c2  49 68 c0 eb 1a 88 8c da
        be 46 fc 4c 6c 2c 20 00  3f 54 b1 37 7b 05 51 49
        b2 74 d3 84 b9 a9 10 c6  45 16 51 01 0a 47 4e e4
        81 79 8a db 04 aa 58 3b  c2 06 b1 fb 7c 14 ec a6
        65 cd 95 7a e4 8a 37 08  56 19 4a 38 54 55 53 13
        16 8a d3 5b 44 d6 be ad  f8 f2 2f 28 ac d6 01 14
     * @param {*} trackData 帧数据
     */

  }, {
    key: "parseToString",
    value: function parseToString(trackData) {
      var str = '';

      for (var i = 0, len = trackData.length; i < len; i++) {
        str += (trackData[i].toString(16).length === 1 ? '0' + trackData[i].toString(16) : trackData[i].toString(16)) + ((i + 1) % 16 === 0 ? '\n' : (i + 1) % 8 === 0 ? '  ' : ' ');
      }

      return str;
    }
  }]);

  return MP4MovieParse;
}();


// CONCATENATED MODULE: ./src/localRecord.js
function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(Object(source), true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(Object(source)).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

/*
* 数据的传递使用postMessage
* 写一个总枢处理器，其他都以插件的形式放入
* 输出必要数据，自当前开启录像开始
* 1.录像总大小
* 2.录像个数
* 3.录像总时长
* 4.单个录像的大小与时长
* 5.录像开始结束时间
* 6.录像基本信息
*/

/*
* 工具函数，判断数据类型
* e.g. isTpye('aa', 'string') === true
*/
function isType(source, compare) {
  compare = compare.toLowerCase();
  compare = compare[0].toUpperCase() + compare.substr(1);
  return Object.prototype.toString.call(source) === '[object ' + compare + ']';
} // 用来抛出错误


function localRecord_error(message) {
  throw new Error(message);
}

function padCharacter(target, letter, length) {
  target = target.toString();

  if (length === void 0) {
    length = 2;
  }

  if (letter === void 0) {
    letter = 0;
  }

  if (target.length >= length) {
    return target;
  } else {
    var dis = length - target.length;
    return new Array(dis).fill(String(letter)).join('') + target;
  }
} // 转化对应格式的字符串内容


function format2dateString(format, date) {
  if (format === undefined || !format) return '';
  date = date || new Date();
  format = format.replace(/y/ig, padCharacter(date.getFullYear()), 0);
  format = format.replace(/m/ig, padCharacter(date.getMonth() + 1), 0);
  format = format.replace(/d/ig, padCharacter(date.getDate()), 0);
  format = format.replace(/h/ig, padCharacter(date.getHours()), 0);
  format = format.replace(/i/ig, padCharacter(date.getMinutes()), 0);
  format = format.replace(/s/ig, padCharacter(date.getSeconds()), 0);
  return format;
}
/*
* 获取以日期为格式的文件名
*/


function getFileNameByDate(options, date) {
  var DEFAULT_DATE_FORMAT = 'ymd_his'; // 默认日期格式

  options = options || {};
  var format = options.nameFormat || [DEFAULT_DATE_FORMAT]; // 默认格式为年月日，时分秒

  date = date || new Date();
  var name = ''; // 如果当前命名格式是string类型

  if (isType(format, 'string')) {
    format = [format, {}];
  } else if (isType(format, 'array')) {
    if (!isType(format[0], 'string')) {
      format[0] = DEFAULT_DATE_FORMAT;
    }

    if (!isType(format[1], 'object')) {
      format[1] = {};
    }
  } else {
    localRecord_error('name format must be string or array');
    return;
  }

  var formatArr = format[0].split(/\{(?:[^{}]+)\}/);
  var formatMap = format[1];
  format[0].replace(/\{([^{}]*)\}/g, function (match, $1, index) {
    var shiftStr = formatArr.shift();
    name += format2dateString();

    if ($1 in formatMap) {
      name += formatMap[$1];
    } else {
      name += match;
    }
  });
  var shiftStr = formatArr.shift();
  name += format2dateString(shiftStr, date);
  return name;
}
/*
* 因为这个实例需要被postMessage出去，函数信息要在原型中绑定
* @params name [string] 文件名称
* @params options [object] 扩展数据
*/


function DavVideo(name, options) {
  this.name = name;
  this.allowUpDateName = true;
  this.byteLength = 0;
  this.options = options;
  this.startTime = new Date().toLocaleString();
}

DavVideo.prototype.setEndTime = function () {
  this.endTime = new Date().toLocaleString();
};

DavVideo.prototype.updateNameByStream = function (options, arrBuf) {
  if (this.allowUpDateName) {
    var stream = new Uint8Array(arrBuf);
    var time = (stream[19] << 24) + (stream[18] << 16) + (stream[17] << 8) + stream[16] >>> 0;
    var timeString = '20' + (time >> 26) + '/' + (time >> 22 & 0x0f) + '/' + (time >> 17 & 0x1f) + ' ' + (time >> 12 & 0x1f) + ':' + (time >> 6 & 0x3f) + ':' + (time & 0x3f);
    this.name = getFileNameByDate(options, new Date(timeString));
    this.allowUpDateName = false;
    stream = null;
  }

  arrBuf = null;
};
/*
* 保存当前这个录像操作中，下载的录像信息
*/


function SqlBase() {
  var dataBase = {
    count: 0,
    // 本次录像下载，已经下载了几个了
    total: 0,
    // 总流量大小
    group: [] // 用来存放已经下载的每个视频的信息

  };

  var controller = function controller() {};

  controller.prototype.add = function (davVideo) {
    dataBase.count++;
    dataBase.total += davVideo.byteLength;
    dataBase.group.push(davVideo);
  };

  controller.prototype.get = function (arg) {
    if (arg in dataBase) {
      return dataBase[arg];
    } else {
      return dataBase;
    }
  };

  return new controller();
}

var sql = new SqlBase(); // 创建一个数据库

function SlogConstruct() {
  var M = 1024 * 1024;
  var G = 1024 * M;
  var NAMED_DATE = 'date'; // 以时间日期为格式，命名

  var NAMED_ORDER = 'order'; // 以字符串加索引命名

  var DEFAULT_DATE_FORMAT = 'y-m-d-his'; // 默认日期格式

  var LIMIT_BY_COUNT = 'count';
  var videoBuffer = null; // 保存当前正在录的这一集视频buffer

  var videoView = null; // 操作当前buffer的视图

  var bufferIndex = 0; // 计数当前视频中，下载了多少长度的数据

  var status = void 0; // 保存当前的程序的运行状态

  var davVideo = null; // 保存当前正在录的dav的实例

  function constructor() {
    // 这个onMessage方法，是给外部的实例对象重写用的
    this.onMessage = function () {};
    /*
    * 这里写一个postmessage，只是为了下面代码看起来不是那么怪异
    * 但是这里还是很怪异的
    * 因为这份代码是从worker改过来的
    */


    this.postMessage = function (options) {
      this.__onMessage(options);
    };

    this.__postMessage = function (data) {
      this.onMessage(data);
    };
  }

  constructor.prototype.__onMessage = function (options) {
    var data = options;

    switch (data.type) {
      case 'init':
        // 初始化下载流程，可以设置各种限制条件
        this.init(data.options);
        break;

      case 'addBuffer':
        this.addBuffer(data);
        break;

      case 'close':
        // 结束视频下载
        this.close();
        break;

      default:
        break;
    }
  };

  constructor.prototype.init = function (options) {
    this.fullSize = options.fullSize || Infinity; // 单次登录的录像总量默认不设上限

    this.singleSize = options.singleSize + 20 * M || 520 * M; // 单个视频下载上限，默认500M,预留20M空间

    status = 'init';
    /*
    * 用来保存限制条件
    * 限制条件可以是:
    * 按照总量大小限制， 优先级最高
    * 按视频下载个数限制
    * 按时长下载限制
    */

    this.limitOptions = Object.assign({
      limitBy: 'fullSize'
    }, options.limitOptions);
    /*
    * 文件命名的限制条件
    * 目前以日期来命名
    */

    this.nameOptions = Object.assign({
      namedBy: 'date',
      nameFormat: ['ymd_his', {}]
    }, options.nameOptions);
  };
  /*
  * 创建一个指定大小的内存空间
  */


  constructor.prototype._malloc = function (size) {
    if (videoBuffer && videoView) {
      videoView = null;
      videoBuffer = null;
    }

    videoBuffer = new ArrayBuffer(size);
    videoView = new DataView(videoBuffer);
    var nameOptions = this.nameOptions;
    var name = ''; // 根据不同的命名格式，传入不同的名称

    switch (this.nameOptions.namedBy.toLowerCase()) {
      case 'date':
        name = getFileNameByDate(nameOptions);
        break;

      default:
        // 使用默认的以日期为标准的命名
        name = getFileNameByDate();
        break;
    }

    davVideo = new DavVideo(name);
  };

  constructor.prototype._initVideoMem = function () {
    if (!videoBuffer && this.singleSize) {
      this._malloc(this.singleSize); // 设置内存大小

    }
  }; // 向视频存储空间追加数据


  constructor.prototype.appendVideoBuf = function (buffer) {
    var len = buffer.byteLength;
    var endLen = bufferIndex + len; // 加上当前数据后，视频会有多大
    // 这个20M是初始化时附加的值，为了保护内存可能会存在溢出的情况，为了保险

    if (endLen > this.singleSize - 20 * M) {
      this.inNodePlace(); // 这一集超了，到达一个下载节点

      this.addBuffer({
        buffer: buffer
      }); // 重启下一轮的下载
    } else {
      for (var i = bufferIndex; i < endLen; i++) {
        videoView.setUint8(i, buffer[i - bufferIndex]);
      }

      bufferIndex = endLen; // 移动标志位
      // 监控视频的当前状态

      this.__postMessage({
        type: 'pendding',
        size: bufferIndex,
        total: this.singleSize
      });
    }
  }; // 接收从sockt中传来的buf数据


  constructor.prototype.addBuffer = function (options) {
    // 当录像结束的时候，可能还有最后一个包数据进入，此时应该丢弃数据
    if (status === 'closed') return;
    var buffer = options.buffer;

    this._initVideoMem(); // 初始化当前视频的内存


    status = 'addBuffer';
    var len = buffer.length;
    var endLen = bufferIndex + len; // 加上当前数据后，视频会有多大
    // 总量超出，则停止下载,总量超出永远都是第一序列

    if (sql.get('total') + endLen > this.fullSize) {
      this.close();
      return;
    } else {
      /*
      * 个数验证的条件不用在这里处理
      * 个数上限的验证，应该是在传递下载内容时，进行拦截
      */
      // 没有触发限定条件，则追加视频数据
      this.appendVideoBuf(buffer);
    }
  };
  /*
  * 到了一个下载节点
  */


  constructor.prototype.inNodePlace = function () {
    if (status === 'addBuffer') {
      status = 'download';
      davVideo.updateNameByStream(this.nameOptions, videoBuffer.slice(0, 20)); // 使用码流中的日期作为文件名

      davVideo.byteLength = bufferIndex;
      davVideo.setEndTime(); // 为当前实例添加上结束时间

      sql.add(davVideo); // 将当前实例保存起来

      var tmpBuf = videoBuffer.slice(0, bufferIndex);
      this.reset(); // 重置内存空间

      this.__postMessage({
        type: 'download',
        data: _objectSpread(_objectSpread({}, davVideo), {}, {
          buffer: tmpBuf
        })
      }); // 要保证程序是同步执行的，而且这个数据是要清除的


      tmpBuf = null; // 如果当前的限制条件是个数限制

      if (this.limitOptions.limitBy === LIMIT_BY_COUNT) {
        /*
        * 限制条数必须设置，如果不设置，则默认限制个数的条件无效
        * 当限制个数存在，且达到上限则关闭录像
        */
        var limitCount = this.limitOptions.count;

        if (limitCount && limitCount === sql.get('count')) {
          this.close();
        }
      }
    }
  };
  /*
  * 将初始设置还原
  */


  constructor.prototype.reset = function () {
    bufferIndex = 0; // 还原索引标志位

    this._malloc(this.singleSize); // 重设设内存大小

  };
  /*
  * 关闭下载
  */


  constructor.prototype.close = function () {
    this.inNodePlace(); // 立即结束当前节点，并发送下载信息
    // 当前状态不是关闭状态，也不是初始状态，则进行关闭操作

    if (status !== 'closed' && status !== void 0) {
      status = 'closed';

      this.__postMessage({
        type: 'closed',
        message: 'record was closed'
      });

      videoBuffer = null; // 关闭之后需要清除变量的设置

      videoView = null;
    } else {
      /*
      * 当关闭下载是因为触发了限制条件，才关闭时，会向上层传递closed信息
      * 此时状态已经是closed
      * 上层接收到closed信息，则会下发关闭下载指令，清除socket的引用
      * 并再次触发close事件，此时因为已经是closed了，没必要再向上层重复上传信息
      * 所以用!=closed拦截掉
      * 即使这里不用!=closed拦截，也不会引起死循环，只是会多出发一次closed的回环操作
      * 当socket被清除之后，就没有函数在执行了
      */
    }
  };

  return new constructor();
}

/* harmony default export */ var src_localRecord = (SlogConstruct); // receiveMessage init e.g.

/*
* @namespace options 当前传入的options对象，下面参数都是options的元素
* @props fullSize [int] 当前视频总量大小
* @props singleSize [int] 单个视频下载大小
* @props nameOptions [object] 命名空间，缺省则默认以日期为文件名
* @props nameOptions.namedBy [string] 命名依据，目前只写了日期格式的
* @props nameOptions.nameFormat [array(string, object)] 命名格式，目前只针对日期做了出路
* @props limitOptions [object] 下载限制条件
* @props limitOptions.limitBy [string] 当前下载的限制条件，默认限制总量大小fullSize,
* @props limitOptions.limitBy [string] count，文件个数，其他条件暂时未添加
*/

/*DAVWorker.postMessage({
    type: 'init',
    options: {
        fullSize: 20 * M,
        singleSize: 2 * M,
        nameOptions: {
            namedBy: 'date',
            nameFormat: ['{vendor}_ymd_his', {
                vendor: 'dahua'
            }]
        },
        limitOptions: {
            limitBy: 'count',
            count: 2
        }
    }
});
*/
// CONCATENATED MODULE: ./src/WebsocketServerPrivate.js
/**
 * Created by 33596 on 2018/4/26.
 */
// 建立ws链接，发送RTSP信令，传递媒体数据





/*
* @params options [object] 扩展对象
*/

var WebsocketServerPrivate_WebsocketServerPrivate = function WebsocketServerPrivate(options) {
  var wsURL = options.wsURL;
  var privateUrl = options.rtspURL;
  var ws = null;
  var isTalkService = options.isTalkService;
  var realm = options.realm;
  var RRIVATE_INTERLEAVE_LENGTH = 6;
  var PRIVATEResArray = null;
  var privateinterleave = null;
  var sockDataRemaining = 0;
  var RTPPacketTotalSize = 0;
  var AUTHORIZATION_INFO = 'Authorization: WSSE profile="UsernameToken"';
  var isFileOffset = privateUrl.search('&srctype=raw') !== -1; //当rtsp数据制作透传的时候，rtsp的URL中有&srctype=raw，代表是透传数据。目前用于MP4的视频播放

  var mp4MovieParse = new MP4MovieParse_MP4MovieParse();
  var RTSP_STATE = options.RTSP_STATE;
  var workerManager = options.workerManager;
  var localRecord = new src_localRecord();
  var isOpenLocalRecord = false; // 开启本地录像的标志信息

  var recordChanged = new Function(); // 监控本地录像的回调函数

  var SEND_GETPARM_INTERVAL = 1e4 * 4;
  var Authentication = null;
  var SDPinfo = [];
  var Cseq = 0;

  var errorCallbackFunc = function errorCallbackFunc() {};

  var privateSDPData = {};
  var currentState = 'UnAuthorized';
  var getParameterIntervalHandler = null;
  var AACCodecInfo = {};
  var GetFrameCallback = null;
  var GetFirstFrameCallback = null;
  var isFirstFrame = true;
  var user = {};
  var precommand = '';
  var isPlayback = false; //判断是否是回放

  var playBackRange = 0; //录像开始播放秒数

  var connectTimeout = 0; //连接超时定时器

  var isSentAuthorized = false;
  var METHOD = {
    PLAY: 0,
    PAUSE: 1,
    KEEP_LIVE: 2,
    STOP: 3
  };
  /*
  * 如果当前的socket是给本地录像用的
  * 那么要重写workerManger的方法内容，用来兼容下面的业务
  */

  if (options.isRecord) {
    // 方法数组中，值只需要设置重写几个特殊的方法即可，其他在本地录像中用不到
    var fnArr = ['init', 'sendSdpInfo', 'parseRTPData', 'setCallback'];
    fnArr.forEach(function (v, index) {
      workerManager[v] = function () {// console.log(v);
      };
    });
    var M = 1024 * 1024; // 一兆
    // 初始化下载流程

    localRecord.postMessage({
      type: 'init',
      options: {
        // fullSize: 1024 * M, 单次登录的下载上限，默认无限制
        singleSize: 500 * M,
        nameOptions: {
          namedBy: 'date',
          nameFormat: ['ymd_his']
        },
        limitOptions: {
          limitBy: 'count',
          count: 10
        }
      }
    }); // 重写实例的接收函数

    localRecord.onMessage = function (data) {
      switch (data.type) {
        case 'pendding':
          // 下载进行时
          recordChanged(data);
          break;

        case 'download':
          // 触发下载
          writeFile(data.data.name, data.data.buffer);
          break;

        case 'closed':
          recordChanged(data);
          isOpenLocalRecord = false;
          break;

        default:
          break;
      }
    };
  }

  function Constructor() {}

  Constructor.prototype = {
    connect: function connect() {
      if (ws) return; //蜂鸟通过workerReady事件回调来connect，同一个Player会调用connect多次导致无法正确拉流

      ws = new WebSocket(wsURL);
      ws.binaryType = 'arraybuffer';
      ws.fileOver = false; //用于记录文件传输完毕

      ws.addEventListener('message', receiveMessage, false);

      ws.onopen = function () {
        Authentication = AUTHORIZATION_INFO;
        SendPrivateCommand(CommandConstructor(METHOD.PLAY, playBackRange));
      };

      ws.onerror = function (obj) {
        errorCallbackFunc({
          errorCode: 202,
          description: 'Open WebSocket Error'
        });
      };

      ws.onclose = function (obj) {
        if (ws && !ws.fileOver) {
          errorCallbackFunc({
            errorCode: 202,
            description: 'Open WebSocket Error'
          });
        }
      };
    },
    disconnect: function disconnect() {
      SendPrivateCommand(CommandConstructor(METHOD.STOP, null));
      clearInterval(getParameterIntervalHandler);
      getParameterIntervalHandler = null;

      if (ws) {
        ws.onerror = null;
        ws.close();
        ws = null;
      }

      workerManager.terminate();
      connectTimeout && clearTimeout(connectTimeout);
    },
    controlPlayer: function controlPlayer(controlInfo) {
      var command = '';
      var info = null;
      precommand = controlInfo.command;

      switch (controlInfo.command) {
        case 'PLAY':
          workerManager.play();

          if (currentState === 'Pause') {
            currentState = 'ContinuePlay';
          }

          if (controlInfo.range !== null && controlInfo.range !== undefined) {
            command = CommandConstructor(METHOD.PLAY, controlInfo.range);
            break;
          }

          command = CommandConstructor(METHOD.PLAY, null);

          if (precommand) {
            workerManager.initStartTime(); //重置解码开始时间
          }

          break;

        case 'PAUSE':
          if (currentState === 'PAUSE') {
            break;
          }

          currentState = 'PAUSE';
          command = CommandConstructor(METHOD.PAUSE, null);
          workerManager.pause();
          break;

        case 'TEARDOWN':
          command = CommandConstructor(METHOD.STOP, null);
          break;

        case 'audioPlay':
          if (controlInfo.data === 'start') {
            // 暂停之后继续播放
            currentState = 'Playing';
            command = CommandConstructor('PLAY', controlInfo.range);
          } else if (controlInfo.data === 'stop') {
            // 直接停止播放
            command = CommandConstructor('TEARDOWN', null);
          } else {
            if (currentState === 'PAUSE') {
              break;
            }

            currentState = 'PAUSE';
            command = CommandConstructor('PAUSE', null);
          }

          workerManager.controlAudio(controlInfo.command, controlInfo.data);
          break;

        case 'volumn':
        case 'audioSamplingRate':
          workerManager.controlAudio(controlInfo.command, controlInfo.data);
          break;

        case 'playNextFrame':
          // 当缓存的帧数少于5帧的时候，重新拉1s的流
          if (workerManager.getVideoBufferQueueSize() < 5) {
            this.getNextFrameData(1000);
          }

          workerManager.playNextFrame();
          break;

        case 'getCurFrameInfo':
          // 训练服务器新增获取帧信息
          // 当缓存的帧数少于10帧的时候，重新拉2s的流
          // if (workerManager.getVideoBufferQueueSize() < 10) {
          //     this.getNextFrameData(2000);
          // }
          info = workerManager.getCurFrameInfo();
          break;

        case 'getCapture':
          // 训练服务器新增抓图方法
          workerManager.getCapture();
          break;

        case 'startRecod':
          // 无插件录像
          isOpenLocalRecord = controlInfo.data;

          if (!isOpenLocalRecord) {
            localRecord.postMessage({
              type: 'close'
            });
          }

          break;

        default:
          debug.log('未知指令: ' + controlInfo.command);
      }

      if (command != '') {
        SendPrivateCommand(command);
      }

      if (info) {
        return info;
      }
    },
    setLiveMode: function setLiveMode(mode) {
      workerManager.setLiveMode(mode);
    },
    setPlayMode: function setPlayMode(mode, range) {
      isPlayback = mode;
      playBackRange = range;
      workerManager.setPlayMode(mode);
    },
    setSignalURL: function setSignalURL(path) {
      privateUrl = path;
    },
    setCallback: function setCallback(type, func) {
      if (type === 'GetFrameRate') {
        GetFrameCallback = func;
      } else if (type === 'GetFirstFrame') {
        GetFirstFrameCallback = func;
      } else if (type === 'recordChanged') {
        recordChanged = func;
      } else {
        workerManager.setCallback(type, func);
      }

      if (type == 'Error') {
        errorCallbackFunc = func;
      }
    },
    setUserInfo: function setUserInfo(username, password) {
      user.username = username;
      user.passWord = password;
    },

    /**
    * 重新获取time秒的数据，用于下一帧的播放
    * @param {number} time 
    */
    getNextFrameData: function getNextFrameData(time) {
      SendPrivateCommand(CommandConstructor('PLAY', null));
      setTimeout(function () {
        SendPrivateCommand(CommandConstructor('PAUSE', null));
      }, time);
    }
  };

  function generateCnoce() {
    var getRandValue = function getRandValue() {
      return Math.random() * 256 | 0; //ascii码256个，取整
    };

    var md5Hash = [];

    for (var i = 0; i < 32; i++) {
      md5Hash.push(String.fromCharCode(getRandValue()));
    }

    return md5(md5Hash.join(''));
    MD5加密一下;
  }

  function createGMTStamp() {
    var time = new Date(); // 与格林尼治时间差（当前时区为东八区）

    var offset = time.getTimezoneOffset(); // => -480 因为格林尼治时间比本地时间小8h
    // 格林尼治的当前时间的时间戳

    var stampGTM = time.getTime() + offset * 60 * 1000;
    var newTime = new Date(stampGTM);
    var y = newTime.getFullYear();
    var m = newTime.getMonth() + 1;
    var d = newTime.getDate();
    var h = newTime.getHours();
    var mm = newTime.getMinutes();
    var s = newTime.getSeconds();

    var add = function add(m) {
      return m < 10 ? '0' + m : m;
    };

    return y + '-' + add(m) + '-' + add(d) + 'T' + add(h) + ':' + add(mm) + ':' + add(s) + 'Z';
  }

  function CommandConstructor(method, range) {
    var sendMessage = '';
    var sdpInfo = '';
    var ha1 = md5(user.username + ':' + realm + ':' + user.password);
    var host = wsURL.split('://')[1].split('/')[0].split(':')[0] + ':8086'; //设备端口默认8086;

    switch (method) {
      case 0:
        var Nonce = generateCnoce();
        var Created = createGMTStamp();
        var PasswordDigest = encodeToBase64Code(strToHexCode(sha1(Nonce + Created + ha1.toUpperCase())));
        sendMessage = 'GET ' + privateUrl + (isPlayback ? '?' : '&') + 'method=' + method + ' HTTP/1.1' + '\r\n';
        sendMessage += 'Accept-Sdp: Private\r\n';
        sendMessage += Authentication + '\r\n';
        sendMessage += 'Connection: keep-alive\r\nCseq: ' + Cseq + '\r\nHost: ' + host + '\r\n';

        if (range) {
          sendMessage += 'Range: npt=' + range + '-' + '\r\n';
        } else {
          if (currentState !== 'ContinuePlay') {
            //暂停后继续播放时不带Range参数
            sendMessage += 'Range: npt=0.000000-' + '\r\n';
          }
        }

        if (isTalkService === true) {
          sdpInfo += 'v=0' + '\r\n';
          sdpInfo += 'o=- 2208989105 2208989105 IN IP4 0.0.0.0' + '\r\n';
          sdpInfo += 's=Media Server' + '\r\n';
          sdpInfo += 'c=IN IP4 0.0.0.0' + '\r\n';
          sdpInfo += 't=0 0' + '\r\n';
          sdpInfo += 'a=control:*' + '\r\n';
          sdpInfo += 'a=packetization-supported:DH' + '\r\n';
          sdpInfo += 'a=rtppayload-supported:DH' + '\r\n';
          sdpInfo += 'a=range:npt=now-' + '\r\n';
          sdpInfo += 'm=audio 0 RTP/AVP 8' + '\r\n';
          sdpInfo += 'a=control:trackID=5' + '\r\n';
          sdpInfo += 'a=rtpmap:8 PCMA/16000' + '\r\n';
          sdpInfo += 'a=sendonly' + '\r\n';
          sendMessage += 'Private-Length: ' + sdpInfo.length + '\r\n';
          sendMessage += 'Private-Type: application/sdp' + '\r\n';
        }

        if (Authentication === AUTHORIZATION_INFO) {
          //未鉴权时发送WSSE;
          sendMessage += 'WSSE: UsernameToken Username="' + user.username + '", PasswordDigest="' + PasswordDigest + '", Nonce="' + Nonce + '", Created="' + Created + '"' + '\r\n\r\n';
        } else {
          sendMessage += '\r\n';
        }

        sendMessage += sdpInfo;
        break;

      case 1:
        sendMessage = 'GET ' + privateUrl + '?method=' + method + ' HTTP/1.1' + '\r\n';
        sendMessage += 'Connection: keep-alive\r\nCseq: ' + Cseq + '\r\nHost: ' + host + '\r\n\r\n';
        break;

      case 2:
      case 3:
        sendMessage = 'GET ' + privateUrl + (isPlayback ? '?' : '&') + 'method=' + method + ' HTTP/1.1' + '\r\n';
        sendMessage += 'Connection: keep-alive\r\nCseq: ' + Cseq + '\r\nHost: ' + host + '\r\n\r\n';
        break;

      default:
        break;
    }

    debug.log(sendMessage);
    return sendMessage;
  }

  ;

  function PrivateResponseHandler(stringMessage) {
    debug.log(stringMessage);
    var privateResponseMsg = {};
    var seekPoint = stringMessage.search('Cseq: ') + 5;
    Cseq = parseInt(stringMessage.slice(seekPoint, seekPoint + 10)) + 1;

    if (isNaN(Cseq)) {
      Cseq = 1;
    }

    privateResponseMsg = parsePrivateResponse(stringMessage);

    if (privateResponseMsg.ResponseCode === RTSP_STATE.UNAUTHORIZED && Authentication === AUTHORIZATION_INFO) {
      //未鉴权
      formDigestAuthHeader(privateResponseMsg);
    } else if (privateResponseMsg.ResponseCode === RTSP_STATE.OK) {
      if (currentState === 'UnAuthorized') {
        privateSDPData = parseDescribeResponse(stringMessage);
        var idx = 0;

        for (idx = 0; idx < privateSDPData.Sessions.length; idx = idx + 1) {
          var sdpInfoObj = {};

          if (privateSDPData.Sessions[idx].CodecMime === 'JPEG' || privateSDPData.Sessions[idx].CodecMime === 'H264' || privateSDPData.Sessions[idx].CodecMime === 'H265' || privateSDPData.Sessions[idx].CodecMime == 'H264-SVC' || privateSDPData.Sessions[idx].CodecMime == 'RAW') {
            sdpInfoObj.codecName = privateSDPData.Sessions[idx].CodecMime;

            if (privateSDPData.Sessions[idx].CodecMime === 'H264-SVC') {
              sdpInfoObj.codecName = 'H264';
            }

            if (privateSDPData.Sessions[idx].CodecMime === 'H265' || privateSDPData.Sessions[idx].CodecMime === 'RAW') {
              Constructor.prototype.setLiveMode('canvas');
            }

            sdpInfoObj.trackID = privateSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = privateSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(privateSDPData.Sessions[idx].Port);

            if (typeof privateSDPData.Sessions[idx].Framerate !== 'undefined') {
              sdpInfoObj.Framerate = parseInt(privateSDPData.Sessions[idx].Framerate);
              workerManager.setFPS(sdpInfoObj.Framerate); //debug.log(GetFrameCallback)

              GetFrameCallback(sdpInfoObj.Framerate);
            }

            SDPinfo.push(sdpInfoObj);
          } else if (privateSDPData.Sessions[idx].CodecMime === 'PCMU' || privateSDPData.Sessions[idx].CodecMime.search('G726-16') !== -1 || privateSDPData.Sessions[idx].CodecMime.search('G726-24') !== -1 || privateSDPData.Sessions[idx].CodecMime.search('G726-32') !== -1 || privateSDPData.Sessions[idx].CodecMime.search('G726-40') !== -1 || privateSDPData.Sessions[idx].CodecMime === 'PCMA' || privateSDPData.Sessions[idx].CodecMime.search("G723.1") !== -1 || privateSDPData.Sessions[idx].CodecMime.search("G729") !== -1 || privateSDPData.Sessions[idx].CodecMime.search("MPA") !== -1 || privateSDPData.Sessions[idx].CodecMime.search("L16") !== -1) {
            if (privateSDPData.Sessions[idx].CodecMime === 'PCMU') {
              sdpInfoObj.codecName = 'G.711Mu';
            } else if (privateSDPData.Sessions[idx].CodecMime === 'G726-16') {
              sdpInfoObj.codecName = 'G.726-16';
            } else if (privateSDPData.Sessions[idx].CodecMime === 'G726-24') {
              sdpInfoObj.codecName = 'G.726-24';
            } else if (privateSDPData.Sessions[idx].CodecMime === 'G726-32') {
              sdpInfoObj.codecName = 'G.726-32';
            } else if (privateSDPData.Sessions[idx].CodecMime === 'G726-40') {
              sdpInfoObj.codecName = 'G.726-40';
            } else if (privateSDPData.Sessions[idx].CodecMime === 'PCMA') {
              sdpInfoObj.codecName = 'G.711A';
            } else if (privateSDPData.Sessions[idx].CodecMime === "G723.1") {
              sdpInfoObj.codecName = "G.723";
            } else if (privateSDPData.Sessions[idx].CodecMime === "G729") {
              sdpInfoObj.codecName = "G.729";
            } else if (privateSDPData.Sessions[idx].CodecMime === "MPA") {
              sdpInfoObj.codecName = "mpeg2";
            } else if (privateSDPData.Sessions[idx].CodecMime === "L16") {
              sdpInfoObj.codecName = "PCM";
            }

            sdpInfoObj.trackID = privateSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = privateSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(privateSDPData.Sessions[idx].Port);
            sdpInfoObj.Bitrate = parseInt(privateSDPData.Sessions[idx].Bitrate);
            sdpInfoObj.TalkTransType = privateSDPData.Sessions[idx].TalkTransType; //设置对讲的传输类型

            SDPinfo.push(sdpInfoObj); //}
          } else if (privateSDPData.Sessions[idx].CodecMime === 'mpeg4-generic' || privateSDPData.Sessions[idx].CodecMime === 'MPEG4-GENERIC') {
            sdpInfoObj.codecName = 'mpeg4-generic';
            sdpInfoObj.trackID = privateSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = privateSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(privateSDPData.Sessions[idx].Port);
            sdpInfoObj.Bitrate = parseInt(privateSDPData.Sessions[idx].Bitrate);
            sdpInfoObj.TalkTransType = privateSDPData.Sessions[idx].TalkTransType; //设置对讲的传输类型

            SDPinfo.push(sdpInfoObj);
          } else if (privateSDPData.Sessions[idx].CodecMime === 'vnd.onvif.metadata') {
            sdpInfoObj.codecName = 'MetaData';
            sdpInfoObj.trackID = privateSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = privateSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(privateSDPData.Sessions[idx].Port);
            SDPinfo.push(sdpInfoObj);
          } else if (privateSDPData.Sessions[idx].CodecMime === 'stream-assist-frame') {
            sdpInfoObj.codecName = 'stream-assist-frame';
            sdpInfoObj.trackID = privateSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = privateSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(privateSDPData.Sessions[idx].Port);
            SDPinfo.push(sdpInfoObj);
          } else {
            if (privateSDPData.Sessions[idx].Type === 'audio') {
              //音频格式不支持
              errorCallbackFunc({
                errorCode: 201
              });
            }

            debug.log('Unknown codec type:', privateSDPData.Sessions[idx].CodecMime, privateSDPData.Sessions[idx].ControlURL);
          }
        }

        if (isTalkService === false) {
          errorCallbackFunc({
            errorCode: 404,
            description: 'rtsp not found'
          });
          return;
        }

        for (var i = 0; i < SDPinfo.length; i++) {
          SDPinfo[i].RtpInterlevedID = (SDPinfo[i].trackID.split('=')[1] - 0) * 2;
        } //rtsp透传数据的时候（MP4播放时），rtsp不提供视频和视频中音频的编码格式，所以这里可以先不传sdp数据，等视频的moov解出来之后，再通过CodecCallback方法传


        !isFileOffset && workerManager.sendSdpInfo(SDPinfo, AACCodecInfo);

        if (isTalkService === true) {
          workerManager.setCallback("audioTalk", SendAudioTalkData); //如果开启了对讲，则将收集到的音频发送给设备
        }

        clearInterval(getParameterIntervalHandler);
        getParameterIntervalHandler = setInterval(function () {
          return SendPrivateCommand(CommandConstructor(METHOD.KEEP_LIVE, null));
        }, SEND_GETPARM_INTERVAL);
        currentState = 'Playing';
      } else if (currentState === 'ContinuePlay') {
        currentState = 'Playing';
      } else if (currentState === 'Playing') {//不做任何处理
      } else {
        debug.log('unknown rtsp state:' + currentState);
      }
    } else if (privateResponseMsg.ResponseCode === RTSP_STATE.NOTSERVICE) {
      if (isTalkService === true) {
        errorCallbackFunc({
          errorCode: 504,
          description: 'Talk Service Unavilable',
          place: 'RtspClient.js'
        });
        return;
      } else {
        errorCallbackFunc({
          errorCode: 503,
          description: 'Service Unavilable'
        });
        return;
      }
    } else if (privateResponseMsg.ResponseCode === RTSP_STATE.NOTFOUND) {
      errorCallbackFunc({
        errorCode: 404,
        description: 'rtsp not found'
      });
      return;
    } else if (privateResponseMsg.ResponseCode === RTSP_STATE.INTERNALSERVERERROR) {
      errorCallbackFunc({
        errorCode: 500,
        description: 'Internal Server Error'
      });
      return;
    }
  }

  function formDigestAuthHeader(stringMessage) {
    var username = user.username;
    var password = user.passWord; //暂时写死

    var digestInfo = {
      Method: null,
      Realm: null,
      Nonce: null,
      Uri: null
    };
    var response = null;
    digestInfo = {
      Method: 'GET',
      Realm: stringMessage.Realm,
      Nonce: stringMessage.Nonce,
      Uri: privateUrl
    };
    response = formAuthorizationResponse(username, password, digestInfo.Uri, digestInfo.Realm, digestInfo.Nonce, digestInfo.Method);
    Authentication = 'Authorization: Digest username="' + username + '", realm="' + digestInfo.Realm + '",';
    Authentication += ' nonce="' + digestInfo.Nonce + '", uri="' + digestInfo.Uri + '", response="' + response + '"';
    SendPrivateCommand(CommandConstructor(METHOD.PLAY, playBackRange));
  }

  function SendPrivateCommand(sendMessage) {
    if (sendMessage == undefined || sendMessage == null || sendMessage == '') {
      return;
    }

    if (ws && ws.readyState === WebSocket.OPEN) {
      sendMessage != undefined && ws.send(stringToUint8Array(sendMessage));
    } else {
      debug.log('ws未连接');
    }
  }
  /**
   * 字符串转16进制整数数组
   */


  function strToHexCode(hexCharCodeStr) {
    var trimedStr = hexCharCodeStr.trim();
    var rawStr = trimedStr.substr(0, 2).toLowerCase() === '0x' ? trimedStr.substr(2) : trimedStr;
    var len = rawStr.length;

    if (len % 2 !== 0) {
      return ''; //存在非法字符
    }

    var curCharCode;
    var resultStr = [];

    for (var i = 0; i < len; i = i + 2) {
      curCharCode = parseInt(rawStr.substr(i, 2), 16); //resultStr.push(String.fromCharCode(curCharCode));

      resultStr.push(curCharCode);
    }

    return resultStr; //return resultStr.join('');
  }
  /**
   * 转成base64
   */


  function encodeToBase64Code(binary) {
    var _keyStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
    var output = '';
    var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
    var i = 0;

    while (i < binary.length) {
      chr1 = binary[i++];
      chr2 = binary[i++];
      chr3 = binary[i++];
      enc1 = chr1 >> 2;
      enc2 = (chr1 & 3) << 4 | chr2 >> 4;
      enc3 = (chr2 & 15) << 2 | chr3 >> 6;
      enc4 = chr3 & 63;

      if (isNaN(chr2)) {
        enc3 = enc4 = 64;
      } else if (isNaN(chr3)) {
        enc4 = 64;
      }

      output = output + _keyStr.charAt(enc1) + _keyStr.charAt(enc2) + _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
    }

    return output;
  }
  /*
      向设备发起数据
  */


  function SendRtpData(rtpdata) {
    if (ws !== null && ws.readyState === WebSocket.OPEN) {
      ws.send(rtpdata);
    } else {
      debug.log('SendRtpData - Websocket does not exist');
    }
  }
  /*
      将大华包音频数据发送给设备
  */


  function SendAudioTalkData(rtpdata) {
    if (isTalkService === true) {
      SendRtpData(rtpdata);
    }
  }

  function receiveMessage(e) {
    var PreceiveUint8 = new Uint8Array();
    var receiveUint8 = new Uint8Array(e.data);
    PreceiveUint8 = new Uint8Array(receiveUint8.length);
    PreceiveUint8.set(receiveUint8, 0);
    sockDataRemaining = PreceiveUint8.length;

    while (sockDataRemaining > 0) {
      if (PreceiveUint8[0] !== 36) {
        var PreceiveMsg = String.fromCharCode.apply(null, PreceiveUint8);
        var privateEndpos = null;

        if (PreceiveMsg.indexOf('OffLine:File Over') !== -1) {
          //文件播放结束时
          ws.fileOver = true;
          workerManager.postRtspOver(); //发布rtsp结束消息
        }

        if (PreceiveMsg.indexOf('OffLine: KmsUnavailable') !== -1) {
          //KMS服务器未连接
          errorCallbackFunc({
            errorCode: 203
          });
          return;
        }

        if (PreceiveMsg.indexOf('OffLine: CheckChannelAuthFailed') !== -1) {
          //通道鉴权失败
          errorCallbackFunc({
            errorCode: 204
          });
          return;
        }

        if (PreceiveMsg.indexOf('OffLine: PasswdUnitFailed') !== -1) {
          //密码未初始化禁止访问
          errorCallbackFunc({
            errorCode: 205
          });
          return;
        }

        if (PreceiveMsg.indexOf('OffLine: OverFlowMaxConnect') !== -1) {
          //达到连接数上限
          errorCallbackFunc({
            errorCode: 206
          });
          return;
        }

        if (PreceiveMsg.indexOf('OffLine: StreamSourceStartFailed') !== -1) {
          //开启码流失败
          errorCallbackFunc({
            errorCode: 404
          });
          return;
        }

        if (isSentAuthorized === false && PreceiveMsg.indexOf('200 OK') !== -1) {
          //鉴权成功，返回的数据最后没有空一行
          privateEndpos = PreceiveMsg.lastIndexOf('\r\n');
          isSentAuthorized = true;
        } else {
          privateEndpos = PreceiveMsg.search('\r\n\r\n'); //其他信令，返回的数据最后空一行
        }

        var privateStartpos = PreceiveMsg.search('HTTP');

        if (privateStartpos !== -1) {
          if (privateEndpos !== -1) {
            PRIVATEResArray = PreceiveUint8.subarray(privateStartpos, privateEndpos + RRIVATE_INTERLEAVE_LENGTH);
            PreceiveUint8 = PreceiveUint8.subarray(privateEndpos + RRIVATE_INTERLEAVE_LENGTH);
            var receiveMsg = String.fromCharCode.apply(null, PRIVATEResArray); // SendPrivateCommand(PrivateResponseHandler(receiveMsg));

            PrivateResponseHandler(receiveMsg);
            sockDataRemaining = PreceiveUint8.length;
          } else {
            sockDataRemaining = PreceiveUint8.length;
            return;
          }
        } else {
          PreceiveUint8 = new Uint8Array();
          return;
        }
      } else {
        //透传的MP4流数据（非固定传过来1帧）
        if (SDPinfo[0].codecName === 'RAW') {
          if (/.aac/.test(rtspUrl)) {
            // aac的裸数据
            workerManager.sendBufferToAudioWorker(PreceiveUint8.subarray(RRIVATE_INTERLEAVE_LENGTH, PreceiveUint8.length));
          } else {
            mp4MovieParse.setMovieData(PreceiveUint8.subarray(RRIVATE_INTERLEAVE_LENGTH, PreceiveUint8.length));
          }

          return;
        } else {
          if (isFirstFrame === true) {
            GetFirstFrameCallback && GetFirstFrameCallback();
          }

          isFirstFrame = false; //通用的dav视频帧数据（固定传过来1帧数据）

          privateinterleave = PreceiveUint8.subarray(0, RRIVATE_INTERLEAVE_LENGTH);
          RTPPacketTotalSize = privateinterleave[2] << 24 | privateinterleave[3] << 16 | privateinterleave[4] << 8 | privateinterleave[5];

          if (RTPPacketTotalSize + RRIVATE_INTERLEAVE_LENGTH <= PreceiveUint8.length) {
            //rtpheader = PreceiveUint8.subarray(RRIVATE_INTERLEAVE_LENGTH, 16);
            var DHPacketArray = PreceiveUint8.subarray(RRIVATE_INTERLEAVE_LENGTH, RTPPacketTotalSize + RRIVATE_INTERLEAVE_LENGTH);

            if (isOpenLocalRecord) {
              localRecord.postMessage({
                type: 'addBuffer',
                buffer: DHPacketArray
              });
            }

            workerManager.parseRTPData(privateinterleave, DHPacketArray);
            PreceiveUint8 = PreceiveUint8.subarray(RTPPacketTotalSize + RRIVATE_INTERLEAVE_LENGTH);
            sockDataRemaining = PreceiveUint8.length;
          } else {
            sockDataRemaining = PreceiveUint8.length;
            return;
          }
        }
      }
    }
  } //MP4的解码相关配置初始化


  mp4MovieParse.CodecCallback = function (mp4Codec) {
    // MP4的视频由于是透传过来的，所以在rtsp的sdp数据中没有视频的视频格式，音频格式。需要自己解析出moov之后再重新发给workerManager
    AACCodecInfo = mp4Codec.AudioCodecInfo;
    SDPinfo[0].Framerate = mp4Codec.Framerate;

    if (AACCodecInfo.VideoCodec === 'H264') {
      Constructor.prototype.setLiveMode('video');
    }

    workerManager.sendSdpInfo(SDPinfo, AACCodecInfo, mp4Codec);
  }; //MP4的每一帧的解码


  mp4MovieParse.TrackCallback = function (buffer) {
    //通过mp4MovieParse，解析出moov之后，每解出来1帧，就发布到这里去解码，迎合之前dav的流程
    var DHPacketArray = new Uint8Array(buffer.subarray(6, buffer.length)); // console.log(mp4MovieParse.parseToString(DHPacketArray));

    workerManager.parseRTPData(buffer.subarray(0, 6), DHPacketArray);
  };

  function parsePrivateResponse(message1) {
    var PrivateResponseData = {};
    var cnt = 0,
        cnt1 = 0,
        ttt = null,
        LineTokens = null;
    var message = null;

    if (message1.search('Private-Type: application/sdp') !== -1) {
      var messageTok = message1.split('\r\n\r\n');
      message = messageTok[0];
    } else {
      message = message1;
    }

    var TokenziedResponseLines = message.split('\r\n');
    var ResponseCodeTokens = TokenziedResponseLines[0].split(' ');

    if (ResponseCodeTokens.length > 2) {
      PrivateResponseData.ResponseCode = parseInt(ResponseCodeTokens[1]);
      PrivateResponseData.ResponseMessage = ResponseCodeTokens[2];
    }

    if (PrivateResponseData.ResponseCode === RTSP_STATE.OK) {
      for (cnt = 1; cnt < TokenziedResponseLines.length; cnt++) {
        LineTokens = TokenziedResponseLines[cnt].split(':');

        if (LineTokens[0] === 'Cseq') {
          PrivateResponseData.Cseq = parseInt(LineTokens[1]);
        } else if (LineTokens[0] === 'Private-Type') {
          PrivateResponseData.ContentType = LineTokens[1];

          if (PrivateResponseData.ContentType.search('application/sdp') !== -1) {
            PrivateResponseData.SDPData = parseDescribeResponse(message1);
          }
        } else if (LineTokens[0] === 'Private-Length') {
          PrivateResponseData.ContentLength = parseInt(LineTokens[1]);
        } else if (LineTokens[0] === 'Session-Id') {
          var SessionTokens = LineTokens[1].split(';');
          PrivateResponseData.SessionID = parseInt(SessionTokens[0]);
        }
      }
    } else if (PrivateResponseData.ResponseCode === RTSP_STATE.UNAUTHORIZED) {
      for (cnt = 1; cnt < TokenziedResponseLines.length; cnt++) {
        LineTokens = TokenziedResponseLines[cnt].split(':');

        if (LineTokens[0] === 'Cseq') {
          PrivateResponseData.Cseq = parseInt(LineTokens[1]);
        } else if (LineTokens[0] === 'WWW-Authenticate') {
          var AuthTokens = LineTokens[1].split(',');

          for (cnt1 = 0; cnt1 < AuthTokens.length; cnt1++) {
            var pos = AuthTokens[cnt1].search('Digest realm=');

            if (pos !== -1) {
              ttt = AuthTokens[cnt1].substr(pos + 13);
              var realmtok = ttt.split('"');
              PrivateResponseData.Realm = realmtok[1];
            }

            pos = AuthTokens[cnt1].search('nonce=');

            if (pos !== -1) {
              ttt = AuthTokens[cnt1].substr(pos + 6);
              var noncetok = ttt.split('"');
              PrivateResponseData.Nonce = noncetok[1];
            }
          }
        }
      }
    }

    return PrivateResponseData;
  }

  function parseDescribeResponse(message1) {
    var SDPData = {};
    var Sessions = [];
    SDPData.Sessions = Sessions;
    var message = null;

    if (message1.search('Private-Type: application/sdp') !== -1) {
      var messageTok = message1.split('\r\n\r\n');
      message = messageTok[1];
    } else {
      message = message1;
    }

    var TokenziedDescribe = message.split('\r\n');
    var cnt = 0;
    var mediaFound = false;

    for (cnt = 0; cnt < TokenziedDescribe.length; cnt++) {
      var SDPLineTokens = TokenziedDescribe[cnt].split('=');

      if (SDPLineTokens.length > 0) {
        switch (SDPLineTokens[0]) {
          case 'a':
            var aLineToken = SDPLineTokens[1].split(':');

            if (aLineToken.length > 1) {
              if (aLineToken[0] === 'control') {
                var pos = TokenziedDescribe[cnt].search('control:');

                if (mediaFound === true) {
                  if (pos !== -1) {
                    SDPData.Sessions[SDPData.Sessions.length - 1].ControlURL = TokenziedDescribe[cnt].substr(pos + 8);
                  }
                } else {
                  if (pos !== -1) {
                    SDPData.BaseURL = TokenziedDescribe[cnt].substr(pos + 8);
                  }
                }
              } else if (aLineToken[0] === 'rtpmap') {
                var rtpmapLine = aLineToken[1].split(' ');
                SDPData.Sessions[SDPData.Sessions.length - 1].PayloadType = rtpmapLine[0];
                var MimeLine = rtpmapLine[1].split('/');
                SDPData.Sessions[SDPData.Sessions.length - 1].CodecMime = MimeLine[0];

                if (MimeLine.length > 1) {
                  SDPData.Sessions[SDPData.Sessions.length - 1].ClockFreq = MimeLine[1];
                }
              } else if (aLineToken[0] === 'framesize') {
                var framesizeLine = aLineToken[1].split(' ');

                if (framesizeLine.length > 1) {
                  var framesizeinf = framesizeLine[1].split('-');
                  SDPData.Sessions[SDPData.Sessions.length - 1].Width = framesizeinf[0];
                  SDPData.Sessions[SDPData.Sessions.length - 1].Height = framesizeinf[1];
                }
              } else if (aLineToken[0] === 'framerate') {
                SDPData.Sessions[SDPData.Sessions.length - 1].Framerate = aLineToken[1];
              } else if (aLineToken[0] === 'fmtp') {
                var sessLine = TokenziedDescribe[cnt].split(' ');

                if (sessLine.length < 2) {
                  continue;
                }

                for (var ii = 1; ii < sessLine.length; ii++) {
                  var sessToken = sessLine[ii].split(';');
                  var sessprmcnt = 0;

                  for (sessprmcnt = 0; sessprmcnt < sessToken.length; sessprmcnt++) {
                    var ppos = sessToken[sessprmcnt].search('mode=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].mode = sessToken[sessprmcnt].substr(ppos + 5);
                    }

                    ppos = sessToken[sessprmcnt].search('config=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].config = sessToken[sessprmcnt].substr(ppos + 7);
                      AACCodecInfo.config = SDPData.Sessions[SDPData.Sessions.length - 1].config;
                      AACCodecInfo.clockFreq = SDPData.Sessions[SDPData.Sessions.length - 1].ClockFreq;
                      AACCodecInfo.bitrate = SDPData.Sessions[SDPData.Sessions.length - 1].Bitrate;
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-vps=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].VPS = sessToken[sessprmcnt].substr(ppos + 10);
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-sps=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].SPS = sessToken[sessprmcnt].substr(ppos + 10);
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-pps=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].PPS = sessToken[sessprmcnt].substr(ppos + 10);
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-parameter-sets=');

                    if (ppos !== -1) {
                      var SPSPPS = sessToken[sessprmcnt].substr(ppos + 21);
                      var SPSPPSTokenized = SPSPPS.split(',');

                      if (SPSPPSTokenized.length > 1) {
                        SDPData.Sessions[SDPData.Sessions.length - 1].SPS = SPSPPSTokenized[0];
                        SDPData.Sessions[SDPData.Sessions.length - 1].PPS = SPSPPSTokenized[1];
                      }
                    }
                  }
                }
              }
            } else if (aLineToken.length === 1) {
              //对讲中拆分后长度为1
              if (aLineToken[0] === 'recvonly') {
                SDPData.Sessions[SDPData.Sessions.length - 1].TalkTransType = 'recvonly';
              } else if (aLineToken[0] === 'sendonly') {
                SDPData.Sessions[SDPData.Sessions.length - 1].TalkTransType = 'sendonly';
              }
            }

            break;

          case 'm':
            var mLineToken = SDPLineTokens[1].split(' ');
            var Session = {};
            Session.Type = mLineToken[0];
            Session.Port = mLineToken[1];
            Session.Payload = mLineToken[3];
            SDPData.Sessions.push(Session);
            mediaFound = true;
            break;

          case 'b':
            if (mediaFound === true) {
              var bLineToken = SDPLineTokens[1].split(':');
              SDPData.Sessions[SDPData.Sessions.length - 1].Bitrate = bLineToken[1];
            }

            break;
        }
      }
    }

    if (isTalkService === true) {
      for (var idx = 0; idx < SDPData.Sessions.length; idx = idx + 1) {
        //私有信令，trackID等于1和2为伴音，过滤掉
        if (SDPData.Sessions[idx].ControlURL.split('=')[1] === '1' || SDPData.Sessions[idx].ControlURL.split('=')[1] === '2') {
          SDPData.Sessions.splice(idx, 1);
        }
      }
    }

    return SDPData;
  } // 录像dav格式的视频


  function writeFile(name, buffer) {
    name = (name || Date.now()) + '';
    name = name.toLowerCase().split('.dav')[0];
    var blob = new Blob([buffer]);
    var a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = name + '.dav';
    a.click();
    setTimeout(function () {
      URL.revokeObjectURL(a.href);
      a = null;
    }, 100);
    buffer = null;
  }

  return new Constructor();
};

/* harmony default export */ var src_WebsocketServerPrivate = (WebsocketServerPrivate_WebsocketServerPrivate);
// CONCATENATED MODULE: ./src/WebsocketServerRTSP.js
/**
 * Created by 33596 on 2018/4/26.
 */
// 建立ws链接，发送RTSP信令，传递媒体数据



/*
 * @params options [object] 扩展对象
 */

var WebsocketServerRTSP_WebsocketServerRTSP = function WebsocketServerRTSP(options) {
  var wsURL = options.wsURL;
  var rtspUrl = options.rtspURL;
  var ws = null;
  var isTalkService = options.isTalkService;
  var RTSP_INTERLEAVE_LENGTH = 6;
  var RTSPResArray = null;
  var rtspinterleave = null;
  var sockDataRemaining = 0;
  var RTPPacketTotalSize = 0;
  var IsDescribe = false;
  var describekey = false;
  var RTSP_STATE = options.RTSP_STATE;
  var isFileOffset = rtspUrl.search('&srctype=raw') !== -1; //当rtsp数据制作透传的时候，rtsp的URL中有&srctype=raw，代表是透传数据。目前用于MP4的视频播放

  var mp4MovieParse = new MP4MovieParse_MP4MovieParse();
  var workerManager = options.workerManager;
  var SEND_GETPARM_INTERVAL = 1e4 * 4;
  var Authentication = '';
  var SDPinfo = [];
  var CSeq = 1;

  var errorCallbackFunc = function errorCallbackFunc() {};

  var rtspSDPData = {};
  var currentState = 'Options';
  var setupSDPIndex = null;
  var SessionId = null;
  var mode = '';
  var getParameterIntervalHandler = null;
  var AACCodecInfo = {};
  var GetFrameCallback = null;
  var GetFirstFrameCallback = null;
  var isFirstFrame = true;
  var user = {};
  var precommand = '';
  var isPlayback = false; //判断是否是回放

  var playBackRange = 0; //录像开始播放秒数

  var connectTimeout = 0; //连接超时定时器

  var localRecord = new src_localRecord();
  var isOpenLocalRecord = false; // 开启本地录像的标志信息

  var recordChanged = new Function(); // 监控本地录像的回调函数

  /*
   * 如果当前的socket是给本地录像用的
   * 那么要重写workerManger的方法内容，用来兼容下面的业务
   */

  if (options.isRecord) {
    // 方法数组中，值只需要设置重写几个特殊的方法即可，其他在本地录像中用不到
    var fnArr = ['init', 'sendSdpInfo', 'parseRTPData', 'setCallback'];
    fnArr.forEach(function (v, index) {
      workerManager[v] = function () {// console.log(v);
      };
    });
    var M = 1024 * 1024; // 一兆
    // 初始化下载流程

    localRecord.postMessage({
      type: 'init',
      options: {
        // fullSize: 1024 * M, 单次登录的下载上限，默认无限制
        singleSize: 500 * M,
        nameOptions: {
          namedBy: 'date',
          nameFormat: ['ymd_his']
        },
        limitOptions: {
          limitBy: 'count',
          count: 10
        }
      }
    }); // 重写实例的接收函数

    localRecord.onMessage = function (data) {
      switch (data.type) {
        case 'pendding':
          // 下载进行时
          recordChanged(data);
          break;

        case 'download':
          // 触发下载
          writeFile(data.data.name, data.data.buffer);
          break;

        case 'closed':
          recordChanged(data);
          isOpenLocalRecord = false;
          break;

        default:
          break;
      }
    };
  }

  function Constructor() {}

  Constructor.prototype = {
    connect: function connect() {
      if (ws) return; //蜂鸟通过workerReady事件回调来connect，同一个Player会调用connect多次导致无法正确拉流

      ws = new WebSocket(wsURL);
      ws.binaryType = 'arraybuffer';
      ws.fileOver = false; //用于记录文件传输完毕

      ws.addEventListener('message', receiveMessage, false);

      ws.onopen = function () {
        var req = stringToUint8Array('OPTIONS ' + rtspUrl + ' RTSP/1.0\r\nCSeq: ' + CSeq + '\r\n\r\n');
        ws.send(req);
      };

      ws.onerror = function (obj) {
        errorCallbackFunc({
          errorCode: 202,
          description: 'Open WebSocket Error'
        });
      };

      ws.onclose = function (obj) {
        if (ws && !ws.fileOver) {
          errorCallbackFunc({
            errorCode: 202,
            description: 'Open WebSocket Error'
          });
        }
      };
    },
    disconnect: function disconnect() {
      SendRtspCommand(CommandConstructor('TEARDOWN', null, null));
      clearInterval(getParameterIntervalHandler);
      getParameterIntervalHandler = null;

      if (ws) {
        ws.close();
        ws = null;
        SessionId = null;
      }

      workerManager.terminate();
      connectTimeout && clearTimeout(connectTimeout);
    },
    controlPlayer: function controlPlayer(controlInfo) {
      var command = '';
      var info = null;
      precommand = controlInfo.command;

      switch (controlInfo.command) {
        case 'PLAY':
          currentState = 'Play';
          workerManager.play();

          if (controlInfo.range != null) {
            command = CommandConstructor('PLAY', null, null, controlInfo.range);
            break;
          }

          command = CommandConstructor('PLAY', null, null);

          if (precommand) {
            workerManager.initStartTime(); //重置解码开始时间
          }

          break;

        case 'PAUSE':
          if (currentState === 'PAUSE') {
            break;
          }

          currentState = 'PAUSE';
          command = CommandConstructor('PAUSE', null, null);
          workerManager.pause();
          break;

        case 'SCALE':
          command = CommandConstructor('SCALE', null, null, controlInfo.data);
          workerManager.playbackSpeed(controlInfo.data);
          break;

        case 'TEARDOWN':
          command = CommandConstructor('TEARDOWN', null, null);
          break;

        case 'audioPlay':
          if (controlInfo.data === 'start') {
            // 暂停之后继续播放
            currentState = 'Play';
            command = CommandConstructor('PLAY', null, null, controlInfo.range);
          } else if (controlInfo.data === 'stop') {
            // 直接停止播放
            command = CommandConstructor('TEARDOWN', null, null);
          } else {
            if (currentState === 'PAUSE') {
              break;
            }

            currentState = 'PAUSE';
            command = CommandConstructor('PAUSE', null, null);
          }

          workerManager.controlAudio(controlInfo.command, controlInfo.data);
          break;

        case 'volumn':
        case 'audioSamplingRate':
          console.log('websocketServerRtsp', controlInfo.data);
          workerManager.controlAudio(controlInfo.command, controlInfo.data);
          break;

        case 'playNextFrame':
          // 当缓存的帧数少于5帧的时候，重新拉1s的流
          if (workerManager.getVideoBufferQueueSize() < 5) {
            this.getNextFrameData(1000);
          }

          workerManager.playNextFrame();
          break;

        case 'getCurFrameInfo':
          // 训练服务器新增获取帧信息
          // 当缓存的帧数少于10帧的时候，重新拉2s的流
          // if (workerManager.getVideoBufferQueueSize() < 10) {
          //     this.getNextFrameData(2000);
          // }
          info = workerManager.getCurFrameInfo();
          break;

        case 'getCapture':
          // 训练服务器新增抓图方法
          workerManager.getCapture();
          break;

        case 'startRecod':
          // 无插件录像
          isOpenLocalRecord = controlInfo.data;

          if (!isOpenLocalRecord) {
            localRecord.postMessage({
              type: 'close'
            });
          }

          break;

        default:
          debug.log('未知指令: ' + controlInfo.command);
      }

      if (command != '') {
        SendRtspCommand(command);
      }

      if (info) {
        return info;
      }
    },
    setLiveMode: function setLiveMode(mode) {
      workerManager.setLiveMode(mode);
    },
    setPlayMode: function setPlayMode(mode, range) {
      isPlayback = mode;
      playBackRange = range;
      workerManager.setPlayMode(mode);
    },
    setSignalURL: function setSignalURL(path) {
      rtspUrl = path;
    },
    setCallback: function setCallback(type, func) {
      if (type === 'GetFrameRate') {
        GetFrameCallback = func;
      } else if (type === 'GetFirstFrame') {
        GetFirstFrameCallback = func;
      } else if (type === 'recordChanged') {
        recordChanged = func;
      } else {
        workerManager.setCallback(type, func);
      }

      if (type == 'Error') {
        errorCallbackFunc = func;
      }
    },
    setUserInfo: function setUserInfo(username, password) {
      user.username = username;
      user.passWord = password;
    },

    /**
     * 重新获取time秒的数据，用于下一帧的播放
     * @param {number} time 
     */
    getNextFrameData: function getNextFrameData(time) {
      SendRtspCommand(CommandConstructor('PLAY', null, null));
      setTimeout(function () {
        SendRtspCommand(CommandConstructor('PAUSE', null, null));
      }, time);
    }
  };

  function CommandConstructor(method, trackID, extHeader, range) {
    var sendMessage = '';

    switch (method) {
      case 'OPTIONS':
      case 'TEARDOWN':
      case 'GET_PARAMETER':
      case 'SET_PARAMETERS':
        sendMessage = method + ' ' + rtspUrl + ' RTSP/1.0\r\nCSeq: ' + CSeq + '\r\n' + Authentication + '\r\n';
        break;

      case 'DESCRIBE':
        sendMessage = method + " " + rtspUrl + " RTSP/1.0\r\nCSeq: " + CSeq;

        if (isTalkService === true) {
          //根据协议，如果是对讲，则需要带上www.onvif.org/ver20/backchannel。
          var requireStr = "www.onvif.org/ver20/backchannel";
          sendMessage = sendMessage + '\r\nRequire: ' + requireStr;
        }

        sendMessage = sendMessage + "\r\n" + Authentication + "\r\n";
        break;

      case 'SETUP':
        debug.log('trackID: ' + trackID);
        sendMessage = method + ' ' + rtspUrl + '/trackID=' + trackID + ' RTSP/1.0\r\nCSeq: ' + CSeq + '\r\n' + Authentication + 'Transport: DH/AVP/TCP;unicast;interleaved=' + trackID * 2 + '-' + (trackID * 2 + 1) + '\r\n';

        if (SessionId != 0) {
          sendMessage += 'Session: ' + SessionId + '\r\n\r\n';
        } else {
          sendMessage += '\r\n';
        }

        break;

      case 'PLAY':
        sendMessage = method + ' ' + rtspUrl + ' RTSP/1.0\r\nCSeq: ' + CSeq + '\r\n' + 'Session: ' + SessionId + '\r\n';

        if (range != undefined && range != 0) {
          //sendMessage += ("Scale: 3\r\n");
          //当rtsp数据制作透传的时候，seek的时候传的是文件大小的偏移量。用byte=1000-来跟原来的npt=1000-作区分
          sendMessage += "Range:".concat(isFileOffset ? 'byte' : 'npt', "=").concat(range, "-\r\n");
          sendMessage += Authentication + '\r\n';
        } else {
          //sendMessage += ('Range: npt=' + 0 + '-' + "\r\n");
          sendMessage += Authentication + '\r\n';
        }

        break;

      case 'PAUSE':
        sendMessage = method + ' ' + rtspUrl + ' RTSP/1.0\r\nCSeq: ' + CSeq + '\r\n' + 'Session: ' + SessionId + '\r\n\r\n';
        break;

      case 'SCALE':
        sendMessage = 'PLAY' + ' ' + rtspUrl + ' RTSP/1.0\r\nCSeq: ' + CSeq + '\r\n' + 'Session: ' + SessionId + '\r\n';
        sendMessage += 'Scale: ' + range + '\r\n';
        sendMessage += Authentication + '\r\n';
        break;

      default:
        break;
    }

    debug.log(sendMessage);
    return sendMessage;
  }

  function RtspResponseHandler(stringMessage) {
    debug.log(stringMessage);
    var rtspResponseMsg = {};
    var extraheader = '';
    var seekPoint = stringMessage.search('CSeq: ') + 5;
    CSeq = parseInt(stringMessage.slice(seekPoint, seekPoint + 10)) + 1;
    rtspResponseMsg = parseRtspResponse(stringMessage);

    if (rtspResponseMsg.ResponseCode === RTSP_STATE.UNAUTHORIZED && Authentication === '') {
      formDigestAuthHeader(rtspResponseMsg);
    } else if (rtspResponseMsg.ResponseCode === RTSP_STATE.OK) {
      if (currentState === 'Options') {
        currentState = 'Describe';
        connectTimeout = setTimeout(function () {
          //连接NVR没有连接IPC通道时 Describe信令无法返回
          errorCallbackFunc({
            errorCode: 404
          });
        }, 6000);
        return CommandConstructor('DESCRIBE', null, null);
      } else if (currentState === 'Describe') {
        connectTimeout && clearTimeout(connectTimeout);
        connectTimeout = 0;
        rtspSDPData = parseDescribeResponse(stringMessage);

        if (typeof rtspResponseMsg.ContentBase !== 'undefined') {
          rtspSDPData.ContentBase = rtspResponseMsg.ContentBase;
        }

        var idx = 0;

        for (idx = 0; idx < rtspSDPData.Sessions.length; idx = idx + 1) {
          var sdpInfoObj = {};

          if (rtspSDPData.Sessions[idx].CodecMime === 'JPEG' || rtspSDPData.Sessions[idx].CodecMime === 'H264' || rtspSDPData.Sessions[idx].CodecMime === 'H265' || rtspSDPData.Sessions[idx].CodecMime == 'H264-SVC' || rtspSDPData.Sessions[idx].CodecMime == 'RAW') {
            sdpInfoObj.codecName = rtspSDPData.Sessions[idx].CodecMime;

            if (rtspSDPData.Sessions[idx].CodecMime === 'H264-SVC') {
              sdpInfoObj.codecName = 'H264';
            }

            if (rtspSDPData.Sessions[idx].CodecMime === 'H265' || rtspSDPData.Sessions[idx].CodecMime === 'RAW') {
              Constructor.prototype.setLiveMode('canvas');
            }

            sdpInfoObj.trackID = rtspSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = rtspSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(rtspSDPData.Sessions[idx].Port);

            if (typeof rtspSDPData.Sessions[idx].Framerate !== 'undefined') {
              sdpInfoObj.Framerate = parseInt(rtspSDPData.Sessions[idx].Framerate);
              workerManager.setFPS(sdpInfoObj.Framerate); //debug.log(GetFrameCallback)

              GetFrameCallback(sdpInfoObj.Framerate);
            }

            SDPinfo.push(sdpInfoObj);
          } else if (rtspSDPData.Sessions[idx].CodecMime === 'PCMU' || rtspSDPData.Sessions[idx].CodecMime.search('G726-16') !== -1 || rtspSDPData.Sessions[idx].CodecMime.search('G726-24') !== -1 || rtspSDPData.Sessions[idx].CodecMime.search('G726-32') !== -1 || rtspSDPData.Sessions[idx].CodecMime.search('G726-40') !== -1 || rtspSDPData.Sessions[idx].CodecMime === 'PCMA' || rtspSDPData.Sessions[idx].CodecMime.search("G723.1") !== -1 || rtspSDPData.Sessions[idx].CodecMime.search("G729") !== -1 || rtspSDPData.Sessions[idx].CodecMime.search("MPA") !== -1 || rtspSDPData.Sessions[idx].CodecMime.search("L16") !== -1) {
            //if (rtspSDPData.Sessions[idx].ControlURL.search("trackID=t") !== -1) {
            //    sdpInfoObj.codecName = "G.711";
            //    sdpInfoObj.trackID = rtspSDPData.Sessions[idx].ControlURL;
            //    sdpInfoObj.Port = parseInt(rtspSDPData.Sessions[idx].Port);
            //    sdpInfoObj.Bitrate = parseInt(rtspSDPData.Sessions[idx].Bitrate);
            //    SDPinfo.push(sdpInfoObj);
            //    audioTalkServiceStatus = true
            //} else {
            if (rtspSDPData.Sessions[idx].CodecMime === 'PCMU') {
              sdpInfoObj.codecName = 'G.711Mu';
            } else if (rtspSDPData.Sessions[idx].CodecMime === 'G726-16') {
              sdpInfoObj.codecName = 'G.726-16';
            } else if (rtspSDPData.Sessions[idx].CodecMime === 'G726-24') {
              sdpInfoObj.codecName = 'G.726-24';
            } else if (rtspSDPData.Sessions[idx].CodecMime === 'G726-32') {
              sdpInfoObj.codecName = 'G.726-32';
            } else if (rtspSDPData.Sessions[idx].CodecMime === 'G726-40') {
              sdpInfoObj.codecName = 'G.726-40';
            } else if (rtspSDPData.Sessions[idx].CodecMime === 'PCMA') {
              sdpInfoObj.codecName = 'G.711A';
            } else if (rtspSDPData.Sessions[idx].CodecMime === "G723.1") {
              sdpInfoObj.codecName = "G.723";
            } else if (rtspSDPData.Sessions[idx].CodecMime === "G729") {
              sdpInfoObj.codecName = "G.729";
            } else if (rtspSDPData.Sessions[idx].CodecMime === "MPA") {
              sdpInfoObj.codecName = "mpeg2";
            } else if (rtspSDPData.Sessions[idx].CodecMime === "L16") {
              sdpInfoObj.codecName = "PCM";
            }

            sdpInfoObj.trackID = rtspSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = rtspSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(rtspSDPData.Sessions[idx].Port);
            sdpInfoObj.Bitrate = parseInt(rtspSDPData.Sessions[idx].Bitrate);
            sdpInfoObj.TalkTransType = rtspSDPData.Sessions[idx].TalkTransType; //设置对讲的传输类型

            SDPinfo.push(sdpInfoObj); //}
          } else if (rtspSDPData.Sessions[idx].CodecMime === 'mpeg4-generic' || rtspSDPData.Sessions[idx].CodecMime === 'MPEG4-GENERIC') {
            sdpInfoObj.codecName = 'mpeg4-generic';
            sdpInfoObj.trackID = rtspSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = rtspSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(rtspSDPData.Sessions[idx].Port);
            sdpInfoObj.Bitrate = parseInt(rtspSDPData.Sessions[idx].Bitrate);
            sdpInfoObj.TalkTransType = rtspSDPData.Sessions[idx].TalkTransType; //设置对讲的传输类型

            SDPinfo.push(sdpInfoObj);
          } else if (rtspSDPData.Sessions[idx].CodecMime === 'vnd.onvif.metadata') {
            sdpInfoObj.codecName = 'MetaData';
            sdpInfoObj.trackID = rtspSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = rtspSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(rtspSDPData.Sessions[idx].Port);
            SDPinfo.push(sdpInfoObj);
          } else if (rtspSDPData.Sessions[idx].CodecMime === 'stream-assist-frame') {
            sdpInfoObj.codecName = 'stream-assist-frame';
            sdpInfoObj.trackID = rtspSDPData.Sessions[idx].ControlURL;
            sdpInfoObj.ClockFreq = rtspSDPData.Sessions[idx].ClockFreq;
            sdpInfoObj.Port = parseInt(rtspSDPData.Sessions[idx].Port);
            SDPinfo.push(sdpInfoObj);
          } else {
            if (rtspSDPData.Sessions[idx].Type === 'audio') {
              //音频格式不支持
              errorCallbackFunc({
                errorCode: 201
              });
            }

            debug.log('Unknown codec type:', rtspSDPData.Sessions[idx].CodecMime, rtspSDPData.Sessions[idx].ControlURL);
          }
        }

        if (isTalkService === false) {
          errorCallbackFunc({
            errorCode: 404,
            description: 'rtsp not found'
          });
          return;
        }

        setupSDPIndex = 0;
        currentState = 'Setup';
        debug.log(SDPinfo);
        return CommandConstructor('SETUP', SDPinfo[setupSDPIndex].trackID.split('=')[1] - 0);
      } else if (currentState === 'Setup') {
        SessionId = rtspResponseMsg.SessionID;

        if (setupSDPIndex < SDPinfo.length) {
          SDPinfo[setupSDPIndex].RtpInterlevedID = rtspResponseMsg.RtpInterlevedID;
          SDPinfo[setupSDPIndex].RtcpInterlevedID = rtspResponseMsg.RtcpInterlevedID;
          setupSDPIndex += 1;

          if (setupSDPIndex !== SDPinfo.length) {
            return CommandConstructor('SETUP', SDPinfo[setupSDPIndex].trackID.split('=')[1] - 0);
          } else {
            //rtsp透传数据的时候（MP4播放时），rtsp不提供视频和视频中音频的编码格式，所以这里可以先不传sdp数据，等视频的moov解出来之后，再通过CodecCallback方法传
            !isFileOffset && workerManager.sendSdpInfo(SDPinfo, AACCodecInfo); //if (audioTalkServiceStatus) {
            // workerManager.setCallback("audioTalk", module.SendAudioTalkData)
            //}

            if (isTalkService === true) {
              workerManager.setCallback("audioTalk", SendAudioTalkData); //如果开启了对讲，则将收集到的音频发送给设备
            }

            currentState = 'Play';

            if (!isPlayback) {
              //预览
              return CommandConstructor('PLAY', null);
            } else {
              //如果是回放，还需要传开始播放秒数
              return CommandConstructor('PLAY', null, null, playBackRange);
            }
          }
        } else {
          debug.log('Unknown setup SDP index');
        }
      } else if (currentState === 'Play') {
        SessionId = rtspResponseMsg.SessionID;
        clearInterval(getParameterIntervalHandler);
        getParameterIntervalHandler = setInterval(function () {
          return SendRtspCommand(CommandConstructor('GET_PARAMETER', null, null));
        }, SEND_GETPARM_INTERVAL);
        var aliveCounter = 0;

        if (mode === 'live') {//do nothing
        }

        currentState = 'Playing';
      } else if (currentState === 'Playing') {//if (mode === "backup") {
        //    checkIsAvaliablePlayback(mode)
        //}
      } else {
        debug.log('unknown rtsp state:' + currentState);
      }
    } else if (rtspResponseMsg.ResponseCode === RTSP_STATE.NOTSERVICE) {
      if (currentState === "Setup" && SDPinfo[setupSDPIndex].TalkTransType === 'sendonly') {
        SDPinfo[setupSDPIndex].RtpInterlevedID = -1;
        SDPinfo[setupSDPIndex].RtcpInterlevedID = -1;
        setupSDPIndex += 1;
        isTalkService = false;
        errorCallbackFunc({
          errorCode: '504',
          description: 'Talk Service Unavilable',
          place: 'RtspClient.js'
        });

        if (setupSDPIndex < SDPinfo.length) {
          return CommandConstructor('SETUP', SDPinfo[setupSDPIndex].trackID);
        } else {
          currentState = 'Play';
          return CommandConstructor('PLAY', null);
        }
      } else {
        errorCallbackFunc({
          errorCode: '503',
          description: 'Service Unavilable'
        });
      }
    } else if (rtspResponseMsg.ResponseCode === RTSP_STATE.NOTFOUND) {
      if (currentState === 'Describe' || currentState === 'Options') {
        errorCallbackFunc({
          errorCode: 404,
          description: 'rtsp not found'
        });
        return;
      }
    } else if (rtspResponseMsg.ResponseCode === RTSP_STATE.INVALID_RANGE) {
      if (mode === 'backup' || mode === 'playback') {
        errorCallbackFunc({
          errorCode: '457',
          description: 'Invalid range'
        });
      }

      debug.log('RTP disconnection detect!!!');
      return;
    }
  }
  /*
      向设备发起数据
  */


  function SendRtpData(rtpdata) {
    if (ws !== null && ws.readyState === WebSocket.OPEN) {
      ws.send(rtpdata);
    } else {
      debug.log("SendRtpData - Websocket does not exist");
    }
  }
  /*
      将大华包音频数据发送给设备
  */


  function SendAudioTalkData(rtpdata) {
    if (isTalkService === true) {
      SendRtpData(rtpdata);
    }
  }

  function formDigestAuthHeader(stringMessage) {
    var username = user.username;
    var password = user.passWord; //暂时写死

    var digestInfo = {
      Method: null,
      Realm: null,
      Nonce: null,
      Uri: null
    };
    var response = null;
    digestInfo = {
      Method: currentState.toUpperCase(),
      Realm: stringMessage.Realm,
      Nonce: stringMessage.Nonce,
      Uri: rtspUrl
    };
    response = formAuthorizationResponse(username, password, digestInfo.Uri, digestInfo.Realm, digestInfo.Nonce, digestInfo.Method);
    Authentication = 'Authorization: Digest username="' + username + '", realm="' + digestInfo.Realm + '",';
    Authentication += ' nonce="' + digestInfo.Nonce + '", uri="' + digestInfo.Uri + '", response="' + response + '"';
    Authentication += '\r\n';
    SendRtspCommand(CommandConstructor('OPTIONS', null, null));
  }

  function SendRtspCommand(sendMessage) {
    if (sendMessage == undefined || sendMessage == null || sendMessage == '') {
      return;
    }

    if (ws && ws.readyState === WebSocket.OPEN) {
      if (describekey === false) {
        var describeCmd = sendMessage.search('DESCRIBE');

        if (describeCmd !== -1) {
          IsDescribe = true;
          describekey = true;
        }
      }

      sendMessage != undefined && ws.send(stringToUint8Array(sendMessage));
    } else {
      debug.log('ws未连接');
    }
  }

  function receiveMessage(e) {
    var PreceiveUint8 = new Uint8Array();
    var receiveUint8 = new Uint8Array(e.data); //var tmp = PreceiveUint8;

    PreceiveUint8 = new Uint8Array(receiveUint8.length); //PreceiveUint8.set(tmp, 0);

    PreceiveUint8.set(receiveUint8, 0);
    sockDataRemaining = PreceiveUint8.length; //debug.log(PreceiveUint8.length);

    while (sockDataRemaining > 0) {
      if (PreceiveUint8[0] !== 36) {
        var PreceiveMsg = String.fromCharCode.apply(null, PreceiveUint8);
        var rtspendpos = null;

        if (PreceiveMsg.indexOf('OffLine:File Over') !== -1 || PreceiveMsg.indexOf('OffLine:Internal Error') !== -1) {
          //文件播放结束时
          ws.fileOver = true;
          workerManager.postRtspOver(); //发布rtsp结束消息
        }

        if (PreceiveMsg.indexOf('OffLine:KmsUnavailable') !== -1) {
          //KMS服务器未连接
          errorCallbackFunc({
            errorCode: 203
          });
        }

        if (IsDescribe === true) {
          rtspendpos = PreceiveMsg.lastIndexOf('\r\n');
          IsDescribe = false;
        } else {
          rtspendpos = PreceiveMsg.search('\r\n\r\n');
        }

        var rtspstartpos = PreceiveMsg.search('RTSP');

        if (rtspstartpos !== -1) {
          if (rtspendpos !== -1) {
            RTSPResArray = PreceiveUint8.subarray(rtspstartpos, rtspendpos + RTSP_INTERLEAVE_LENGTH);
            PreceiveUint8 = PreceiveUint8.subarray(rtspendpos + RTSP_INTERLEAVE_LENGTH);
            var receiveMsg = String.fromCharCode.apply(null, RTSPResArray);
            SendRtspCommand(RtspResponseHandler(receiveMsg));
            sockDataRemaining = PreceiveUint8.length;
          } else {
            sockDataRemaining = PreceiveUint8.length;
            return;
          }
        } else {
          PreceiveUint8 = new Uint8Array();
          return;
        }
      } else {
        //透传的MP4流数据（非固定传过来1帧）
        if (SDPinfo[0].codecName === 'RAW') {
          if (/.aac/.test(rtspUrl)) {
            // aac的裸数据
            workerManager.sendBufferToAudioWorker(PreceiveUint8.subarray(RTSP_INTERLEAVE_LENGTH, PreceiveUint8.length));
          } else {
            mp4MovieParse.setMovieData(PreceiveUint8.subarray(RTSP_INTERLEAVE_LENGTH, PreceiveUint8.length));
          }

          return;
        } else {
          if (isFirstFrame === true) {
            GetFirstFrameCallback && GetFirstFrameCallback();
          }

          isFirstFrame = false; //通用的dav视频帧数据（固定传过来1帧数据）

          rtspinterleave = PreceiveUint8.subarray(0, RTSP_INTERLEAVE_LENGTH);
          RTPPacketTotalSize = rtspinterleave[2] << 24 | rtspinterleave[3] << 16 | rtspinterleave[4] << 8 | rtspinterleave[5];

          if (RTPPacketTotalSize + RTSP_INTERLEAVE_LENGTH <= PreceiveUint8.length) {
            //rtpheader = PreceiveUint8.subarray(RTSP_INTERLEAVE_LENGTH, 16);
            var DHPacketArray = PreceiveUint8.subarray(RTSP_INTERLEAVE_LENGTH, RTPPacketTotalSize + RTSP_INTERLEAVE_LENGTH);

            if (isOpenLocalRecord) {
              localRecord.postMessage({
                type: 'addBuffer',
                buffer: DHPacketArray
              });
            }

            workerManager.parseRTPData(rtspinterleave, DHPacketArray);
            PreceiveUint8 = PreceiveUint8.subarray(RTPPacketTotalSize + RTSP_INTERLEAVE_LENGTH);
            sockDataRemaining = PreceiveUint8.length;
          } else {
            sockDataRemaining = PreceiveUint8.length;
            return;
          }
        }
      }
    }
  } //MP4的解码相关配置初始化


  mp4MovieParse.CodecCallback = function (mp4Codec) {
    // MP4的视频由于是透传过来的，所以在rtsp的sdp数据中没有视频的视频格式，音频格式。需要自己解析出moov之后再重新发给workerManager
    AACCodecInfo = mp4Codec.AudioCodecInfo;
    SDPinfo[0].Framerate = mp4Codec.Framerate;

    if (AACCodecInfo.VideoCodec === 'H264') {
      Constructor.prototype.setLiveMode('video');
    }

    workerManager.sendSdpInfo(SDPinfo, AACCodecInfo, mp4Codec);
  }; //MP4的每一帧的解码


  mp4MovieParse.TrackCallback = function (buffer) {
    //通过mp4MovieParse，解析出moov之后，每解出来1帧，就发布到这里去解码，迎合之前dav的流程
    var DHPacketArray = new Uint8Array(buffer.subarray(6, buffer.length)); // console.log(mp4MovieParse.parseToString(DHPacketArray));

    workerManager.parseRTPData(buffer.subarray(0, 6), DHPacketArray);
  };

  function parseRtspResponse(message1) {
    var RtspResponseData = {};
    var cnt = 0,
        cnt1 = 0,
        ttt = null,
        LineTokens = null;
    var message = null;

    if (message1.search('Content-Type: application/sdp') !== -1) {
      var messageTok = message1.split('\r\n\r\n');
      message = messageTok[0];
    } else {
      message = message1;
    }

    var TokenziedResponseLines = message.split('\r\n');
    var ResponseCodeTokens = TokenziedResponseLines[0].split(' ');

    if (ResponseCodeTokens.length > 2) {
      RtspResponseData.ResponseCode = parseInt(ResponseCodeTokens[1]);
      RtspResponseData.ResponseMessage = ResponseCodeTokens[2];
    }

    if (RtspResponseData.ResponseCode === RTSP_STATE.OK) {
      for (cnt = 1; cnt < TokenziedResponseLines.length; cnt++) {
        LineTokens = TokenziedResponseLines[cnt].split(':');

        if (LineTokens[0] === 'Public') {
          RtspResponseData.MethodsSupported = LineTokens[1].split(',');
        } else if (LineTokens[0] === 'CSeq') {
          RtspResponseData.CSeq = parseInt(LineTokens[1]);
        } else if (LineTokens[0] === 'Content-Type') {
          RtspResponseData.ContentType = LineTokens[1];

          if (RtspResponseData.ContentType.search('application/sdp') !== -1) {
            RtspResponseData.SDPData = parseDescribeResponse(message1);
          }
        } else if (LineTokens[0] === 'Content-Length') {
          RtspResponseData.ContentLength = parseInt(LineTokens[1]);
        } else if (LineTokens[0] === 'Content-Base') {
          var ppos = TokenziedResponseLines[cnt].search('Content-Base:');

          if (ppos !== -1) {
            RtspResponseData.ContentBase = TokenziedResponseLines[cnt].substr(ppos + 13);
          }
        } else if (LineTokens[0] === 'Session') {
          var SessionTokens = LineTokens[1].split(';');
          RtspResponseData.SessionID = parseInt(SessionTokens[0]);
        } else if (LineTokens[0] === 'Transport') {
          var TransportTokens = LineTokens[1].split(';');

          for (cnt1 = 0; cnt1 < TransportTokens.length; cnt1++) {
            var tpos = TransportTokens[cnt1].search('interleaved=');

            if (tpos !== -1) {
              var interleaved = TransportTokens[cnt1].substr(tpos + 12);
              var interleavedTokens = interleaved.split('-');

              if (interleavedTokens.length > 1) {
                RtspResponseData.RtpInterlevedID = parseInt(interleavedTokens[0]);
                RtspResponseData.RtcpInterlevedID = parseInt(interleavedTokens[1]);
              }
            }
          }
        } else if (LineTokens[0] === 'RTP-Info') {
          LineTokens[1] = TokenziedResponseLines[cnt].substr(9);
          var RTPInfoTokens = LineTokens[1].split(',');
          RtspResponseData.RTPInfoList = [];

          for (cnt1 = 0; cnt1 < RTPInfoTokens.length; cnt1++) {
            var RtpTokens = RTPInfoTokens[cnt1].split(';');
            var RtpInfo = {};
            var cnt2 = 0;

            for (cnt2 = 0; cnt2 < RtpTokens.length; cnt2++) {
              var poss = RtpTokens[cnt2].search('url=');

              if (poss !== -1) {
                RtpInfo.URL = RtpTokens[cnt2].substr(poss + 4);
              }

              poss = RtpTokens[cnt2].search('seq=');

              if (poss !== -1) {
                RtpInfo.Seq = parseInt(RtpTokens[cnt2].substr(poss + 4));
              }
            }

            RtspResponseData.RTPInfoList.push(RtpInfo);
          }
        }
      }
    } else if (RtspResponseData.ResponseCode === RTSP_STATE.UNAUTHORIZED) {
      for (cnt = 1; cnt < TokenziedResponseLines.length; cnt++) {
        LineTokens = TokenziedResponseLines[cnt].split(':');

        if (LineTokens[0] === 'CSeq') {
          RtspResponseData.CSeq = parseInt(LineTokens[1]);
        } else if (LineTokens[0] === 'WWW-Authenticate') {
          var AuthTokens = LineTokens[1].split(',');

          for (cnt1 = 0; cnt1 < AuthTokens.length; cnt1++) {
            var pos = AuthTokens[cnt1].search('Digest realm=');

            if (pos !== -1) {
              ttt = AuthTokens[cnt1].substr(pos + 13);
              var realmtok = ttt.split('"');
              RtspResponseData.Realm = realmtok[1];
            }

            pos = AuthTokens[cnt1].search('nonce=');

            if (pos !== -1) {
              ttt = AuthTokens[cnt1].substr(pos + 6);
              var noncetok = ttt.split('"');
              RtspResponseData.Nonce = noncetok[1];
            }
          }
        }
      }
    }

    return RtspResponseData;
  }

  function parseDescribeResponse(message1) {
    var SDPData = {};
    var Sessions = [];
    SDPData.Sessions = Sessions;
    var message = null;

    if (message1.search('Content-Type: application/sdp') !== -1) {
      var messageTok = message1.split('\r\n\r\n');
      message = messageTok[1];
    } else {
      message = message1;
    }

    var TokenziedDescribe = message.split('\r\n');
    var cnt = 0;
    var mediaFound = false;

    for (cnt = 0; cnt < TokenziedDescribe.length; cnt++) {
      var SDPLineTokens = TokenziedDescribe[cnt].split('=');

      if (SDPLineTokens.length > 0) {
        switch (SDPLineTokens[0]) {
          case 'a':
            var aLineToken = SDPLineTokens[1].split(':');

            if (aLineToken.length > 1) {
              if (aLineToken[0] === 'control') {
                var pos = TokenziedDescribe[cnt].search('control:');

                if (mediaFound === true) {
                  if (pos !== -1) {
                    SDPData.Sessions[SDPData.Sessions.length - 1].ControlURL = TokenziedDescribe[cnt].substr(pos + 8);
                  }
                } else {
                  if (pos !== -1) {
                    SDPData.BaseURL = TokenziedDescribe[cnt].substr(pos + 8);
                  }
                }
              } else if (aLineToken[0] === 'rtpmap') {
                var rtpmapLine = aLineToken[1].split(' ');
                SDPData.Sessions[SDPData.Sessions.length - 1].PayloadType = rtpmapLine[0];
                var MimeLine = rtpmapLine[1].split('/');
                SDPData.Sessions[SDPData.Sessions.length - 1].CodecMime = MimeLine[0];

                if (MimeLine.length > 1) {
                  SDPData.Sessions[SDPData.Sessions.length - 1].ClockFreq = MimeLine[1];
                }
              } else if (aLineToken[0] === 'framesize') {
                var framesizeLine = aLineToken[1].split(' ');

                if (framesizeLine.length > 1) {
                  var framesizeinf = framesizeLine[1].split('-');
                  SDPData.Sessions[SDPData.Sessions.length - 1].Width = framesizeinf[0];
                  SDPData.Sessions[SDPData.Sessions.length - 1].Height = framesizeinf[1];
                }
              } else if (aLineToken[0] === 'framerate') {
                SDPData.Sessions[SDPData.Sessions.length - 1].Framerate = aLineToken[1];
              } else if (aLineToken[0] === 'fmtp') {
                var sessLine = TokenziedDescribe[cnt].split(' ');

                if (sessLine.length < 2) {
                  continue;
                }

                for (var ii = 1; ii < sessLine.length; ii++) {
                  var sessToken = sessLine[ii].split(';');
                  var sessprmcnt = 0;

                  for (sessprmcnt = 0; sessprmcnt < sessToken.length; sessprmcnt++) {
                    var ppos = sessToken[sessprmcnt].search('mode=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].mode = sessToken[sessprmcnt].substr(ppos + 5);
                    }

                    ppos = sessToken[sessprmcnt].search('config=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].config = sessToken[sessprmcnt].substr(ppos + 7);
                      AACCodecInfo.config = SDPData.Sessions[SDPData.Sessions.length - 1].config;
                      AACCodecInfo.clockFreq = SDPData.Sessions[SDPData.Sessions.length - 1].ClockFreq;
                      AACCodecInfo.bitrate = SDPData.Sessions[SDPData.Sessions.length - 1].Bitrate;
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-vps=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].VPS = sessToken[sessprmcnt].substr(ppos + 10);
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-sps=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].SPS = sessToken[sessprmcnt].substr(ppos + 10);
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-pps=');

                    if (ppos !== -1) {
                      SDPData.Sessions[SDPData.Sessions.length - 1].PPS = sessToken[sessprmcnt].substr(ppos + 10);
                    }

                    ppos = sessToken[sessprmcnt].search('sprop-parameter-sets=');

                    if (ppos !== -1) {
                      var SPSPPS = sessToken[sessprmcnt].substr(ppos + 21);
                      var SPSPPSTokenized = SPSPPS.split(',');

                      if (SPSPPSTokenized.length > 1) {
                        SDPData.Sessions[SDPData.Sessions.length - 1].SPS = SPSPPSTokenized[0];
                        SDPData.Sessions[SDPData.Sessions.length - 1].PPS = SPSPPSTokenized[1];
                      }
                    }
                  }
                }
              }
            } else if (aLineToken.length === 1) {
              //对讲中拆分后长度为1
              if (aLineToken[0] === 'recvonly') {
                SDPData.Sessions[SDPData.Sessions.length - 1].TalkTransType = 'recvonly';
              } else if (aLineToken[0] === 'sendonly') {
                SDPData.Sessions[SDPData.Sessions.length - 1].TalkTransType = 'sendonly';
              }
            }

            break;

          case 'm':
            var mLineToken = SDPLineTokens[1].split(' ');
            var Session = {};
            Session.Type = mLineToken[0];
            Session.Port = mLineToken[1];
            Session.Payload = mLineToken[3];
            SDPData.Sessions.push(Session);
            mediaFound = true;
            break;

          case 'b':
            if (mediaFound === true) {
              var bLineToken = SDPLineTokens[1].split(':');
              SDPData.Sessions[SDPData.Sessions.length - 1].Bitrate = bLineToken[1];
            }

            break;
        }
      }
    }

    return SDPData;
  } // 录像dav格式的视频


  function writeFile(name, buffer) {
    name = (name || Date.now()) + '';
    name = name.toLowerCase().split('.dav')[0];
    var blob = new Blob([buffer]);
    var a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = name + '.dav';
    a.click();
    setTimeout(function () {
      URL.revokeObjectURL(a.href);
      a = null;
    }, 100);
    buffer = null;
  }

  return new Constructor();
};

/* harmony default export */ var src_WebsocketServerRTSP = (WebsocketServerRTSP_WebsocketServerRTSP);
// CONCATENATED MODULE: ./src/WebsocketServer.js
/**
 * Created by 33596 on 2018/4/26.
 */
// 建立ws链接，发送RTSP信令，传递媒体数据




/*
 * @params options [object] 扩展对象
 */

var WebsocketServer_WebsocketServer = function WebsocketServer(wsURL, rtspURL, extend) {
  var deployType = extend.dType;
  var isPrivateProtocol = extend.isPrivateProtocol;
  var RTSP_STATE = {
    OK: 200,
    UNAUTHORIZED: 401,
    NOTFOUND: 404,
    INVALID_RANGE: 457,
    NOTSERVICE: 503,
    DISCONNECT: 999,
    BADREQUEST: 400,
    FORBIDDEN: 403,
    INTERNALSERVERERROR: 500,
    SERVICEUNAVAILABLE: 503
  };
  var websocketServerInstance = null;
  var workerManager = null;

  if (deployType === 'Train') {
    workerManager = new workerManagerTrain();
  } else {
    workerManager = new src_workerManager();
  }

  var option = {
    'wsURL': wsURL,
    'rtspURL': rtspURL,
    'workerManager': workerManager,
    'RTSP_STATE': RTSP_STATE
  };
  var mergeOption = Object.assign(option, extend);

  if (isPrivateProtocol === true) {
    websocketServerInstance = new src_WebsocketServerPrivate(mergeOption);
  } else {
    websocketServerInstance = new src_WebsocketServerRTSP(mergeOption);
  }

  function Constructor() {}

  Constructor.prototype = {
    init: function init(_canvas, videoElem, channel, isPlaybackFlag, isAudioFlag) {
      if (deployType === 'Train') {
        workerManager.init(_canvas, channel);
      } else {
        workerManager.init(_canvas, videoElem, channel, isPlaybackFlag, isAudioFlag);
      }
    },
    talkInit: function talkInit() {
      workerManager.talkInit();
    },
    connect: function connect() {
      websocketServerInstance.connect();
    },
    disconnect: function disconnect() {
      websocketServerInstance.disconnect();
    },
    controlPlayer: function controlPlayer(controlInfo) {
      websocketServerInstance.controlPlayer(controlInfo);
    },
    setLiveMode: function setLiveMode(mode) {
      workerManager.setLiveMode(mode);
    },
    setPlayMode: function setPlayMode(mode, range) {
      websocketServerInstance.setPlayMode(mode, range);
    },
    setRTSPURL: function setRTSPURL(path) {
      websocketServerInstance.setSignalURL(path);
    },
    setCallback: function setCallback(type, func) {
      websocketServerInstance.setCallback(type, func);
    },
    setUserInfo: function setUserInfo(username, password) {
      websocketServerInstance.setUserInfo(username, password);
    },
    capture: function capture(filename) {
      workerManager.capture(filename);
    },
    setLessRate: function setLessRate(state) {
      workerManager.setLessRate(state);
    },
    gotoSecond: function gotoSecond(seek) {
      workerManager.gotoSecond(seek);
    },
    gotoFrame: function gotoFrame(frameIndex) {
      workerManager.gotoFrame(frameIndex);
    },
    checkLeftSize: function checkLeftSize(seek, dir) {
      workerManager.checkLeftSize(seek, dir);
    },
    clearMap: function clearMap() {
      workerManager.clearMap();
    },
    getCapture: function getCapture(filename, type, quality) {
      workerManager.getCapture(filename, type, quality);
    }
  };
  return new Constructor();
};

/* harmony default export */ var src_WebsocketServer = (WebsocketServer_WebsocketServer);
// CONCATENATED MODULE: ./src/playerControl.js
/**
 * Created by 33596 on 2018/4/26.
 * 封装对外接口，支持自定义事件(内部通过在workermanager中注册各种回调函数实现)
 */


var PlayerControl = function PlayerControl(options) {
  this.wsURL = options.wsURL;
  this.rtspURL = options.rtspURL;
  this.isTalkService = options.isTalkService;
  this.isPlayback = options.playback || false;
  this.playBackRange = options.range || false; //回放开始播放的秒数

  this.isPrivateProtocol = options.isPrivateProtocol || false;
  this.isAudioFlag = options.isAudioFlag || false; //是否是纯音频播放

  this.lessRateCanvas = options.lessRateCanvas || false; //低帧率时是否用canvas

  this.audioState = 'stop'; // 音频播放状态

  this.realm = options.realm || '';
  this.ws = null;
  this.decodeMode = options.decodeMode;
  this.events = {
    ResolutionChanged: function ResolutionChanged() {},
    PlayStart: function PlayStart() {},
    DecodeStart: function DecodeStart() {},
    UpdateCanvas: function UpdateCanvas() {},
    GetFrameRate: function GetFrameRate() {},
    FrameTypeChange: function FrameTypeChange() {},
    Error: function Error() {},
    MSEResolutionChanged: function MSEResolutionChanged() {},
    audioChange: function audioChange() {},
    WorkerReady: function WorkerReady() {},
    IvsDraw: function IvsDraw() {},
    FileOver: function FileOver() {},
    Waiting: function Waiting() {},
    UpdateTime: function UpdateTime() {},
    recordChanged: function recordChanged() {},
    GetFirstFrame: function GetFirstFrame() {}
  };
  this.username = options.username;
  this.password = options.password;
  this.deployType = options.deployType;
  this.duration = options.duration;
};

PlayerControl.prototype = {
  init: function init(can, videoElem, channel) {
    //var rtsp = new RTSPServer(this.wsURL, this.rtspURL);
    this.ws = new src_WebsocketServer(this.wsURL, this.rtspURL, {
      dType: this.deployType,
      isPrivateProtocol: this.isPrivateProtocol,
      realm: this.realm
    });
    this.ws.init(can, videoElem, channel, this.isPlayback, this.isAudioFlag);
    this.ws.setLiveMode(this.decodeMode);
    this.ws.setUserInfo(this.username, this.password);
    this.ws.setPlayMode(this.isPlayback, this.playBackRange);
    this.ws.setLessRate(this.lessRateCanvas); //for(var i = 0; i < this.events.length; i++){
    //    this.ws.setCallback(this.events[i].eventName, this.events[i].callback);
    //}
    //this.events = [];

    for (var i in this.events) {
      this.ws.setCallback(i, this.events[i]);
    }

    this.events = null;
  },
  startRecod: function startRecod(bool) {
    if (bool) {
      if (this.ws) {
        // 当前ws已经存在，则不需要重新创建，实际上这里应该不会走
        return;
      }

      this.ws = new src_WebsocketServer(this.wsURL, this.rtspURL, {
        isRecord: true,
        isPrivateProtocol: this.isPrivateProtocol,
        realm: this.realm
      });
      this.ws.setUserInfo(this.username, this.password); // 回调必须下发，不然有有部分函数被执行,会报错

      for (var i in this.events) {
        this.ws.setCallback(i, this.events[i]);
      }

      this.controlPlayer('startRecod', true);
      this.connect();
    } else {
      if (this.ws) {
        this.controlPlayer('startRecod', false);
        this.ws.disconnect();
        this.ws = null;
      }
    }
  },
  connect: function connect() {
    this.ws.connect();
    this.audioState = 'play'; // 音频自动播放
  },
  play: function play() {
    this.controlPlayer('PLAY');
  },
  pause: function pause() {
    this.controlPlayer('PAUSE');
  },
  stop: function stop() {
    this.controlPlayer('TEARDOWN');
  },
  close: function close() {
    this.ws.disconnect();
  },
  playByTime: function playByTime(range) {
    //回放时才能按时间播放
    range = range < 0 ? 0 : range;

    if (this.duration > 0 && range > this.duration) {
      range = this.duration;
    }

    this.controlPlayer('PLAY', 'video', range);
  },
  playFF: function playFF(speed) {
    //快放
    this.controlPlayer('PAUSE');
    this.controlPlayer('SCALE', speed);
  },
  playRewind: function playRewind() {//快退
  },
  playNextFrame: function playNextFrame() {
    // 下一帧
    this.controlPlayer('playNextFrame');
  },
  getCurFrameInfo: function getCurFrameInfo() {
    // 下一帧
    return this.controlPlayer('getCurFrameInfo');
  },
  // 继续播放
  audioPlay: function audioPlay() {
    this.controlPlayer('audioPlay', 'start');
    this.audioState = 'play';
  },
  audioStop: function audioStop() {
    this.controlPlayer('audioPlay', 'stop');
  },
  audioPause: function audioPause() {
    this.controlPlayer('audioPlay', 'pause');
    this.audioState = 'pause';
  },
  setAudioSamplingRate: function setAudioSamplingRate(val) {
    this.controlPlayer('audioSamplingRate', val);
  },
  setAudioVolume: function setAudioVolume(val) {
    this.controlPlayer('volumn', val);
  },
  gotoSecond: function gotoSecond(seek) {
    var total = 5; //如果是跳转到某秒，则总共当前数据拉前后5s，一共10s

    var me = this;
    window.clearInterval(me.checkRsPre);
    window.clearInterval(me.checkRsNext);
    window.clearInterval(me.checkRsGoto);
    me.ws.clearMap();

    if (me.running === true) {
      me.pause();
      me.running = false;
    }

    me.playByTime(seek - total); //跳转到前4秒开始拉流;

    me.running = true;
    me.checkRsGoto = window.setTimeout(function () {
      me.pause();
      me.running = false; //console.log('跳转秒完成缓冲');
    }, (total + 1) * 2 * 1000); //12s后停止
  },
  // 下一帧
  nextFrame: function nextFrame(frameIndex, curSec, callback) {
    var me = this;
    var frameIdx = frameIndex > Math.pow(2, 32) ? 0 : frameIndex;
    var data = me.ws.gotoFrame(frameIdx); //从map中获取png数据

    if (data === false) {
      // 如果获取不到数据，执行一次下一秒，往后拉流几秒
      me.nextSecond(curSec, function (data) {
        callback(me.ws.gotoFrame(frameIndex));
      });
    } else {
      callback(data);
    }
  },
  // 上一帧
  preFrame: function preFrame(frameIndex, curSec, callback) {
    var me = this;
    var data = me.ws.gotoFrame(frameIndex); //从map中获取png数据

    if (data === false) {
      // 如果获取不到数据，执行一次上一秒，往前拉流几秒
      me.preSecond(curSec, function (data) {
        callback(me.ws.gotoFrame(frameIndex));
      });
    } else {
      callback(data);
    }
  },
  nextSecond: function nextSecond(seek, callback) {
    var total = 5;
    var checkRs; //间隔3秒循环检测是否已经有当前数据

    var me = this;
    var data = me.ws.gotoSecond(seek); //从map中获取png数据

    if (data === false) {
      //没有获取到数据
      if (me.running === false) {
        //如果当前没有拉流，则开始拉流
        //console.log('下1秒没有数据，需要从第 ' + seek +' 秒开始缓冲');
        me.playByTime(seek); //跳转到当前秒开始拉流 

        me.running = true;
      }
      /*
       *  间隔2秒，检测一下是否完成，如果完成，则返回png数据，并且暂停拉流，否则继续检测
       */


      me.checkRsNext = window.setInterval(function () {
        data = me.ws.gotoSecond(seek);

        if (data !== false) {
          //console.log('当前秒缓冲完成');
          window.clearInterval(me.checkRsNext);
          window.setTimeout(function () {
            me.running = false;
            me.pause(); //console.log('当前秒没数据时的缓冲结束');
          }, (total + 4) * 1000);
          callback(data);
        }
      }, 2 * 1000);
    } else {
      //在有数据的情况下，需要确认剩下缓冲还有多少秒的数据
      var keyCount = me.ws.checkLeftSize(seek, 'next');

      if (keyCount <= 2 && me.running === false) {
        //只剩下2秒数据、当前没拉流时，启动拉流
        //console.log('下1秒的缓冲区剩余不足2s，开始缓冲');
        me.playByTime(seek + 1); //跳转到当前秒的下1秒开始拉流

        me.running = true;
        window.setTimeout(function () {
          me.pause();
          me.running = false; //console.log('下1秒的缓冲区剩余不足2s的缓冲结束');
        }, (total + 4) * 1000); //4s后停止
      }

      callback(data);
    }
  },
  preSecond: function preSecond(seek, callback) {
    var total = 3;
    var checkRs; //间隔2秒循环检测是否已经有当前数据

    var me = this;
    var data = me.ws.gotoSecond(seek); //从map中获取png数据

    if (data === false) {
      //没有获取到数据
      if (me.running === false) {
        //如果当前没有拉流，则开始拉流
        //console.log('上1秒没有数据，需要从第 ' + (seek - 5) +' 秒开始缓冲');
        me.playByTime(seek - 5); //跳转到当前秒开始拉流

        me.running = true;
      }
      /*
       *  间隔3秒，检测一下是否完成，如果完成，则返回png数据，并且暂停拉流，否则继续检测
       */


      me.checkRsPre = window.setInterval(function () {
        data = me.ws.gotoSecond(seek);

        if (data !== false) {
          //console.log('上1秒缓冲完成');
          window.clearInterval(me.checkRsPre);
          window.setTimeout(function () {
            me.running = false;
            me.pause(); //console.log('上1秒没数据时的缓冲结束');
          }, (total + 6) * 1000);
          callback(data);
        }
      }, 2 * 1000);
    } else {
      //在有数据的情况下，需要确认剩下缓冲还有多少秒的数据
      var keyCount = me.ws.checkLeftSize(seek, 'pre');

      if (keyCount <= 2 && me.running === false) {
        //只剩下2秒数据、当前没拉流时，启动拉流
        //console.log('上1秒的缓冲区剩余不足2s，开始缓冲');
        me.playByTime(seek - 5); //跳转到当前秒的上2秒开始拉流

        me.running = true;
        window.setTimeout(function () {
          me.pause();
          me.running = false; //console.log('上1秒的缓冲区剩余不足2s的缓冲结束');
        }, (total + 6) * 1000); //3s后停止
      }

      callback(data);
    }
  },
  controlPlayer: function controlPlayer(command, data, range) {
    var option;

    if (data === 'video') {
      option = {
        command: command,
        range: range ? range : 0
      };
    } else if (command === 'audioPlay') {
      // 音频的指令
      option = {
        command: command,
        data: data,
        range: range ? range : 0
      };
    } else {
      option = {
        command: command,
        data: data
      };
    }

    return this.ws.controlPlayer(option);
  },
  setPlayMode: function setPlayMode(mode) {
    this.ws.setLiveMode(mode);
  },
  setPlayPath: function setPlayPath(rtspURL) {
    this.ws.setRTSPURL(rtspURL);
  },
  capture: function capture(filename) {
    var options = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {
      ivsCanvasArr: []
    };
    //ivsCanvasArr表示需要额外叠加的canvas，默认为空数组
    this.ws.capture(filename, options);
  },
  getCapture: function getCapture(filename, type, quality) {
    return this.ws.getCapture(filename, type, quality);
  },
  talk: function talk(status) {
    if (status === 'on') {
      this.ws = new src_WebsocketServer(this.wsURL, this.rtspURL, {
        isTalkService: this.isTalkService,
        isPrivateProtocol: this.isPrivateProtocol,
        realm: this.realm
      });
      this.ws.talkInit();
      this.ws.setUserInfo(this.username, this.password); // 回调必须下发，不然有有部分函数被执行,会报错

      for (var i in this.events) {
        this.ws.setCallback(i, this.events[i]);
      }

      this.ws.connect();
    } else {
      this.ws.disconnect();
    }
  },

  /**
   * 注册自定义事件,目前支持如下事件:
   * [ResolutionChanged] 分辨率改变,返回具体分辨率
   * [PlayStart] 播放开始, 指通过canvas开始播放第一帧或者video加载了initsegment，返回值为"PlayStart"
   * [DecodeStart] 开始解码，指通过SPS/DH帧头 获取到第一帧的分辨率，仅canvas可用，返回值为{width:xxx, height: xxx}
   * [UpdateCanvas] 每绘制一帧时触发一次,返回值为{width:xxx, height: xxx}
   * [GetFrameRate] 返回帧率，在SDP信息中获取
   * [FrameTypeChange] 编码类型改变，返回新类型, 支持"MJPEG","H264","H265"
   * [Error] 错误信息，返回值为{errorCode: xxx} ,错误码类型如下
   * *** 101  延时大于两秒 ***
   * *** 201  不支持当前音频格式 ***
   * *** 404  找不到流    ***
   * [MSEResolutionChanged] 由于MSE不能获取分辨率改变的事件，故只能在收到一帧时进行判断
   * [audioChange] 音频改变事件，当音频编码格式改变或者采样率改变时触发
   * @param eventName 事件名
   * @param callback  回调函数
   * @return player
   */
  on: function on(eventName, callback) {
    //this.events.push({
    //    eventName: eventName,
    //    callback: callback
    //});
    this.events[eventName] = callback; // this.ws.setCallback(eventName, callback);
  }
};
/* harmony default export */ var playerControl = __webpack_exports__["default"] = (PlayerControl);

/***/ })
/******/ ])["default"];