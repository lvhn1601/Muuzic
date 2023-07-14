<%-- 
    Document   : discover
    Created on : Jul 6, 2023, 12:39:19 AM
    Author     : lvhn1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/home.css"/>
        <link rel="stylesheet" href="css/discover.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="main">
            <div class="banner">
                <img class="background" src="images/saidthesky_ziro_2019_28.jpg" alt="background"/>
                <div class="banner-back">
                    <div class="banner-content">
                        <h2>Connect to Muuzic</h2>
                        <div>
                            Discover, stream, and share a constantly expanding mix of music.
                        </div>
                        <button class="signupBtn" onclick="location.href = 'register'">Sign up for free</button>
                    </div>
                </div>
            </div>

            <section class="tracklist"> 
                <h2 class="list-category">Top Stream:</h2>
                <button class="pre-btn"><i class="fa-solid fa-chevron-right"></i></button>
                <button class="nxt-btn"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="track-container">
                    <c:forEach items="${listTop}" var="t">
                        <div class="track-card">
                            <div class="track-cover">
                                <img src="${t.coverURL}" class="cover-img" alt="">
                                <button class="play-btn" onclick="playMusic('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"> <i class="fa-solid fa-play"></i></button>
                                <button class="add-btn" onclick="addToQueue('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-regular fa-square-plus"></i></button>
                            </div>
                            <div class="track-info">
                                <h2 class="track-title">${t.title}</h2>
                                <p class="artist"> 
                                    <c:forEach items="${t.artist}" var="ar" varStatus="al">
                                        <a href="profile?id=${ar.username}">${ar.displayName}</a>${!al.last ? ', ' : ''}
                                    </c:forEach>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <section class="tracklist"> 
                <h2 class="list-category">Top Artist:</h2>
                <button class="pre-btn"><i class="fa-solid fa-chevron-right"></i></button>
                <button class="nxt-btn"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="track-container">
                    <c:forEach items="${listAcc}" var="a">
                        <div class="artist-card" onclick="location.href = 'profile?id=${a.username}'">
                            <div class="track-cover">
                                <img src="${a.avatarURL eq null ? 'images/defaultAvatar.jpg' : a.avatarURL}" class="artist-img" alt="">
                            </div>
                            <div class="track-info">
                                <h2 class="artist-name">${a.displayName}</h2>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </div>
        
        <jsp:include page="player.jsp"/>

        <script>
            const productContainers = [...document.querySelectorAll('.track-container')];
            const nxtBtn = [...document.querySelectorAll('.nxt-btn')];
            const preBtn = [...document.querySelectorAll('.pre-btn')];

            productContainers.forEach((item, i) => {
                let containerDimensions = item.getBoundingClientRect();
                let containerWidth = containerDimensions.width;

                nxtBtn[i].addEventListener('click', () => {
                    item.scrollLeft += containerWidth;
                });

                preBtn[i].addEventListener('click', () => {
                    item.scrollLeft -= containerWidth;
                });
            });
            
            function playMusic(id, title, artist, trackURL, coverURL) {
                var cnf = true;
                let aplist = document.querySelector('.aplayer-list');
                if (aplist !== null && aplist.firstElementChild.childElementCount > 1)
                    cnf = confirm("Delete all queue and play new?");
                
                if (cnf) {
                    ap.list.clear();
                    ap.list.add([{
                            id: id,
                            name: title,
                            artist: artist,
                            url: trackURL,
                            cover: coverURL
                        }]);

                    $("#aplayer").removeClass('hidePlayer');
                    ap.play();
                    if ('${sessionScope.acc.username}' != '') {
                        let cval = id;
                        setExCookie('${sessionScope.acc.username}', cval, 30);
                    }
                }
            }

            function addToQueue(id, title, artist, trackURL, coverURL) {
                ap.list.add([{
                        id: id,
                        name: title,
                        artist: artist,
                        url: trackURL,
                        cover: coverURL
                    }]);
                ap.notice('Added ' + title);
                if ('${sessionScope.acc.username}' != '') {
                    let cval = getCookie('${sessionScope.acc.username}') + '/' + id;
                    setExCookie('${sessionScope.acc.username}', cval, 30);
                }
            }
        </script>
    </body>
</html>
