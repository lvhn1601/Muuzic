<%-- 
    Document   : search
    Created on : Jul 11, 2023, 3:55:44 PM
    Author     : lvhn1
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/search.css"/>
        <title>Search</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="main">
            <form action="search" method="post" class="searchForm" autocomplete="off">
                <div class="searchBox">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" name="search" placeholder="What're you looking for?"/>
                </div>
                
                <div class="extendSearch">
                    <a onclick="btnExtend()">Extend <i class="fa-solid fa-caret-down"></i></a>
                    <div class="selectGrp">
                        <select name="eGenre">
                            <option value="-1">All</option>
                            <c:forEach items="${listGen}" var="gen">
                                <option value="${gen.id}">${gen.name}</option>
                            </c:forEach>
                        </select>

                        <select name="eOrder">
                            <option value="title">Title</option>
                            <option value="COUNT(id)">Stream number</option>
                        </select>

                        <select name="eArr">
                            <option value="ASC">Ascending</option>
                            <option value="DESC">Descending</option>
                        </select>
                    </div>
                </div>
            </form>

            <div class="searchResult">
                <div class="searchList">
                    <div class="err">
                        <h2 ${searchArtist[0] eq null and searchTrack[0] eq null and !(searchText eq null) ? '' : 'hidden'}>Can not found any result for "${searchText}".</h2>
                    </div>
                    <h2 ${searchArtist[0] eq null ? 'hidden' : ''}>People</h2>
                    <div class="listContain">
                        <c:forEach items="${searchArtist}" var="a">
                            <div class="accountBox" onclick="location.href='profile?id=${a.username}'">
                                <img src="${a.avatarURL eq null ? 'images/defaultAvatar.jpg' : a.avatarURL}" alt="avatar">
                                <h3 class="accName">${a.displayName}</h3>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="searchList">
                    <h2 ${searchTrack[0] eq null ? 'hidden' : ''}>Track</h2>
                    <ul class="trackList-container">
                        <c:forEach items="${searchTrack}" var="t">
                            <li class="track-object">
                                <div class="track-display">
                                    <img class="track-cover" src="${t.coverURL}" alt="cover" />
                                    <button class="playBtn" onclick="playMusic('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-solid fa-play"></i></button>
                                    <h3 class="track-title">${t.title}</h3>
                                </div>
                                <p class="artist">
                                    <c:forEach items="${t.artist}" var="ar" varStatus="loop">
                                        <a href="profile?id=${ar.username}">${ar.displayName}</a>${!loop.last ? ', ' : ''}
                                    </c:forEach>
                                </p>
                                <button class="addList" onclick="addToQueue('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-regular fa-square-plus"></i></button>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
                    
        <jsp:include page="player.jsp"/>
        
        <script>
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
            
            function btnExtend() {
                let sGrp = document.querySelector(".selectGrp");
                if (sGrp.style.visibility == 'hidden')
                    sGrp.style.visibility = 'visible';
                else
                    sGrp.style.visibility = 'hidden';
            }
        </script>
    </body>
</html>
