<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" import="models.BeanUser"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/formRegister.css" rel="stylesheet">
<title> Template Register Form (Validation JQuery) </title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />

<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>


<script type="text/javascript">
function sendNewProfile(){
  console.log($("#editForm").serialize());
  $('#leftcolumnIndex').load('ProfileController',$("#editForm").serialize());   
}
</script>

 <form id="editForm">
 <div class="form-group">
<label for="name">Name:</label>
<input type="text" name="name" class="form-control" id="name" value="${usuari.name}">
</div>

<div class="form-group">
   <label for="middleName">Middlename:</label>
   <input type="text" name="middleName" class="form-control" id="middleName" value="${usuari.middleName}">
</div>

<div class="form-group">
   <label for="lastName">Last name:</label>
   <input type="text" name="lastName" class="form-control" id="lastName" value="${usuari.lastName}">
 </div>

<div class="form-group">
   <label for="mail">Mail:</label>
   <input type="email" class="form-control" id="mail" name="mail" value="${usuari.mail}">
</div>

<div class="form-group">
   <label for="password">Password:</label>
   <input type="password" class="form-control" id="password" name="password" value="${usuari.password}">
</div>

<div class="form-group">
   <label for="profilePicture">Profile Picture:</label>
   <input type="text" class="form-control" id="profilePicture" name="profilePicture" value="${usuari.profilePicture}">
</div>

 <button type="submit" onclick="sendNewProfile()">Guardar</button>
 </form>