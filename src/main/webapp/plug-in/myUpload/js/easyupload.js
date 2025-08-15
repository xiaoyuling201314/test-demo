/**
 * @author  funnyque@163.com
 * @param   configs 配置参数必填
 * @version 2.0.3修订版本
 * @description 文件上传插件，支持多文件上传、批量上传及混合上传
 * 注：需先引入jquery
 */
;(function (window, document) {

    //该代码解决ie8以下浏览器不支持Object.assign方法的代码
    if (typeof Object.assign != 'function') {
        Object.assign = function (target) {
            'use strict';
            if (target == null) {
                throw new TypeError('Cannot convert undefined or null to object');
            }
            target = Object(target);
            for (var index = 1; index < arguments.length; index++) {
                var source = arguments[index];
                if (source != null) {
                    for (var key in source) {
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
        var arr = this,
            i,
            j,
            len = arr.length;
        for (i = 0; i < len; i++) {
            for (j = i + 1; j < len; j++) {
                if (arr[i].name == arr[j].name) {
                    arr.splice(j, 1);
                    len--;
                    j--;
                }
            }
        }
        return arr;
    };

    //定义一个文件上传的函数
    var easyUploader = function (configs) {
        //1.配置不可为空，且渲染id必填
        if (!configs || !configs.id) {
            alert('缺少配置参数');
            return;
        }
        //2.判断easyUploader是否为当前函数实例，不是就创建一个
        if (!(this instanceof easyUploader)) {
            return new easyUploader(configs);
        }
        //3.初始化配置
        this.initPlugin(configs);
    };

    //定义默认的配置参数 和  非图像文件预览的base64编码
    var defaultConfigs = {
        id: "",                     // 渲染容器id
        accept: '.jpg,.png',        // 上传类型
        action: "",                 // 上传地址
        isBatch: true,              // 是否批量传递
        autoUpload: false,          // 是否开启自动上传
        crossDomain: true,          // 是否允许跨域
        data: null,                 // 上传配置参数，依据dataFormat而不同，
        dataFormat: 'formData',     // 上传表单类型，有formData和base64两种
        dataType: 'json',           // 同$.ajax，默认返回数据格式为json
        headers: {
            // testKey: 'testValue'
            // 上传的请求头部，视需要配置
        },
        maxCount: 3,                // 最大上传文件数
        maxSize: 3,                 // 最大上传文件体积，单位M
        offSort: 1,                 // 多实例加密状态 针对于自己的文件上传加密需要
        isEncrypt: false,
        multiple: false,            // 是否开启多选上传
        name: 'file',               // 上传的文件字段名
        previewWidth: 70,           // 压缩预览图的宽度，样式中高度等于宽度
        processData: false,         // 同$.ajax参数，这里默认为false
        successKey: 'code',         // 标识上传成功的key
        successValue: 200,          // 标识上传成功对应的value
        showAlert: false,            // 是否开启alert提示
        timeout: 0,                 // ajax请求超时时间，默认值为0，表示永不超时
        withCredentials: true,      // 是否支持发送 cookie 凭证信息
        beforeUpload: null,         // ajax上传前的回调函数
        onAlert: null,              // alert时的回调函数
        onChange: null,             // input change的回调函数
        //onError: null,              // 上传失败时的回调函数
        //onRemove: null,             //移除文件时的回调函数
        //onSuccess: null             // 上传成功时的回调函数
    };
    //为easyUploader函数对象创建属性
    easyUploader.prototype = {
        configs: {}, /* 当前实例的配置 */
        files: [],
        fileId: 0, /* ajax待传文件id */
        fileObj: {
            fileList: [], /* 当前实例选中过滤后的文件 */
            isReady: true /* 图片转base是异步的，用开关来控制每一次更新 */
        },
        node: {
            /* 用于接收dom节点 */
            list: null,
            input: null
        },
        ajax: {
            example: null,
            isReady: true,
            index: 0 /*用于接收最近一个等待上传文件的索引 */
        },
        //初始化配置，完成容器的渲染
        initPlugin: function (configs) {
            /** 配置文件属性的赋值
             * Object.assign(target, ...sources);
             * 方法用于将所有可枚举属性的值从一个或多个源对象复制到目标对象。它将返回目标对象
             */
            this.configs = Object.assign({}, defaultConfigs, configs);
            this.files = [];//初始化文件为空
            //获取容器完成按钮的渲染
            var container = $("#" + this.configs.id);
            if (!container) {
                alert("没有找到id为" + this.configs.id + "的渲染容器");
                return;
            } else {
                container.html(this.buildUploadButton());//按钮的添加
                this.bindHeadEvent();
            }

            /* 启动拦截器 */
        },
        //构建上传按钮
        buildUploadButton: function () {
            var html = '';
            html += '<div class="upload-form fileIds">';
            if (this.configs.isEncrypt == true) {
                html += '<div class="file-encrypt">';
                /*+ '<button type="button" class="btn-xs btn-success">清空</button>'*/
                html += '<input id="file-checkbox" ';
                html += (this.configs.offSort == 1 ? 'name="off" ' : 'name="off' + this.configs.offSort + '" ');
                html += ' type="checkbox" value="1"/> <label for="file-checkbox">保密</label>';
                html += '</div>';
            }
            html += '<input class="input-file ' + this.configs.id + '" type="file" id="files' + this.configs.id + '" accept="' + this.configs.accept + '" ';
            html += (this.configs.multiple ? 'multiple="multiple" ' : '');
            html += '>';
            html += '<label class="up-label btn-select-file' + this.configs.id + '" for="files' + this.configs.id + '">上传</label>';
            html += '<div class="fileStyle" id="file-list-' + this.configs.id + '"></div>';
            html += '</div>';
            return html;
        },
        //对添加的按钮进行事件的绑定
        bindHeadEvent: function () {
            var that = this;
            $(".btn-select-file" + that.configs.id).on("click", function () {
                that.node.list = $(this).parent().siblings(".list");//界面迭代出的文件的dom节点对象

                //===========start：解决change事件多次调用问题====================
                var html = '';
                html += '<input class="input-file ' + that.configs.id + '" type="file" id="files' + that.configs.id + '" accept="' + that.configs.accept + '" '
                    + (that.configs.multiple ? 'multiple="multiple" ' : '')
                    + '>';
                $("." + that.configs.id).replaceWith(html);
                //===========end：解决change事件多次调用问题====================
                $(this).parent().children(".input-file").on("change", function (e) {
                    that.fileObj = {fileList: e.target.files, isReady: true};//文件集合的赋值操作
                    for (var i = 0; i < e.target.files.length; i++) {
                        that.files.push(e.target.files[i]);
                    }
                    //赋值完毕，对files进行去重
                    that.files.distinct();
                    that.node.input = $(this);
                    that.updateFiles();//检测所有选中的文件是否符合标准
                    //判断是否存在，存在就调用 文件选中时的change事件
                    that.configs.onChange && that.configs.onChange(e.target.files);
                    //渲染界面，界面展示选中的文件
                    that.renderFileList();
                    //渲染结束添加删除事件
                    that.addRemove();
                });
            });
        }, addRemove: function () {
            var that = this;
            $(".shanchu").each(function (index, item) {
                $(item).click(function () {
                    this.closest("div").remove();
                    that.files.forEach(function (file, index2) {
                        if (file.name == $(item).attr("data-fn")) {
                            that.files.splice(index2, 1);
                        }
                    });
                    console.log(that.files);
                });
            })
        },
        //选中文件的校验
        updateFiles: function (type) {
            var existingCout = this.files.length, /* files 数组里已有的数量 */
                index = 0, msg = '', that = this, maxCount = this.configs.maxCount;
            var onAlert = function (message) {
                if (that.configs.showAlert) {
                    alert(message);
                }
                if (that.configs.onAlert) {
                    that.configs.onAlert(message);
                }
            };

            if (existingCout > maxCount) {
                msg = '文件数量超出，允许最大数量' + maxCount + '个';
                onAlert(msg);
                for (var len = that.files.length, i = len - 1; i >= 0; i--) {
                    //只保留前几个符合个数的文件
                    if (i + 1 > maxCount) {
                        that.files.splice(i, existingCout - maxCount);
                    }
                }
            }

            for (var len = that.files.length, i = len - 1; i >= 0; i--) {
                //大于指定大小就删除
                if (that.fileObj.fileList[i] && that.fileObj.fileList[i].size > that.configs.maxSize * (1024 * 1024)) {
                    msg = that.files[i].name + '文件大小超出，允许大小为' + that.configs.maxSize + 'M';
                    onAlert(msg);
                    if (i > -1) {
                        that.files.splice(i, 1);
                    }
                }
                //如果文件大小为0kb就删除
                if (that.fileObj.fileList[i] && that.fileObj.fileList[i].size <= 0) {
                    msg = that.files[i].name + '文件大小不能为0KB';
                    onAlert(msg);
                    if (i > -1) {
                        that.files.splice(i, 1);
                    }
                }
            }
            /*that.files.forEach(function (file, index) {
             //大于指定大小就删除
             if (that.fileObj.fileList[index] && that.fileObj.fileList[index].size > that.configs.maxSize * (1024 * 1024)) {
             msg = file.name + '文件大小超出，允许大小为' + that.configs.maxSize + 'M';
             onAlert(msg);
             if (index > -1) {
             that.files.splice(index, 1);
             }
             }
             });*/
        },
        //拼接选中文件界面
        renderFileList: function () {
            var that = this;
            var fileListDisplay = $("#file-list-" + that.configs.id);
            fileListDisplay.find(".shanchu").each(function (index, item) {
                var obj = $(item);
                if (!obj.data("fileid")) {//如果当前回显的文件没有id那么就清空下面的内容
                    obj.closest("div").remove();
                }
            });
            that.files.forEach(function (file, index) {
                var html = '';
                html += '<div class="upload-files clearfix">';
                html += '<span title="' + file.name + '">' + file.name + '</span>';
                html += '<a class="icon iconfont icon-chushaixuanxiang shanchu"  data-fn="' + file.name + '" title="删除"></a>';
                html += '</div>';
                fileListDisplay.append(html);
            });
        },
        removeFile: function (e) {

        }
    };
    window.easyUploader = easyUploader;


}(window, document));
/**
 * 编辑回显已上传过的文件的删除方法
 * 用途：在form表单内添加要删除的文件ID
 * @param obj
 */
function removeFile(o, id) {
    var obj = $(o);
    var fileId = obj.data("fileid");
    var html = '<input type="hidden" name="deleteFileIds" value="' + fileId + '">';
    $(obj.data("uploadid")).append(html);
    obj.closest("div").remove();
}