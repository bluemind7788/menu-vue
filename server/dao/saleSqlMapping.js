let sale = {
	insert: 'INSERT INTO sale(zorderid, foodid, price, num, salestatus) VALUES (?, ?, ?, ?, ?);',
	updateSaleStatus: 'UPDATE sale SET salestatus = ? where saleid = ? ',
	deleteSale: 'DELETE FROM sale where saleid = ?',
};

module.exports = sale;