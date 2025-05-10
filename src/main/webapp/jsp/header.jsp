<%-- /webapp/jsp/header.jsp --%>
<div class="header">
    <h1>Warehouse Management System</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/asn/list">ASN List</a>
        | <a href="${pageContext.request.contextPath}/asn">Create New ASN</a>
        <!-- Add more navigation links as you create more features -->
    </nav>
</div>

<style>
    .header {
        background-color: #f8f9fa;
        padding: 20px;
        margin-bottom: 20px;
        border-bottom: 1px solid #e1e1e1;
    }
    .header h1 {
        margin: 0;
        color: #333;
    }
    .header nav {
        margin-top: 10px;
    }
    .header nav a {
        margin-right: 10px;
        text-decoration: none;
        color: #007bff;
    }
    .header nav a:hover {
        text-decoration: underline;
    }
</style>