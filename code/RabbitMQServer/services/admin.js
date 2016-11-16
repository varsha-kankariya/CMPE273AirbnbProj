//Reabbit MQ server side for handling the admin related services
var tool = require("../utili/common");
var ObjectID = require('mongodb').ObjectID;

var approveHost = {

	handle_request : function(connection, msg, callback) {
		var res = {};
		var json_resp = {};
		try {

			var coll = connection.mongoConn.collection('user');

			console.log("In RabbitMQ Server : admin.js : host_id : " + msg.host_id);
			var searchCriteria = {
				"_id" : ObjectID(msg.host_id)
			};
			var data = {
					$set : {		
						"host_status" : "ACCEPTED"
					}
			};

			coll.updateOne(searchCriteria, data, function(err, results) {

				if (err) {
					//TODO: need to handle error
					console.log("RabbitMQ server : admin.js : error :"+err);
					tool.logError(err);
					json_resp = {
						"status_code" : 400,
					};
					res = {
						"json_resp" : json_resp
					};
					callback(null, res);
				} else {
					if (results.modifiedCount == 1) {
						json_resp = {
							"status_code" : 200,
						};
					} else {
						console.log("RabbitMQ server : admin.js : No erro but record was not updated : host_id : " +host_id);
						json_resp = {
							"status_code" : 400,
						};
					}
					res = {
						"json_resp" : json_resp
					};
					callback(null, res);
				}

			});
		} catch (err) {
			tool.logError(err);
			json_resp = {
				"status_code" : 400,
			};
			res = {
				"json_resp" : json_resp
			};
			callback(null, res);
		}

	}
};

exports.approveHost = approveHost;