<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - WMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hover-shadow:hover {

        }
        /* Stats Cards */
        .stat-card {
            border-radius: 1rem;
            border: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            overflow: hidden;
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem 1.5rem;
            border-bottom: none;
        }

        .stat-card-body {
            padding: 1rem 1.5rem 1.5rem;
        }

        .stat-card-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0;
            line-height: 1;
        }

        .stat-card-label {
            font-size: 0.9rem;
            margin-bottom: 0;
            opacity: 0.7;
        }

        .stat-card-icon {
            font-size: 2rem;
            opacity: 0.8;
        }

        /* Colors for stat cards */
        .bg-products {
            background: linear-gradient(135deg, #4361ee 0%, #3a0ca3 100%);
            color: white;
        }

        .bg-stock {
            background: linear-gradient(135deg, #4cc9f0 0%, #4895ef 100%);
            color: white;
        }

        .bg-orders {
            background: linear-gradient(135deg, #f72585 0%, #b5179e 100%);
            color: white;
        }

        .bg-lowstock {
            background: linear-gradient(135deg, #ff4d6d 0%, #c9184a 100%);
            color: white;
        }

        body, html {
            height: 100%;
        }

        .sidebar {
            width: 250px;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background-color: #f8f9fa;
            padding: 20px;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .card {
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
            border-radius: 0.75rem;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<div class="d-flex">
    <%@ include file="/jsp/includes/sidebar.jsp" %>

    <div class="main-content container-fluid">
        <h2 class="mb-4">Dashboard</h2>

        <!-- Stats Overview Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-products">
                            <div class="stat-card-header">
                                <h5 class="stat-card-label">Total Products</h5>
                                <i class="bi bi-box stat-card-icon"></i>
                            </div>
                            <div class="stat-card-body">
                                <h2 class="stat-card-value">1,248</h2>
                                <p class="stat-card-label">12% increase from last month</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-stock">
                            <div class="stat-card-header">
                                <h5 class="stat-card-label">In Stock</h5>
                                <i class="bi bi-archive stat-card-icon"></i>
                            </div>
                            <div class="stat-card-body">
                                <h2 class="stat-card-value">856</h2>
                                <p class="stat-card-label">68.6% of inventory</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-orders">
                            <div class="stat-card-header">
                                <h5 class="stat-card-label">Pending Orders</h5>
                                <i class="bi bi-clipboard-check stat-card-icon"></i>
                            </div>
                            <div class="stat-card-body">
                                <h2 class="stat-card-value">24</h2>
                                <p class="stat-card-label">5 due today</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-lowstock">
                            <div class="stat-card-header">
                                <h5 class="stat-card-label">Low Stock</h5>
                                <i class="bi bi-exclamation-triangle stat-card-icon"></i>
                            </div>
                            <div class="stat-card-body">
                                <h2 class="stat-card-value">18</h2>
                                <p class="stat-card-label">Items need attention</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Quick Actions - Modern Design -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card shadow-sm border-0 rounded-lg">
                            <div class="card-header bg-white border-bottom-0 pt-3 pb-1">
                                <h5 class="fw-bold text-primary mb-0">
                                    <i class="bi bi-lightning-charge-fill me-2"></i>Quick Actions
                                </h5>
                            </div>
                            <div class="card-body pt-0 pb-3">
                                <div class="row g-2">
                                    <!-- Create ASN -->
                                    <div class="col-md-6 col-lg-3">
                                        <a href="${pageContext.request.contextPath}/asn" class="text-decoration-none">
                                            <div class="card border-0 shadow-sm hover-shadow transition-all">
                                                <div class="card-body d-flex align-items-center p-2">
                                                    <div class="rounded-pill bg-primary bg-opacity-10 px-2 py-1 me-2">
                                                        <i class="bi bi-plus-circle text-primary"></i>
                                                    </div>
                                                    <span class="fw-medium">Create ASN</span>
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                    <!-- Add Inventory -->
                                    <div class="col-md-6 col-lg-3">
                                        <a href="${pageContext.request.contextPath}/inventory/add" class="text-decoration-none">
                                            <div class="card border-0 shadow-sm hover-shadow transition-all">
                                                <div class="card-body d-flex align-items-center p-2">
                                                    <div class="rounded-pill bg-success bg-opacity-10 px-2 py-1 me-2">
                                                        <i class="bi bi-box-seam text-success"></i>
                                                    </div>
                                                    <span class="fw-medium">Add Inventory</span>
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                    <!-- New Order -->
                                    <div class="col-md-6 col-lg-3">
                                        <a href="${pageContext.request.contextPath}/orders/new" class="text-decoration-none">
                                            <div class="card border-0 shadow-sm hover-shadow transition-all">
                                                <div class="card-body d-flex align-items-center p-2">
                                                    <div class="rounded-pill bg-info bg-opacity-10 px-2 py-1 me-2">
                                                        <i class="bi bi-cart-plus text-info"></i>
                                                    </div>
                                                    <span class="fw-medium">New Order</span>
                                                </div>
                                            </div>
                                        </a>
                                    </div>

                                    <!-- Process Shipping -->
                                    <div class="col-md-6 col-lg-3">
                                        <a href="${pageContext.request.contextPath}/shipping" class="text-decoration-none">
                                            <div class="card border-0 shadow-sm hover-shadow transition-all">
                                                <div class="card-body d-flex align-items-center p-2">
                                                    <div class="rounded-pill bg-warning bg-opacity-10 px-2 py-1 me-2">
                                                        <i class="bi bi-truck text-warning"></i>
                                                    </div>
                                                    <span class="fw-medium">Process Shipping</span>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


        <!-- Recent ASNs and Orders - Modern Look -->
        <div class="row g-4">

            <!-- Recent ASNs -->
            <div class="col-lg-6">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-header bg-white border-bottom">
                        <h5 class="mb-0 fw-semibold text-primary">Recent ASNs (Advanced Shipping Notice)</h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty recentASNs}">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light text-nowrap">
                                            <tr>
                                                <th>ASN ID</th>
                                                <th>Supplier</th>
                                                <th>Expected Delivery</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentASNs}" var="asn">
                                                <tr>
                                                    <td class="fw-medium">${asn.asnId}</td>
                                                    <td>${asn.supplierName}</td>
                                                    <td>
                                                        <fmt:formatDate value="${asn.expectedDeliveryDate}" pattern="yyyy-MM-dd" />
                                                    </td>
                                                    <td>
                                                        <span class="badge px-3 py-2 rounded-pill
                                                            ${asn.status == 'Received' ? 'bg-success-subtle text-success' : 'bg-warning-subtle text-warning'}">
                                                            ${asn.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning m-3">No recent ASNs found.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Recent Orders -->
            <div class="col-lg-6">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-header bg-white border-bottom">
                        <h5 class="mb-0 fw-semibold text-primary">Recent Orders</h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty recentOrders}">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light text-nowrap">
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Destination</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentOrders}" var="order">
                                                <tr>
                                                    <td class="fw-medium">${order.orderId}</td>
                                                    <td>${order.destination}</td>
                                                    <td>
                                                        <span class="badge px-3 py-2 rounded-pill
                                                            ${order.status == 'Shipped' ? 'bg-success-subtle text-success' :
                                                              order.status == 'Processing' ? 'bg-warning-subtle text-warning' :
                                                              'bg-primary-subtle text-primary'}">
                                                            ${order.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info m-3">No recent orders found.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

        </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
