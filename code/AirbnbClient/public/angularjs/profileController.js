var myProfile = angular.module('myProfile',[]);
		myProfile.filter("trustUrl", ['$sce', function ($sce) {
			return function (recordingUrl) {
				return $sce.trustAsResourceUrl(recordingUrl);
			};
		}]);
    	myProfile.controller('myProfileController',function($scope,$http){
    		$scope.signUpError ="";
    		$scope.msg ="";
			$scope.errormsg = "";
    		$http({
	            method:"POST",
	            url:"/api/profile/loadProfile"
	        }).success(function(data){
	        	$scope.data=data.user;
	        	$scope.first_name = data.user.first_name;
				$scope.last_name = data.user.last_name;
				$scope.phone = data.user.phone;
				$scope.email = data.user.email;
				$scope.street = data.user.street;
				$scope.dob = data.user.dob;
				$scope.address = data.user.address;
				$scope.city = data.user.city;
				$scope.state = data.user.state;
				$scope.zipcode = data.user.zipcode;
				console.log("the zipcode is:"+data.user.zipcode);
				$scope.ssn = data.user.ssn;
				$scope.image = data.user.picture_path[0].filename;
				var str1="/uploads/";
				str1 = str1.concat(data.user.video_path[0].filename);
				console.log("the url is:"+str1);
				$scope.path = str1;
	        })

    		$scope.card1=true;
    		$scope.card=false;
    		$scope.profile = function(){
    			$scope.card=false;
    			$scope.card1=true;
    		}
    		$scope.profileImage = function(){
    			$scope.card1=false;
    			$scope.card=true;

    		}

    		$scope.uploadImg = function(){
    			$http({
    	            method:"POST",
    	            url:"/api/profile/uploadPic",
    	            data: {
        	        	"file":document.getElementById('file').files[0]
    	            }
    	        }).success(function(data){
    	        	$scope.data=data.user;
					$scope.msg = "Updated Successfully";
					$scope.signUpError="";
    	        })
    		}
    		
    		$scope.submitProfile = function(){
    			
    			var zipPatt = new RegExp("^[0-9]{5}(-[0-9]{4})?$");
    	        var validZip = zipPatt.test($scope.zipcode);	
    	        
    	        if($scope.zipcode != undefined && !validZip){
    	        	$scope.signUpError="Zip should be in these formats - 12345 or 12345-1111";
    	        	$scope.msg ="";
    	        }
    	        else{
    			$http({
    	            method:"POST",
    	            url:"/api/profile/updateProfile",
    	            data: {
        	        	"first_name":$scope.first_name,
        	        	"last_name": $scope.last_name,
        	        	"phoneNumber": $scope.phone 	,
        	        	"email": $scope.email 	,
        	        	"dob": $scope.dob ,
                        "street":$scope.street,
                        "address":$scope.adress,
                        "city":$scope.city,
                        "state":$scope.state,
                        "zipcode":$scope.zipcode,
                        "ssn":$scope.ssn
    	            }
    	        }).success(function(data){
    	        	if(data.status_code == "200" ){
    	        		$scope.data=data.user;
    					$scope.msg = "Updated Successfully";
    					$scope.errormsg = "";
    	        	}
    	        	else{
    	        		$scope.msg = "";
    	        		$scope.errormsg = "Error while updating";
    	        		window.location.reload();
    	        	}
    	        })
    	        }
    		}
    		
    		$scope.searchByCity = function(){
            	//alert(1);
            	var whereTo = $scope.searchCity;
            	if(whereTo)
            	window.location.assign("/api/auth/home?c="+whereTo);
            	else
            		window.location.assign("/api/auth/home");	
            }
    	});