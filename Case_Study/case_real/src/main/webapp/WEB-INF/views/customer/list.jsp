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
                            <form action="/customers" method="get">
                                <input type="text" name="name" />
                                <input type="hidden" name="action" value="search" placeholder="Search by Name" />
                                <input type="submit" value="Search">
                            </form>
                            <h4><a href="/customers">REFRESH</a></h4>
                        </div>
                        <div class="body table-responsive">
                            <a href="/customers?action=create" class="btn btn-primary btn-custom">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i> Add new product
                            </a>
                            <table class="table table-striped" id="dataTable-listStudent">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Customer Type</th>
                                    <th>Name</th>
                                    <th>Birthday</th>
                                    <th>Gender</th>
                                    <th>ID Card</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>Address</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${customers}" var="item">
                                        <tr>
                                            <td>${item.id }</td>
                                            <c:forEach items="${customerType}" var="type">
                                                <c:if test="${type.id == item.customerType}" >
                                                    <td>${type.nameType}</td>
                                                </c:if>
                                            </c:forEach>
                                            <td>${item.name}</td>
                                            <td>${item.birthday}</td>
                                            <c:if test="${item.gender}" >
                                                <td>Men</td>
                                            </c:if>
                                            <c:if test="${!item.gender}" >
                                                <td>Girl</td>
                                            </c:if>
                                            <td>${item.idCard}</td>
                                            <td>${item.phone}</td>
                                            <td>${item.email}</td>
                                            <td>${item.address}</td>
                                            <td style="color: #00BCD4;">
                                                <a href="/customers?action=update&idCustomer=${item.id}">
                                                    edit
                                                </a>
                                            </td>
                                            <td style="color: red">delete</td>
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
