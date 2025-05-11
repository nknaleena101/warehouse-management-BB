<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inbound Processing - WMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .process-step {
            position: relative;
            padding-left: 30px;
            margin-bottom: 30px;
        }
        .process-step:before {
            content: "";
            position: absolute;
            left: 10px;
            top: 0;
            bottom: 0;
            width: 2px;
            background-color: #dee2e6;
        }
        .process-step.active:before {
            background-color: #0d6efd;
        }
        .step-number {
            position: absolute;
            left: 0;
            width: 22px;
            height: 22px;
            line-height: 22px;
            text-align: center;
            border-radius: 50%;
            background-color: #dee2e6;
            color: #495057;
            font-weight: bold;
            font-size: 12px;
        }
        .process-step.active .step-number {
            background-color: #0d6efd;
            color: white;
        }
        .inspection-item {
            border-left: 3px solid #dee2e6;
            padding-left: 15px;
            margin-bottom: 15px;
        }
        .inspection-item.checked {
            border-left-color: #198754;
        }
        .location-selector {
            cursor: pointer;
            transition: all 0.2s;
        }
        .location-selector:hover {
            transform: scale(1.02);
        }
        .location-selector.selected {
            border: 2px solid #0d6efd !important;
            background-color: #f0f7ff;
        }
    </style>
