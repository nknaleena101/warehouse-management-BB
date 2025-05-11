<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inbound Processing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .main-content {
            margin-left: 260px;
            padding: 20px;
        }
        .process-step {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .step-header {
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        .quality-checklist {
            margin-left: 20px;
        }
        .location-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }
        .location-cell {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: center;
            cursor: pointer;
            border-radius: 5px;
        }
        .location-cell:hover {
            background-color: #f8f9fa;
        }
        .location-cell.selected {
            background-color: #e9ecef;
            border-color: #adb5bd;
        }
    </style>
</head>
<body>
    <%@ include file="/jsp/includes/sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Inbound Processing</h2>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createASNModal">
                <i class="bi bi-plus-circle"></i> Create ASN
            </button>
        </div>

        <!-- Process Steps -->
        <div class="process-step">
            <div class="step-header">
                <h4>1. Receive Goods</h4>
            </div>
            <form id="receiveGoodsForm">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="asnSelect" class="form-label">Select ASN</label>
                        <select class="form-select" id="asnSelect" required>
                            <option value="" selected disabled>Choose ASN...</option>
                            <c:forEach items="${pendingASNs}" var="asn">
                                <option value="${asn.asnId}">ASN-${asn.asnId} - ${asn.supplierName} (Expected: ${asn.expectedDeliveryDate})</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <button type="button" class="btn btn-success" id="receiveGoodsBtn" disabled>Receive Goods</button>
            </form>
        </div>

        <div class="process-step" id="inspectionSection" style="display: none;">
            <div class="step-header">
                <h4>2. Inspection</h4>
            </div>
            <form id="inspectionForm">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="inspectorName" class="form-label">Inspector Name</label>
                        <input type="text" class="form-control" id="inspectorName" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="inspectionNotes" class="form-label">Inspection Notes</label>
                        <textarea class="form-control" id="inspectionNotes" rows="3"></textarea>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Quality Checklist</label>
                        <div class="quality-checklist">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="quantityCheck">
                                <label class="form-check-label" for="quantityCheck">Quantities match ASN</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="qualityCheck">
                                <label class="form-check-label" for="qualityCheck">Product quality meets standards</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="packagingCheck">
                                <label class="form-check-label" for="packagingCheck">Packaging is undamaged</label>
                            </div>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-success" id="completeInspectionBtn">Complete Inspection</button>
            </form>
        </div>

        <div class="process-step" id="putawaySection" style="display: none;">
            <div class="step-header">
                <h4>3. Putaway</h4>
            </div>
            <form id="putawayForm">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="locationSearch" class="form-label">Search Storage Locations</label>
                        <input type="text" class="form-control" id="locationSearch" placeholder="Search locations...">
                    </div>
                </div>

                <div class="mb-3">
                    <h5>Select Storage Location</h5>
                    <div class="location-grid">
                        <div class="location-cell" data-location="A-01-01">A-01-01<br>Energy</div>
                        <div class="location-cell" data-location="A-01-02">A-01-02<br>Energy</div>
                        <div class="location-cell" data-location="B-02-01">B-02-01<br>Electronics</div>
                        <div class="location-cell" data-location="B-02-02">B-02-02<br>Electronics</div>
                    </div>
                </div>

                <div class="mb-3">
                    <h5>Assignment Summary</h5>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Location</th>
                            </tr>
                        </thead>
                        <tbody id="assignmentSummary">
                            <!-- Will be populated dynamically -->
                        </tbody>
                    </table>
                </div>

                <button type="button" class="btn btn-success" id="completePutawayBtn">Complete Putaway</button>
            </form>
        </div>

        <!-- Create ASN Modal -->
        <div class="modal fade" id="createASNModal" tabindex="-1" aria-labelledby="createASNModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createASNModalLabel">Create Advanced Shipping Notice</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="asnForm">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="supplierName" class="form-label">Supplier Name</label>
                                    <input type="text" class="form-control" id="supplierName" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="expectedDeliveryDate" class="form-label">Expected Delivery Date</label>
                                    <input type="date" class="form-control" id="expectedDeliveryDate" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <h5>Items</h5>
                                <div id="itemsContainer">
                                    <div class="item-row row mb-2">
                                        <div class="col-md-5">
                                            <select class="form-select product-select" required>
                                                <option value="" selected disabled>Select Product</option>
                                                <c:forEach items="${products}" var="product">
                                                    <option value="${product.productId}">${product.productName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="number" class="form-control quantity-input" placeholder="Quantity" min="1" required>
                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-danger btn-sm remove-item-btn" disabled>
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-secondary btn-sm mt-2" id="addItemBtn">
                                    <i class="bi bi-plus"></i> Add Item
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" id="submitASNBtn">Create ASN</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // ASN Creation
            let itemCount = 1;

            // Add item row
            $('#addItemBtn').click(function() {
                itemCount++;
                const newRow = `
                    <div class="item-row row mb-2">
                        <div class="col-md-5">
                            <select class="form-select product-select" required>
                                <option value="" selected disabled>Select Product</option>
                                <c:forEach items="${products}" var="product">
                                    <option value="${product.productId}">${product.productName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <input type="number" class="form-control quantity-input" placeholder="Quantity" min="1" required>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-danger btn-sm remove-item-btn">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </div>
                `;
                $('#itemsContainer').append(newRow);

                // Enable remove buttons if there's more than one item
                if (itemCount > 1) {
                    $('.remove-item-btn').prop('disabled', false);
                }
            });

            // Remove item row
            $(document).on('click', '.remove-item-btn', function() {
                if (itemCount > 1) {
                    $(this).closest('.item-row').remove();
                    itemCount--;

                    // Disable remove buttons if only one item left
                    if (itemCount === 1) {
                        $('.remove-item-btn').prop('disabled', true);
                    }
                }
            });

            // Submit ASN
            $('#submitASNBtn').click(function() {
                const supplierName = $('#supplierName').val();
                const expectedDeliveryDate = $('#expectedDeliveryDate').val();

                if (!supplierName || !expectedDeliveryDate) {
                    alert('Please fill in all required fields');
                    return;
                }

                const items = [];
                let isValid = true;

                $('.item-row').each(function() {
                    const productId = $(this).find('.product-select').val();
                    const quantity = $(this).find('.quantity-input').val();

                    if (!productId || !quantity) {
                        isValid = false;
                        return false; // break loop
                    }

                    items.push({
                        productId: parseInt(productId),
                        quantity: parseInt(quantity)
                    });
                });

                if (!isValid || items.length === 0) {
                    alert('Please add at least one valid item');
                    return;
                }

                const asnData = {
                    supplierName: supplierName,
                    expectedDeliveryDate: expectedDeliveryDate,
                    items: items
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/asn/create',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(asnData),
                    success: function(response) {
                        alert('ASN created successfully');
                        $('#createASNModal').modal('hide');
                        location.reload(); // Refresh to show new ASN
                    },
                    error: function(xhr) {
                        alert('Error creating ASN: ' + xhr.responseText);
                    }
                });
            });

            // Receive Goods
            $('#asnSelect').change(function() {
                if ($(this).val()) {
                    $('#receiveGoodsBtn').prop('disabled', false);
                } else {
                    $('#receiveGoodsBtn').prop('disabled', true);
                }
            });

            $('#receiveGoodsBtn').click(function() {
                const asnId = $('#asnSelect').val();

                $.ajax({
                    url: '${pageContext.request.contextPath}/inbound/receive',
                    type: 'POST',
                    data: { asnId: asnId },
                    success: function(response) {
                        $('#inspectionSection').show();
                        $('#asnSelect').prop('disabled', true);
                        $('#receiveGoodsBtn').prop('disabled', true);
                    },
                    error: function(xhr) {
                        alert('Error receiving goods: ' + xhr.responseText);
                    }
                });
            });

            // Inspection
            $('#completeInspectionBtn').click(function() {
                const inspectorName = $('#inspectorName').val();
                const inspectionNotes = $('#inspectionNotes').val();
                const asnId = $('#asnSelect').val();

                if (!inspectorName) {
                    alert('Please enter inspector name');
                    return;
                }

                const passed = $('#quantityCheck').is(':checked') &&
                              $('#qualityCheck').is(':checked') &&
                              $('#packagingCheck').is(':checked');

                const inspectionData = {
                    asnId: asnId,
                    inspectorName: inspectorName,
                    notes: inspectionNotes,
                    passed: passed
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/inbound/inspect',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(inspectionData),
                    success: function(response) {
                        $('#putawaySection').show();
                    },
                    error: function(xhr) {
                        alert('Error completing inspection: ' + xhr.responseText);
                    }
                });
            });

            // Putaway
            let selectedLocation = null;

            $('.location-cell').click(function() {
                $('.location-cell').removeClass('selected');
                $(this).addClass('selected');
                selectedLocation = $(this).data('location');

                // Update assignment summary
                $('#assignmentSummary').html(`
                    <tr>
                        <td>Oxy</td>
                        <td>100</td>
                        <td>${selectedLocation}</td>
                    </tr>
                `);
            });

            $('#completePutawayBtn').click(function() {
                if (!selectedLocation) {
                    alert('Please select a location');
                    return;
                }

                const asnId = $('#asnSelect').val();
                const putawayData = {
                    asnId: asnId,
                    location: selectedLocation
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/inbound/putaway',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(putawayData),
                    success: function(response) {
                        alert('Putaway completed successfully');
                        location.reload(); // Refresh the page
                    },
                    error: function(xhr) {
                        alert('Error completing putaway: ' + xhr.responseText);
                    }
                });
            });
        });
    </script>
</body>
</html>