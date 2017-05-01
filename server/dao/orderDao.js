var BaseDao = require('./baseDao');
var $sql = require('./orderSqlMapping');
var $saleSql = require('./saleSqlMapping');
var Util = require('../util/util');


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
                let d = new Date(),
                    tomorrow = new Date();
                    
                let fd = Util.formatDate(d, 'yyyy-MM-dd');
                tomorrow.setTime(tomorrow.getTime() + 3600 * 1000 * 24 * 1);
                let tod = Util.formatDate(tomorrow, 'yyyy-MM-dd');

                connection.query($sql.queryMaxOrderNo, [params.restid, fd + ' 00:00:00', tod + ' 00:00:00'], function(err, result) {
                    let max = result[0][Object.keys(result[0])[0]];
                    let zorderno = null
                    if(max) {
                        let number = parseInt(max.substr(13))+1;
                        let zeroNum = 5 - (number+'').length;
                        let prefixZero = ''
                        for(let i=0;i<zeroNum;i++) {
                            prefixZero += '0';
                        }
                        zorderno = max.substring(0, 13) + prefixZero + number;
                    } else {
                        zorderno = Util.formatDate(d, 'yyyyMMdd') + params.restid + '00001'
                    }

                    connection.query($sql.insert, [params.restid, params.deskid, params.customerid, params.saletime, params.totalprice, 0, zorderno], function(err, result) {
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
                

                // let zorderno = Util.formatDate(new Date(), 'yyyy-MM-dd') + params.restid + ;
         
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
            connection.query($sql.queryByRestIdAndStatus, [params.restid], function(err, result) {
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
