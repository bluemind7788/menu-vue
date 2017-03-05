import Vue from 'vue'
import Firebase from 'firebase/app'
import 'firebase/database'
import VueFire from 'vuefire'

Vue.use(VueFire)

var config = {
	// apiKey: "AIzaSyBr91ULIXf0Gu0LLN1qNjNbHwqqHLlehxc",
	// authDomain: "fastmenu-90af4.firebaseapp.com",
	databaseURL: "https://fastmenu-90af4.firebaseio.com",
	// storageBucket: "fastmenu-90af4.appspot.com",
	// messagingSenderId: "53560460945"
	// databaseURL: 'https://hacker-news.firebaseio.com'
	        // databaseURL: 'https://vuefiredemo.firebaseio.com'

};
Firebase.initializeApp(config);

let db = Firebase.database()

export default db