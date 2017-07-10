<script type="text/javascript">
	$(document).ready(function() {
		    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
		    $('#navigation').load('MenuController');
		    $('#leftcolumnIndex').load('LoginController', {user:"${user}"});
		    $('#contentIndex').load('TweetsController', {user:"${user}", profile:"profile"});
		    $('#rightcolumnIndex').load('FollowController', {friend:"false"});
	});
</script>