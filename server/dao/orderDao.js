var BaseDao = require('./baseDao');
var $sql = require('./orderSqlMapping');
var $saleSql = require('./saleSqlMapping');


module.exports = {
	saveOrder: function (req, res, next) {
        var params = req.query || req.params,
        	foodList = JSON.parse(decodeURIComponent(params.foodlist));


		// var sql1 = "insert table set a=?, b=? where 1=1";
		// var param1 = {a:1, b:2};
		// sqlParamsEntity.push(_getNewSqlParamEntity($sql.insert,  [params.restid, params.deskid, params.saletime, params.totalprice]));
        if(params.type == 'addOrderFood') {
            BaseDao.pool.getConnection(function(err, connection) {
                execInsertSales(params.orderid, foodList, () => {
                    connection.release();
                });
            });
        } else {
            BaseDao.pool.getConnection(function(err, connection) {
                connection.query($sql.insert, [params.restid, params.deskid, params.customerid, params.saletime, params.totalprice, 0], function(err, result) {
                    if(result.insertId >= 0) {
         //             var sqlParamsEntity = [];
         //             foodList.forEach((food) => {
                  //        sqlParamsEntity.push(BaseDao.getNewSqlParamEntity($saleSql.insert, [result.insertId, food.foodid, food.price, food.num, 0]));
                  //       })

                        // BaseDao.execTrans(sqlParamsEntity, function(err, info){
                        //  if(err){
                        //     console.error("事务执行失败");
                        //  }else{
                        //     BaseDao.jsonWrite(res, {orderId: result.insertId});
                        //  }
         //                    connection.release();
                        // })
                        execInsertSales(result.insertId, foodList, () => {
                            connection.release();
                        });
                    } else {
                        connection.release();
                    }
                    
                });
            });
        }


        function execInsertSales(orderId, foodList, cb) {
            var sqlParamsEntity = [];
            foodList.forEach((food) => {
                sqlParamsEntity.push(BaseDao.getNewSqlParamEntity($saleSql.insert, [orderId, food.foodid, food.price, food.num, 0]));
            })

            BaseDao.execTrans(sqlParamsEntity, function(err, info){
                if(err){
                   console.error("事务执行失败");
                   cb && cb()
                }else{
                   BaseDao.jsonWrite(res, {orderId: orderId});
                }
                
                cb && cb()
            })
        }

        

    },
    queryByRestIdAndStatus: function(req, res, next) {
        var params = req.query || req.params
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.queryByRestIdAndStatus, [params.restid, params.status], function(err, result) {
                console.log(result)
                BaseDao.jsonWrite(res, result);
                connection.release();

            });
        });
    },
    queryOrderById: function(req, res, next) {
        var params = req.query || req.params
        BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.queryById, [params.orderid], function(err, result) {
                console.log(result)
                
                BaseDao.jsonWrite(res, result);
                connection.release();
            });
        });
    },
    queryOrderByCustomerId: function(req, res, next) {
    	var params = req.query || req.params
    	BaseDao.pool.getConnection(function(err, connection) {
            connection.query($sql.queryByCustomerid, [params.customerid, params.deskid, params.status], function(err, result) {
            	console.log(result)
            	
                BaseDao.jsonWrite(res, result);
                connection.release();
            });
        });
    }
};
