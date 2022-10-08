<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: linht
  Date: 9/14/2022
  Time: 7:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
    <title>Product list</title>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/page-loader.jsp" />
    <jsp:include page="/WEB-INF/views/layout/navbar.jsp" />
    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp" />
    <section class="content">
        <div class="container-fluid">
            <!-- Vertical Layout -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>Product list</h2>
                        </div>
                        <div class="text-center">
                            <form action="/product" method="get">
                                <input type="text" name="name" />
                                <input type="hidden" name="action" value="search" placeholder="Search by Name" />
                                <input type="submit" value="Search">
                            </form>
                            <h4><a href="/product">REFRESH</a></h4>
                        </div>
                        <div class="body table-responsive">
                            <a href="/product?action=create" class="btn btn-primary btn-custom">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i> Add new product
                            </a>
                            <table class="table table-striped" id="dataTable-listStudent">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Color</th>
                                    <th>Description</th>
                                    <th>Category</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${products}" var="item">
                                        <tr>
                                            <td>${item.id }</td>
                                            <td>${item.name}</td>
                                            <td>${item.price}</td>
                                            <td>${item.quantity}</td>
<%--                                            <c:if test="${item.gender}" >--%>
<%--                                                <td>Men</td>--%>
<%--                                            </c:if>--%>
<%--                                            <c:if test="${!item.gender}" >--%>
<%--                                                <td>Girl</td>--%>
<%--                                            </c:if>--%>
                                            <td>${item.color}</td>
                                            <td>${item.description}</td>
                                            <c:forEach items="${categories}" var="type">
                                                <c:if test="${type.id == item.idCategory}" >
                                                    <td>${type.name}</td>
                                                </c:if>
                                            </c:forEach>
                                            <td style="color: #00BCD4;">
                                                <a href="/product?action=update&idProduct=${item.id}">
                                                    edit
                                                </a>
                                            </td>
                                            <td style="color: red">
                                                <a href="/product?action=delete&idProduct=${item.id}">
                                                    delete
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/layout/script.jsp" />
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
