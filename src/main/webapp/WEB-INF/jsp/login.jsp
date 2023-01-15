<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="header.html" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login Form</title>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/validationscript.js"></script>
</head>
<body>

<div class="login-form" >
    <form:form modelAttribute="loginDTO" method="post" onsubmit="return validateLoginForm()">

        <h2 class="text-center">Log in</h2>    
        <spring:bind path="email">
            <div class="form-group">
                <input type="email" path="email" id="email" name="email" class="form-control" placeholder="Email" required="required" autofocus="true">
            </div>
        </spring:bind>   
        <div id="invalidMail" class="emsg form-group">${errEmail}</div>

        <spring:bind path="password">
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="Password" required="required" autofocus="true">
            </div>
        </spring:bind>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">Log in</button>
        </div>
            <div class="${errClasses}">
                ${errMsg}
            </div>
      
      
    </form:form>
    <p class="text-center"><a href="register">Create an Account?</a></p>
</div>

</body>
</html>                  