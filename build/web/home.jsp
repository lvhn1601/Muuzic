<%-- 
    Document   : home
    Created on : Jun 30, 2023, 9:40:15 PM
    Author     : lvhn1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/home.css"/>
        <script src="https://kit.fontawesome.com/dd95d7c139.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <c:set value="${main_info}" var="m"/>
        <jsp:include page="header.jsp" />

        <div class="main">
            <jsp:include page="banner.jsp" />

            <section class="tracklist" ${listNewest[0] eq null ? 'hidden' : ''}> 
                <h2 class="list-category">Following:</h2>
                <button class="pre-btn"><i class="fa-solid fa-chevron-right"></i></button>
                <button class="nxt-btn"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="track-container">
                    <c:forEach items="${listNewest}" var="t">
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

            <section class="tracklist" ${listRecently[0] eq null ? 'hidden' : ''}> 
                <h2 class="list-category">Recently play:</h2>
                <button class="pre-btn"><i class="fa-solid fa-chevron-right"></i></button>
                <button class="nxt-btn"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="track-container">
                    <c:forEach items="${listRecently}" var="t">
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
                <h2 class="list-category">People You May Know:</h2>
                <button class="pre-btn"><i class="fa-solid fa-chevron-right"></i></button>
                <button class="nxt-btn"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="track-container">
                    <c:forEach items="${listAcc}" var="a">
                        <div class="artist-card" onclick="location.href='profile?id=${a.username}'">
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
            
            <section class="tracklist"> 
                <h2 class="list-category">Top 10 ${recGenre}:</h2>
                <button class="pre-btn"><i class="fa-solid fa-chevron-right"></i></button>
                <button class="nxt-btn"><i class="fa-solid fa-chevron-right"></i></button>

                <div class="track-container">
                    <c:forEach items="${listTopGen}" var="t">
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
        </div>

        <jsp:include page="player.jsp" />

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
                    let cval = id;
                    setExCookie('${sessionScope.acc.username}', cval, 30);
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
                let cval = getCookie('${sessionScope.acc.username}') + '/' + id;
                setExCookie('${sessionScope.acc.username}', cval, 30);
            }

            function getCookie(cname) {
                let name = cname + "=";
                let decodedCookie = decodeURIComponent(document.cookie);
                let ca = decodedCookie.split(';');
                for (let i = 0; i < ca.length; i++) {
                    let c = ca[i];
                    while (c.charAt(0) == ' ') {
                        c = c.substring(1);
                    }
                    if (c.indexOf(name) == 0) {
                        return c.substring(name.length, c.length);
                    }
                }
                return "";
            }
            
            function setExCookie(cname, cvalue, exdays) {
                const d = new Date();
                d.setTime(d.getTime() + (exdays*24*60*60*1000));
                let expires = "expires="+ d.toUTCString();
                document.cookie = cname + "=" + cvalue + ";" + expires + ";";
            }
        </script>
    </body>
</html>
