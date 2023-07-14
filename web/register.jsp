<%-- 
    Document   : register
    Created on : Jul 3, 2023, 6:39:39 PM
    Author     : lvhn1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/login.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <header>
            <div class="navbar">
                <div class="logo"> <a href="./"><img src="images/Logo.png" alt="Logo"/> Muuzic </a></div>
            </div>
        </header>

        <div class="main">
            <div class="login-container">
                <h1>Sign up for free to start listening.</h1>
                <div id="login-error" ${err eq "error" ? '' : 'hidden'}>Username already exist, sign up failed.</div>
                <form class="login-form" action="register" method="post" onsubmit="return validateForm()">
                    Create a username <br/> 
                    <input type="text" name="un" placeholder="Enter username" class="box" onfocusout="checkInput('un')"/> 
                    <span class="error un">You need to create username.</span> <br/>
                    <br/>
                    
                    What's your email? <br/> 
                    <input type="text" name="em" placeholder="Enter your email" class="box" onfocusout="checkEmail()"/>
                    <span class="error em">Invalid email address.</span> <br/>
                    <br/>
                    
                    Create a password <br/> 
                    <input type="password" name="pw" placeholder="Enter a password" class="box" onfocusout="checkInput('pw')"/>
                    <span class="error pw">You need to enter password.</span> <br/>
                    <br/>
                    
                    Re-enter your password <br/> 
                    <input type="password" name="rpw" placeholder="Re-enter password" class="box" onfocusout="checkRePass()"/>
                    <span class="error rpw">Re-enter password incorrect.</span> <br/>
                    <br/>
                    
                    What should we call you? <br/> 
                    <input type="text" name="dn" placeholder="Enter your display name" class="box" onfocusout="checkInput('dn')"/>
                    <span class="error dn">Enter a name to display.</span> <br/>
                    <br/>
                    
                    What's your date of birth? <br/> 
                    <input type="date" name="dob" placeholder="Date of birth" class="box" onfocusout="checkInput('dob')"/>
                    <span class="error dob">Enter a valid date.</span> <br/>
                    <br/>
                    
                    What's your gender? <br/> 
                    <input type="radio" name="gd" value="Male" placeholder="Male" required/> <span id="val">Male</span> &nbsp;&nbsp; 
                    <input type="radio" name="gd" value="Female" placeholder="Female"/> <span id="val">Female</span> &nbsp;&nbsp; 
                    <input type="radio" name="gd" value="Other" placeholder="Other"/> <span id="val">Other</span> &nbsp;&nbsp;
                    <br/>
                    
                    <input type="submit" value="Sign up" class="btn"/> 
                </form>
                <div class="signup">Already have account? <a href="login">Log in</a></div>
            </div>
        </div>
        
        <script>
            function checkInput(messName) {
                let input = document.querySelector('input[name="'+messName+'"]').value;
                let mess = document.querySelector('.' + messName);
                
                
                if (input.trim() == "") {
                    mess.style.visibility = 'visible';
                    return false;
                }
                else {
                    mess.style.visibility = 'hidden';
                    return true;
                }
            }
            
            function checkEmail() {
                var mailFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                let mess = document.querySelector('.em');
                
                if (document.querySelector('input[name="em"]').value.match(mailFormat)) {
                    mess.style.visibility = 'hidden';
                    return true;
                }
                else {
                    mess.style.visibility = 'visible';
                    return false;
                }
            }
            
            function checkRePass() {
                let password = document.querySelector('input[name="pw"]').value;
                let repassword = document.querySelector('input[name="rpw"]').value;
                let mess = document.querySelector('.rpw');
                
                if (repassword == password) {
                    mess.style.visibility = 'hidden';
                    return true;
                }
                else {
                    mess.style.visibility = 'visible';
                    return false;
                }
            }
            
            function validateForm() {
                if (checkInput('un') & checkEmail() & checkInput('pw') & checkRePass() & checkInput('dn'))
                    return true;
                else
                    return false;
            }
        </script>
    </body>
</html>
