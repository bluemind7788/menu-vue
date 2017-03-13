var restDao = require('../dao/restDao');
var menuDao = require('../dao/menuDao');

module.exports = function(app) {
    app.get('/api/restinfo', function(req, res, next) {
        restDao.queryById(req, res, next);
    });
    app.get('/api/menu', function(req, res, next) {
        menuDao.queryByRestId(req, res, next);
       
    });

};