</head>
<body class="d-flex" data-bs-theme="light">
    <%@ include file="/jsp/includes/sidebar.jsp" %>

    <div class="main-content container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Inbound Processing</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createAsnModal">
                <i class="bi bi-plus-circle"></i> Create ASN
            </button>
        </div>

        <!-- Process Steps -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="process-step active">
                    <span class="step-number">1</span>
                    <h4>Receive Goods</h4>

                    <div class="mb-3">
                        <label class="form-label">Select ASN</label>
                        <select class="form-select" id="asnSelect">
                            <option selected disabled>Choose ASN...</option>
                            <c:forEach items="${pendingAsns}" var="asn">
                                <option value="${asn.asnId}">
                                    ASN#${asn.asnId} - ${asn.supplierName} (Expected: <fmt:formatDate value="${asn.expectedDeliveryDate}" pattern="yyyy-MM-dd"/>)
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div id="asnDetails" class="d-none">
                        <h5 class="mb-3">ASN Items</h5>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Expected Qty</th>
                                    <th>Received Qty</th>
                                </tr>
                            </thead>
                            <tbody id="asnItemsTable">
                                <!-- Will be populated by JavaScript -->
                            </tbody>
                        </table>

                        <div class="d-flex justify-content-end">
                            <button class="btn btn-success" id="confirmReceiptBtn">
                                <i class="bi bi-check-circle"></i> Confirm Receipt
                            </button>
                        </div>
                    </div>
                </div>

                <div class="process-step" id="inspectionStep">
                    <span class="step-number">2</span>
                    <h4>Inspection</h4>

                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> Please verify the condition of received items
                    </div>

                    <div id="inspectionChecklist" class="mb-3">
                        <!-- Will be populated by JavaScript -->
                    </div>

                    <div class="d-flex justify-content-end">
                        <button class="btn btn-success" id="completeInspectionBtn" disabled>
                            <i class="bi bi-check-circle"></i> Complete Inspection
                        </button>
                    </div>
                </div>

                <div class="process-step" id="putawayStep">
                    <span class="step-number">3</span>
                    <h4>Putaway</h4>

                    <div class="row">
                        <div class="col-md-6">
                            <h5>Select Storage Location</h5>
                            <div class="mb-3">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" class="form-control" placeholder="Search locations..." id="locationSearch">
                                </div>
                            </div>

                            <div class="row g-2" id="locationGrid">
                                <!-- Sample locations - would normally come from database -->
                                <div class="col-6 col-md-4">
                                    <div class="card location-selector p-2 text-center" data-location="A-01-01">
                                        <i class="bi bi-pallet fs-3"></i>
                                        <div class="fw-bold">A-01-01</div>
                                        <small class="text-muted">Empty</small>
                                    </div>
                                </div>
                                <div class="col-6 col-md-4">
                                    <div class="card location-selector p-2 text-center" data-location="A-01-02">
                                        <i class="bi bi-pallet fs-3"></i>
                                        <div class="fw-bold">A-01-02</div>
                                        <small class="text-muted">Empty</small>
                                    </div>
                                </div>
                                <!-- More locations would be here -->
                            </div>
                        </div>

                        <div class="col-md-6">
                            <h5>Assignment Summary</h5>
                            <div class="card">
                                <div class="card-body">
                                    <table class="table table-sm" id="assignmentTable">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Qty</th>
                                                <th>Location</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Will be populated by JavaScript -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-3">
                        <button class="btn btn-success" id="completePutawayBtn" disabled>
                            <i class="bi bi-check-circle"></i> Complete Putaway
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Create ASN Modal -->
    <div class="modal fade" id="createAsnModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Create New ASN</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="asnForm">
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
                                    <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
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
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="submitAsnBtn">Submit ASN</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JavaScript for the inbound processing will go here
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize the page
            const savedTheme = localStorage.getItem('theme') || 'light';
            document.documentElement.setAttribute('data-bs-theme', savedTheme);

            // ASN selection handler
            document.getElementById('asnSelect').addEventListener('change', function() {
                const asnId = this.value;
                if (asnId) {
                    // In a real app, this would fetch from server
                    fetchAsnDetails(asnId);
                    document.getElementById('asnDetails').classList.remove('d-none');
                } else {
                    document.getElementById('asnDetails').classList.add('d-none');
                }
            });

            // Confirm receipt handler
            document.getElementById('confirmReceiptBtn').addEventListener('click', function() {
                document.getElementById('inspectionStep').classList.add('active');
                initializeInspection();
            });

            // Complete inspection handler
            document.getElementById('completeInspectionBtn').addEventListener('click', function() {
                document.getElementById('putawayStep').classList.add('active');
                initializePutaway();
            });

            // Location selection handler
            document.querySelectorAll('.location-selector').forEach(el => {
                el.addEventListener('click', function() {
                    document.querySelectorAll('.location-selector').forEach(loc =>
                        loc.classList.remove('selected'));
                    this.classList.add('selected');
                    // Update assignment table
                    updateAssignmentTable();
                });
            });

            // Add item to ASN form
            document.getElementById('addItemBtn').addEventListener('click', addItemRow);

            // Submit ASN form
            document.getElementById('submitAsnBtn').addEventListener('click', submitAsn);
        });

        function fetchAsnDetails(asnId) {
            // Simulate fetching ASN details
            const items = [
                { productId: 101, productName: "Men's T-Shirt (Black, L)", expectedQty: 50 },
                { productId: 205, productName: "Women's Jeans (Blue, 32)", expectedQty: 30 },
                { productId: 312, productName: "Unisex Hoodie (Gray, M)", expectedQty: 20 }
            ];

            const tableBody = document.getElementById('asnItemsTable');
            tableBody.innerHTML = '';

            items.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${item.productName}</td>
                    <td>${item.expectedQty}</td>
                    <td><input type="number" class="form-control form-control-sm received-qty"
                         min="0" max="${item.expectedQty}" value="${item.expectedQty}"></td>
                `;
                tableBody.appendChild(row);
            });
        }

        function initializeInspection() {
            const checklist = document.getElementById('inspectionChecklist');
            checklist.innerHTML = `
                <div class="inspection-item">
                    <div class="form-check">
                        <input class="form-check-input inspection-checkbox" type="checkbox" id="check1">
                        <label class="form-check-label" for="check1">
                            All items match the ASN description
                        </label>
                    </div>
                </div>
                <div class="inspection-item">
                    <div class="form-check">
                        <input class="form-check-input inspection-checkbox" type="checkbox" id="check2">
                        <label class="form-check-label" for="check2">
                            Quantities match the ASN
                        </label>
                    </div>
                </div>
                <div class="inspection-item">
                    <div class="form-check">
                        <input class="form-check-input inspection-checkbox" type="checkbox" id="check3">
                        <label class="form-check-label" for="check3">
                            No visible damage to packaging
                        </label>
                    </div>
                </div>
                <div class="inspection-item">
                    <div class="form-check">
                        <input class="form-check-input inspection-checkbox" type="checkbox" id="check4">
                        <label class="form-check-label" for="check4">
                            Product quality meets standards
                        </label>
                    </div>
                </div>
            `;

            // Enable/disable complete button based on checkboxes
            document.querySelectorAll('.inspection-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    const allChecked = Array.from(document.querySelectorAll('.inspection-checkbox'))
                        .every(cb => cb.checked);
                    document.getElementById('completeInspectionBtn').disabled = !allChecked;

                    // Visual feedback
                    this.closest('.inspection-item').classList.toggle('checked', this.checked);
                });
            });
        }

        function initializePutaway() {
            // In a real app, this would fetch suggested locations based on product types
            updateAssignmentTable();
        }

        function updateAssignmentTable() {
            const tableBody = document.querySelector('#assignmentTable tbody');
            tableBody.innerHTML = '';

            // Sample data - in real app this would come from the ASN and selected locations
            const assignments = [
                { productId: 101, productName: "Men's T-Shirt (Black, L)", quantity: 50, location: "A-01-01" },
                { productId: 205, productName: "Women's Jeans (Blue, 32)", quantity: 30, location: "A-01-02" }
            ];

            assignments.forEach(assign => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${assign.productName}</td>
                    <td>${assign.quantity}</td>
                    <td>${assign.location}</td>
                `;
                tableBody.appendChild(row);
            });

            // Enable complete button if all items have locations
            document.getElementById('completePutawayBtn').disabled = assignments.some(a => !a.location);
        }

        function addItemRow() {
            const container = document.getElementById('asnItemsContainer');
            const newItem = document.createElement('div');
            newItem.className = 'row asn-item mb-2';
            newItem.innerHTML = `
                <div class="col-md-5">
                    <select class="form-select" name="productId" required>
                        <option value="">Select Product</option>
                        ${Array.from(document.querySelectorAll('#asnItemsContainer select[name="productId"] option'))
                            .filter(opt => opt.value)
                            .map(opt => opt.outerHTML)
                            .join('')}
                    </select>
                </div>
                <div class="col-md-5">
                    <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
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
        }

        function submitAsn() {
            // Validate form
            const form = document.getElementById('asnForm');
            if (!form.checkValidity()) {
                form.classList.add('was-validated');
                return;
            }

            // Collect form data
            const formData = {
                supplierName: form.elements['supplierName'].value,
                expectedDeliveryDate: form.elements['expectedDeliveryDate'].value,
                items: []
            };

            document.querySelectorAll('.asn-item').forEach(item => {
                formData.items.push({
                    productId: item.querySelector('[name="productId"]').value,
                    quantity: item.querySelector('[name="quantity"]').value
                });
            });

            // In a real app, you would send this to the server
            console.log('Submitting ASN:', formData);

            // Close modal and refresh ASN list
            bootstrap.Modal.getInstance(document.getElementById('createAsnModal')).hide();
            alert('ASN created successfully!');
            // In a real app, you would refresh the ASN select dropdown
        }
    </script>
</body>
</html>