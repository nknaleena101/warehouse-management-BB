<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Orders - WMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .toast {
            margin-bottom: 10px;
            min-width: 250px;
        }
        .main-content {
            margin-left: 260px;
            padding: 20px;
        }
        .section-title {
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 10px;
            margin-top: 30px;
            margin-bottom: 20px;
        }
        .order-card {
            transition: all 0.3s ease;
        }
        .order-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 5px 10px;
            border-radius: 20px;
        }
    </style>
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
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
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
                                        <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#orderItemsModal" data-order-id="${order.orderId}">
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
                                            <option value="Not Started" ${order.pickingStatus == 'Not Started' ? 'selected' : ''}>Not Started</option>
                                            <option value="In Progress" ${order.pickingStatus == 'In Progress' ? 'selected' : ''}>In Progress</option>
                                            <option value="Completed" ${order.pickingStatus == 'Completed' ? 'selected' : ''}>Completed</option>
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
                                            <input type="number" class="form-control quantity-input" name="quantity" min="1" value="1" required>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add item row functionality
            document.getElementById('addItemBtn').addEventListener('click', function() {
                const tbody = document.querySelector('#orderItemsTable tbody');
                const newRow = document.createElement('tr');
                newRow.innerHTML = `
                    <td>
                        <select class="form-select product-select" name="productId" required>
                            <script>
                              const productSelect = document.querySelector('.product-select');
                              const options = Array.from(productSelect.options)
                                .filter(opt => opt.value !== '')
                                .map(opt => `<option value="${opt.value}">${opt.text}</option>`)
                                .join('');

                              document.querySelector('#yourTargetElement').innerHTML = options;
                            </script>

                        </select>
                    </td>
                    <td>
                        <input type="number" class="form-control quantity-input" name="quantity" min="1" value="1" required>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-danger remove-item-btn">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                `;
                tbody.appendChild(newRow);

                <script>
                // Add event listener to the new delete button
                newRow.querySelector('.remove-item-btn').addEventListener('click', function() {
                    if (tbody.children.length > 1) {
                        tbody.removeChild(newRow);
                    }
                });
            });

            // Order items modal functionality
            const orderItemsModal = document.getElementById('orderItemsModal');
            if (orderItemsModal) {
                orderItemsModal.addEventListener('show.bs.modal', function(event) {
                    const button = event.relatedTarget;
                    const orderId = button.getAttribute('data-order-id');
                    const modalTitle = orderItemsModal.querySelector('.modal-title');
                    modalTitle.textContent = `Order Items - ${orderId}`;

                    // Clear previous items
                    const itemsBody = document.getElementById('orderItemsBody');
                    itemsBody.innerHTML = '<tr><td colspan="3" class="text-center">Loading items...</td></tr>';

                    // Extract numeric order ID
                    const numericOrderId = orderId.replace('ORD-', '');

                    // Fetch order items via AJAX
                    fetch(`${pageContext.request.contextPath}/orders?orderId=${numericOrderId}`, {
                        method: 'GET',
                        headers: {
                            'Accept': 'application/json'
                        }
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(items => {
                        if (items.error) {
                            itemsBody.innerHTML = `<tr><td colspan="3" class="text-center text-danger">${items.error}</td></tr>`;
                            return;
                        }

                        if (items.length === 0) {
                            itemsBody.innerHTML = '<tr><td colspan="3" class="text-center">No items found for this order</td></tr>';
                            return;
                        }

                        // Build the items table
                        let html = '';
                        items.forEach(item => {
                            let statusBadge = '';
                            if (item.status === 'Picked') {
                                statusBadge = '<span class="badge bg-success">Picked</span>';
                            } else if (item.status === 'Packed') {
                                statusBadge = '<span class="badge bg-info">Packed</span>';
                            } else {
                                statusBadge = '<span class="badge bg-warning text-dark">Pending</span>';
                            }

                            html += `
                                <tr>
                                    <td>PROD-${item.productId}</td>
                                    <td>${item.quantity}</td>
                                    <td>${statusBadge}</td>
                                </tr>
                            `;
                        });

                        itemsBody.innerHTML = html;
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        itemsBody.innerHTML = `<tr><td colspan="3" class="text-center text-danger">Error loading items: ${error.message}</td></tr>`;
                    });
                });
            }

            // Add delete functionality to the first rows delete button
            const firstDeleteBtn = document.querySelector('#orderItemsTable .remove-item-btn');
            if (firstDeleteBtn) {
                firstDeleteBtn.addEventListener('click', function() {
                    const tbody = document.querySelector('#orderItemsTable tbody');
                    if (tbody.children.length > 1) {
                        tbody.removeChild(this.closest('tr'));
                    }
                });
            }

            // Set todays date as default for order date
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('orderDate').value = today;
        });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle picking status change
            document.querySelectorAll('.picking-status').forEach(select => {
                select.addEventListener('change', function() {

                    // Get the numeric order ID (remove "ORD-" prefix if present)
                    let orderId = this.getAttribute('data-order-id');
                    orderId = orderId.replace('ORD-', '');

                    // const orderId = this.getAttribute('data-order-id');
                    const status = this.value;
                    const originalValue = this.getAttribute('data-original-value');

                    console.log("Sending request with orderId:", orderId, "status:", status);

                    // Show loading indicator
                    this.disabled = true;
                    const spinner = document.createElement('span');
                    spinner.className = 'spinner-border spinner-border-sm ms-2';
                    this.parentNode.appendChild(spinner);

                    fetch(`${pageContext.request.contextPath}/orders/picking`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `orderId=${orderId}&status=${status}`
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        // Remove loading indicator
                        this.disabled = false;
                        spinner.remove();

                        if (data.success) {
                            // Update UI
                            const packingBtn = document.querySelector(`.complete-packing-btn[data-order-id="${orderId}"]`);
                            packingBtn.disabled = status !== 'Completed';

                            // Update original value marker
                            this.setAttribute('data-original-value', status);

                            // Show success toast
                            showToast('Status updated', 'Picking status was updated successfully', 'success');
                        } else {
                            // Revert to original value
                            this.value = originalValue;
                            showToast('Update failed', data.message || 'Failed to update picking status', 'danger');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        // Remove loading indicator
                        this.disabled = false;
                        spinner.remove();

                        // Revert to original value
                        this.value = originalValue;
                        showToast('Error', 'Failed to update picking status: ' + error.message, 'danger');
                    });
                });

                // Set initial original value
                select.setAttribute('data-original-value', select.value);
            });

            // Add this helper function for showing toasts
            function showToast(title, message, type) {
                const toastContainer = document.getElementById('toastContainer') || createToastContainer();
                const toastId = 'toast-' + Date.now();

                const toast = document.createElement('div');
                toast.className = `toast align-items-center text-white bg-${type} border-0`;
                toast.setAttribute('role', 'alert');
                toast.setAttribute('aria-live', 'assertive');
                toast.setAttribute('aria-atomic', 'true');
                toast.id = toastId;

                toast.innerHTML = `
                    <div class="d-flex">
                        <div class="toast-body">
                            <strong>${title}</strong><br>${message}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                `;

                toastContainer.appendChild(toast);
                new bootstrap.Toast(toast).show();

                // Auto-remove after hide
                toast.addEventListener('hidden.bs.toast', function() {
                    toast.remove();
                });
            }

            function createToastContainer() {
                const container = document.createElement('div');
                container.id = 'toastContainer';
                container.style.position = 'fixed';
                container.style.top = '20px';
                container.style.right = '20px';
                container.style.zIndex = '1100';
                document.body.appendChild(container);
                return container;
            }

            // Handle complete packing button
            document.querySelectorAll('.complete-packing-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const orderId = this.getAttribute('data-order-id');

                    if (confirm('Are you sure you want to mark this order as packed?')) {
                        fetch(`${pageContext.request.contextPath}/orders/packing`, {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: `orderId=${orderId}`
                        })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Failed to complete packing');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                // Update the order status in the UI
                                const row = document.querySelector(`tr[data-order-id="${orderId}"]`);
                                if (row) {
                                    // You might want to refresh the row or indicate packing is complete
                                    alert('Order marked as packed successfully');
                                    location.reload(); // Refresh the page to show updated status
                                }
                            } else {
                                alert('Failed to complete packing: ' + (data.message || 'Unknown error'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Error completing packing: ' + error.message);
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>