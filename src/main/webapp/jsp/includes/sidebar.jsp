<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="${requestScope['javax.servlet.forward.request_uri']}" />

<div class="d-flex flex-column justify-content-between bg-white text-dark shadow-sm" style="width: 260px; height: 100vh; position: fixed; left: 0; z-index: 1000;">
    <!-- Top Logo Section with gradient accent -->
    <div>
        <div class="position-relative">
            <div class="position-absolute top-0 start-0 end-0" style="height: 4px; background: linear-gradient(90deg, #3B82F6, #60A5FA);"></div>
            <div class="d-flex align-items-center justify-content-center py-4 px-3">
                <div class="d-flex align-items-center">
                    <div class="me-2" style="background: linear-gradient(135deg, #3B82F6, #2563EB); width: 38px; height: 38px; border-radius: 8px; display: flex; align-items: center; justify-content: center;">
                        <i class="bi bi-box-seam-fill text-white fs-5"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold m-0">WMS</h4>
                        <p class="text-muted m-0 small">Warehouse System</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navigation Category -->
        <div class="px-4 pt-4">
            <p class="text-uppercase fw-semibold text-secondary small mb-3" style="letter-spacing: 1px;">Navigation</p>
        </div>

        <!-- Enhanced Nav Links -->
        <ul class="nav flex-column px-3">
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/dashboard"
                   class="nav-link ${currentPage.endsWith('/dashboard') ? 'active fw-medium text-primary' : 'text-secondary'} d-flex align-items-center gap-3 px-3 py-2 rounded-pill transition-all">
                    <i class="bi bi-grid-fill ${currentPage.endsWith('/dashboard') ? 'text-primary' : ''}" style="width: 20px;"></i>
                    <span>Dashboard</span>
                    ${currentPage.endsWith('/dashboard') ? '<div class="ms-auto bg-primary rounded-circle" style="width: 6px; height: 6px;"></div>' : ''}
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/inbound"
                   class="nav-link ${currentPage.endsWith('/inbound') ? 'active fw-medium text-primary' : 'text-secondary'} d-flex align-items-center gap-3 px-3 py-2 rounded-pill transition-all">
                    <i class="bi bi-box-arrow-in-down ${currentPage.endsWith('/inbound') ? 'text-primary' : ''}" style="width: 20px;"></i>
                    <span>Inbound</span>
                    ${currentPage.endsWith('/inbound') ? '<div class="ms-auto bg-primary rounded-circle" style="width: 6px; height: 6px;"></div>' : ''}
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/inventory"
                   class="nav-link ${currentPage.endsWith('/inventory') ? 'active fw-medium text-primary' : 'text-secondary'} d-flex align-items-center gap-3 px-3 py-2 rounded-pill transition-all">
                    <i class="bi bi-box-seam ${currentPage.endsWith('/inventory') ? 'text-primary' : ''}" style="width: 20px;"></i>
                    <span>Inventory</span>
                    ${currentPage.endsWith('/inventory') ? '<div class="ms-auto bg-primary rounded-circle" style="width: 6px; height: 6px;"></div>' : ''}
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/orders"
                   class="nav-link ${currentPage.endsWith('/orders') ? 'active fw-medium text-primary' : 'text-secondary'} d-flex align-items-center gap-3 px-3 py-2 rounded-pill transition-all">
                    <i class="bi bi-clipboard-check ${currentPage.endsWith('/orders') ? 'text-primary' : ''}" style="width: 20px;"></i>
                    <span>Orders</span>
                    ${currentPage.endsWith('/orders') ? '<div class="ms-auto bg-primary rounded-circle" style="width: 6px; height: 6px;"></div>' : ''}
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/shipping"
                   class="nav-link ${currentPage.endsWith('/shipping') ? 'active fw-medium text-primary' : 'text-secondary'} d-flex align-items-center gap-3 px-3 py-2 rounded-pill transition-all">
                    <i class="bi bi-truck ${currentPage.endsWith('/shipping') ? 'text-primary' : ''}" style="width: 20px;"></i>
                    <span>Shipping</span>
                    ${currentPage.endsWith('/shipping') ? '<div class="ms-auto bg-primary rounded-circle" style="width: 6px; height: 6px;"></div>' : ''}
                </a>
            </li>
        </ul>
    </div>

    <!-- Bottom Section with Theme Toggle -->
    <div class="p-4">
        <div class="d-flex align-items-center justify-content-between bg-light p-3 rounded-3">
            <div class="d-flex align-items-center gap-2">
                <div class="p-1">
                    <i class="bi bi-palette text-primary"></i>
                </div>
                <span class="small fw-medium">Theme Mode</span>
            </div>
            <div class="form-check form-switch mb-0">
                <input class="form-check-input" type="checkbox" role="switch" id="themeSwitch">
            </div>
        </div>
    </div>

    <style>
        .transition-all {
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            background-color: rgba(59, 130, 246, 0.08);
            color: #3B82F6 !important;
        }

        .nav-link:hover i {
            color: #3B82F6 !important;
        }

        .form-check-input:checked {
            background-color: #3B82F6;
            border-color: #3B82F6;
        }

        .form-check-input:focus {
            border-color: rgba(59, 130, 246, 0.5);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }
    </style>
</div>