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
                <th>Items</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${asnList}" var="asn">
                <tr>
                    <td>${asn.asnId}</td>
                    <td>${asn.supplierName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty asn.items}">
                                <ul>
                                    <c:forEach items="${asn.items}" var="item">
                                        <li>Product ${item.productId}: ${item.quantity} units</li>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                No items
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${asn.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>