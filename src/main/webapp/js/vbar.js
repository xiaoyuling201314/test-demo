

var websocket_connected = false;
//var output;

//连接VBarServer
function vbar_open() {
    if (!websocket_connected) {
        var host = "ws://localhost:2693";
        websocketCtrl = new WebSocket(host,'ctrl');
        websocketData = new WebSocket(host,'data');
//        output = document.getElementById("output");
        websocketData.onopen = function(evt) {
            websocket_connected = true;
            websocket_open_state(evt);
            lighton();
            scanbeep1();
        }


        websocketData.onmessage = function (evt) {
            websocket_decode(evt.data);
        }
    }

    setTimeout("vbar_open()", 3000);
}

function openwebsocket()
{
    vbar_open("localhost","2693");
}
function opendev()
{
    websocketCtrl.send("connectdev");
}
function closedev()
{
    websocketCtrl.send("disconnectdev");
}
function websocket_open_state(message)
{
    //document.getElementById('wsocket').value = "已连接";
}


/*//接收扫码结果处理
function websocket_decode(message){
	output.value=message;
}*/

//开灯
function lighton(){
    websocketCtrl.send("lighton")
}
//关灯
function lightoff(){
    websocketCtrl.send("lightoff");
}
function beep1(){
    websocketCtrl.send("beep1");
}
function beep3(){
    websocketCtrl.send("beep3");
}
//扫码响一声
function scanbeep1(){
    websocketCtrl.send("scanbeep1");
}


