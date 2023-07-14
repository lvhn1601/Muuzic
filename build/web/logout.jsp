<%-- 
    Document   : logout
    Created on : Jul 6, 2023, 2:21:52 AM
    Author     : lvhn1
--%>

<%
    session.invalidate();
    response.sendRedirect("./");
%>