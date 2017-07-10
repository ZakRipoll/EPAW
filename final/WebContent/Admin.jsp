<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<table class="table table-striped">

	<tr>
		<th>Profile Picture</th>
		<th>Username</th>
	 	<th>Name</th>
	 	<th>Middle name</th>
	 	<th>Last name</th>
	 	<th>E-mail</th>
	 	<th>Password</th>
	 	<th>Birthdate</th>
 	</tr>
 	
	<c:forEach items="${information}" var="item">
		
		<tr id = "${item.getUser()}">
			<td class="delete-user">
		 		<img alt="Profile Picutre" src="${item.getProfilePicture()}" width = "100%">
		 	</td>
		 	<td class="show-profile">${item.getUser()}</td>
		 	<td>${item.getName()}</td>
		 	<td>${item.getMiddleName()}</td>
		 	<td>${item.getLastName()}</td>
		 	<td>${item.getMail()}</td>
		 	<td>${item.getPassword()}</td>
		 	<td>${item.getBirthdate()}</td>
		</tr>

 	</c:forEach>
	
</table>

<script type="text/javascript">
$(document).ready(function() { 
    $(".show-profile").click(function(){
    	$('#contentIndex').load('TweetsController', {user: $(this).parent().attr("id"), profile: 'profile'});
    });
    
    $(".delete-user").click(function(){
    	var that = $(this).parent();
    	$.ajax({
            type: "POST",
            url: "IsAdmin",
    		data: ({user:that.attr("id"), type:"delete"}),
            success: function(html) {
            	that.remove();
            }
        });
    });
});
</script>