// 房间用户名单
let roomInfo = {};
// {
//     restId: []
// }

function parseCookie(req) {
    var Cookies = {};
    console.log(req)
    req.headers.cookie && req.headers.cookie.split(';').forEach(function( Cookie ) {
        var parts = Cookie.split('=');
        Cookies[ parts[ 0 ].trim() ] = ( parts[ 1 ] || '' ).trim();
    });
    return Cookies;
}

function parseRestId(req) {
    var url = req.headers.referer;
    
    var splited = url.split('?')[0].split('/');
    if(splited[splited.length - 2] == 'cooker') {
        return splited[splited.length - 1]
    }
    return splited[splited.length - 2];
}

module.exports = (_server) => {
    let io = require('socket.io')(_server)

    io.on('connection', function (_socket) {
        // let cookies = parseCookie(_socket.request),
        let restId = parseRestId(_socket.request),
            roomID = "Room_" + restId;

        // if(cookies.customer_uuid) {
        //     roomID = 'Room_' + cookies.customer_uuid;
        //     _socket.join(roomID);
        // }

        _socket.join(roomID);

        console.log(_socket.id + ' join room ' + roomID);

        _socket.on('join-room', () => {
            // roomInfo[restId].push(user);
            _socket.join(roomID);
        })

        _socket.on('new-order', function (orderInfo) {
            // console.log('Message Received: ', orderInfo);
            
            // _socket.broadcast.emit('order', orders);
            
            io.to(roomID).emit('new-order', orderInfo);
        });

        _socket.on('food-status', function (sale) {
            // console.log('Message Received: ', sale);
            // _socket.broadcast.emit('food-status', sale);
            io.to(roomID).emit('food-status', sale);
        });

        _socket.on('order-item-remove', function (item) {
            // console.log('Message Received: ', item);
            // _socket.broadcast.emit('order-item-remove', item);
            io.to(roomID).emit('order-item-remove', item);
        });

        _socket.on('disconnect', function(){
          console.log('user disconnected');
        });
    });
}