import MockRest from './mock/rest.js'

export default {
	fetchRestInfo(params, callback) {
		callback(MockRest)
	}
}