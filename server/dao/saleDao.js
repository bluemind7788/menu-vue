var BaseDao = require('./baseDao');
var $sql = require('./saleSqlMapping');

module.exports = {
	saveSale: function (req, res, next) {
        var params = req.query || req.params;
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.insert, [params.zorderid, params.foodid, params.price, params.num, 0], function(err, result) {
            	BaseDao.jsonWrite(res, result);
                connection.release();

            });
        });
    },
    updateSaleStatus: function (req, res, next) {
        var params = req.query || req.params;
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.updateSaleStatus, [params.status, params.saleid], function(err, result) {
                console.log(result)
                BaseDao.jsonWrite(res, result);
                connection.release();
            });
        });
    },
    deleteSale: function (req, res, next) {
        var params = req.query || req.params;
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.deleteSale, [params.saleid], function(err, result) {
                console.log(result)
                BaseDao.jsonWrite(res, result);
                connection.release();
            });
        });
    },
};
