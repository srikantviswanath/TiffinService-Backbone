const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.myFirstFunction = functions.database.ref('OrderItems/04-19-2017/{itemId}/Users/{userId}')
	.onWrite( event => {
		const userNewQty = event.data.val()
		const userPrevQty = event.data.previous.val()
		var totalItemCount = event.data.ref.parent.parent.child('Count')
		console.log("Jajjarabhooto", userNewQty, totalItemCount.val())
		return event.data.ref.parent.parent.child('Count').set(totalItemCount - userPrevQty + userNewQty);
	}
);