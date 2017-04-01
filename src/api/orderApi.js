import API from './api'

export default {
	saveOrder(params, callback) {
		API.get('/api/saveorder', params, callback)
	},
	getOrderByCustId(params, callback) {
		API.get('/api/getOrderByCustId', params, callback)
	},
	queryOrderById(params, callback) {
		API.get('/api/queryOrderById', params, callback)
	},
	getOrderByRestIdAndStatus(params, callback) {
		API.get('/api/getOrderByRestIdAndStatus', params, callback)
	}
}