function likeRetweetShare(element, usuari, perfil){
	
	if(usuari == null) 
		usuari = "null";
	 $.ajax({
        type: "POST",
        url: 'LtsController',
		data: ({id:parseInt(element.parentNode.parentNode.id), type:element.nextSibling.nextSibling.className}),
         success: function(html) {
        	 $('#contentIndex').load('TweetsController', {user:usuari, profile:perfil});
         }
     });
}

function tweetDelete(element, usuari){
	$.ajax({
        type: "POST",
        url: "TweetsController",
		data: ({data:element, user:usuari, introduce:"FALSE"}),
        success: function(html) {
        	document.getElementById(element).parentNode.remove();
        	var tweet = parseInt( document.querySelector(".userTweets").innerHTML );
			 tweet -= 1;
			 document.querySelector(".userTweets").innerHTML = tweet;
        }
    });
}

function sendTweet(event, usuari, perfil){
	
	if(event.keyCode == 13)
	{
		var text = $("#newTweet").val();
	    
		text = text.replace(/</g, "&lt;").replace(/>/g, "&gt;");
		text = text.replace("\'", "\\'");
		
		$.ajax({
			type: "POST",
			url: 'TweetsController',
			data: ({data:text, user:usuari, introduce:"TRUE"}),
			success: function(data) 
			{
				if(perfil == "profile"){
					var tweet = parseInt( document.querySelector(".userTweets").innerHTML );
					tweet += 1;
					document.querySelector(".userTweets").innerHTML = tweet;
				}
				 $('#contentIndex').load('TweetsController', {user:usuari, profile:perfil});
			}
		});
	}
}

function showProfile(element, login){
	if( login ){
		$.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
		$('#leftcolumnIndex').load('LoginController', {user:element});
	}

    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
    $('#contentIndex').load('TweetsController', {user:element, profile:"profile"});
}
