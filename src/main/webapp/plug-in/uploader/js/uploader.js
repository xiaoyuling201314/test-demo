/**
 * @author shit
 * @date 2020/07/14
 * 备注：IIFE语法，开头加上“;”是为了防止将两个 JavaScript 文件连接在一起时可能出现的问题
 */
;(function (window, document) {

    //重写Object.assign方法，解决ie8以下浏览器不支持Object.assign方法的代码
    if (typeof Object.assign !== 'function') {
        Object.assign = function (target) {
            'use strict';
            if (target == null) {
                throw new TypeError('Cannot convert undefined or null to object');
            }
            target = Object(target);
            for (let index = 1; index < arguments.length; index++) {
                let source = arguments[index];
                if (source != null) {
                    for (let key in source) {
                        if (Object.prototype.hasOwnProperty.call(source, key)) {
                            target[key] = source[key];
                        }
                    }
                }
            }
            return target;
        };
    }

    //给数组添加一个去重函数 ：根据数组内元素的名称来去重
    Array.prototype.distinct = function () {
        let arr = this, i, j, len = arr.length;
        for (i = 0; i < len; i++) {
            for (j = i + 1; j < len; j++) {
                if (arr[i].name === arr[j].name) {
                    arr.splice(j, 1);
                    len--;
                    j--;
                }
            }
        }
        return arr;
    };

    //定义一个文件上传对象 uploader
    let uploader = function (configs) {
        //1.配置不可为空，且渲染id必填
        if (!configs || !configs.id) {
            alert('缺少配置参数');
            return;
        }
        //2.判断uploader是否为当前函数实例，不是就创建一个
        if (!(this instanceof uploader)) {
            return new uploader(configs);
        }
        //3.初始化配置
        this.initPlugin(configs);
    };

    //定义默认的配置参数 和  非图像文件预览的base64编码
    let defaultConfigs = {
        id: "uploader",             // 渲染容器id（默认为uploader）
        accept: '.png,.jpg,.jpeg,.bmp,.GIF,.tiff,.PCX,.ico,.mp4,.rmvb,.wmv,.avi,.MPOEG,.FLV,.mkv,.doc,.docx,.xls,.xlsx,.pdf,.rar,.zip,.ppt,.pptx,.txt',        // 支持上传文件类型
        maxCount: 1,                // 最大上传文件数
        maxSize: 3,                 // 最大上传文件体积，单位M
        multiple: false,            // 是否开启多选上传
        name: 'file',               // 上传的文件字段名(默认为file)
        delName: 'delFileUrl',      // 被删除的文件创建隐藏input的name名称 默认delFileUrl
        isImage: false,             //是否图片上传（默认为图片上传）
        previewWidth: 70,           // 压缩预览图的宽度，如果只设置宽度，则样式中高度等于宽度
        previewHeight: 0,           // 压缩预览图的高度，
        showAlert: false,           // 是否开启alert提示
        onAlert: null,              // alert时的回调函数
        onChange: null,             // input change的回调函数
        onRemove: null              //移除文件时的回调函数
    };

    //为uploader对象设置属性和方法
    uploader.prototype = {
        configs: {}, //当前实例的配置
        files: [],   //选中文件对象数组
        fileObj: {
            fileList: [], //当前实例选中过滤后的文件
            isReady: true //图片转base是异步的，用开关来控制每一次更新
        },
        //初始化配置，完成容器的渲染
        initPlugin: function (configs) {
            /** 配置文件属性的赋值
             * Object.assign(target, ...sources);
             * 方法用于将所有可枚举属性的值从一个或多个源对象复制到目标对象。它将返回目标对象
             */
            this.configs = Object.assign({}, defaultConfigs, configs);//这里是生成了一个新的configs对象出来
            this.files = [];//初始化文件为空
            //获取容器完成按钮的渲染
            let container = $("#" + this.configs.id);
            if (!container) {
                alert("没有找到id为 " + this.configs.id + " 的渲染容器");
                return false;
            } else {
                container.html(this.buildUploadButton());//上传按钮的添加
                this.bindHeadEvent();
            }
        },
        //构建上传按钮
        buildUploadButton: function () {
            let html = '', configs = this.configs, uploadId = configs.id;
            if (configs.isImage) {
                html += '<div class="upload-form fileIds">'
                    + '<input class="input-file ' + uploadId + '" type="file" id="files' + uploadId + '" accept="' + configs.accept + '" '
                    + (configs.multiple ? 'multiple="multiple" ' : '')
                    + '>'
                    + '<label class="up-label img-upload btn-select-file' + uploadId + '" for="files' + uploadId + '"></label>'
                    + '<div class="myfile-list pull-left clearfix" id="file-list-' + uploadId + '"></div>'
                    + '</div>';
            } else {
                html += '<div class="upload-form fileIds">'
                    + '<input class="input-file ' + uploadId + '" type="file" id="files' + uploadId + '" accept="' + configs.accept + '" '
                    + (configs.multiple ? 'multiple="multiple" ' : '')
                    + '>'
                    + '<div class="myfile-list clearfix" id="file-list-' + uploadId + '"></div>'
                    + '<label class="up-label files-upload btn-select-file' + uploadId + '" for="files' + uploadId + '">上传</label>'
                    + '</div>';
            }
            return html;
        },

        //对添加的按钮进行事件的绑定
        bindHeadEvent: function () {
            let that = this;
            $(".btn-select-file" + that.configs.id).on("click", function () {
                //===========start：解决change事件多次调用问题====================
                let html = '';
                html += '<input class="input-file ' + that.configs.id + '" type="file" id="files' + that.configs.id + '" accept="' + that.configs.accept + '" '
                    + (that.configs.multiple ? 'multiple="multiple" ' : '')
                    + '>';
                $("." + that.configs.id).replaceWith(html);
                //===========end：解决change事件多次调用问题====================

                $(this).parent().children(".input-file").on("change", function (e) {
                    let target_files = e.target.files;
                    if (that.configs.maxCount === 1) that.files = [];//如果是单选的话就把文件集合初始化为空
                    //that.fileObj = {fileList: target_files, isReady: true};//文件集合的赋值操作
                    for (let i = 0; i < target_files.length; i++) {
                        that.files.push(target_files[i]);
                    }
                    that.files.distinct(); //赋值完毕，对files进行去重
                    that.updateFiles();//检测所有选中的文件是否符合标准
                    that.configs.onChange && that.configs.onChange(target_files); //判断是否存在，存在就调用 文件选中时的change事件
                    if (that.configs.isImage) {
                        that.renderFileListImage(); //渲染界面，界面展示选中的文件
                    } else {
                        that.renderFileList(); //渲染界面，界面展示选中的文件
                        that.addRemove();  //渲染结束执行删除事件
                    }
                });
            });
        },
        //删除事件
        addRemove: function () {
            let that = this;
            $(".del_file").each(function (index, item) {
                $(item).click(function () {
                    $(this).closest("div").remove();
                    that.files.forEach(function (file, index2) {
                        if (file.name === $(item).attr("data-fn")) {
                            that.files.splice(index2, 1);
                            console.log("当前删除文件：");
                            console.log(file);
                        }
                    });
                    console.log("剩余文件：");
                    console.log(that.files);
                });
            })
        },
        //删除事件
        addRemoveImage: function () {
            let that = this;
            $(".del_image").each(function (index, item) {
                $(item).click(function () {
                    $(this).closest("li").remove();
                    that.files.forEach(function (file, index2) {
                        if (file.name === $(item).attr("data-fn")) {
                            that.files.splice(index2, 1);
                            console.log("当前删除图片文件：");
                            console.log(file);
                        }
                    });
                    console.log("剩余图片文件：");
                    console.log(that.files);
                    //如果只能上传一个文件，且当前已选择文件为空就显示上传按钮
                    if (that.configs.maxCount === 1 && !$("#file-list-" + that.configs.id).html()) {
                        $("#" + that.configs.id).find(".btn-select-fileupload").show();
                    }
                });
            })
        },
        //选中文件的校验
        updateFiles: function (type) {
            let existingCout = this.files.length, /* files 数组里已有的数量 */
                msg = '', that = this, maxCount = this.configs.maxCount, currentAccept = that.configs.accept;
            let onAlert = function (message) {
                if (that.configs.showAlert) {
                    alert(message);
                }
                if (that.configs.onAlert) {
                    that.configs.onAlert(message);
                }
            };

            //求得回显文件数组和界面显示的文件数组
            let fileListDisplay = $("#file-list-" + that.configs.id);
            let echoFileArr = fileListDisplay.find(".del_show_file");
            let showFileArr = fileListDisplay.find(".shanchu");
            let showCount = showFileArr.length;//当前界面显示的所有文件个数（包含回显文件）
            let echoCount = maxCount === 1 ? 0 : echoFileArr.length;//当前回显文件个数
            //此处对选中文件进行过滤
            if ((existingCout + echoCount) > maxCount) {
                msg = '文件数量超出，允许最大数量' + maxCount + '个';
                onAlert(msg);
                for (let len = that.files.length, i = len - 1; i >= 0; i--) {
                    //只保留前几个符合个数的文件
                    if ((i + 1 + echoCount) > maxCount) {
                        that.files.splice(i, (existingCout + echoCount) - maxCount);
                    }
                }
            }
            //情况1：如果只能上传一个文件，就直接替换（存在回显文件，该回显文件路径直接放入隐藏域）
            if (maxCount === 1) {
                if (echoFileArr.length) {
                    echoFileArr.each(function (index, item) {
                        let obj = $(item);
                        let delFileUrl = obj.data("url");
                        obj.closest("li").remove();
                        $("#" + that.configs.id).append('<input type="hidden" name="' + that.configs.delName + '" value="' + delFileUrl + '"/>');
                    });
                }
                fileListDisplay.html('');//清空界面显示的图片
                $("#" + that.configs.id).find(".btn-select-fileupload").hide();//隐藏上传按钮
                //情况2：如果能上传2个文件（多文件）
                //①：依次选中文件A,B,C,界面只拼接文件A和文件B,文件C过滤掉
                //②：第一次选中文件A,第二次选中文件B和文件C,界面将只拼接文件A和文件B,文件C过滤掉
                //③：第一次选中文件A,B，第二次选中文件C,D,界面只拼接文件A和文件B,文件C和文件D过滤掉
                //④：存在回显文件A,再次选中上传文件B和C,此时提示超出文件上传个数限制，并把文件B加入界面，多余的文件C直接删除
            }
            for (let len = that.files.length, i = len - 1; i >= 0; i--) {
                //大于指定大小就删除
                let myfileName = that.files[i].name;

                if (that.files[i] && that.files[i].size > that.configs.maxSize * (1024 * 1024)) {
                    msg = myfileName + '文件大小超出，允许大小为' + that.configs.maxSize + 'M';
                    onAlert(msg);
                    if (i > -1) {
                        that.files.splice(i, 1);
                    }
                }
                //如果文件大小为0kb就删除
                if (that.files[i] && that.files[i].size <= 0) {
                    msg = myfileName + '文件大小不能为0KB';
                    onAlert(msg);
                    if (i > -1) {
                        that.files.splice(i, 1);
                    }
                }

                /*if (that.fileObj.fileList[i] && that.fileObj.fileList[i].size > that.configs.maxSize * (1024 * 1024)) {
                    msg = myfileName + '文件大小超出，允许大小为' + that.configs.maxSize + 'M';
                    onAlert(msg);
                    if (i > -1) {
                        that.files.splice(i, 1);
                    }
                }
                //如果文件大小为0kb就删除
                if (that.fileObj.fileList[i] && that.fileObj.fileList[i].size <= 0) {
                    msg = myfileName + '文件大小不能为0KB';
                    onAlert(msg);
                    if (i > -1) {
                        that.files.splice(i, 1);
                    }
                }*/
                //如果不是当前控制的类型就删除掉
                if (currentAccept && currentAccept !== '*' && myfileName && IEVersion() !== -1) {
                    let index = myfileName.lastIndexOf(".");
                    let filename = myfileName.substring(index + 1);
                    if (filename && currentAccept.lastIndexOf(filename.toLowerCase()) < 0) {
                        msg = myfileName + ' 为不支持文件类型';
                        onAlert(msg);
                        that.files.splice(i, 1);
                    }
                }
            }
        },
        //拼接选中文件界面
        renderFileList: function () {
            let that = this;
            let fileListDisplay = $("#file-list-" + that.configs.id);
            fileListDisplay.find(".del_file").each(function (index, item) {
                let obj = $(item);
                if (!obj.data("fileid")) {
                    obj.closest("div").remove();
                }
            });
            that.files.forEach(function (file, index) {
                let html = '';
                html += '<div class="upload-files2 clearfix">';
                html += '<a style="float: left" class="text-danger icon iconfont icon-chushaixuanxiang shanchu del_file"  data-fn="' + file.name + '" title="删除"></a>';
                html += '<span style="float: left" title="' + file.name + '">' + file.name + '</span>';
                html += '</div>';
                fileListDisplay.append(html);
            });
        },
        renderFileListImage: function () {
            if (typeof FileReader === "undefined") {
                alert("检测到你的浏览器不支持FileReader对象!");
            }
            let that = this;
            let width = that.configs.previewWidth;
            let heigth = that.configs.previewHeight;
            let maxCount = that.configs.maxCount;
            let fileListDisplay = $("#file-list-" + that.configs.id);


            //这里进行判断，如果显示文件名称和之前的名称相同就不在进行显示
            let showFileArr = fileListDisplay.find(".shanchu");
            let showFnArr = [];//已经显示的文件名称数组
            showFileArr.each(function (index, item) {
                showFnArr.push($(item).data("fn"))
            });

            //迭代当前选中的文件拼接html进行选中文件的展示
            that.files.forEach(function (file, index) {
                let html = '';
                if (showFnArr.indexOf(file.name) === -1) {
                    createImageHtml(file).then(function (result) {
                        html = '<li class="upload-files"><i class="del-img icon iconfont icon-close shanchu del_image" data-fn="' + file.name + '" ></i> <img src="' + result + '" ' + (width ? "width='" + width + "px'" : "") + ' ' + (heigth ? "heigth='" + heigth + "px'" : "") + ' /></li>';
                        fileListDisplay.append(html);
                        that.addRemoveImage();//添加删除方法
                    });
                }
            });
        }, cleanModalHtml: function () {//清空模态框的文件数据
            let delName = this.configs.delName;
            $("#file-list-" + this.configs.id).html('');
            $("#" + this.configs.id).find("input[name=" + delName + "]").remove();
            this.files = [];
            //this.fileObj.fileList = [];
        }
    };
    window.uploader = uploader;

}(window, document));


