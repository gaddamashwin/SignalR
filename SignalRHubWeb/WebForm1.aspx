<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SignalRHubWeb.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <script src="http://code.jquery.com/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="Scripts/jquery.signalR-1.1.1.min.js" type="text/javascript"></script>
<!--  If this is an MVC project then use the following -->
 <script src="~/signalr/hubs" type="text/javascript"></script> 
<!-- <script src="signalr/hubs" type="text/javascript"></script>-->
<script type="text/javascript">
    $(function () {
        // Proxy created on the fly          
        var chat = $.connection.hub;

        // Declare a function on the chat hub so the server can invoke it          
        chat.client.addMessage = function (message) {
            $('#messages').append('<li>' + message + '</li>');
        };

        // Start the connection
        $.connection.hub.start().done(function () {
            $("#broadcast").click(function () {
                // Call the chat method on the server
                chat.server.send($('#msg').val());
            });
        });
    });
</script>
  
  <div>
    <input type="text" id="msg" />
<input type="button" id="broadcast" value="broadcast" />

<ul id="messages">
</ul>
  </div>
    </form>
</body>
</html>
