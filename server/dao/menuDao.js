var BaseDao = require('./baseDao');
var $sql = require('./menuSqlMapping');


module.exports = {
	queryByRestId: function (req, res, next) {
        var id = req.query.id;
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.queryByRestId, id, function(err, result) {
            	console.log(result)
            	let rsl = [],
            		tagIndex = {};

            	result.forEach((r) => {
            		if(typeof tagIndex[r.tagid] == 'undefined') {
            			rsl.push({
	            			tagid: r.tagid,
	            			tagname: r.tagname,
	            			foods: [{
	            				id: r.foodid,
	            				name: r.foodname,
	            				price: r.price
	            			}]
	            		})
	            		tagIndex[r.tagid] = rsl.length-1;

            		} else {
            			rsl[tagIndex[r.tagid]].foods.push({
            				id: r.foodid,
            				name: r.foodname,
            				price: r.price
            			})
            		}
            	})

                BaseDao.jsonWrite(res, rsl);
                connection.release();
            });
        });
    },
};
