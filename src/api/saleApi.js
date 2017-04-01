import API from './api'

export default {
	updateSaleStatus(params, callback) {
		API.get('/api/updateSaleStatus', params, callback)
	},
	deleteSale(params, callback) {
		API.get('/api/deleteSale', params, callback)
	},
	saveSale(params, callback) {
		API.get('/api/saveSale', params, callback)
	}
}