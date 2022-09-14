<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/13/2022
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Address</th>
    </tr>
    <tr>
        <td>${customer.getId()}</td>
        <td>${customer.getName()}</td>
        <td>${customer.getEmail()}</td>
        <td>${customer.getAddress()}</td>
    </tr>
</table>
</body>
</html>