/**
 * 拼接图片界面
 * @param file
 * @returns {Promise<any>}
 */
function createImageHtml(file) {
    return new Promise(function (resolve, reject) {
        let reader = new FileReader();//读取文件的对象
        reader.readAsDataURL(file);//读取文件的信息
        reader.onload = function (e) {
            resolve(e.target.result)
        }
    })
}


/**
 * 拼接图片界面
 * @param uploader 文件上传对象
 * @param url 图片路径或多个图片路径，用逗号隔开
 * @param webRoot 项目根路径
 * @returns {string} 返回拼接后的界面
 */
function showImageHtml(uploader, url, webRoot) {
    if (url) {
        let html = '';
        let urlArr = url.split(",");
        let {id, previewWidth, previewHeight, delName, maxCount} = uploader.configs;
        for (let i = 0; i < urlArr.length; i++) {
            html += '<li class="echo_data">';
            html += '<i class="del-img icon iconfont icon-close shanchu del_show_file" onclick="delShowImage(this,\'' + id + '\',\'' + urlArr[i] + '\',\'' + delName + '\',\'' + maxCount + '\')" data-url="' + urlArr[i] + '"></i>';
            html += '<a href="' + (webRoot + "/resources/" + urlArr[i]) + '" target="_blank">';
            html += '<img src="' + (webRoot + "/resources/" + urlArr[i]) + '" ' + (previewWidth ? 'width="' + previewWidth + 'px"' : "") + ' ' + (previewHeight ? 'height="' + previewHeight + 'px"' : "") + '>';
            html += '</a>';
            html += '</li>';
        }
        $("#file-list-" + id).html(html);
        if(uploader.configs.maxCount===1){
            $("#" + uploader.configs.id).find(".btn-select-fileupload").hide();
        }
    }
}

