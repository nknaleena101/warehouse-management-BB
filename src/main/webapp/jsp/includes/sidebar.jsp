<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="${requestScope['javax.servlet.forward.request_uri']}" />

<!-- Premium WMS Sidebar -->
<div class="d-flex flex-column h-100"
     style="width: 280px; height: 100vh; position: fixed; left: 0;
            background: linear-gradient(180deg, #ffffff 0%, #f9f9fb 100%);
            border-right: 1px solid rgba(0, 0, 0, 0.04);
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Helvetica Neue', sans-serif;
            overflow: hidden;">

    <!-- Decorative top area with gradient line -->
    <div style="height: 3px; background: linear-gradient(90deg, #007AFF, #5856D6, #FF2D55);"></div>

    <!-- Sidebar Header Area with gradient background -->
    <div style="background: linear-gradient(180deg, rgba(255,255,255,0.95) 0%, rgba(249,249,251,0.95) 100%); padding: 24px 0 12px; border-bottom: 1px solid rgba(0,0,0,0.03);">
        <div class="d-flex align-items-center justify-content-between px-4">
            <!-- Logo and title -->
            <div class="d-flex align-items-center">
                <!-- Modern cube logo -->
                <div style="width: 36px; height: 36px; position: relative; margin-right: 10px;">
                    <div style="position: absolute; width: 24px; height: 24px; background: linear-gradient(135deg, #007AFF 0%, #5AC8FA 100%); border-radius: 4px; transform: rotate(45deg); top: 6px; left: 6px;"></div>
                    <div style="position: absolute; width: 14px; height: 14px; background: white; border-radius: 2px; transform: rotate(45deg); top: 11px; left: 11px;"></div>
                </div>

                <div>
                    <h3 style="margin: 0; font-size: 18px; font-weight: 600; background: linear-gradient(90deg, #000000, #434343); -webkit-background-clip: text; color: transparent; letter-spacing: -0.5px;">WMS</h3>
                    <p style="margin: 0; font-size: 11px; color: #8E8E93; letter-spacing: 0.2px;">Warehouse System</p>
                </div>
            </div>

            <!-- Notification indicator -->
            <div style="position: relative;">
                <i class="bi bi-bell" style="font-size: 18px; color: #8E8E93;"></i>
                <span style="position: absolute; top: -4px; right: -4px; width: 8px; height: 8px; background-color: #FF3B30; border-radius: 50%; border: 2px solid white;"></span>
            </div>
        </div>
    </div>

    <!-- Search Area -->
    <div class="px-4 py-3">
        <div style="position: relative; width: 100%;">
            <input type="text" placeholder="Search..."
                   style="width: 100%; padding: 8px 15px 8px 35px; background-color: rgba(142, 142, 147, 0.08);
                   border: none; border-radius: 8px; font-size: 13px; color: #1C1C1E; transition: all 0.2s ease;" />
            <i class="bi bi-search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #8E8E93; font-size: 13px;"></i>
        </div>
    </div>

    <!-- Main Navigation Scroll Area -->
    <div class="flex-grow-1" style="overflow-y: auto; padding: 10px 16px;">
        <!-- Core section -->
        <div class="mb-4">
            <p style="font-size: 11px; font-weight: 500; text-transform: uppercase; letter-spacing: 0.8px; margin: 12px 0 8px 12px; color: #8E8E93;">
                Core
            </p>

            <!-- Dashboard item - Active -->
            <a href="${pageContext.request.contextPath}/dashboard" class="d-block position-relative mb-1 ${currentPage.endsWith('/dashboard') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/dashboard') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/dashboard') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-grid" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/dashboard') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Dashboard
                    </span>
                    ${currentPage.endsWith('/dashboard') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>

            <!-- Inbound -->
            <a href="${pageContext.request.contextPath}/inbound" class="d-block position-relative mb-1 ${currentPage.endsWith('/inbound') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/inbound') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/inbound') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-box-arrow-in-down" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/inbound') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Inbound
                    </span>
                    ${currentPage.endsWith('/inbound') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>

            <!-- Inventory -->
            <a href="${pageContext.request.contextPath}/inventory" class="d-block position-relative mb-1 ${currentPage.endsWith('/inventory') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/inventory') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/inventory') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-box-seam" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/inventory') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Inventory
                    </span>
                    ${currentPage.endsWith('/inventory') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>

            <!-- Orders -->
            <a href="${pageContext.request.contextPath}/orders" class="d-block position-relative mb-1 ${currentPage.endsWith('/orders') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/orders') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/orders') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-bag" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/orders') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Orders
                    </span>
                    ${currentPage.endsWith('/orders') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>

            <!-- Shipping -->
            <a href="${pageContext.request.contextPath}/shipping" class="d-block position-relative mb-1 ${currentPage.endsWith('/shipping') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/shipping') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/shipping') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-truck" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/shipping') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Shipping
                    </span>
                    ${currentPage.endsWith('/shipping') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>
        </div>

        <!-- Analytics section -->
        <div class="mb-4">
            <p style="font-size: 11px; font-weight: 500; text-transform: uppercase; letter-spacing: 0.8px; margin: 12px 0 8px 12px; color: #8E8E93;">
                Analytics
            </p>

            <!-- Reports -->
            <a href="${pageContext.request.contextPath}/reports" class="d-block position-relative mb-1 ${currentPage.endsWith('/reports') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/reports') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/reports') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-file-earmark-bar-graph" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/reports') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Reports
                    </span>
                    ${currentPage.endsWith('/reports') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>

            <!-- Analytics -->
            <a href="${pageContext.request.contextPath}/analytics" class="d-block position-relative mb-1 ${currentPage.endsWith('/analytics') ? 'active-nav-item' : ''}"
               style="text-decoration: none; transition: all 0.2s ease;">
                <div class="d-flex align-items-center p-3 rounded-3"
                     style="${currentPage.endsWith('/analytics') ? 'background: linear-gradient(90deg, rgba(0, 122, 255, 0.12), rgba(0, 122, 255, 0.04)); border-left: 3px solid #007AFF;' : 'border-left: 3px solid transparent;'}">
                    <div class="d-flex justify-content-center align-items-center"
                         style="width: 28px; height: 28px; border-radius: 8px; ${currentPage.endsWith('/analytics') ? 'background: linear-gradient(135deg, #007AFF, #5AC8FA); color: white;' : 'background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;'}">
                        <i class="bi bi-graph-up" style="font-size: 14px;"></i>
                    </div>
                    <span style="margin-left: 12px; font-size: 14px; font-weight: 500; ${currentPage.endsWith('/analytics') ? 'color: #007AFF;' : 'color: #1C1C1E;'}">
                        Analytics
                    </span>
                    ${currentPage.endsWith('/analytics') ? '<i class="bi bi-chevron-right" style="position: absolute; right: 16px; font-size: 12px; color: #007AFF;"></i>' : ''}
                </div>
            </a>
        </div>

        <!-- Quick Stats Section (new feature) -->
        <div class="mb-4">
            <p style="font-size: 11px; font-weight: 500; text-transform: uppercase; letter-spacing: 0.8px; margin: 12px 0 8px 12px; color: #8E8E93;">
                Quick Stats
            </p>

            <div class="d-flex gap-2 px-1 mb-2">
                <!-- Orders Stat -->
                <div class="flex-grow-1 p-3 rounded-4" style="background: linear-gradient(135deg, rgba(88, 86, 214, 0.08) 0%, rgba(88, 86, 214, 0.04) 100%); border: 1px solid rgba(88, 86, 214, 0.1);">
                    <div class="d-flex align-items-center mb-2">
                        <div class="d-flex justify-content-center align-items-center" style="width: 24px; height: 24px; border-radius: 6px; background-color: rgba(88, 86, 214, 0.1); color: #5856D6;">
                            <i class="bi bi-bag" style="font-size: 12px;"></i>
                        </div>
                        <span style="margin-left: 8px; font-size: 11px; color: #8E8E93;">Orders</span>
                    </div>
                    <p style="margin: 0; font-size: 16px; font-weight: 600; color: #1C1C1E;">156</p>
                </div>

                <!-- Shipments Stat -->
                <div class="flex-grow-1 p-3 rounded-4" style="background: linear-gradient(135deg, rgba(255, 45, 85, 0.08) 0%, rgba(255, 45, 85, 0.04) 100%); border: 1px solid rgba(255, 45, 85, 0.1);">
                    <div class="d-flex align-items-center mb-2">
                        <div class="d-flex justify-content-center align-items-center" style="width: 24px; height: 24px; border-radius: 6px; background-color: rgba(255, 45, 85, 0.1); color: #FF2D55;">
                            <i class="bi bi-truck" style="font-size: 12px;"></i>
                        </div>
                        <span style="margin-left: 8px; font-size: 11px; color: #8E8E93;">Shipments</span>
                    </div>
                    <p style="margin: 0; font-size: 16px; font-weight: 600; color: #1C1C1E;">32</p>
                </div>
            </div>

            <!-- Inventory Status (new feature) -->
            <div class="p-3 rounded-4" style="background: linear-gradient(135deg, rgba(52, 199, 89, 0.08) 0%, rgba(52, 199, 89, 0.04) 100%); border: 1px solid rgba(52, 199, 89, 0.1);">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <div class="d-flex align-items-center">
                        <div class="d-flex justify-content-center align-items-center" style="width: 24px; height: 24px; border-radius: 6px; background-color: rgba(52, 199, 89, 0.1); color: #34C759;">
                            <i class="bi bi-box-seam" style="font-size: 12px;"></i>
                        </div>
                        <span style="margin-left: 8px; font-size: 11px; color: #8E8E93;">Inventory</span>
                    </div>
                    <span style="font-size: 12px; font-weight: 500; color: #34C759;">Healthy</span>
                </div>
                <!-- Progress bar -->
                <div style="height: 6px; width: 100%; background-color: rgba(142, 142, 147, 0.1); border-radius: 3px; overflow: hidden; margin-bottom: 8px;">
                    <div style="height: 100%; width: 76%; background-color: #34C759; border-radius: 3px;"></div>
                </div>
                <div class="d-flex justify-content-between" style="font-size: 11px;">
                    <span style="color: #8E8E93;">24,560 items</span>
                    <span style="color: #1C1C1E; font-weight: 500;">76%</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Area -->
    <div style="border-top: 1px solid rgba(0,0,0,0.04); padding: 16px; background-color: rgba(249,249,251,0.95);">
        <!-- Theme Toggle -->
        <div class="d-flex align-items-center justify-content-between mb-3">
            <div class="d-flex align-items-center">
                <div class="d-flex justify-content-center align-items-center me-2"
                     style="width: 24px; height: 24px; border-radius: 6px; background-color: rgba(142, 142, 147, 0.08); color: #8E8E93;">
                    <i class="bi bi-sun" style="font-size: 14px;"></i>
                </div>
                <span style="font-size: 13px; color: #1C1C1E;">Appearance</span>
            </div>

            <!-- Apple-style switch -->
            <label class="ios-switch">
                <input type="checkbox">
                <span></span>
            </label>
        </div>

        <!-- User profile card -->
        <div class="d-flex align-items-center p-2 rounded-4"
             style="background: linear-gradient(135deg, rgba(0, 122, 255, 0.04) 0%, rgba(90, 200, 250, 0.04) 100%); border: 1px solid rgba(0, 122, 255, 0.1);">
            <div style="width: 38px; height: 38px; border-radius: 38px; overflow: hidden; background: linear-gradient(135deg, #007AFF, #5AC8FA); display: flex; align-items: center; justify-content: center; color: white; font-weight: 500; font-size: 14px;">
                JD
            </div>
            <div class="ms-3">
                <p style="margin: 0; font-size: 13px; font-weight: 500; color: #1C1C1E;">John Doe</p>
                <p style="margin: 0; font-size: 12px; color: #8E8E93;">Administrator</p>
            </div>
            <div class="ms-auto">
                <button type="button" class="btn btn-sm p-1"
                        style="background-color: rgba(142, 142, 147, 0.08); border: none; border-radius: 50%; width: 28px; height: 28px; display: flex; align-items: center; justify-content: center;">
                    <i class="bi bi-three-dots" style="font-size: 14px; color: #8E8E93;"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Custom CSS -->
<style>
    /* Better font rendering */
    * {
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        box-sizing: border-box;
    }

    /* Custom scrollbar */
    ::-webkit-scrollbar {
        width: 6px;
    }

    ::-webkit-scrollbar-track {
        background: transparent;
    }

    ::-webkit-scrollbar-thumb {
        background: rgba(142, 142, 147, 0.2);
        border-radius: 3px;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: rgba(142, 142, 147, 0.4);
    }

    /* Nav item hover effect */
    a.d-block:not(.active-nav-item):hover .rounded-3 {
        background-color: rgba(142, 142, 147, 0.08);
        transform: translateX(3px);
    }

    /* iOS style switch */
    .ios-switch {
        position: relative;
        display: inline-block;
        width: 42px;
        height: 24px;
    }

    .ios-switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }

    .ios-switch span {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #e4e4e4;
        transition: .3s;
        border-radius: 24px;
    }

    .ios-switch span:before {
        position: absolute;
        content: "";
        height: 20px;
        width: 20px;
        left: 2px;
        bottom: 2px;
        background-color: white;
        box-shadow: 0 1px 3px rgba(0,0,0,0.15);
        transition: .3s;
        border-radius: 50%;
    }

    .ios-switch input:checked + span {
        background-color: #007AFF;
    }

    .ios-switch input:checked + span:before {
        transform: translateX(18px);
    }

    /* Focus states */
    input:focus, button:focus, a:focus {
        outline: none;
    }

    /* Smooth transitions */
    .d-flex, .d-block, button, input, a {
        transition: all 0.2s ease;
    }

    /* Input focus effect */
    input:focus {
        background-color: rgba(142, 142, 147, 0.12) !important;
        box-shadow: 0 0 0 3px rgba(0, 122, 255, 0.1);
    }
</style>