var REGISTER = {
    init: function(){
      checkInputs();
    },
    validate: {
      name: false,
      password: false,
      mail: false
    }
}

function checkInputs(){
  /*document.getElementsByClassName("checkables").onkeyup = function(){
    switch (this.id) {
      case "username":
          checkUsername();
        break;
      case "password":
            checkPassord();
        break;
      case "mail":
          checkEmail();
        break;
    }
  }*/

  document.getElementById("username").addEventListener("keyup", function () {
    checkUsername();
  });

  document.getElementById("checkpasswod").addEventListener("blur", function () {
    checkPassord();
  });

  document.getElementById("mail").addEventListener("blur", function () {
    checkEmail();
  });
}

function send(){
	if( name && password && mail )
		document.getElementById("send").disabled = false;
}

function checkUsername(){
  var username = document.getElementById("username");
	name = username.value.length > 3;
  if(name == "false"){
    username.style.color = "red";
  }
  else {
    username.style.color = "orange";
  }
	//Falta mirar bé com fer la consulta
	send();
}

function checkPassord(){
	var pass = document.getElementById("password");
  var pascheck = document.getElementById("checkpasswod");
	password = pass.value.length > 7 && pass.value == pascheck.value;
  pascheck.style.color = pass.style.color = password ? "green" : "red";
	send();
}

function checkEmail() {
    var email = document.getElementById("mail");
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    mail = re.test(email.value);
    email.style.color = mail ? "green" : "red";
    send();
}

REGISTER.init();
