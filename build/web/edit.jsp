<%-- 
    Document   : edit
    Created on : Jul 12, 2023, 3:23:38 AM
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
                <form class="editPrf_form" action="edit" method="post" enctype="multipart/form-data">
                    <input type="text" name="trackid" value="${track.id}" hidden/>
                    
                    <div class="form-element">
                        <div id="input_field">
                            <input type="file" name="cover" placeholder="cover" accept=".jpg, .jpeg, .png" class="upload" onchange="uploadImg('cover', this, 'coverURL')"/>
                            Or <br/>
                            <input type="text" name="coverURL" placeholder="Cover URL" class="inputBox" id="coverURL" onfocusout="changeImg('cover', this)"/>
                            <img id="cover" src="${track.coverURL}" alt="Cover image"/>
                        </div>
                    </div>

                    <div class="form-element">Track information</div>
                    
                    <div class="form-element">
                        <div id="input_field" style="width: 100%">
                            Track title<br/> 
                            <input type="text" name="title" value="${track.title}" placeholder="Title" class="inputBox" required/>
                        </div>
                    </div>
                    
                    <div class="form-element">
                        <div id="input_field" style="width: 30%">
                            Genre<br/> 
                            <select name="genre" class="inputBox" required>
                                <option value="">-Choose Genre-</option>
                                <c:forEach items="${genres}" var="gen">
                                    <option value="${gen.id}" ${gen.name eq track.genre ? 'selected' : ''}>${gen.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div id="input_field" style="width: 60%">
                            Feature Artist <br/> 
                            <input type="text" name="listArtist" placeholder="Feature Artists" value="${fArtist}" class="inputBox"/>
                        </div>
                    </div>
                        
                    <div id="input_field" style="width: 100%">
                        Bio <br/>
                        <textarea name="detail" placeholder="Tell something about your track..." class="inputBox forBio"></textarea>
                    </div>

                    <div class="btnInForm">
                        <button class="Btn cancel" type="button" onclick="location.href = './home'">Cancel</button>
                        <button class="Btn delete" type="button" onclick="pressDel('${track.id}')">Delete</button>
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
            
            function pressDel(id) {
                var cnf = confirm("Do you sure you want to delete this track?");
                if (cnf) {
                    location.href = 'delete?id=' + id;
                }
            }
        </script>
    </body>
</html>
