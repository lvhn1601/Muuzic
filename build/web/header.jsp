<%-- 
    Document   : header
    Created on : Jul 5, 2023, 11:12:29 PM
    Author     : lvhn1
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${main_info}" var="m"/>
<script src="https://kit.fontawesome.com/dd95d7c139.js" crossorigin="anonymous"></script>
<header id="myHeader">
    <style>

        li {
            list-style: none;
        }

        a {
            text-decoration: none;
            color: white;
            font-size: 1rem;
        }
        a:hover {
            color: #6ac5fe;
        }

        header {
            z-index: 2;
            background-color: #212121;
            position: relative;
            width: 100%;
            padding: 0;
        }

        .navbar {
            background-color: #212121;
            width: 100%;
            height: 75px;
            max-width: 1300px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar .toggle_btn {
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            display: none;
        }

        .logo {
            height: 80%;
            width: 33%;
        }

        .logo a {
            height: 100%;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            color: #6ac5fe;
        }

        .logo img {
            height: 80%;
        }

        .navbar .links {
            width: 33%;
            display: flex;
            gap: 2rem;
        }

        .navbar .profile {
            height: 60px;
            width: 33%;
            display: flex;
            align-items: center;
            justify-content: end;
            cursor: pointer;
            position: relative;
        }

        .navbar .profile img {
            height: 40px;
            width: 40px;
            object-fit: cover;
            border-radius: 50%;
        }
        .navbar .profile .fa-caret-down {
            color: white;
            margin-left: 5px;
        }

        .navbar .rLinks {
            width: 33%;
            display: flex;
            justify-content: end;
            gap: 1rem;
            align-items: center;
        }

        .navbar .rLinks #login {
            border: white solid 1px;
            border-radius: 5px;
            padding: 5px 10px;
        }

        .navbar .rLinks #register {
            background-color: #6ac5fe;
            border-radius: 5px;
            padding: 5px 10px;
        }

        .navbar .rLinks #register:hover {
            background-color: #303030;
        }

        /* DROPDOWN PROFILE*/
        .dropdown_profile {
            position: absolute;
            right: 0px;
            top: 70px;
            height: 0;
            width: 150px;
            z-index: 10;
            background-color: rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: height .2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .dropdown_profile.open {
            height: auto;
        }

        .dropdown_profile li {
            padding: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .dropdown_profile li a {
            color: white;
        }

        .dropdown_profile li a:hover {
            color: #6ac5fe;
        }

        .sticky {
            position: fixed;
            top: 0;
            width: 100%
        }

        .sticky + .content {
            padding-top: 102px;
        }
    </style>

    <div class="navbar">
        <ul class="links">
            <li><a href="home">Home</a></li>
            <li><a href="search">Search</a></li>
        </ul>

        <div class="logo"> <a href="home"><img src="images/Logo.png" alt="Logo"/> Muuzic </a></div>

        <c:if test="${sessionScope.acc != null}">
            <div class="profile" onclick="dropDown('.dropdown_profile')">
                <img src="${m.avatarURL eq null ? 'images/defaultAvatar.jpg' : m.avatarURL}" alt="profile"/>
                <i class="fa-solid fa-caret-down"></i>

                <ul class="dropdown_profile">
                    <li><a href="profile?id=${sessionScope.acc.username}"><i class="fa-regular fa-circle-user"></i> Profile</a></li>
                    <li><a href="upload"><i class="fa-solid fa-arrow-up-from-bracket"></i> Upload</a></li>
                    <li><a href="#"><i class="fa-solid fa-sliders"></i> Setting</a></li>
                    <li><a href="logout.jsp"><i class="fa-solid fa-arrow-right-from-bracket"></i> Sign out</a></li>
                </ul>
            </div>
        </c:if>

        <c:if test="${sessionScope.acc eq null}">
            <ul class="rLinks">
                <li id="login"><a href="login">Sign in</a></li>
                <li id="register"><a href="register">Create Account</a></li>
            </ul>
        </c:if>
    </div>
</header>

<script>
    var header = document.getElementById("myHeader");

    window.onscroll = function () {
        if (window.pageYOffset > header.offsetTop) {
            header.classList.add("sticky");
        } else {
            header.classList.remove("sticky");
        }
    }

    function dropDown(panel) {
        document.querySelector(panel).classList.toggle('open');
    }
</script>