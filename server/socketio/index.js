
module.exports = (_server) => {
    let io = require('socket.io')(_server)

    io.on('connection', function (_socket) {
        console.log(_socket.id + ': connection');
        _socket.on('order', function (orders) {
            console.log('Message Received: ', orders);
            _socket.broadcast.emit('order', orders);
        });
        _socket.on('food-status', function (food) {
            console.log('Message Received: ', food);
            _socket.broadcast.emit('food-status', food);
        });
        _socket.on('order-item-remove', function (item) {
            console.log('Message Received: ', item);
            _socket.broadcast.emit('order-item-remove', item);
        });

        _socket.on('disconnect', function(){
          console.log('user disconnected');
        });
    });
}