<%--
  Created by IntelliJ IDEA.
  User: TechCare
  Date: 9/12/2022
  Time: 8:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
    <form action="/calculator" method="get">
      First operand: <input type="number" name="first"/><br>
      Operator: <select name="operator"><br>
                    <option value="+">Add</option>
                    <option value="-">Sub</option>
                    <option value="*">Mul</option>
                    <option value="/">Div</option>
                </select><br>
      Second operand: <input type="number" name="second"/><br>
      <input type="submit" value="submit">
    </form>
  </body>
</html>
