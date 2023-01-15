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
<title>Add User</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
<script src="${pageContext.request.contextPath}/resources/js/validationscript.js"></script>
</head>
<body>
<div class="signup-form">
    <form:form onsubmit="return validateRegForm()" modelAttribute="UDTO" method="post" enctype="multipart/form-data">
        <h2 class="text-center">Add User</h2>
        <img src="/resources/images/default.jpg" name="imgName" class="image-round-centered" id="profile" ><br>
        
            <div class="form-group">
                <label for="myfile">Upload Image:</label>
                <input type="file" name="image" class="form-control-file" accept="image/*" id="uploadImg"/>
            </div>
        
        <spring:bind path="username">
            <div class="form-group">
                <form:input type="text" path="username" id="username" class="form-control ${fieldUsername}" placeholder="Username" required="required"
                    minlength="4" maxlength="10" autofocus="true"/>
            </div>
                <div id="invalidUser" class="emsg form-group">${errUsername}</div>
        </spring:bind>
        
        <spring:bind path="email">
            <div class="form-group">
                <form:input type="email" id="email" path="email" class="form-control ${fieldEmail}" placeholder="Email" required="required" autofocus="true"/>
            </div>
            <div id="invalidMail" class="emsg form-group">${errEmail}</div>
        </spring:bind>    
        
        <spring:bind path="password">
            <div class="form-group">
                <form:input type="password" id="password" path="password" class="form-control" placeholder="Password" required="required"
                minlength="6" maxlength="12"/>
            </div>
            <div id="pass" class="emsg form-group"></div> 
            <div class="form-group">
                <input type="password" name="password2" id="password2" class="form-control" placeholder="Re-Enter Password" required="required"
                minlength="6" maxlength="12"/>
            </div>
            <div id="pass2" class="emsg form-group"></div> 
            
        </spring:bind>
        <div class="form-group ${classes}">
            ${saved}
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">Add</button>
        </div>  
    </form:form>
    <p class="text-center">Already have an account?<a href="/login"> Sign-in.</a></p>
</div>
<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>                  