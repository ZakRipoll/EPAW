<link href="css/perfil.css" rel="stylesheet">

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:choose>
	<c:when test = "${friends == 'true'}" >
			<div class="friends"> <strong>Friends</strong> </div> 
	</c:when>
	<c:otherwise>
			<div class="friends"> <strong>Suggested friends</strong>  </div>
	</c:otherwise>
</c:choose>

<c:forEach items="${follow}" var="information">

	<div class="followDone" id = "${information.getUser()}">
		<div class = "profilePictureFollow" >
			<img alt="Profile Picutre" src="${information.getProfilePicture()}">
		</div>
		<div></div>
		<div class = "Name show-profile" >${information.getName()}</div>
		<div class = "middleName show-profile">${information.getMiddleName()}</div>
		<div class = "finalName show-profile">${information.getLastName()}</div>
	</div>
	
</c:forEach>

<script type="text/javascript">
$(document).ready(function() {
	$.ajaxSetup({ cache: false }); // Avoids Internet Explorer caching!
	
	$('#navigation').load('MenuController');
	
	$(".show-profile").click(function(){
	    $('#leftcolumnIndex').load('LoginController', {user: $(this).parent().attr("id")});
	    $('#contentIndex').load('TweetsController', {user: $(this).parent().attr("id"), profile: 'profile'});
	});
	
	$(".profilePictureFollow").click( function() {
		var that = $(this).parent();
		var increment = "${friends}";
		
		$.ajax({
	        type: "POST",
	        url: "FollowController",
			data: ({user:that.attr("id"), insert:"${friends}"}),
	        success: function(html) 
	        {	        	 
	        	 if(increment == "false")
	        	 {
		         	 var tweet = parseInt( document.querySelector(".userFollow").innerHTML );
		 			 tweet += 1;
		 			 document.querySelector(".userFollow").innerHTML = tweet;
	        	 }
	        	 else 
	        	 {
	        		 $('#contentIndex').load('TweetsController', {user: "${user}"});
	        	 }
	        	 
	        	 that.remove();
	        }
	    });
	});
});
</script>
