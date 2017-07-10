<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/prova.css" rel="stylesheet"> 

<script type="text/javascript">
$(document).ready(function() {
    $(".menu").click(function(event) {
        $('#contentIndex').load('ContentController',{content: $(this).attr('id')});
        });
});
</script>

</head>
<div id = "Registration">
	<a class="menu" id="RegisterController" href=#> Registration </a>
</div>
<div id = "Login">
	<a class="menu login" id="LoginController" href=#> Login </a>
</div>
