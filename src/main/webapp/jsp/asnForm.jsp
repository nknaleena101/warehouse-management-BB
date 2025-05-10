<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Create ASN</title>
    <link rel="stylesheet" href="../css/style.css">
    <script>
        function addItemRow() {
            const container = document.getElementById("itemsContainer");
            const row = document.createElement("div");
            row.className = "item-row";
            row.innerHTML = `
                <div>
                    <label>Product ID:</label>
                    <input type="number" name="productId" required>
                </div>
                <div>
                    <label>Quantity:</label>
                    <input type="number" name="quantity" required>
                </div>
                <button type="button" onclick="this.parentNode.remove()">Remove</button>
            `;
            container.appendChild(row);
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>
    <h1>Create Advanced Shipping Notice</h1>


    <form action="/warehouse_system/asn/create" method="post">
        <div>
            <label for="supplierName">Supplier Name:</label>
            <input type="text" id="supplierName" name="supplierName" required>
        </div>

        <div>
            <label for="expectedDeliveryDate">Expected Delivery Date:</label>
            <input type="date" id="expectedDeliveryDate" name="expectedDeliveryDate" required>
        </div>

        <h3>Items</h3>
        <div id="itemsContainer">
            <!-- Initial item row -->
            <div class="item-row">
                <div>
                    <label>Product ID:</label>
                    <input type="number" name="productId" required>
                </div>
                <div>
                    <label>Quantity:</label>
                    <input type="number" name="quantity" required>
                </div>
            </div>
        </div>

        <button type="button" onclick="addItemRow()">Add Item</button>
        <button type="submit">Submit ASN</button>
    </form>

    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
</body>
</html>