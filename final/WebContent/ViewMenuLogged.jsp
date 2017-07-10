<link rel="stylesheet" type="text/css" href="css/header.css" />

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<div id="leftcolumn">
	<input id = "search" type="text">
</div>

<div id="content">
		<img src="imatges/logo.png" alt="Company Logo" class = "photo" >
</div>

<div id="rightcolumn">
	<div id = "user">
		<img class = "photo profile" src="imatges/logo.png" alt="Company Logo" title="Home">
		<p class="menu clickable contprof" id="ProfileController">${user}</p>	
	</div>
	<div id = "logout">
		<p class="menu clickable logout" id="LogoutController">Logout</p>
	</div>
</div>


<script type="text/javascript">
$(document).ready(function() {
	
    $(".contprof").click(function(event) {
    	console.log("${admin}");
    	$('#leftcolumnIndex').load('LoginController', {user:"${user}"});
        $("#contentIndex").load('TweetsController', {user:"${user}", profile:"profile"});
        $('#rightcolumnIndex').load('FollowController', {friend:"false"});
    });

    $(".logout").click(function(event) {
   		$.ajax({
			type: "POST",
			url: "LogoutController",
			success: function(html) {
				$('#navigation').load('MenuController');
				$('#rightcolumnIndex').empty();
				$('#leftcolumnIndex').empty();
				$("#contentIndex").load('TweetsController');
			}
   		});
    });

	$("#content").click(function(event) {
		$('#rightcolumnIndex').load('FollowController', {friend:"true"});
	    $('#leftcolumnIndex').empty();
	    $('#contentIndex').load('TweetsController', {user:"${user}"});
	});
	
	$("#search").keypress(function(e) 
	{
		if(e.which == 13) 
		{
		  	var text = $("#search").val();
		  	$("#search").val("");			
			$.ajax({
		        type: "POST",
		        url: "CheckUser",
				data: ({user:text}),
		        success: function(html) {
					$.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
					$('#leftcolumnIndex').load('LoginController', {user:text});
					
					$.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
					$('#contentIndex').load('TweetsController', {user:text, profile:"profile"});
		       }
			});
		}
	});
});

</script>


