<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/9/2022
  Time: 8:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
  <title>Simple Dictionary</title>
</head>
<body>
<h2>Vietnamese Dictionary</h2>
<form action="/translate" method="post">
  <input type="text" name="txtSearch" placeholder="Enter your word: "/>
  <input type = "submit" id = "submit" value = "Search"/>
</form>

<%
  String result = (String) request.getAttribute("result");
  if (result == "") { %>
<b style="color: red">${error}</b>
<%} else {%>
<b> Word ${txtSearch} is ${result}</b>
<% } %>

</body>
</html>
