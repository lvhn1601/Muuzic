<%-- 
    Document   : login
    Created on : Jun 30, 2023, 9:41:54 PM
    Author     : lvhn1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/login.css"/>
        <style>
            body {
                overflow-y: hidden;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <header>
            <div class="navbar">
                <div class="logo"> <a href="./"><img src="images/Logo.png" alt="Logo"/> Muuzic </a></div>
            </div>
        </header>

        <div class="main" style="height: 100vh">
            <div class="login-container">
                <h1>Log in to Muuzic</h1>
                <div id="login-error" ${err eq "error" ? '' : 'hidden'}>Incorrect username or password.</div>
                <form class="login-form" action="login" method="post">
                    Username or Email <br/> <input type="text" name="un" placeholder="Username or Email" class="box"/> <br/>
                    Password <br/> <input type="password" name="pw" placeholder="Password" class="box"/> <br/>
                    <input type="checkbox" name="rm" placeholder="on"/> Remember me <br/>
                    <input type="submit" value="Log In" class="btn"/> 
                </form>
                <div class="signup">Don't have an account? <a href="register">Sign up for Muuzic</a></div>
            </div>
        </div>
    </body>
</html>
