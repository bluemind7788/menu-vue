import MockMenu from './mock/menu.js'

export default {
	fetchMenu(params, callback) {
		callback(MockMenu)
	}
}