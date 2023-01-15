<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User List</title>

<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
<!-- jquery for tooltip -->
<script>
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
});
</script>
</head>
<body>
<div class="container">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-xs-5">
                        <h2>User <b>List</b></h2><h2 class="text-center"> ${disabled}</h2>
                    </div>
                    <div class="col-xs-7">
                        <a href="/register" class="btn btn-primary"><i class="material-icons">&#xE147;</i> <span>Add New User</span></a>
                        <a href="http://localhost:8080/api/users/export/pdf" class="btn btn-primary"><i class="material-icons">&#xE415;</i> <span>Export to PDF</span></a>
                        <a href="http://localhost:8080/api/users/export/excel" class="btn btn-primary"><i class="material-icons">&#xE24D;</i> <span>Export to Excel</span></a>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Username</th>						
                        <th>Email</th>
                        <th>Role</th>
                        <th>Enabled</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td><c:out value="${user.id}"/></td>
                            <td><img src="http://localhost:8080/resources/images/${user.photo}" class="avatar" alt="Avatar"> ${user.username}</a></td>
                            <td><c:out value="${user.email}"/></td>                       
                            <td><c:out value="${user.role}"/></td>
                            <td>${user.status}</td>
                            <td>
                                <a href="userlist/edituser/${user.id}" class="edit" title="Edit" data-toggle="tooltip" onclick="return confirm('Edit?')">
                                    <i class="material-icons">&#xE3C9;</i></a>
                               <a href="userlist/activate/${user.id}" class="activate" title="Activate" data-toggle="tooltip" onclick="return confirm('Activate?')">
                                <i class="material-icons">&#xE86C;</i></a>
                               <a href="userlist/delete/${user.id}" class="delete" title="Disable" data-toggle="tooltip" onclick="return confirm('Disable?')">
                                <i class="material-icons">&#xE5C9;</i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>        
</div>     
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>