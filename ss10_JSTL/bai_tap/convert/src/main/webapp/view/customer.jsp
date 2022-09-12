<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/12/2022
  Time: 7:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1 style="text-align: center">Danh sách khách hàng</h1>
<table style="width: 100%;text-align: center">
    <tr>
        <th>Tên</th>
        <th>Ngày sinh</th>
        <th>Địa chỉ</th>
        <th>Ảnh</th>
    </tr>
    <c:forEach var="customer" items="${list}" varStatus="status">
        <tr>
            <td>${customer.getName()}</td>
            <td>${customer.getDate()}</td>
            <td>${customer.getAddress()}</td>
            <td><img src="${customer.getImage()}" alt="image"/></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
