<script type="text/javascript">
$(document).ready(function() {
	    $.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	    $('#navigation').load('MenuController');
	    $('#contentIndex').load('TweetsController');
	    $('#rightcolumnIndex').load('FollowController');
});
</script>