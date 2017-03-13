var BaseDao = require('./baseDao');
var $sql = require('./restSqlMapping');

module.exports = {
	queryById: function (req, res, next) {
        var id = req.query.id;
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.queryById, id, function(err, result) {
                BaseDao.jsonWrite(res, result[0]);
                connection.release();

            });
        });
    },
};
