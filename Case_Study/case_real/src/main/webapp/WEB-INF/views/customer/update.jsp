<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: linht
  Date: 9/14/2022
  Time: 7:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create product</title>
    <link rel="stylesheet" href="/assets/css/index.css">
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
                            <h2>
                                Update product
                            </h2>
                            <a href="/customers">Return List</a>
                            <c:if test="${error != null}">
                                <h2 style="color: red">${error}</h2>
                            </c:if>
                            <div class="body">
                                <form action="/customers" method="post">
                                    <label for="name">Name: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="text" name="name" class="form-control" value="${customer.name}"
                                                   placeholder="Customer Name" tabindex="2" id="name" />
                                        </div>
                                    </div>

                                    <label for="type">Type: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <select name="type" id="type" class="form-control" >
                                                <c:forEach items="${customerType}" var="item">
                                                    <c:if test="${customer.customerType == item.id}">
                                                        <option value="${item.id}" selected>${item.nameType}</option>
                                                    </c:if>
                                                    <option value="${item.id}">${item.nameType}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <label for="gender">Gender: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <select name="gender" id="gender" class="form-control" >
                                                <c:if test="${customer.gender}">
                                                    <option value="1" selected>Nam</option>
                                                    <option value="0" >NỮ</option>
                                                </c:if>
                                                <c:if test="${!customer.gender}">
                                                    <option value="0" selected>Nữ</option>
                                                    <option value="1" selected>Nam</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>

                                    <label for="dateRelease">Birthday: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="date" name="birth" class="form-control" placeholder="birthday"
                                                   value="${customer.birthday}" tabindex="4" id="dateRelease" value=""/>
                                        </div>
                                    </div>

                                    <label for="idCard">Id card: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="text" name="idCard" class="form-control" placeholder="idCard"
                                                   tabindex="5" id="idCard" value="${customer.idCard}"/>
                                        </div>
                                    </div>

                                    <label for="phone">Phone: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="text" name="phone" class="form-control"
                                                   placeholder="phone" tabindex="5" id="phone" value="${customer.phone}" />
                                        </div>
                                    </div>

                                    <label for="email">Email: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="email" name="email" class="form-control" placeholder="email"
                                                   tabindex="5" id="email" value="${customer.email}"/>
                                        </div>
                                    </div>

                                    <label for="address">Address: <span style="color: red;"> *</span></label>
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="text" name="address" class="form-control" placeholder="address"
                                                   tabindex="5" id="address" value="${customer.address}"/>
                                        </div>
                                    </div>

                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="idCus" value="${customer.id}" />
                                    <button type="reset" class="btn btn-primary btn-custom" tabindex="6"><i class="fa fa-check" aria-hidden="true"></i> Reset</button>
                                    <button type="submit" class="btn btn-primary btn-custom" tabindex="7"><i class="fa fa-check" aria-hidden="true"></i> Update</button>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <br>
    <jsp:include page="/WEB-INF/views/layout/script.jsp" />
<%--    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />--%>
</body>
</html>
