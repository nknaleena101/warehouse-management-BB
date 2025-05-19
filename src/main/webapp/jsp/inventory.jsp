<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory - WMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .main-content {
            margin-left: 260px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/jsp/includes/sidebar.jsp" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Inventory</h2>
                <div>
                    <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#viewLocationsModal">
                        <i class="bi bi-eye"></i> View Locations
                    </button>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createLocationModal">
                        Create New Location
                    </button>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Product ID</th>
                                    <th>Quantity</th>
                                    <th>Location</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${inventoryList}">
                                    <tr>
                                        <td>${item.product_id}</td>
                                        <td>${item.quantity}</td>
                                        <td>${item.location}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary me-2">
                                                <i class="bi bi-pencil"></i> Edit
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty inventoryList}">
                                    <tr>
                                        <td colspan="4" class="text-center">No inventory items with Putaway Complete status found</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    <!-- Create Location Modal -->
    <div class="modal fade" id="createLocationModal" tabindex="-1" aria-labelledby="createLocationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createLocationModalLabel">Create New Location</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="locationForm" action="createLocation" method="POST">
                    <div class="modal-body">
                    <div class="row">
                                                <div class="col-md-4 mb-3">
                                                    <label for="zone" class="form-label">Zone</label>
                                                    <select class="form-select" id="zone" name="zone" required>
                                                        <option value="">Select Zone</option>
                                                        <option value="A">Zone A</option>
                                                        <option value="B">Zone B</option>
                                                        <option value="C">Zone C</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="rack" class="form-label">Rack</label>
                                                    <input type="number" class="form-control" id="rack" name="rack" min="1" required>
                                                </div>
                                                <div class="col-md-4 mb-3">
                                                    <label for="shelf" class="form-label">Shelf</label>
                                                    <input type="number" class="form-control" id="shelf" name="shelf" min="1" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-primary">Save Location</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- View Locations Modal -->
                        <div class="modal fade" id="viewLocationsModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">All Locations</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead class="table-dark">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Zone</th>
                                                        <th>Rack</th>
                                                        <th>Shelf</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="locationsTableBody">
                                                    <!-- Data will be inserted here -->
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

                        <!-- jQuery first -->
                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                        <!-- Then Bootstrap JS -->
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


                        <script>
                        $(document).ready(function() {
                            // Handle form submission
                            $('#locationForm').on('submit', function(e) {
                                e.preventDefault();

                                $.ajax({
                                    type: 'POST',
                                    url: 'createLocation',
                                    data: $(this).serialize(),
                                    success: function(response) {
                                        $('#createLocationModal').modal('hide');
                                        // Show success message
                                        alert('Location created successfully!');
                                        // Refresh the page to show the new location
                                        window.location.reload();
                                    },
                                    error: function(xhr) {
                                        alert('Error creating location: ' + xhr.responseText);
                                    }
                                });
                            });
                            // Clear form when modal is closed
                                    $('#createLocationModal').on('hidden.bs.modal', function() {
                                        $('#locationForm')[0].reset();
                                    });
                                });
                                </script>

                                <script>
                                $(document).ready(function() {
                                    // Load locations when modal opens
                                    $('#viewLocationsModal').on('show.bs.modal', function() {
                                        console.log("Loading locations...");

                                        $.ajax({
                                            url: 'getLocations',
                                            type: 'GET',
                                            dataType: 'json',
                                            success: function(data) {
                                                console.log("Received data:", data);

                                                var tableBody = $('#locationsTableBody');
                                                tableBody.empty(); // Clear existing rows

                                                if(data && data.length > 0) {
                                                    // Add each location as a table row
                                                    $.each(data, function(index, location) {
                                                        var row = $('<tr>');
                                                        row.append($('<td>').text(location.locationId));
                                                        row.append($('<td>').text(location.zone));
                                                        row.append($('<td>').text(location.rack));
                                                        row.append($('<td>').text(location.shelf));
                                                        tableBody.append(row);
                                                    });
                                                } else {
                                                    // Show message if no locations found
                                                    tableBody.append(
                                                        '<tr><td colspan="4" class="text-center">No locations found</td></tr>'
                                                    );
                                                }
                                            },
                                            error: function(xhr, status, error) {
                                                console.error("Error loading locations:", error);
                                                $('#locationsTableBody').html(
                                                    '<tr><td colspan="4" class="text-center text-danger">Error loading locations</td></tr>'
                                                );
                                            }
                                        });
                                    });
                                });
                                </script>
                            </body>
                            </html>