<%-- 
    Document   : profile
    Created on : Jul 4, 2023, 1:36:01 AM
    Author     : lvhn1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${acc_info}" var="a"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${a.displayName}</title>
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/profile.css"/>
        <script src="https://kit.fontawesome.com/dd95d7c139.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="content">
            <div class="profileHeader">
                <div class="profileHeader_info">
                    <div class="profile_avatar">
                        <img src="${a.avatarURL eq null ? 'images/defaultAvatar.jpg' : a.avatarURL}" alt="avatar" onclick="showAvatar('visible')"/>
                    </div>

                    <div class="profile_info">
                        <h2 class="displayName">${a.displayName} ${a.isAuthen ? '<i class="fa-solid fa-circle-check" style="color: #6ac5fe">' : ''} </i></h2> 
                        <h3 class="addtional">${a.fname} ${a.lname}</h3>
                        <h3 class="addtional">${a.city} ${a.country}</h3>
                    </div>
                </div>
                <div class="profileBackground" style="background-image: url(${a.wallpaperURL eq null ? 'images/defaultWallpaper.jpg' : a.wallpaperURL})"></div>
            </div>

            <form name="followForm" action="follow" hidden>
                <input type="text" name="user" value="${sessionScope.acc.username}"/>
                <input type="text" name="flwing" value="${a.username}"/>
            </form>

            <form name="unfollowForm" action="follow" method="post" hidden>
                <input type="text" name="user" value="${sessionScope.acc.username}"/>
                <input type="text" name="flwing" value="${a.username}"/>
            </form>

            <div class="btnGroup">
                <c:if test="${!isFollowing}">
                    <button class="Btn follow" onclick="followForm.submit()" ${sessionScope.acc eq null or sessionScope.acc.username eq a.username ? 'hidden' : ''}><i class="fa-solid fa-user-plus"></i> Follow</button>
                </c:if>
                <c:if test="${isFollowing}">
                    <button class="Btn unfollow" onclick="unfollowForm.submit()"><i class="fa-solid fa-user-check"></i> Following</button>
                </c:if>
                <button class="Btn share"><i class="fa-regular fa-share-from-square"></i> Share</button>
                <button class="Btn stats" onclick="location.href='stats'" ${sessionScope.acc.username eq a.username ? '' : 'hidden'}><i class="fa-solid fa-chart-line"></i> Statistics</button>
                <button class="Btn edit" onclick="editProfile('visible')" ${sessionScope.acc.username eq a.username ? '' : 'hidden'}><i class="fa-solid fa-user-pen"></i> Edit profile</button>
            </div>

            <div class="prf-all">
                <div class="prf-main">
                    <div class="spotlight">
                        <h2 class="main-title">Spotlight</h2>
                        <ul class="spotlight-container">
                            <c:forEach items="${spotlight}" var="t">
                                <li class="track-object">
                                    <div class="track-display">
                                        <img class="track-cover" src="${t.coverURL}" alt="cover"/>
                                        <button class="playBtn" onclick="playMusic('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-solid fa-play"></i></button>
                                        <div class="track-info">
                                            <h3 class="track-title">${t.title}</h3>
                                            <p class="artist">
                                                <c:forEach items="${t.artist}" var="ar" varStatus="loop">
                                                    <a href="profile?id=${ar.username}">${ar.displayName}</a>${!loop.last ? ', ' : ''}
                                                </c:forEach>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="rightBtnGr">
                                        <button class="rightbtn editT" onclick="location.href='edit?id=${t.id}'" ${sessionScope.acc.username != a.username ? 'hidden' : ''}><i class="fa-solid fa-pen-to-square"></i></button>
                                        <button class="rightbtn" onclick="addToQueue('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-regular fa-square-plus"></i></button>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="recent">
                        <h2 class="main-title">Recently played</h2>
                        <ul class="spotlight-container">
                            <c:forEach items="${recent}" var="t">
                                <li class="track-object">
                                    <div class="track-display">
                                        <img class="track-cover" src="${t.coverURL}" alt="cover"/>
                                        <button class="playBtn" onclick="playMusic('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-solid fa-play"></i></button>
                                        <div class="track-info">
                                            <h3 class="track-title">${t.title}</h3>
                                            <p class="artist">
                                                <c:forEach items="${t.artist}" var="ar" varStatus="loop">
                                                    <a href="profile?id=${ar.username}">${ar.displayName}</a>${!loop.last ? ', ' : ''}
                                                </c:forEach>
                                            </p>
                                        </div>
                                    </div>
                                    <button class="rightbtn" onclick="addToQueue('${t.id}', '${t.title}', '${t.artistsToString()}', '${t.trackURL}', '${t.coverURL}')"><i class="fa-regular fa-square-plus"></i></button>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="prf-right">
                    <div class="infoStats">
                        <table class="statsTable">
                            <tr>
                                <td class="statElement">
                                    <h5 class="statTitle">Followers</h5>
                                    <div class="statValue">${count[0]}</div>
                                </td>
                                <td class="statElement">
                                    <h5 class="statTitle">Following</h5>
                                    <div class="statValue">${count[1]}</div>
                                </td>
                                <td class="statElement">
                                    <h5 class="statTitle">Tracks</h5>
                                    <div class="statValue">${count[2]}</div>
                                </td>
                            </tr>
                        </table>
                        <div class="prfBio">
                            <h3>Bio</h3>
                            <div class="truncatedBio">
                                <p>${a.bio}</p>
                            </div>
                            <a class="truncateBtn" onclick="showBio(this)">Show more</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <div class="overlay showAva" onclick="showAvatar('hidden')">
            <div class="boxPanel showAva_box">
                <img src="${a.avatarURL eq null ? 'images/defaultAvatar.jpg' : a.avatarURL}" alt="avatar"/>
                <div class="closeBtn" onclick="showAvatar('hidden')"><i class="fa-solid fa-xmark"></i></i></div>
            </div>
        </div>

        <div class="overlay editPrf">
            <div class="boxPanel editPrf_box">
                <div class="editPrf_content">
                    <div class="editPrf_title">
                        <h2>Edit your Profile</h2>
                    </div>
                    <form class="editPrf_form" action="profile" method="post" enctype="multipart/form-data">
                        <div class="form-element">Your Avatar <input type="file" name="avatar" placeholder="avatar" accept=".jpg, .jpeg, .png" class="upload" onchange="uploadImg('avatar', this)"/></div>
                        <img id="avatar" src="${a.avatarURL eq null ? 'images/defaultAvatar.jpg' : a.avatarURL}" alt="avatar"/>

                        <div class="form-element">Your Wallpaper <input type="file" name="wallpaper" placeholder="wallpaper" accept=".jpg, .jpeg, .png" class="upload" onchange="uploadImg('wallpaper', this)"/></div>
                        <img id="wallpaper" src="${a.wallpaperURL eq null ? 'images/defaultWallpaper.jpg' : a.wallpaperURL}" alt="wallpaper"/>

                        <div class="form-element">Your basic profile</div>
                        <div id="input" style="width: 80%">
                            Display Name<br/> <input type="text" name="displayName" placeholder="Display Name" value="${a.fname eq null ? '' : a.displayName}" class="inputBox"/>
                        </div>
                        <div class="form-element">
                            <div id="input">First name<br/> <input type="text" name="fName" placeholder="First name" value="${a.fname eq null ? '' : a.fname}" class="inputBox"/></div>
                            <div id="input">Last name <br/> <input type="text" name="lName" placeholder="Last name" value="${a.lname eq null ? '' : a.lname}" class="inputBox"/></div>
                        </div>
                        <div class="form-element">
                            <div id="input">City<br/> <input type="text" name="city" placeholder="City" value="${a.city eq null ? '' : a.city}" class="inputBox"/></div>
                            <div id="input">Country <br/> <input type="text" name="country" placeholder="Country" value="${a.country eq null ? '' : a.country}" class="inputBox"/></div>
                        </div>
                        <div id="input" style="width: 80%">
                            Email<br/> <input type="text" placeholder="${a.email}" disabled class="inputBox"/>
                        </div>
                        <div id="input" style="width: 100%">
                            Bio <br/>
                            <textarea name="bio" placeholder="Tell the world a little bit about yourself..." class="inputBox forBio">${a.bio}</textarea>
                        </div>

                        <div class="btnInForm">
                            <button class="Btn cancel" type="button" onclick="editProfile('hidden')">Cancel</button>
                            <button class="Btn save">Save</button>
                        </div>
                    </form>
                </div>

                <div class="closeBtn" onclick="editProfile('hidden')"><i class="fa-solid fa-xmark"></i></i></div>
            </div>
        </div>

        <jsp:include page="player.jsp"/>

        <script>
            const editPrf = document.querySelector('.editPrf');

            const showAva = document.querySelector('.showAva');

            function editProfile(status) {
                editPrf.style.visibility = status;
            }
            
            var bioPn = document.querySelector('.truncatedBio');
            if (bioPn.clientHeight < 85) {
                document.querySelector('.truncateBtn').style.visibility = 'hidden';
            }
            
            function showBio(btn) {
                let bioPn = document.querySelector('.truncatedBio');
                if (bioPn.style.maxHeight == '85px') {
                    bioPn.style.maxHeight = 'none';
                    btn.innerText = "Show Less";
                }
                else {
                    bioPn.style.maxHeight = '85px';
                    btn.innerText = "Show More";
                }
            }

            function showAvatar(status) {
                showAva.style.visibility = status;
                if (status == 'visible')
                    document.querySelector('body').style.overflow = 'hidden';
                else
                    document.querySelector('body').style.overflow = 'auto';
            }

            function uploadImg(imgID, inp) {
                let img = document.getElementById(imgID);

                if (inp.files[0]) {
                    var reader = new FileReader();

                    reader.readAsDataURL(inp.files[0]);

                    reader.onloadend = function () {
                        img.src = reader.result;
                    }
                }
            }
            
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
        </script>
    </body>
</html>