/**
 * 回显的文件删除方法
 * @param o
 * @param id
 * @param delFileUrl
 */
function delShowImage(o, id, delFileUrl, delName, maxCount) {
    $("#" + id).append('<input type="hidden" name="' + delName + '" value="' + delFileUrl + '"/>');
    $(o).closest("li").remove();
    //如果只能上传一个文件，且当前已选择文件为空就显示上传按钮
    if (maxCount === "1" && !$("#file-list-" + id).html()) {
        $("#" + id).find(".btn-select-fileupload").show();
    }
}


/**
 * 拼接文件界面
 * @param uploader 文件上传对象
 * @param files 文件路径或多个图片路径，用逗号隔开
 * @param webRoot 项目根路径
 * @returns {string} 返回拼接后的界面
 */
function showFileHtml(uploader, files, fileNames, webRoot) {
    if (files) {
        let html = '';
        let urlArr = files.split(",");
        let fileNameArr = fileNames ? fileNames.split(",") : "";
        let {id, delName} = uploader.configs;
        for (let i = 0; i < urlArr.length; i++) {
            let fileUrl = urlArr[i];
            let fileName = fileNameArr ? fileNameArr[i] : fileUrl.substring(fileUrl.lastIndexOf("/") + 1, fileUrl.length);
            //let fileName = fileUrl.substring(fileUrl.lastIndexOf("/")+1,fileUrl.length);
            html += '<div class="upload-files2 clearfix">';
            html += '<a style="float: left" class="text-danger icon iconfont icon-chushaixuanxiang shanchu" onclick="delShowFile(this,\'' + id + '\',\'' + fileUrl + '\',\'' + delName + '\',\'' + fileName + '\')"  title="删除"></a>';
            html += '<span style="float: left" title="' + fileName + '">' + fileName + '</span>';
            html += '</div>';
        }
        $("#file-list-" + id).html(html);
    }
}

