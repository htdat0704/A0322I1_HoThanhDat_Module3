<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/15/2022
  Time: 4:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Product list</h1>
<form>
    <label>Search by Name: </label>
    <input type="text" name="txtSearch"/>
    <input name="action" type="hidden" value="findName"/>
    <input type="submit" value="Search"/>
</form>
<c:if test="${error != null}">
    <h2 style="color: red">${error}</h2>
</c:if>
<a href="/product?action=create">Add new product</a>
<table border="1">
    <tr>
        <th>No</th>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Description</th>
        <th>Producer</th>
        <th>Detail</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <c:forEach items="${productList}" varStatus="item">
        <tr>
            <td>${item.count }</td>
            <td>${item.current.id}</td>
            <td>${item.current.name}</td>
            <td>${item.current.price}</td>
            <td>${item.current.description}</td>
            <td>${item.current.producer}</td>
            <td><a href="/product?action=detail&id=${item.current.id}">Detail</a></td>
            <td><a href="/product?action=update&id=${item.current.id}">Update</a></td>
            <td><a href="/product?action=delete&id=${item.current.id}">Delete</a></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
