<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title> Lab 3 template </title>
<link rel="stylesheet" type="text/css" href="css/prova.css" />
<link href="css/formRegister.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"> </script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>

	<!-- Begin Header -->
	<div id="header">
		
		<!-- Begin Navigation -->
		<div id="navigation">
		
			<jsp:include page="ViewMenuNotLogged.jsp" />
			
		</div>
	
	</div>
	<!-- End Header -->
	
	<!-- Begin Faux Columns -->
	<div id="faux">
	
	      <!-- Begin Left Column -->
	<div id="leftcolumnIndex">
	
<%-- 		<jsp:include page = "${esquerra}" /> --%>
	
	</div>
	<!-- End Left Column -->
	
	<!-- Begin Content Column -->
	<div id="contentIndex">
		
		<jsp:include page = "${centre}" />
	   			  
	</div>
	<!-- End Content Column -->
	
	<!-- Begin Right Column -->
	<div id="rightcolumnIndex">
	
<%-- 		<jsp:include page = "${dreta}" /> --%>
	
	</div>
	<!-- End Right Column -->
	
	</div>	   
	<!-- End Faux Columns --> 
		 
</body>
</html>