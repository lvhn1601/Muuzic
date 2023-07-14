<%-- 
    Document   : music
    Created on : Jul 7, 2023, 7:49:39 PM
    Author     : lvhn1
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aplayer/1.10.1/APlayer.min.css"/>
<style>
    #aplayer {
        position: fixed;
        z-index: 3;
        bottom: 0;
        left: 0;
        width: 100%;
        margin: 0;
        box-shadow: 0 -2px 2px #303030;
        transition: all ease 0.5s;
    }
    #aplayer.hidePlayer {
        bottom: -100%;
    }

    .aplayer {
        background-color: #303030;
    }
    span{
        color: white;
        font-size: 14px;
    }
    .aplayer-list li {
        background: #212121;
    }
    .aplayer-list-light {
        background: #303030 !important;
    }
    .aplayer .aplayer-info .aplayer-controller .aplayer-bar-wrap .aplayer-bar .aplayer-loaded{
        background: #e0e0e0;
        height: 4px;
    }
    .aplayer .aplayer-info .aplayer-controller .aplayer-bar-wrap .aplayer-bar .aplayer-played{
        height: 4px;
        background-color: #2196F3 !important;
    }
    .aplayer .aplayer-info .aplayer-controller .aplayer-bar-wrap .aplayer-bar .aplayer-played .aplayer-thumb{
        background-color: #2196F3 !important;
    }

    .aplayer .aplayer-icon{
        width: 20px;
        height: 20px;
    }
    .aplayer .aplayer-info .aplayer-controller .aplayer-time .aplayer-icon path {
        fill: white;
    }
    .aplayer .aplayer-info .aplayer-music{
        margin-bottom: 5px;
    }
</style>

<div id="aplayer"></div>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aplayer/1.10.1/APlayer.min.js"></script>
<script>
    const ap = new APlayer({
            container: document.getElementById('aplayer'),
            listFolded: true,
            theme: '#212121',
            audio: [
            <c:forEach items="${playedTrack}" var="t">
                {
                    id: '${t.id}',
                    name: '${t.title}',
                    artist: '${t.artistsToString()}',
                    url: '${t.trackURL}',
                    cover: '${t.coverURL}'
                }${!loop.last ? ',' : ''}
            </c:forEach>
            ]
    });
    
    //ap.list.switch(localStorage.getItem("player_index"));
    ap.list.switch(getCookie('played_index'));
    
    window.onload = function () {
        if (ap.list['audios'].length == 0)
            $("#aplayer").addClass('hidePlayer');
    };
    
    ap.on('play', function () {
        let index = document.querySelector('.aplayer-list-light .aplayer-list-index');
        if (index != null) {
            var str = getCookie('streamHistory');
            if (str.substring(str.lastIndexOf('?') + 1) != ap.list['audios'][index.innerHTML - 1]['id'])
                document.cookie = 'streamHistory=' + getCookie('streamHistory') + (getCookie('streamHistory') == '' ? '' : '/') + '${sessionScope.acc.username}?' + ap.list['audios'][index.innerHTML - 1]['id'];
        }
        document.cookie = "playStatus=playing";
    });
    
    ap.on('loadeddata', function () {
        ap.seek(getCookie('played_time'));
        //ap.seek(localStorage.getItem("player_time"));
        document.cookie = "played_time=; expires=Thu, 01 Jan 1970 00:00:00 UTC;"
        
    });
    
    window.onunload = function () {
        let index = document.querySelector('.aplayer-list-light .aplayer-list-index');
        if (index != null)
            document.cookie = "played_index=" + (index.innerHTML - 1);
            //localStorage.setItem("player_index", index.innerHTML - 1);
        //localStorage.setItem("player_time", ap.audio.currentTime);
        document.cookie = "played_time=" + ap.audio.currentTime;
    };

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
    
    function setExCookie(cname, exdays) {
        const d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        let expires = "expires="+ d.toUTCString();
        document.cookie = cname + "=" + getCookie(cname) + ";" + expires + ";path=/";
    }
</script>
