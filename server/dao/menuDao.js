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
            	// 转换数据格式
            	result.forEach((r) => {
            		if(typeof tagIndex[r.tagid] == 'undefined') {
            			rsl.push({
	            			tagid: r.tagid,
	            			tagname: r.tagname,
	            			foods: [{
	            				foodid: r.foodid,
	            				foodname: r.foodname,
	            				price: r.price,
	            				image: r.image,
	            			}]
	            		})
	            		tagIndex[r.tagid] = rsl.length-1;

            		} else {
            			rsl[tagIndex[r.tagid]].foods.push({
            				foodid: r.foodid,
            				foodname: r.foodname,
            				price: r.price,
            				image: r.image
            			})
            		}
            	})

                BaseDao.jsonWrite(res, rsl);
                connection.release();
            });
        });
    },
};
