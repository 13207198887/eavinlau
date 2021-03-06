<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--<jsp:forward page="/home/main" />-->

<html>
  <head>
    <title>chat</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
   
  <body>
  	<span>
	  	发送内容：
	    <input id="text" type="text" />
	    <input type="button" onclick="send()" value="发送"/>
	    &nbsp;&nbsp;&nbsp;&nbsp;
	    <input type="button" onclick="close()" value="关闭"/>
	</span>
    <br />
    <div id="message"></div>
  </body>
   
  <script type="text/javascript">
      var websocket = null;
       
      //判断当前浏览器是否支持WebSocket
      if('WebSocket' in window){
          websocket = new WebSocket("ws://localhost:8080/eavinlau/chat");
      }else{
          alert('Not support websocket')
      }
       
      //连接发生错误的回调方法
      websocket.onerror = function(event){
          setMessageInnerHTML("发生错误了！！!");
      };
       
      //连接成功建立的回调方法
      websocket.onopen = function(event){
          setMessageInnerHTML("连接打开了！！！");
      }
       
      //接收到消息的回调方法
      websocket.onmessage = function(event){
          setMessageInnerHTML(event.data);
      }
       
      //连接关闭的回调方法
      websocket.onclose = function(event){
          setMessageInnerHTML("连接关闭了！！！");
      }
       
      //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
      window.onbeforeunload = function(){
          websocket.close();
      }
       
      //将消息显示在网页上
      function setMessageInnerHTML(html){
          document.getElementById('message').innerHTML += html + '<br/>';
      }
       
      //关闭连接
      function close(){
          websocket.close();
      }
       
      //发送消息
      function send(){
          var message = document.getElementById('text').value;
          if(message==null||message==''){
        	  alert('内容不能为空');
        	  return;
          }
          websocket.send(message);
          document.getElementById('text').value='';
      }
  </script>
</html>