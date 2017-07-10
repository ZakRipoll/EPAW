<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<link href="css/perfil.css" rel="stylesheet">

<div class="loginDone">
	<div class = "profilePictureBig">
		<img class = "profilePictureBig" alt="Profile Picutre" src="${information.getProfilePicture()}">
	</div>
	<div class = "information">
		<table>
			<tr>
				<td> ${information.getName()} </td>
				<td> ${information.getMiddleName()} </td>
				<td> ${information.getLastName()} </td>
			</tr>
			<tr>
				<td> Follow </td>
				<td> Followed </td>
				<td> Tweets </td>
			</tr>
			<tr>
				<td class = "userFollow"> ${information.getFollow()} </td>
				<td class = "userFollowed"> ${information.getFollowed()} </td>
				<td class = "userTweets"> ${information.getTweets()} </td>
			</tr>
		</table>
		
		<div class = "unFriend">
			<c:choose>
				<c:when test = "${information.getFriends() == 0}" >
						<p class = "fiends" id = "${information.getUser()}"> 
							Add <i class="material-icons">person_add</i> 
						</p>
				</c:when>
				<c:when test = "${user != information.getUser()}" >
						<p class = "unfriend" id = "${information.getUser()}"> 
							Delete <i class="material-icons">person_add</i> 
						</p>
	  			</c:when>
			</c:choose>
		</div>
	</div>
</div>


<script type="text/javascript">
$(document).ready(function() {
    $(".fiends").click(function(){
    	var that = $(this);
    	$.ajax({
            type: "POST",
            url: "FollowController",
    		data: ({user:that.attr("id"), insert:"false"}),
            success: function(html) {
            	$('#leftcolumnIndex').load('LoginController', {user:that.attr("id")});
            	$('#rightcolumnIndex').load('FollowController', {friend:"${friends}"});
            }
        });
    });
    
    $(".unfriend").click(function(){
    	var that = $(this);
    	$.ajax({
            type: "POST",
            url: "FollowController",
    		data: ({user:that.attr("id"), insert:"true"}),
            success: function(html) {
            	$('#leftcolumnIndex').load('LoginController', {user:that.attr("id")});
            	$('#rightcolumnIndex').load('FollowController', {friend:"${friends}"});
            }
        });
    });
    
    $(".profilePictureBig").click(function(){
    	 $('#leftcolumnIndex').load('ProfileController', {user:"${user}"});
    });
});
</script>