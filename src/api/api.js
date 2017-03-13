import Axios from 'axios'

const Base_Url = 'http://localhost:8080'

export default {
	get(url, params, callback) {
		Axios.get(url, {
			params: params
		}).then((res) => {
			callback && callback(res.data)
		})
	}
}