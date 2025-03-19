<%-- 
    Document   : login.jsp
    Created on : Feb 28, 2025, 11:54:25 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            .form-container {
                width: 50%;
                margin: auto;
                margin-top: 50px;
                padding: 20px;
                border: 2px solid #ccc;
                border-radius: 10px;
                background-color: #f9f9f9;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <form action="BookingHome" method="post">
                <div class="mb-3">
                    <input type="hidden" class="form-control" id="Type" name="type" value="login" readonly="">
                    <label for="username" class="form-label">UserName: </label>
                    <input type="text" class="form-control" id="username" name="username" >
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password: </label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>         
                <input type="checkbox" name="savePass" value="true" ${cookie.save.value}/>Save Password
                <button type="submit" class="btn btn-primary">Submit</button>
                <a href="index.jsp" class='btn btn-primary'> Cancel</a> 
            </form>
        </div>
    </body>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</html>
