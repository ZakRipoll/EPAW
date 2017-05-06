<!DOCTYPE html>
<html>
<body>

<form action="FormController" method="post">
  <fieldset>
    <legend>Personal information:</legend>
    Name*:<br>
    <input type="text" name="name" class="checkables" placeholder="Name">
    <br>
    Middle name:<br>
    <input type="text" name="middle_name" placeholder="Middle name">
    <br>
    Last name*:<br>
    <input type="text" name="last_name" class="checkables" placeholder="Last name">
    <br>
    Username*:<br>
    <input type="text" name="username" id="username" class="checkables" placeholder="Username">
    <br>
    Email*:<br>
    <input type="text" name="email" id="mail" class="checkables" placeholder="Email">
    <br>
    Password*:<br>
    <input type="text" name="password" id="password" class="checkables" placeholder="Password">
    <br>
    Repeat password*:<br>
    <input type="text" name="repeat_password" id="checkpasswod" class="checkables" placeholder="Repeat password">
    <br>
    Birth date*:<br>
    <input type="date" name="birth_date" class="checkables">
    <br>
    Profile Picture:<br>
    <input type="text" name="profile_picture" placeholder="Profile Picture">
    <br>
    Sex:*<br>
    <input type="radio" name="sex" value="male" > Male<br>
    <input type="radio" name="sex" value="female"> Female<br>
    <input type="radio" name="sex" value="other" checked> Other<br>
    <br>
    <input type="checkbox" name="terms_of_use" value="Bike">Terms of Use*:<br>
    <br><br>
    <input type="submit" id="send" value="Submit">
  </fieldset>
</form>

</body>

<script src="js/register.js"></script>
<script src="js/app.js"></script>

</html>
