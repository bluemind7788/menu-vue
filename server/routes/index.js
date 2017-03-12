var restDao = require('../dao/restDao');

module.exports = function(app) {
    app.get('/api/restinfo', function(req, res, next) {
        restDao.queryById(req, res, next);
    });

};
