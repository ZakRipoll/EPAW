<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/formRegister.css" rel="stylesheet">
<link href="css/formLogin.css" rel="stylesheet">
<title> Login Form </title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script src="js/ViewLoginForm.js"></script>

<script>
$("#loginForm").submit(function(event){

	event.preventDefault();
	
	var input = $("#loginForm").serialize();
	
	var administrador = jQuery('input[name="user"]').val();

	$.ajax({
        type: "POST",
        url: "IsAdmin",
		data: ({user:administrador}),
        success: function(html) {
        	var answer = confirm("Do you want to access at admin section?");
        	if (answer == true) 
        		$('#contentIndex').load('IsAdmin ', {admin:administrador});
        	else 
        		$('#contentIndex').load('LoginController',input);
        },
		error: function(xhr){
			$('#contentIndex').load('LoginController',input);
		}
    });
});

</script>

<div class="wrapper">
	<div class="form-container">
		<form id="loginForm">
			<h2 class="form-signin-heading">Login</h2>
			<div class="loginForm">
				<div class="container-input">
					<label for="user" class="sr-only">User id*</label>
					<input id="user" name="user" type="text" placeholder="User id*" class="form-control" minlength="5" value="${login.user}" required autofocus>
				</div>
				<div class="container-input">
					<label for="password" class="sr-only">Password*</label>
					<input type="password" name="password" value="${login.password}" id="password" placeholder="Password*" class="form-control" required autofocus>
					<c:if test="${login.error[0] == 1}">
						<div class="error"> Nonexistent this username and password in our DB! </div> 
					</c:if>
				</div>
				<button class="btn btn-lg btn-primary btn-block" type="submit" >Login</button>
			</div>
		</form>
	</div>
</div>