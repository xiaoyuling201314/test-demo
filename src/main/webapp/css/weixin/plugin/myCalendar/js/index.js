(function (e, t, n) {
    var r = e.decodeURIComponent, i = e.location, s = {"&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#039;"},
        o = {amp: "&", lt: "<", gt: ">", quot: '"', "#039": "'"}, u = {
            trim: function (e) {
                return e.replace(/^[\s]+|[\s]+$/, "")
            }, startsWith: function (e, t) {
                return e.indexOf(t) === 0
            }, endsWith: function (e, t) {
                return e.lastIndexOf(t) === e.length - t.length
            }, contains: function (e, t) {
                return e.indexOf(t) !== -1
            }, escapeHTML: function (e) {
                return typeof e != "string" ? e : e.replace(/([<>'"])/g, function (e, t) {
                    return s[t]
                })
            }, unescapeHTML: function (e) {
                return typeof e != "string" ? e : e.replace(/&(amp|lt|gt|quot|#039);/g, function (e, t) {
                    return o[t]
                })
            }, parseQuery: function (e) {
                if (e) {
                    var t = e.indexOf("?");
                    t != -1 && (e = e.substr(t + 1))
                }
                e = e || i.search.substr(1);
                var n = e.split("&"), s = {};
                for (var o = n.length - 1, u, a, f; o >= 0; o--) {
                    u = n[o].split("="), a = u[0], f = u[1];
                    try {
                        a = r(a), f = r(f)
                    } catch (l) {
                    }
                    s[a] = f
                }
                return s
            }
        };
    So.lib = u
})(window, document), function (e) {
    e.cookie = function () {
        function e(e, n) {
            var r = {};
            if (t(e) && e.length > 0) {
                var s = n ? o : i, u = e.split(/;\s/g), a, f, l;
                for (var c = 0, h = u.length; c < h; c++) {
                    l = u[c].match(/([^=]+)=/i);
                    if (l instanceof Array)try {
                        a = o(l[1]), f = s(u[c].substring(l[1].length + 1))
                    } catch (p) {
                    } else a = o(u[c]), f = "";
                    a && (r[a] = f)
                }
            }
            return r
        }

        function t(e) {
            return typeof e == "string"
        }

        function n(e) {
            return t(e) && e !== ""
        }

        function r(e) {
            if (!n(e))throw new TypeError("Cookie name must be a non-empty string")
        }

        function i(e) {
            return e
        }

        var s = {}, o = decodeURIComponent, u = encodeURIComponent;
        return s.get = function (t, n) {
            r(t), typeof n == "function" ? n = {converter: n} : n = n || {};
            var s = e(document.cookie, !n.raw);
            return (n.converter || i)(s[t])
        }, s.set = function (e, t, i) {
            r(e), i = i || {};
            var s = i.expires, o = i.domain, a = i.path;
            i.raw || (t = u(String(t)));
            var f = e + "=" + t, l = s;
            return typeof l == "number" && (l = new Date, l.setTime(l.getTime() + s)), l instanceof Date && (f += "; expires=" + l.toUTCString()), n(o) && (f += "; domain=" + o), n(a) && (f += "; path=" + a), i.secure && (f += "; secure"), document.cookie = f, f
        }, s.remove = function (e, t) {
            return t = t || {}, t.expires = new Date(0), this.set(e, "", t)
        }, s
    }()
}(So.lib), function (e, t, n) {
    function r(t, n, r) {
        var i = {pro: "so", pid: So.comm.pid || "", mod: t, abv: So.comm.abv || "", src: So.comm.src || ""};
        if (n)for (prop in n)i[prop] = n[prop];
        e.monitor && monitor.setConf("logUrl", "//s.qhupdate.com/" + r + ".gif").log(i, "log")
    }

    var i = e.decodeURIComponent, s = e.location;
    n.log = function (e, t, n) {
        r(e, t, n || "so/click")
    }, n.disp = function (e, t, n) {
        r(e, t, n || "so/disp")
    }, n.addCss = function (e) {
        if (document.createStyleSheet) {
            var t = document.createStyleSheet();
            t.cssText = e
        } else {
            var n = document.createElement("style");
            n.type = "text/css", n.appendChild(document.createTextNode(e)), document.getElementsByTagName("HEAD")[0].appendChild(n)
        }
    }, n.template = function (e, t) {
        var n = new Function("obj", "var p=[],print=function(){p.push.apply(p,arguments);};with(obj){p.push('" + e.replace(/[\r\t\n]/g, " ").split("<%").join("	").replace(/((^|%>)[^\t]*)'/g, "$1\r").replace(/\t=(.*?)%>/g, "',$1,'").split("	").join("');").split("%>").join("p.push('").split("\r").join("\\'") + "');}return p.join('');");
        return t ? n(t) : n
    }, n.sslReplace = function (e) {
        return e ? s.protocol == "https:" ? e.replace(/http:\/\/p\d+\.qhimg\.com\//g, "https://p.ssl.qhimg.com/").replace(/http:\/\/u\.qhimg\.com\//g, "https://u.ssl.qhimg.com/").replace(/http:\/\/u1\.qhimg\.com\//g, "https://u1.ssl.qhimg.com/").replace(/http:\/\/p\d+\.so\.qhimg\.com\//g, "https://ps.ssl.qhimg.com/").replace(/http:\/\/s\d+\.qhimg\.com\//g, "https://s.ssl.qhimg.com/").replace(/http:\/\/quc\.qhimg\.com\//g, "https://quc.ssl.qhimg.com/") : e.replace(/http:\/\/s[02468]\.qhimg\.com\//g, "https://s.ssl.qhimg.com/").replace(/http:\/\/s[13579]\.qhimg\.com\//g, "https://s.ssl.qhimg.com/").replace(/http:\/\/p[02468]\.qhimg\.com\//g, "https://p.ssl.qhimg.com/").replace(/http:\/\/p[13579]\.qhimg\.com\//g, "https://p.ssl.qhimg.com/").replace(/http:\/\/p\d{2}\.qhimg\.com\//g, "https://p.ssl.qhimg.com/") : e
    }, n.soLocalStorage = !1;
    try {
        n.soLocalStorage = window.localStorage
    } catch (o) {
    }
    n.browser = {};
    var u = t.documentElement.className || "", a = u.match(/\bie(\d+)\b/i);
    a && (n.browser = {ie: !0, version: a[1]})
}(window, document, So.lib), function (win, doc, undefined) {
    window.JSON = window.JSON || function () {
            var m = {"\b": "\\b", "	": "\\t", "\n": "\\n", "\f": "\\f", "\r": "\\r", '"': '\\"', "\\": "\\\\"}, s = {
                "boolean": function (e) {
                    return String(e)
                }, number: function (e) {
                    return isFinite(e) ? String(e) : "null"
                }, string: function (e) {
                    return /["\\\x00-\x1f]/.test(e) && (e = e.replace(/([\x00-\x1f\\"])/g, function (e, t) {
                        var n = m[t];
                        return n ? n : (n = t.charCodeAt(), "\\u00" + Math.floor(n / 16).toString(16) + (n % 16).toString(16))
                    })), '"' + e + '"'
                }, object: function (e) {
                    if (e) {
                        var t = [], n, r, i, o, u;
                        if (e instanceof Array) {
                            t[0] = "[", o = e.length;
                            for (i = 0; i < o; i += 1)u = e[i], r = s[typeof u], r && (u = r(u), typeof u == "string" && (n && (t[t.length] = ","), t[t.length] = u, n = !0));
                            t[t.length] = "]"
                        } else {
                            if (!(e instanceof Object))return;
                            t[0] = "{";
                            for (i in e)u = e[i], r = s[typeof u], r && (u = r(u), typeof u == "string" && (n && (t[t.length] = ","), t.push(s.string(i), ":", u), n = !0));
                            t[t.length] = "}"
                        }
                        return t.join("")
                    }
                    return "null"
                }
            };
            return {
                copyright: "(c)2005 JSON.org", license: "http://www.crockford.com/JSON/license.html", stringify: function (e) {
                    var t = s[typeof e];
                    if (t) {
                        e = t(e);
                        if (typeof e == "string")return e
                    }
                    return null
                }, parse: function (text) {
                    try {
                        return !/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(text.replace(/"(\\.|[^"\\])*"/g, "")) && eval("(" + text + ")")
                    } catch (e) {
                        return !1
                    }
                }
            }
        }()
}(window, document), So.lib.md5 = function () {
    function e(e, t) {
        var n = (e & 65535) + (t & 65535), r = (e >> 16) + (t >> 16) + (n >> 16);
        return r << 16 | n & 65535
    }

    function t(e, t) {
        return e << t | e >>> 32 - t
    }

    function n(n, r, i, s, o, u) {
        return e(t(e(e(r, n), e(s, u)), o), i)
    }

    function r(e, t, r, i, s, o, u) {
        return n(t & r | ~t & i, e, t, s, o, u)
    }

    function i(e, t, r, i, s, o, u) {
        return n(t & i | r & ~i, e, t, s, o, u)
    }

    function s(e, t, r, i, s, o, u) {
        return n(t ^ r ^ i, e, t, s, o, u)
    }

    function o(e, t, r, i, s, o, u) {
        return n(r ^ (t | ~i), e, t, s, o, u)
    }

    function u(t, n) {
        t[n >> 5] |= 128 << n % 32, t[(n + 64 >>> 9 << 4) + 14] = n;
        var u, a, f, l, c, h = 1732584193, p = -271733879, d = -1732584194, v = 271733878;
        for (u = 0; u < t.length; u += 16)a = h, f = p, l = d, c = v, h = r(h, p, d, v, t[u], 7, -680876936), v = r(v, h, p, d, t[u + 1], 12, -389564586), d = r(d, v, h, p, t[u + 2], 17, 606105819), p = r(p, d, v, h, t[u + 3], 22, -1044525330), h = r(h, p, d, v, t[u + 4], 7, -176418897), v = r(v, h, p, d, t[u + 5], 12, 1200080426), d = r(d, v, h, p, t[u + 6], 17, -1473231341), p = r(p, d, v, h, t[u + 7], 22, -45705983), h = r(h, p, d, v, t[u + 8], 7, 1770035416), v = r(v, h, p, d, t[u + 9], 12, -1958414417), d = r(d, v, h, p, t[u + 10], 17, -42063), p = r(p, d, v, h, t[u + 11], 22, -1990404162), h = r(h, p, d, v, t[u + 12], 7, 1804603682), v = r(v, h, p, d, t[u + 13], 12, -40341101), d = r(d, v, h, p, t[u + 14], 17, -1502002290), p = r(p, d, v, h, t[u + 15], 22, 1236535329), h = i(h, p, d, v, t[u + 1], 5, -165796510), v = i(v, h, p, d, t[u + 6], 9, -1069501632), d = i(d, v, h, p, t[u + 11], 14, 643717713), p = i(p, d, v, h, t[u], 20, -373897302), h = i(h, p, d, v, t[u + 5], 5, -701558691), v = i(v, h, p, d, t[u + 10], 9, 38016083), d = i(d, v, h, p, t[u + 15], 14, -660478335), p = i(p, d, v, h, t[u + 4], 20, -405537848), h = i(h, p, d, v, t[u + 9], 5, 568446438), v = i(v, h, p, d, t[u + 14], 9, -1019803690), d = i(d, v, h, p, t[u + 3], 14, -187363961), p = i(p, d, v, h, t[u + 8], 20, 1163531501), h = i(h, p, d, v, t[u + 13], 5, -1444681467), v = i(v, h, p, d, t[u + 2], 9, -51403784), d = i(d, v, h, p, t[u + 7], 14, 1735328473), p = i(p, d, v, h, t[u + 12], 20, -1926607734), h = s(h, p, d, v, t[u + 5], 4, -378558), v = s(v, h, p, d, t[u + 8], 11, -2022574463), d = s(d, v, h, p, t[u + 11], 16, 1839030562), p = s(p, d, v, h, t[u + 14], 23, -35309556), h = s(h, p, d, v, t[u + 1], 4, -1530992060), v = s(v, h, p, d, t[u + 4], 11, 1272893353), d = s(d, v, h, p, t[u + 7], 16, -155497632), p = s(p, d, v, h, t[u + 10], 23, -1094730640), h = s(h, p, d, v, t[u + 13], 4, 681279174), v = s(v, h, p, d, t[u], 11, -358537222), d = s(d, v, h, p, t[u + 3], 16, -722521979), p = s(p, d, v, h, t[u + 6], 23, 76029189), h = s(h, p, d, v, t[u + 9], 4, -640364487), v = s(v, h, p, d, t[u + 12], 11, -421815835), d = s(d, v, h, p, t[u + 15], 16, 530742520), p = s(p, d, v, h, t[u + 2], 23, -995338651), h = o(h, p, d, v, t[u], 6, -198630844), v = o(v, h, p, d, t[u + 7], 10, 1126891415), d = o(d, v, h, p, t[u + 14], 15, -1416354905), p = o(p, d, v, h, t[u + 5], 21, -57434055), h = o(h, p, d, v, t[u + 12], 6, 1700485571), v = o(v, h, p, d, t[u + 3], 10, -1894986606), d = o(d, v, h, p, t[u + 10], 15, -1051523), p = o(p, d, v, h, t[u + 1], 21, -2054922799), h = o(h, p, d, v, t[u + 8], 6, 1873313359), v = o(v, h, p, d, t[u + 15], 10, -30611744), d = o(d, v, h, p, t[u + 6], 15, -1560198380), p = o(p, d, v, h, t[u + 13], 21, 1309151649), h = o(h, p, d, v, t[u + 4], 6, -145523070), v = o(v, h, p, d, t[u + 11], 10, -1120210379), d = o(d, v, h, p, t[u + 2], 15, 718787259), p = o(p, d, v, h, t[u + 9], 21, -343485551), h = e(h, a), p = e(p, f), d = e(d, l), v = e(v, c);
        return [h, p, d, v]
    }

    function a(e) {
        var t, n = "";
        for (t = 0; t < e.length * 32; t += 8)n += String.fromCharCode(e[t >> 5] >>> t % 32 & 255);
        return n
    }

    function f(e) {
        var t, n = [];
        n[(e.length >> 2) - 1] = undefined;
        for (t = 0; t < n.length; t += 1)n[t] = 0;
        for (t = 0; t < e.length * 8; t += 8)n[t >> 5] |= (e.charCodeAt(t / 8) & 255) << t % 32;
        return n
    }

    function l(e) {
        return a(u(f(e), e.length * 8))
    }

    function c(e, t) {
        var n, r = f(e), i = [], s = [], o;
        i[15] = s[15] = undefined, r.length > 16 && (r = u(r, e.length * 8));
        for (n = 0; n < 16; n += 1)i[n] = r[n] ^ 909522486, s[n] = r[n] ^ 1549556828;
        return o = u(i.concat(f(t)), 512 + t.length * 8), a(u(s.concat(o), 640))
    }

    function h(e) {
        var t = "0123456789abcdef", n = "", r, i;
        for (i = 0; i < e.length; i += 1)r = e.charCodeAt(i), n += t.charAt(r >>> 4 & 15) + t.charAt(r & 15);
        return n
    }

    function p(e) {
        return unescape(encodeURIComponent(e))
    }

    function d(e) {
        return l(p(e))
    }

    function v(e) {
        return h(d(e))
    }

    function m(e, t) {
        return c(p(e), p(t))
    }

    function g(e, t) {
        return h(m(e, t))
    }

    return function (e, t, n) {
        return t ? n ? m(t, e) : g(t, e) : n ? d(e) : v(e)
    }
}();
var PageLine = {
    queues: {release: []}, fill: function (e) {
        var t = this;
        t.save(e)
    }, save: function (e) {
        var t = null, n = this;
        typeof e != "function" ? t = function () {
            Display.moheLog(e)
        } : t = e, n.queues.release.push(t), n.isReleased && n.release("release")
    }, on: function (e, t) {
        var n = this;
        n.queues[e] || (n.queues[e] = []), typeof t == "function" && n.queues[e].push(t)
    }, trigger: function (e, t) {
        var n = this, r = 0, i = [];
        if (!n.queues[e])return !1;
        i = n.queues[e];
        while (r < i.length)i[r].call(this, t), r++
    }, release: function (e) {
        function t() {
            var e = r.shift();
            e && typeof e == "function" && e();
            if (r.length <= 0)return n.isReleased = !0, !1;
            t()
        }

        var n = this, r = n.queues[e];
        if (!r)return !1;
        t()
    }
};
(function (e) {
    function t(e, t) {
        var n = document, r = n.getElementsByTagName("head")[0] || n.documentElement, i = n.createElement("script"), s = !1;
        i.src = e, i.onerror = i.onload = i.onreadystatechange = function () {
            !s && (!this.readyState || this.readyState == "loaded" || this.readyState == "complete") && (s = !0, t && t(), i.onerror = i.onload = i.onreadystatechange = null, r.removeChild(i))
        }, r.insertBefore(i, r.firstChild)
    }

    function n(e) {
        var t, n, r, i;
        for (t = 0; t < l.length; t++) {
            r = l[t], i = r.requires;
            for (n = 0; n < i.length; n++)if (i[n] == e)break;
            i.splice(n, 1), i.length === 0 && (r.fun(), l.splice(t, 1))
        }
    }

    function r() {
        var e = f.splice(0, 1)[0], i = a[e], s = function () {
            n(e), i.loaded = !0, f.length ? r() : c = !1
        };
        if (!i)return;
        c = !0, i.loaded || i.checker && i.checker() ? s(e) : t(i.url, function () {
            s(e)
        })
    }

    var i = {};
    e.OB = i, i.Browser = function () {
        var t = e.navigator, n = t.userAgent.toLowerCase(),
            r = /(msie|webkit|gecko|presto|opera|safari|firefox|chrome|maxthon|android|ipad|iphone|webos|hpwos)[ \/os]*([\d_.]+)/ig,
            i = {platform: t.platform};
        n.replace(r, function (e, t, n) {
            var r = t.toLowerCase();
            i[r] || (i[r] = n)
        }), i.opera && n.replace(/opera.*version\/([\d.]+)/, function (e, t) {
            i.opera = t
        });
        if (i.msie) {
            i.ie = i.msie;
            var s = parseInt(i.msie, 10);
            i["ie" + s] = !0
        }
        return i
    }();
    if (i.Browser.ie)try {
        document.execCommand("BackgroundImageCache", !1, !0)
    } catch (s) {
    }
    var o = i.Browser, u = {
        ready: function (e, t) {
            function n() {
                clearTimeout(t.__QWDomReadyTimer);
                if (r.length) {
                    var e = r.shift();
                    r.length && (t.__QWDomReadyTimer = setTimeout(n, 0)), e()
                }
            }

            t = t || document;
            var r = t.__QWDomReadyCbs = t.__QWDomReadyCbs || [];
            r.push(e), setTimeout(function () {
                if (/complete/.test(t.readyState)) n(); else if (t.addEventListener) "interactive" == t.readyState ? n() : t.addEventListener("DOMContentLoaded", n, !1); else {
                    var e = function () {
                        e = new Function, n()
                    };
                    (function () {
                        try {
                            t.body.doScroll("left")
                        } catch (n) {
                            return setTimeout(arguments.callee, 1)
                        }
                        e()
                    })(), t.attachEvent("onreadystatechange", function () {
                        "complete" == t.readyState && e()
                    })
                }
            }, 0)
        }
    };
    i.DomU = u;
    var a = {
        jquery: {
            url: webRootUlr+"/css/weixin/plugin/myCalendar/js/183.js", checker: function () {
                return !!e.jQuery
            }
        }, "require.2.1.11": {
            url: "https://s.ssl.qhimg.com/!5a33324b/require.js", checker: function () {
                return !!e.require && !!e.define
            }
        }
    }, f = [], l = [], c = !1;
    e._loader = {
        add: function (e, t, n) {
            a[e] || (a[e] = {url: t, checker: n})
        }, use: function (e, t) {
            i.DomU.ready(function () {
                e = e.split(/\s*,\s*/g), f = f.concat(e), l.push({requires: e, fun: t}), c || r()
            })
        }, remove: function (e) {
            a[e] && delete a[e]
        }
    }
})(window), function () {
    var e = document.documentElement, t = function (e, t) {
        var n = document.getElementsByTagName("head")[0], r = null;
        document.createStyleSheet ? (r = document.createStyleSheet(), r.addRule(e, t)) : (r = document.createElement("style"), r.type = "text/css", r.innerHTML = e + "{" + t + "}", n.appendChild(r))
    }, n = 1200;
    e.clientWidth > n && t("#side", "width:410px;left:195px;")
}(), window.hd_init = function () {
    var e = function (e, t, n) {
        var r, i = {};
        t = t || {};
        for (r in e)i[r] = e[r], t[r] != null && (n ? e.hasOwnProperty[r] && (i[r] = t[r]) : i[r] = t[r]);
        return i
    }, t = function (e) {
        return document.getElementById(e)
    }, n = function (e, t, n) {
        e.addEventListener ? e.addEventListener(t, n, !1) : e.attachEvent ? e.attachEvent("on" + t, n) : e["on" + t] = n
    }, r = function (e) {
        return e || window.event
    }, i = function (e) {
        return e.target || e.srcElement
    }, s = {
        check: function () {
            var e = this, t = !1;
            try {
                switch (external.smartwiz() * 1) {
                    case 0:
                        s.render(0);
                        break;
                    case 1:
                        s.render(1, "");
                        break;
                    case 2:
                        s.render(1, "isXdu");
                        break;
                    case 3:
                        s.render(1, "haslogo")
                }
            } catch (n) {
                try {
                    var r = external.GetSID(window), i = parseInt(external.GetVersion(r).split(".").join(""), 10);
                    external.AppCmd(external.GetSID(window), "", "getsearchbarstatus", "", "", s.render)
                } catch (n) {
                    s.render(0)
                }
                return
            }
        }, render: function (e, t) {
            var n = this, r = "", i = null, o = !1, u = document.getElementsByTagName("head")[0];
            document.cookie.indexOf("ED351A52-EE52-47f8-8616-3355B59424C1") >= 0 && (o = !0), e == 1 || o ? (r = document.getElementsByTagName("body")[0].className, r += t == "" ? " g-hide-hd" : " g-hide-all", document.getElementsByTagName("body")[0].className = r) : (s.insertStyle("#g-hd", "display:block"), e != 2 && s.insertStyle("#g-hd-searchs", "display:block"))
        }, insertStyle: function (e, t) {
            var n = document.getElementsByTagName("head")[0], r = null;
            document.createStyleSheet ? (r = document.createStyleSheet(), r.addRule(e, t)) : (r = document.createElement("style"), r.type = "text/css", r.innerHTML = e + "{" + t + "}", n.appendChild(r))
        }
    };
    return function (o) {
        o = e({inputId: "keyword", getValue: null}, o);
        var u = t("g-hd"), a = t(o.inputId), f = function () {
            return typeof o.getValue == "function" ? o.getValue() : a ? a.value.replace(/^\s+|\s+$/g, "") : ""
        }, l = f();
        if (u) {
            var c = t("g-hd-more-title"), h = t("g-hd-more-div");
            if (c && h) {
                var p = function (e) {
                    if (e.relatedTarget)return e.relatedTarget;
                    var t = e.fromElement, n = e.target || e.srcElement, r = t === n ? e.toElement : t;
                    return r
                }, d = function (e, t) {
                    if (e.contains)return e.contains(t);
                    if (e.compareDocumentPosition)return e.compareDocumentPosition(t) & 16;
                    while (t = t.parentNode)if (t == e)return !0;
                    return !1
                }, v = function (e, t) {
                    function i(t) {
                        t = r(t);
                        var n = p(t);
                        if (!n || n !== e && !d(e, n)) t.type == "mouseover" ? s(arguments) : o(arguments)
                    }

                    t = t || {};
                    var s = t.enter || function () {
                        }, o = t.leave || function () {
                        }, u = "onmouseenter" in document.createElement("div");
                    if (u) {
                        n(e, "mouseenter", s), n(e, "mouseleave", o);
                        return
                    }
                    n(e, "mouseover", i), n(e, "mouseout", i)
                }, m = function () {
                    clearTimeout(g), g = setTimeout(function () {
                        h.style.display = ""
                    }, 300)
                }, g, y = function () {
                    clearTimeout(g), g = setTimeout(function () {
                        h.style.display = "none"
                    }, 300)
                }, b = [c, h];
                for (var w = 0; w < b.length; w++) {
                    var E = b[w];
                    v(E, {enter: m, leave: y})
                }
            }
            var S = function (e) {
                try {
                    e = r(e);
                    var t = i(e);
                    if (t && t.tagName && t.tagName.toUpperCase() === "A") {
                        var n = t.getAttribute("data-s"), s = f();
                        n && (a && (t.getAttribute("data-home") || t.setAttribute("data-home", t.href), s ? t.href = n.replace(/%q%/g, encodeURIComponent(s)) : t.href = t.getAttribute("data-home")), d(h, t) && (h.style.display = "none"))
                    }
                } catch (o) {
                }
            };

            function x() {
                var e = u.getElementsByTagName("A"), t = document.getElementById("mod-engs").getElementsByTagName("A"), n = [], r = "";
                for (var i = 0, s = e.length; i < s; i++) {
                    r = e[i].getAttribute("data-s");
                    if (!r)continue;
                    r = r.replace("%q%", encodeURIComponent(l)), e[i].setAttribute("href", r), n.push(e[i])
                }
                for (var i = 0, s = t.length; i < s; i++) {
                    r = t[i].getAttribute("data-s");
                    if (!r)continue;
                    r = r.replace("%q%", encodeURIComponent(l)), t[i].setAttribute("href", r), n.push(t[i])
                }
            }

            s.check(), x(), n(u, "click", S);
            var T = t("g-hd-searchs");
            T && n(T, "click", S)
        }
    }
}();