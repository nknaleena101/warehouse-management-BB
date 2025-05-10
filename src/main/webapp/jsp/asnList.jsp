<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>ASN List</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        tr:hover { background-color: #f5f5f5; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <h1>Advanced Shipping Notices</h1>

    <a href="${pageContext.request.contextPath}/asn">Create New ASN</a>

    <table>
        <thead>
            <tr>
                <th>ASN ID</th>
                <th>Supplier</th>
                <th>Expected Delivery</th>
                <th>Status</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${asnList}" var="asn">
                <tr>
                    <td>${asn.asnId}</td>
                    <td>${asn.supplierName}</td>
                    <td><fmt:formatDate value="${asn.expectedDeliveryDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${asn.status}</td>
                    <td><fmt:formatDate value="${asn.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/asn/details?id=${asn.asnId}">View</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>