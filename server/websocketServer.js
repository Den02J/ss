const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 3000 },()=>{
    console.log('server started')
})
wss.on('connection', (ws, request) => {
    let clientIp = request.connection.remoteAddress;
    console.log(clientIp);

   ws.on('message', (data) => {
      console.log('data received \n '+ data)
      wss.clients.forEach(function(client) {
         client.send(data.toString());
      });
   })
})
wss.on('listening',()=>{
   console.log('listening on 3000')
})