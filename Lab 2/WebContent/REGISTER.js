var name, password, mail;

name = password = mail = false;

function send(){
	if( name && passwor && mail )
		document.getElementById("send").disabled = false;
}

function checkUsername(){
	name = document.getElementById("username").value.length > 3;
	//Falta mirar bé com fer la consulta
	send();
}

function checkPassord(){
	var pass = document.getElementById("password").value;
	passord = pass > 7 && pass == document.getElementById("checkpasswod").value;
	send();
}

function checkEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    mai = re.test(email);
    send();
}
