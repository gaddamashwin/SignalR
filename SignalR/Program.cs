using Microsoft.AspNet.SignalR.Client.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SignalR
{
    class Program
    {
        private static string connID = "";

        static void Main(string[] args)
        {
            // Connect to the service
            var hubConnection = new HubConnection("http://localhost:39533/");

            // Create a proxy to the chat service
            var chat = hubConnection.CreateHubProxy("chatHub");
            Action<string, string> act = WriteToConsole;
            // Print the message when it comes in
            //chat.On("broadcastMessage",  message => Console.WriteLine(message));
            chat.On("broadcastMessage", act);
            chat.On("notifyMessageSent", () => Console.WriteLine("Message Sent"));
            // Start the connection
            hubConnection.Start().Wait();
            connID = hubConnection.ConnectionId;

            string line = null;
            while ((line = Console.ReadLine()) != null)
            {
                // Send a message to the server
                chat.Invoke("Send", "console", line).Wait();
            }
        }

        private static void WriteToConsole(string string1, string string2)
        {

            Console.WriteLine("{2}-{0} : {1} ", string1, string2, Convert.ToString(connID));
        }
    }
}
