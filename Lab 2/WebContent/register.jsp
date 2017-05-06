<!DOCTYPE html>
<html>
<body>

<form action="FormController" method="post">
  <fieldset>
    <legend>Personal information:</legend>
    Name*:<br>
    <input type="text" name="firstname" class="checkables" placeholder="Name">
    <br>
    Middle name:<br>
    <input type="text" name="lastname" placeholder="Middle name">
    <br>
    Last name*:<br>
    <input type="text" name="lastname" class="checkables" placeholder="Last name">
    <br>
    Username*:<br>
    <input type="text" name="username" id="username" class="checkables" placeholder="Username">
    <br>
    Email*:<br>
    <input type="text" name="lastname" id="mail" class="checkables" placeholder="Email">
    <br>
    Password*:<br>
    <input type="text" name="lastname" id="password" class="checkables" placeholder="Password">
    <br>
    Repeat password*:<br>
    <input type="text" name="lastname" id="checkpasswod" class="checkables" placeholder="Repeat password">
    <br>
    Birth date*:<br>
    <input type="date" name="bday" class="checkables">
    <br>
    Profile Picture:<br>
    <input type="text" name="lastname" placeholder="Profile Picture">
    <br>
    Sex:*<br>
    <input type="radio" name="gender" value="male" > Male<br>
    <input type="radio" name="gender" value="female"> Female<br>
    <input type="radio" name="gender" value="other" checked> Other<br>
    <br>
    <input type="checkbox" name="vehicle" value="Bike">Terms of Use*:<br>
    <br><br>
    <input type="submit" id="send" value="Submit">
  </fieldset>
</form>

</body>

<script src="js/register.js"></script>
<script src="js/app.js"></script>

</html>
