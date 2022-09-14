<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/14/2022
  Time: 9:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create</title>
</head>
<body>
<h1>Add new product</h1>
<c:if test="${error != null}">
    <h2 style="color: red">${error}</h2>
</c:if>

<a href="/customer">Return List</a>
<form action="/customer" method="post">
    <table border="1">
        <tr>
            <td>ID</td>
            <td><input type="text" name="id" /></td>
        </tr>
        <tr>
            <td>Name</td>
            <td><input type="text" name="name" /></td>
        </tr>
        <tr>
            <td>Email</td>
            <td><input type="email" name="email" /></td>
        </tr>
        <tr>
            <td>Address</td>
            <td><input type="text" name="address" /></td>
        </tr>
        <tr>
            <td>
                <input type="reset" value="Reset" />
            </td>
            <td>
                <input type="submit" value="Submit" />
            </td>
        </tr>
    </table>
    <input type="hidden" name="action" value="create" />
</form>
</body>
</html>
