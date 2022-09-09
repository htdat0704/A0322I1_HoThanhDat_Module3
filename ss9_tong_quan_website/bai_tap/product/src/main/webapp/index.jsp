<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/9/2022
  Time: 8:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Products</title>
</head>
<body>
<h2>Products</h2>
<form action="/discount" method="post">
  <label>Product Description: </label><br/>
  <input type="text" name="product" placeholder="Product Description" /><br/>
  <label>List Price: </label><br/>
  <input type="number" name="price" placeholder="List Price" /><br/>
  <label>Discount Percent: </label><br/>
  <input type="number" name="percent" placeholder="Discount Percent" /><br/>
  <input type = "submit" id = "submit" value = "Submit"/>
</form>

<b>${productName}</b> <br>
<b>${discountAmount}</b> <br>
<b>${discountPrice}</b>

</body>
</html>
