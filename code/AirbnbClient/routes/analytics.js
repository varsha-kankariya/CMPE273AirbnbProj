
var express = require('express');
var router = express.Router();
var mq_client = require('../rpc/client');
var tool = require("../utili/common");

router.get('/topProp',function (req,res) {
    var no_of_props= req.param("no_of_props");
    var json_responses;
    var msg_payload = {"no_of_props":no_of_props};

    mq_client.make_request('top_property_queue',msg_payload,function (err,results) {

        if(err)
        {
      	   tool.logError(err);
            json_responses = {"status_code":400};
        }
        else{
            if(results.statusCode == 200){
                json_responses = {"status_code":results.statusCode,"top_property":results.top_property};
            }
            else{
                json_responses = {"status_code":results.statusCode};
            }
        }
        res.send(json_responses);
        res.end();
    });

});

router.get('/cityWiseData',function (req,res) {

    var json_responses;
    var city = req.param("city");

    var msg_payload = {"city":city};

    mq_client.make_request('city_wise_data_queue',msg_payload,function (err,results) {

        if(err){
      	   tool.logError(err);
            json_responses = {"status_code":400};
        }
        else {
            if(results.statusCode == 200){
                json_responses = {"status_code":results.statusCode,"city_wise_data":results.city_wise_data};
            }
            else{
                json_responses = {"status_code":results.statusCode};
            }
        }
        res.send(json_responses);
        res.end();
    });

});

router.get('/topHost',function (req,res) {
    var no_of_hosts= req.param("no_of_hosts");
    var json_responses;
    var msg_payload = {"no_of_hosts":no_of_hosts};

    mq_client.make_request('top_host_queue',msg_payload,function (err,results) {

        if(err)
        {
      	   tool.logError(err);
            json_responses = {"status_code":400};
        }
        else{
            if(results.statusCode == 200){
                json_responses = {"status_code":results.statusCode,"top_host":results.top_host};
            }
            else{
                json_responses = {"status_code":results.statusCode};
            }
        }
        res.send(json_responses);
        res.end();
    });

});

router.get('/propRatings',function (req,res) {
    var property_id= req.param("property_id");
    console.log("In AirbnbClient  : analytics.js  : propRatings : "+property_id);
    var msg_payload = {"property_id":property_id};

    mq_client.make_request('prop_ratings_queue',msg_payload,function (err,results) {

        if(err){
            console.log("In AirbnbClient : analytics.js : Property ratings : Error : " +err);
            tool.logError(err);
            var json_resp = {
                "status_code" : 400
            };
            res.send(json_resp);
            res.end();

        }else{

            res.send(results.json_resp);
            res.end();
        }

    });

});

router.get('/bidInfo',function (req,res) {

    var json_responses;
    var prop_id=req.param("prop_id");
    var msg_payload = {"prop_id":prop_id};

    mq_client.make_request('analytics_bid_info_queue',msg_payload,function (err,results) {

        if(err)
        {
            tool.logError(err);
            json_responses={"status_code":400};
        }
        else
        {
            if(results.statusCode==200){
                json_responses = {"status_code":results.statusCode,"bid_info":results.bid_info};
            }
            else {
                json_responses = {"status_code":results.statusCode};
            }
        }
        res.send(json_responses);
        res.end();

    });

});


module.exports =router;