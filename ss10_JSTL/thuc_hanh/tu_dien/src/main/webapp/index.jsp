<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/12/2022
  Time: 7:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <%!
    String rong = "Not Found";
  %>
  <form action="/tudien" method="post">
    <input type="text" name="search" placeholder="Enter your word: "/>
    <input type = "submit" id = "submit" value = "Search"/>
  </form>
  <b>${result}</b>

  <c:if test="${result eq rong}">
    <b style="color:red">${error}</b>
  </c:if>
  </body>
</html>
