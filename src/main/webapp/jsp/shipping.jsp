<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shipping - WMS</title>
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
        .shipped-card {
            transition: all 0.3s ease;
        }
        .shipped-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        /* Color-only changes to match blue sidebar */
        .btn-primary {
            background-color: #3B82F6;
            border-color: #3B82F6;
        }

        .btn-primary:hover, .btn-primary:focus {
            background-color: #2563EB;
            border-color: #2563EB;
        }

        .table-primary, .table-primary > th, .table-primary > td {
            background-color: rgba(59, 130, 246, 0.1);
        }

        .text-primary {
            color: #3B82F6 !important;
        }

        .border-primary {
            border-color: #3B82F6 !important;
        }

        .bg-primary {
            background-color: #3B82F6 !important;
        }

        .form-check-input:checked {
            background-color: #3B82F6;
            border-color: #3B82F6;
        }

        .form-check-input:focus {
            border-color: rgba(59, 130, 246, 0.5);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }

        .form-control:focus, .form-select:focus {
            border-color: rgba(59, 130, 246, 0.5);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(59, 130, 246, 0.05);
        }

        /* Status badges with blue theme */
        .status-transit {
            background-color: rgba(59, 130, 246, 0.1);
            color: #3B82F6;
        }

        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.875rem;
        }

        .status-delivered {
            background-color: rgba(25, 135, 84, 0.1);
            color: #198754;
        }

        .status-pending {
            background-color: rgba(96, 165, 250, 0.1);
            color: #60A5FA;
        }
    </style>
</head>
<body>
    <%@ include file="/jsp/includes/sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Shipping</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#shipOrderModal">
                <i class="bi bi-truck"></i> Ship Order
            </button>
        </div>

        <!-- Shipping Modal -->
        <div class="modal fade" id="shipOrderModal" tabindex="-1" aria-labelledby="shipOrderModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="shipOrderModalLabel">Ship Order</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/shipping-process" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="orderId" class="form-label">Order</label>
                                <select class="form-select" id="orderId" name="orderId" required>
                                    <option value="" selected disabled>Select an order</option>
                                    <c:forEach var="order" items="${packedOrders}">
                                        <option value="${order.orderId}">Order #${order.orderId} - ${order.destination}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="carrier" class="form-label">Carrier Name</label>
                                <input type="text" class="form-control" id="carrier" name="carrier" required>
                            </div>
                            <div class="mb-3">
                                <label for="trackingNumber" class="form-label">Tracking Number</label>
                                <input type="text" class="form-control" id="trackingNumber" name="trackingNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="expectedArrival" class="form-label">Expected Arrival Date</label>
                                <input type="date" class="form-control" id="expectedArrival" name="expectedArrival" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Complete Shipment</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Shipping History Section -->
        <div class="card mt-4">
            <div class="card-header bg-white">
                <h5 class="section-title">Shipping History</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Order ID</th>
                                <th>Destination</th>
                                <th>Product ID</th>
                                <th>Quantity</th>
                                <th>Carrier</th>
                                <th>Tracking #</th>
                                <th>Order Date</th>
                                <th>Shipped Date</th>
                                <th>Expected Arrival</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${shippingItems}">
                                <tr>
                                    <td>${item.orderId}</td>
                                    <td>${item.destination}</td>
                                    <td>${item.productId}</td>
                                    <td>${item.quantity}</td>
                                    <td>${item.carrier}</td>
                                    <td>${item.trackingNumber}</td>
                                    <td><fmt:formatDate value="${item.orderDate}" pattern="yyyy-MM-dd"/></td>
                                    <td><fmt:formatDate value="${item.shippedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td><fmt:formatDate value="${item.expectedArrival}" pattern="yyyy-MM-dd"/></td>
                                    <td>${item.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Show order items when an order is selected
            const orderSelect = document.getElementById('orderSelect');
            const orderItemsPreview = document.getElementById('orderItemsPreview');

            orderSelect.addEventListener('change', function() {
                const selectedOption = this.options[this.selectedIndex];
                if (selectedOption.value) {
                    const items = selectedOption.getAttribute('data-items').split(', ');
                    let itemsHtml = '<strong>Items to ship:</strong><ul class="mb-0">';
                    items.forEach(item => {
                        itemsHtml += `<li>${item}</li>`;
                    });
                    itemsHtml += '</ul>';
                    orderItemsPreview.innerHTML = itemsHtml;
                } else {
                    orderItemsPreview.innerHTML = '';
                }
            });

            // Handle shipment confirmation
            document.getElementById('confirmShipment').addEventListener('click', function() {
                const form = document.getElementById('shippingForm');
                if (form.checkValidity()) {
                    // In a real app, you would submit this to your backend
                    alert('Shipment confirmed! This would submit to your backend in a real application.');
                    const modal = bootstrap.Modal.getInstance(document.getElementById('shipOrderModal'));
                    modal.hide();

                    // Here you would typically refresh the shipping history table
                    // or add the new shipment to it via AJAX
                } else {
                    form.reportValidity();
                }
            });

            // Initialize the modal to clear form when closed
            const shipOrderModal = document.getElementById('shipOrderModal');
            shipOrderModal.addEventListener('hidden.bs.modal', function() {
                document.getElementById('shippingForm').reset();
                orderItemsPreview.innerHTML = '';
            });
        });
    </script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Pre-fill order ID when clicking ship button
        document.querySelectorAll('.ship-order-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const orderId = this.getAttribute('data-order-id');
                document.getElementById('orderId').value = orderId;
            });
        });

        // Handle success/error messages
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            alert('Order shipped successfully!');
        } else if (urlParams.has('error')) {
            alert('Error shipping order. Please try again.');
        }
    });
    </script>
</body>
</html>