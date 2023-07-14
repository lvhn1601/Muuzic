<%-- 
    Document   : upload
    Created on : Jul 6, 2023, 2:12:37 AM
    Author     : lvhn1
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/upload.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="main">
            <div class="login-container">
                <h1>Bring your music to the world</h1>
                <form class="editPrf_form" action="upload" method="post" enctype="multipart/form-data" hidden>
                    <div class="form-element">
                        <div id="input_field">
                            Upload your music
                            <label for="music" class="drop-container" id="dropcontainer">
                                <span class="drop-title">Drop files here</span>
                                or
                                <input type="file" name="music" placeholder="music" accept=".mp3" class="upload" id="music" required/>
                            </label>
                        </div>
                        <div id="input_field">
                            <input type="file" name="cover" placeholder="cover" accept=".jpg, .jpeg, .png" class="upload" onchange="uploadImg('cover', this, 'coverURL')"/>
                            Or <br/>
                            <input type="text" name="coverURL" placeholder="Cover URL" class="inputBox" id="coverURL" onfocusout="changeImg('cover', this)"/>
                            <img id="cover" src="images/defaultCover.png" alt="Cover image"/>
                        </div>
                    </div>

                    <div class="form-element">Track information</div>
                    
                    <div class="form-element">
                        <div id="input_field" style="width: 100%">
                            Track title<br/> 
                            <input type="text" name="title" placeholder="Title" class="inputBox" required/>
                        </div>
                    </div>
                    
                    <div class="form-element">
                        <div id="input_field" style="width: 30%">
                            Genre<br/> 
                            <select name="genre" class="inputBox" required>
                                <option value="0">-Choose Genre-</option>
                                <c:forEach items="${genres}" var="gen">
                                    <option value="${gen.id}">${gen.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div id="input_field" style="width: 60%">
                            Feature Artist <br/> 
                            <input type="text" name="listArtist" placeholder="Feature Artists" value="${a.country eq null ? '' : a.country}" class="inputBox"/>
                        </div>
                    </div>
                        
                    <div id="input_field" style="width: 100%">
                        Bio <br/>
                        <textarea name="detail" placeholder="Tell something about your track..." class="inputBox forBio"></textarea>
                    </div>

                    <div class="btnInForm">
                        <button class="Btn cancel" type="button" onclick="location.href = './home'">Cancel</button>
                        <button class="Btn save">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function uploadImg(imgID, inp, inpboxID) {
                let img = document.getElementById(imgID);

                if (inp.files[0]) {
                    document.getElementById(inpboxID).disabled = true;
                    var reader = new FileReader();

                    reader.readAsDataURL(inp.files[0]);

                    reader.onloadend = function () {
                        img.src = reader.result;
                    }
                }
                else {
                    document.getElementById(inpboxID).disabled = false;
                }
            }
            
            function changeImg(imgID, urlBox) {
                let img = document.getElementById(imgID);
                
                img.src = urlBox.value;
            }
        </script>
    </body>
</html>
