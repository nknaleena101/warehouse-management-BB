<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="${requestScope['javax.servlet.forward.request_uri']}" />

<div class="d-flex flex-column justify-content-between bg-white text-dark shadow-sm" style="width: 260px; height: 100vh; position: fixed; left: 0; border-radius: 20px 0 0 20px;">
    <!-- Top Logo -->
    <div>
        <div class="text-center py-4">
            <h4 class="fw-bold">WMS</h4>
        </div>

        <!-- Nav Links -->
        <ul class="nav flex-column px-3">
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/dashboard"
                   class="nav-link ${currentPage.endsWith('/dashboard') ? 'active bg-warning-subtle' : ''} d-flex align-items-center gap-2 px-3 py-2">
                    <i class="bi bi-grid-fill"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/inbound"
                   class="nav-link ${currentPage.endsWith('/inbound') ? 'active bg-warning-subtle' : ''} d-flex align-items-center gap-2 px-3 py-2">
                    <i class="bi-box-arrow-in-down"></i>
                    <span>Inbound</span>
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/inventory"
                   class="nav-link ${currentPage.endsWith('/inventory') ? 'active bg-warning-subtle' : ''} d-flex align-items-center gap-2 px-3 py-2">
                    <i class="bi bi-box-seam"></i>
                    <span>Inventory</span>
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/orders"
                   class="nav-link ${currentPage.endsWith('/orders') ? 'active bg-warning-subtle' : ''} d-flex align-items-center gap-2 px-3 py-2">
                    <i class="bi bi-box-seam"></i>
                    <span>Orders</span>
                </a>
            </li>
            <li class="nav-item mb-2">
                <a href="${pageContext.request.contextPath}/shipping"
                   class="nav-link ${currentPage.endsWith('/shipping') ? 'active bg-warning-subtle' : ''} d-flex align-items-center gap-2 px-3 py-2">
                    <i class="bi bi-box-seam"></i>
                    <span>Shipping</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Bottom Theme Toggle -->
    <div class="d-flex justify-content-around align-items-center px-3 pb-3">
        <div class="btn-group border rounded-pill bg-light w-10" role="group">
            <button type="button" class="btn btn-warning rounded-start-pill"><i class="bi bi-sun-fill"></i></button>
            <button type="button" class="btn btn-light text-muted rounded-end-pill"><i class="bi bi bi-moon-fill"></i></button>
        </div>
    </div>
</div>