//files/quick/402891187b0a1d5d017b0a1d5d1b0000.png,files/quick/402891187b0a1d5d017b0a1d5e700001.png,files/quick/402891187b0a1d5d017b0a1d5e770002.png


/**
 * 回显的文件删除方法
 * @param o
 * @param id
 * @param delFileUrl
 */
function delShowFile(o, id, delFileUrl, delName, fileName) {
    $("#" + id).append('<input type="hidden" name="' + delName + '" value="' + delFileUrl + '"/>');
    $("#" + id).append('<input type="hidden" name="delFileName" value="' + fileName + '"/>');
    $(o).closest("div").remove();
}


/**
 * 判断是否IE浏览器
 * @returns {*}
 * @constructor
 */
function IEVersion() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器
    var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器
    var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
    if (isIE) {
        var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        reIE.test(userAgent);
        var fIEVersion = parseFloat(RegExp["$1"]);
        if (fIEVersion == 7) {
            return 7;
        } else if (fIEVersion == 8) {
            return 8;
        } else if (fIEVersion == 9) {
            return 9;
        } else if (fIEVersion == 10) {
            return 10;
        } else {
            return 6;//IE版本<=7
        }
    } else if (isEdge) {
        return 'edge';//edge
    } else if (isIE11) {
        return 11; //IE11
    } else {
        return -1;//不是ie浏览器
    }
}