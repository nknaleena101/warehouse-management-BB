<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create ASN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .asn-item {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .remove-item-btn {
            margin-top: 32px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <!-- Button to trigger modal -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createAsnModal">
        <i class="bi bi-plus-circle"></i> Create New ASN
    </button>

    <!-- ASN List Table -->
    <div class="card mt-4">
        <div class="card-header">
            <h4>ASN List</h4>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ASN ID</th>
                        <th>Supplier</th>
                        <th>Expected Delivery</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${asnList}" var="asn">
                        <tr>
                            <td>${asn.asnId}</td>
                            <td>${asn.supplierName}</td>
                            <td>${asn.expectedDeliveryDate}</td>
                            <td>
                                <span class="badge ${asn.status == 'Received' ? 'bg-success' : 'bg-warning'}">
                                    ${asn.status}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Create ASN Modal -->
    <div class="modal fade" id="createAsnModal" tabindex="-1" aria-labelledby="createAsnModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createAsnModalLabel">Create New ASN</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="asnForm" action="${pageContext.request.contextPath}/asn/create" method="post">
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Supplier Name</label>
                                <input type="text" class="form-control" name="supplierName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Expected Delivery Date</label>
                                <input type="date" class="form-control" name="expectedDeliveryDate" required>
                            </div>
                        </div>

                        <h5 class="mt-4">Items</h5>
                        <div id="asnItemsContainer">
                            <div class="row asn-item mb-2">
                                <div class="col-md-5">
                                    <select class="form-select" name="productId" required>
                                        <option value="">Select Product</option>
                                        <c:forEach items="${products}" var="product">
                                            <option value="${product.id}">${product.name} (SKU: ${product.sku})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-5">
                                    <input type="number" class="form-control" name="quantity" placeholder="Quantity" required min="1">
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-danger remove-item-btn">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <button type="button" class="btn btn-outline-primary mt-2" id="addItemBtn">
                            <i class="bi bi-plus-circle"></i> Add Item
                        </button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Create ASN</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add item row
        document.getElementById('addItemBtn').addEventListener('click', function() {
            const container = document.getElementById('asnItemsContainer');
            const newItem = document.createElement('div');
            newItem.className = 'row asn-item mb-2';

            // Clone the options from the first select
            const optionsHTML = document.querySelector('#asnItemsContainer select[name="productId"]').innerHTML;

            newItem.innerHTML = `
                <div class="col-md-5">
                    <select class="form-select" name="productId" required>
                        ${optionsHTML}
                    </select>
                </div>
                <div class="col-md-5">
                    <input type="number" class="form-control" name="quantity" placeholder="Quantity" required min="1">
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger remove-item-btn">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            `;

            container.appendChild(newItem);

            // Add event listener to remove button
            newItem.querySelector('.remove-item-btn').addEventListener('click', function() {
                container.removeChild(newItem);
            });
        });

        // Handle form submission
        document.getElementById('asnForm').addEventListener('submit', function(e) {
            // Validation can be added here if needed
            return true;
        });
    });
</script>
</body>
</html>
