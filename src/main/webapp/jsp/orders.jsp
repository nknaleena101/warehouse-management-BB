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
                            <!-- Sample data - replace with JSTL/EL from your backend -->
                            <tr>
                                <td>ORD-1001</td>
                                <td>123 Main St, Anytown</td>
                                <td>2023-07-15</td>
                                <td><span class="badge bg-warning text-dark status-badge">Processing</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#orderItemsModal" data-order-id="ORD-1001">
                                        View Items (3)
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
                            <tr>
                                <td>ORD-1002</td>
                                <td>456 Oak Ave, Somewhere</td>
                                <td>2023-07-16</td>
                                <td><span class="badge bg-success status-badge">Shipped</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#orderItemsModal" data-order-id="ORD-1002">
                                        View Items (2)
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-2" disabled>
                                        <i class="bi bi-pencil"></i> Edit
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger" disabled>
                                        <i class="bi bi-trash"></i> Cancel
                                    </button>
                                </td>
                            </tr>
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
                    <table class="table table-striped table-hover">
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
                            <!-- Sample picking data -->
                            <tr>
                                <td>ORD-1003</td>
                                <td>789 Pine Rd, Elsewhere</td>
                                <td>
                                    <ul class="list-unstyled">
                                        <li>PROD-1001 - Qty: 2</li>
                                        <li>PROD-1005 - Qty: 1</li>
                                    </ul>
                                </td>
                                <td>
                                    <select class="form-select form-select-sm" style="width: auto; display: inline-block;">
                                        <option>Not Started</option>
                                        <option selected>In Progress</option>
                                        <option>Completed</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-success">
                                        <i class="bi bi-check-circle"></i> Complete Packing
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>ORD-1004</td>
                                <td>321 Elm St, Nowhere</td>
                                <td>
                                    <ul class="list-unstyled">
                                        <li>PROD-1002 - Qty: 3</li>
                                    </ul>
                                </td>
                                <td>
                                    <select class="form-select form-select-sm" style="width: auto; display: inline-block;">
                                        <option selected>Not Started</option>
                                        <option>In Progress</option>
                                        <option>Completed</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-success" disabled>
                                        <i class="bi bi-check-circle"></i> Complete Packing
                                    </button>
                                </td>
                            </tr>
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
                <div class="modal-body">
                    <form>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="destination" class="form-label">Destination Address</label>
                                <input type="text" class="form-control" id="destination" required>
                            </div>
                            <div class="col-md-6">
                                <label for="orderDate" class="form-label">Order Date</label>
                                <input type="date" class="form-control" id="orderDate" required>
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
                                            <select class="form-select product-select" required>
                                                <option value="">Select Product</option>
                                                <option value="1001">PROD-1001</option>
                                                <option value="1002">PROD-1002</option>
                                                <option value="1003">PROD-1003</option>
                                                <option value="1004">PROD-1004</option>
                                                <option value="1005">PROD-1005</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="number" class="form-control quantity-input" min="1" value="1" required>
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
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Create Order</button>
                </div>
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
        // Sample JavaScript for dynamic functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Add item row functionality
            document.getElementById('addItemBtn').addEventListener('click', function() {
                const tbody = document.querySelector('#orderItemsTable tbody');
                const newRow = document.createElement('tr');
                newRow.innerHTML = `
                    <td>
                        <select class="form-select product-select" required>
                            <option value="">Select Product</option>
                            <option value="1001">PROD-1001</option>
                            <option value="1002">PROD-1002</option>
                            <option value="1003">PROD-1003</option>
                            <option value="1004">PROD-1004</option>
                            <option value="1005">PROD-1005</option>
                        </select>
                    </td>
                    <td>
                        <input type="number" class="form-control quantity-input" min="1" value="1" required>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-danger remove-item-btn">
                            <i class="bi bi-trash"></i>
                        </button>
                    </td>
                `;
                tbody.appendChild(newRow);

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

                    // In a real app, you would fetch this data from your backend
                    const itemsBody = document.getElementById('orderItemsBody');
                    if (orderId === 'ORD-1001') {
                        itemsBody.innerHTML = `
                            <tr>
                                <td>PROD-1003</td>
                                <td>5</td>
                                <td><span class="badge bg-success">Picked</span></td>
                            </tr>
                            <tr>
                                <td>PROD-1005</td>
                                <td>2</td>
                                <td><span class="badge bg-warning text-dark">Pending</span></td>
                            </tr>
                            <tr>
                                <td>PROD-1007</td>
                                <td>1</td>
                                <td><span class="badge bg-success">Picked</span></td>
                            </tr>
                        `;
                    } else if (orderId === 'ORD-1002') {
                        itemsBody.innerHTML = `
                            <tr>
                                <td>PROD-1002</td>
                                <td>1</td>
                                <td><span class="badge bg-success">Picked</span></td>
                            </tr>
                            <tr>
                                <td>PROD-1004</td>
                                <td>1</td>
                                <td><span class="badge bg-success">Picked</span></td>
                            </tr>
                        `;
                    }
                });
            }

            // Add delete functionality to the first row's delete button
            const firstDeleteBtn = document.querySelector('#orderItemsTable .remove-item-btn');
            if (firstDeleteBtn) {
                firstDeleteBtn.addEventListener('click', function() {
                    const tbody = document.querySelector('#orderItemsTable tbody');
                    if (tbody.children.length > 1) {
                        tbody.removeChild(this.closest('tr'));
                    }
                });
            }
        });
    </script>
</body>
</html>