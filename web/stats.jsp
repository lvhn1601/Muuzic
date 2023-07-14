<%-- 
    Document   : stats
    Created on : Jul 12, 2023, 12:32:52 AM
    Author     : lvhn1
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/stats.css"/>
        
        <script type="text/javascript">
            window.onload = function () {

                var chart1 = new CanvasJS.Chart("streamChart", {
                    theme: "dark1",
                    title: {
                        text: "Stream numbers of ${recent} in 7 days"
                    },
                    axisY: {
                        title: "Stream numbers"
                    },
                    data: [{
                            type: "spline",
                            toolTipContent: "<b>{label}</b>: {y}",
                            dataPoints: ${streamPoints}
                        }]
                });
                chart1.render();
                
                var chart2 = new CanvasJS.Chart("fanChart", {
                    theme: "dark1",
                    title: {
                            text: "Top 5 listeners"
                    },
                    axisX: {
                            title: "Listener"
                    },
                    axisY: {
                            title: "Number of stream"
                    },
                    data: [{
                            type: "bar",
                            indexLabel: "{y}",
                            dataPoints: ${fanPoints}
                    }]
                });
                chart2.render();
                
                var chart3 = new CanvasJS.Chart("trackChart", {
                    theme: "dark1",
                    title: {
                            text: "Top Track Stream"
                    },
                    axisX: {
                            title: "Track Title"
                    },
                    axisY: {
                            title: "Numbers of stream",
                            includeZero: true
                    },
                    data: [{
                            type: "column",
                            dataPoints: ${trackPoints}
                        }]
                });
                chart3.render();
                
            }
        </script>
        
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="main">
            <form class="stats-form" action="stats" method="get">
                <select name="trackid" onchange="this.form.submit()">
                    <option value="0" ${recent eq 'all tracks' ? 'selected' : ''}>-All-</option>
                    <c:forEach items="${listTrack}" var="t">
                        <option value="${t.id}" ${t.title eq recent ? 'selected' : ''}>${t.title}</option>
                    </c:forEach>
                </select>
            </form>
            <div class="stats-main">
                <div class="stats-container">
                    <h2 class="stats-title">Stream Stats</h2>
                    <div class="chartContainer" id="streamChart"></div>
                </div>
                
                <div class="stats-container">
                    <h2 class="stats-title">Top 5 listeners</h2>
                    <div class="chartContainer" id="fanChart"></div>
                </div>
            </div>
            <div class="stats-container">
                <h2 class="stats-title">Track Streams</h2>
                <div class="chartContainer" id="trackChart"></div>
            </div>
        </div>
        <script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
    </body>
</html>
