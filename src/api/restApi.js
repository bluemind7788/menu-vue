import MockRest from './mock/rest.js'
import API from './api'

export default {
	fetchRestInfo(params, callback) {
		API.get('/api/restinfo', params, callback)
	}
}