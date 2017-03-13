let menu = {
	queryByRestId: 'select * from food f, tag t '
					+ 'where f.restid=? and (f.tag1 = t.tagid or f.tag2 = t.tagid or f.tag3 = t.tagid)'
					+ 'ORDER BY t.tagord;',
};

module.exports = menu;