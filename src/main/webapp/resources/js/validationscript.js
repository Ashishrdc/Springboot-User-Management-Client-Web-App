
 // Validating Form
function validateEditForm(){
        email = document.getElementById("email").value;
        errorField = document.getElementById("email");
        errorMsg = document.getElementById("invalidMail");

        username = document.getElementById("username").value;
        userErrorField = document.getElementById("username")
        userErrorMsg = document.getElementById("invalidUser");
        valid = true;
        // Check Username
        var unameRegex = /^[a-zA-Z0-9]{4,10}$/;
        if (username.match(unameRegex)){
            userErrorField.classList.remove("err");
            userErrorMsg.innerHTML = ""
            valid = true;
        }
        else{
            userErrorField.classList.add("err");
            userErrorMsg.innerHTML = "Username should not contain any special characters.";
            return false;
        }

        // Checking Email
        var mailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if (email.match(mailRegex)){
            errorField.classList.remove("err");
            errorMsg.innerHTML = "";
            valid = true;
        }
        else{
            errorField.classList.add("err");
            errorMsg.innerHTML = "Enter a valid email!";
            return false;
        }

}

function validateLoginForm(){
        email = document.getElementById("email").value;
        errorField = document.getElementById("email");
        errorMsg = document.getElementById("invalidMail");
        valid = true;

        var mailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if (email.match(mailRegex)){
            errorField.classList.remove("err");
            errorMsg.innerHTML = "";
            valid = true;
        }
        else{
            errorField.classList.add("err");
            errorMsg.innerHTML = "Enter a valid email!";
            return false;
        }
}

function validateRegForm(){

        // Gathering the values from the field
        // For username Field
        username = document.getElementById("username").value;
        userErrorField = document.getElementById("username")
        userErrorMsg = document.getElementById("invalidUser");

        // For Email Field
        email = document.getElementById("email").value;
        errorField = document.getElementById("email");
        errorMsg = document.getElementById("invalidMail");

        // For Password Field
        password = document.getElementById("password").value;
        password2 = document.getElementById("password2").value;
        email = document.getElementById("email").value;
        field = document.getElementById("password");
        field2 = document.getElementById("password2");
        error = document.getElementById("pass");
        error2 = document.getElementById("pass2");
        valid = true;

        // Checking Username
        var unameRegex = /^[a-zA-Z0-9]{4,10}$/;
        if (username.match(unameRegex)){
            userErrorField.classList.remove("err");
            userErrorMsg.innerHTML = ""
            valid = true;
        }
        else{
            userErrorField.classList.add("err");
            userErrorMsg.innerHTML = "Username should not contain any special characters.";
            return false;
        }

        // Checking Email
        var mailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if (email.match(mailRegex)){
            errorField.classList.remove("err");
            errorMsg.innerHTML = "";
            valid = true;
        }
        else{
            errorField.classList.add("err");
            errorMsg.innerHTML = "Enter a valid email!";
            return false;
        }

        // Checking length and minimum requirements
        var passRegex = /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,12}$/;
        if(password.match(passRegex)){
            field.classList.remove("err");
            error.innerHTML = ""
            valid = true;
        }
        else{
            field.classList.add("err");
            error.innerHTML = "Password must contain at least one digit and a special character.";
            return false;
        }

        if (password != password2){
            valid = false;
            field.classList.add("err");
            field2.classList.add("err");
            error.innerHTML = "Passwords do not match.";
            error2.innerHTML = "Passwords do not match.";
        }
        else{
            field.classList.remove("err");
            field2.classList.remove("err");
            error.innerHTML = ""
            error2.innerHTML = ""
            valid = true;
        }

        return valid;

    }