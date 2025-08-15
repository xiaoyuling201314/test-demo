//发送普通打印命令方法
var socket;//打印机驱动连接
var returnMesg;//返回消息
var connectStatus;//连接状态
var sendMessage;//发送打印命令
var bytes;
/**
 * 发送打印命令
 * @returns
 */
function sendCommand()
{
	if (typeof socket == "undefined" || socket.readyState == 3) {
		doConnect(sendCommand);
		return;
	}

	if (socket.readyState != WebSocket.OPEN) {
		alert("无效连接: " + socket.readyState+",请检查打印机是否开机，打印机数据线是否连接！");
		return;
	}

	socket.send(sendMessage);	
}
/**
 * 连接打印机
 * @param callback
 * @returns
 */
function doConnect(callback)
{
	var serviceUrl = "ws://localhost:12353";
	socket = new WebSocket(serviceUrl);
//	socket.binaryType = "arraybuffer";
	// 监听消息
	socket.onmessage = function(event)
	{ 
		console.log('Client received a message',event); 
		returnMesg = returnMesg + event.data + "\n";
	};

	socket.onopen = function(event)
	{
		if (callback != null) {
			callback();
		}
		setStatusLabel("已连接");
	}

	socket.onerror = function(error)
	{
		console.log("Failed to connect CN print at " + serviceUrl, error);
		setStatusLabel("连接错误");
	}

	// 监听Socket的关闭
	socket.onclose = function(event)
	{ 
		console.log('Client notified socket has closed',event);
		setStatusLabel("连接关闭");
	}; 
}
/**
 * 监控打印机状态
 * @param msg
 * @returns
 */
function setStatusLabel(msg)
{
	connectStatus = msg;
}