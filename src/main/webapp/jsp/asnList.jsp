<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>ASN List - Warehouse Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .action-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .table-responsive {
            overflow-x: auto;
        }
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Advanced Shipping Notices (ASN)</h2>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createAsnModal">
            <i class="bi bi-plus-circle"></i> Add New ASN
        </button>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <c:choose>
                    <c:when test="${not empty asnList}">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>ASN ID</th>
                                    <th>Supplier</th>
                                    <th>Expected Delivery</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${asnList}" var="asn">
                                    <tr>
                                        <td class="fw-semibold">${asn.asnId}</td>
                                        <td>${asn.supplierName}</td>
                                        <td>
                                            <fmt:formatDate value="${asn.expectedDeliveryDate}" pattern="yyyy-MM-dd"/>
                                        </td>
                                        <td>
                                            <span class="badge ${asn.status == 'Received' ? 'bg-success' : 'bg-warning'}">
                                                ${asn.status}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/asn/view?id=${asn.asnId}"
                                               class="btn btn-sm btn-outline-primary action-btn"
                                               title="View Details">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/asn/edit?id=${asn.asnId}"
                                               class="btn btn-sm btn-outline-secondary action-btn"
                                               title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-box-seam" style="font-size: 2rem;"></i>
                            <p class="mt-2 mb-0">No ASNs found</p>
                            <button type="button" class="btn btn-link mt-2" data-bs-toggle="modal" data-bs-target="#createAsnModal">
                                Create your first ASN
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
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
                                <label class="form-label">Product ID</label>
                                <input type="number" class="form-control" name="productId" placeholder="Enter Product ID" required min="1">
                            </div>
                            <div class="col-md-5">
                                <label class="form-label">Quantity</label>
                                <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity" required min="1">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label invisible">Remove</label>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add item row
        document.getElementById('addItemBtn').addEventListener('click', function() {
            const container = document.getElementById('asnItemsContainer');
            const newItem = document.createElement('div');
            newItem.className = 'row asn-item mb-2';

            newItem.innerHTML = `
                <div class="col-md-5">
                    <label class="form-label">Product ID</label>
                    <input type="number" class="form-control" name="productId" placeholder="Enter Product ID" required min="1">
                </div>
                <div class="col-md-5">
                    <label class="form-label">Quantity</label>
                    <input type="number" class="form-control" name="quantity" placeholder="Enter Quantity" required min="1">
                </div>
                <div class="col-md-2">
                    <label class="form-label invisible">Remove</label>
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
    });
</script>
</body>
</html>