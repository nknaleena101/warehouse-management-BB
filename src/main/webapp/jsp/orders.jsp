<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Orders - WMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<%@ include file="/jsp/includes/sidebar.jsp" %>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Orders</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createOrderModal">
            <i class="bi bi-plus-circle"></i> Create New Order
        </button>
    </div>

    <!-- Success message -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Order created successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Orders List Section -->
    <div class="card mb-5">
        <div class="card-header bg-white">
            <h5 class="section-title">Order Management</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>Order ID</th>
                        <th>Destination</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Items</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${recentOrders}" var="order">
                        <tr>
                            <td>ORD-${order.orderId}</td>
                            <td>${order.destination}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'Created'}">
                                        <span class="badge bg-primary status-badge">${order.status}</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Picking'}">
                                        <span class="badge bg-warning text-dark status-badge">${order.status}</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Packed'}">
                                        <span class="badge bg-info status-badge">${order.status}</span>
                                    </c:when>
                                    <c:when test="${order.status == 'Shipped'}">
                                        <span class="badge bg-success status-badge">${order.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary status-badge">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal"
                                        data-bs-target="#orderItemsModal" data-order-id="${order.orderId}">
                                    View Items
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary me-2">
                                    <i class="bi bi-pencil"></i> Edit
                                </button>
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="bi bi-trash"></i> Cancel
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Picking/Packing Section -->
    <div class="card">
        <div class="card-header bg-white">
            <h5 class="section-title">Picking & Packing</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover" id="pickingTable">
                    <thead class="table-light">
                    <tr>
                        <th>Order ID</th>
                        <th>Destination</th>
                        <th>Items to Pick</th>
                        <th>Picking Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ordersForPicking}" var="order">
                        <tr data-order-id="${order.orderId}">
                            <td>ORD-${order.orderId}</td>
                            <td>${order.destination}</td>
                            <td>
                                <ul class="list-unstyled">
                                    <c:forEach items="${order.items}" var="item">
                                        <li>PROD-${item.productId} - Qty: ${item.quantity}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td>
                                <select class="form-select form-select-sm picking-status"
                                        style="width: auto; display: inline-block;"
                                        data-order-id="${order.orderId}">
                                    <option value="Not Started" ${order.pickingStatus == 'Not Started' ? 'selected' : ''}>
                                        Not Started
                                    </option>
                                    <option value="In Progress" ${order.pickingStatus == 'Completed' ? 'selected' : ''}>
                                        In Progress
                                    </option>
                                </select>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-success complete-packing-btn"
                                        data-order-id="${order.orderId}"
                                    ${order.pickingStatus != 'Completed' ? 'disabled' : ''}>
                                    <i class="bi bi-check-circle"></i> Complete Packing
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Create Order Modal -->
<div class="modal fade" id="createOrderModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createOrderModalLabel">Create New Order</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/orders" method="POST">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="destination" class="form-label">Destination Address</label>
                            <input type="text" class="form-control" id="destination" name="destination" required>
                        </div>
                        <div class="col-md-6">
                            <label for="orderDate" class="form-label">Order Date</label>
                            <input type="date" class="form-control" id="orderDate" name="orderDate" required>
                        </div>
                    </div>

                    <h6 class="mt-4 mb-3">Order Items</h6>
                    <div class="table-responsive">
                        <table class="table" id="orderItemsTable">
                            <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Quantity</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <select class="form-select product-select" name="productId" required>
                                        <option value="">Select Product</option>
                                        <c:forEach items="${availableProducts}" var="productId">
                                            <option value="${productId}">PROD-${productId}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <input type="number" class="form-control quantity-input" name="quantity" min="1"
                                           value="1" required>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-danger remove-item-btn">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-primary" id="addItemBtn">
                        <i class="bi bi-plus"></i> Add Another Item
                    </button>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create Order</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Order Items Modal -->
<div class="modal fade" id="orderItemsModal" tabindex="-1" aria-labelledby="orderItemsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderItemsModalLabel">Order Items - <span id="modalOrderId"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Quantity</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody id="orderItemsBody">
                        <!-- Will be populated by JavaScript -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>