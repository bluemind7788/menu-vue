var restDao = require('../dao/restDao');
var menuDao = require('../dao/menuDao');
var orderDao = require('../dao/orderDao');
var saleDao = require('../dao/saleDao');


module.exports = function(app) {
    app.get('/api/restinfo', function(req, res, next) {
        restDao.queryById(req, res, next);
    });
    app.get('/api/menu', function(req, res, next) {
        menuDao.queryByRestId(req, res, next);
    });
    app.get('/api/saveorder', function(req, res, next) {
        orderDao.saveOrder(req, res, next);
    });

    app.get('/api/getOrderByCustId', function(req, res, next) {
        orderDao.queryOrderByCustomerId(req, res, next);
    });

    app.get('/api/queryOrderById', function(req, res, next) {
        orderDao.queryOrderById(req, res, next);
    });
    
    app.get('/api/getOrderByRestIdAndStatus', function(req, res, next) {
        orderDao.queryByRestIdAndStatus(req, res, next);
    });

    app.get('/api/updateSaleStatus', function(req, res, next) {
        saleDao.updateSaleStatus(req, res, next);
    });

    app.get('/api/deleteSale', function(req, res, next) {
        saleDao.deleteSale(req, res, next);
    });
    
    app.get('/api/saveSale', function(req, res, next) {
        saleDao.saveSale(req, res, next);
    });
};
