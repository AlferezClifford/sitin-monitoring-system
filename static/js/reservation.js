// Wait for the DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Get the data passed from Flask
    const data = window.RESERVATION_DATA || {
        studentRecord: null,
        purposes: [],
        labIds: [],
        grouped: {},
        reservation: []  // Add initial reservation data
    };

    // Initialize student record if available
    if (data.studentRecord) {
        document.getElementById('idNo').value = data.studentRecord[0];  // idno
        document.getElementById('fullName').value = data.studentRecord[1];  // fullname
        document.getElementById('remainingSessions').value = data.studentRecord[2];  // remaining sessions
    }

    // Initialize reservation table with initial data
    if (data.reservation && Array.isArray(data.reservation)) {
        updateReservationTable(data.reservation);
    }

    // Handle ID number input to fetch student data
    document.getElementById('idNo').addEventListener('input', async function(e) {
        const idNo = e.target.value;
        if (idNo) {
            try {
                const response = await fetch(`/api/student/${idNo}`);
                const studentData = await response.json();
                
                if (studentData) {
                    document.getElementById('fullName').value = studentData.fullname;
                    document.getElementById('remainingSessions').value = studentData.remaining_sessions;
                }
            } catch (error) {
                console.error('Error fetching student data:', error);
            }
        }
    });

    // Populate purpose dropdown
    const purposeSelect = document.getElementById('purpose');
    if (data.purposes.length > 0) {
        data.purposes.forEach(purpose => {
            const option = document.createElement('option');
            option.value = purpose[0];  // key (1,2,3,4)
            option.textContent = purpose[1];  // purpose name (e.g., programming lang)
            purposeSelect.appendChild(option);
        });
    }

    // Populate laboratory dropdown
    const labSelect = document.getElementById('laboratory');
    if (data.labIds.length > 0) {
        data.labIds.forEach(labId => {
            const option = document.createElement('option');
            option.value = labId;
            option.textContent = `Laboratory ${labId}`;
            labSelect.appendChild(option);
        });
    }

    // Handle laboratory selection to update PC grid
    labSelect.addEventListener('change', function() {
        const labId = this.value;
        if (labId && data.grouped[labId]) {
            displayPCs(data.grouped[labId]);
        }
    });

    // Function to display PC buttons
    function displayPCs(pcs) {
        const pcGrid = document.querySelector('.pc-list-grid');
        pcGrid.innerHTML = '';
        
        pcs.forEach(pcNumber => {
            const pcButton = document.createElement('button');
            pcButton.type = 'button';
            pcButton.className = 'pc-btn';
            pcButton.textContent = `PC-${pcNumber}`;
            pcButton.dataset.pc = pcNumber;
            
            pcButton.addEventListener('click', function() {
                // Remove selection from other buttons
                document.querySelectorAll('.pc-btn.selected').forEach(btn => {
                    btn.classList.remove('selected');
                });
                // Add selection to clicked button
                this.classList.add('selected');
            });
            
            pcGrid.appendChild(pcButton);
        });
    }

    // Function to update reservation table
    function updateReservationTable(reservations) {
        const tableBody = document.getElementById('reservationTableBody');
        if (!tableBody) {
            console.error('Reservation table body not found');
            return;
        }
        
        tableBody.innerHTML = '';
        
        if (!reservations || !Array.isArray(reservations)) {
            console.error('Invalid reservations data:', reservations);
            return;
        }

        console.log('Updating table with reservations:', reservations);  // Debug log

        reservations.forEach(reservation => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${reservation[0] || ''}</td>  <!-- type_of_purpose -->
                <td>Lab ${reservation[1] || ''}</td>  <!-- lab_id -->
                <td>PC-${reservation[2] || ''}</td>  <!-- pc_id -->
                <td>${reservation[3] || ''}</td>  <!-- res_date -->
                <td>${reservation[4] || ''}</td>  <!-- reserv_time -->
                <td><span class="badge ${reservation[5] === 'Confirmed' ? 'bg-success' : 'bg-warning'}">${reservation[5] || 'Pending'}</span></td>  <!-- status -->
            `;
            tableBody.appendChild(row);
        });
    }

    // Handle form submission
    document.getElementById('reservationForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        // Validate PC selection
        const selectedPC = document.querySelector('.pc-btn.selected');
        if (!selectedPC) {
            alert('Please select a PC');
            return;
        }
        
        // Collect form data
        const formData = {
            idNo: document.getElementById('idNo').value,
            purpose: document.getElementById('purpose').value,
            laboratory: document.getElementById('laboratory').value,
            selectedPC: selectedPC.dataset.pc,
            date: document.getElementById('date').value,
            time: document.getElementById('timeIn').value
        };
        
        try {
            // Send reservation data to server
            const response = await fetch('/reservation/submit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });
            
            const result = await response.json();
            if (result.status === 'success') {
                // Update the reservation table with new data
                if (result.reservations) {
                    updateReservationTable(result.reservations);
                }
                
                // Show success message
                const successAlert = document.createElement('div');
                successAlert.className = 'alert alert-success alert-dismissible fade show';
                successAlert.innerHTML = `
                    ${result.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                `;
                document.querySelector('.card-body').insertBefore(successAlert, document.querySelector('.table-responsive'));
                
                // Auto-dismiss alert after 3 seconds
                setTimeout(() => {
                    successAlert.remove();
                }, 3000);

                // Reset form
                this.reset();
                document.querySelectorAll('.pc-btn.selected').forEach(btn => {
                    btn.classList.remove('selected');
                });
                document.querySelector('.pc-list-grid').innerHTML = '';
            } else {
                // Show error message
                const errorAlert = document.createElement('div');
                errorAlert.className = 'alert alert-danger alert-dismissible fade show';
                errorAlert.innerHTML = `
                    ${result.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                `;
                document.querySelector('.card-body').insertBefore(errorAlert, document.querySelector('.table-responsive'));
                
                // Auto-dismiss alert after 3 seconds
                setTimeout(() => {
                    errorAlert.remove();
                }, 3000);
            }
        } catch (error) {
            console.error('Error submitting reservation:', error);
            // Show error message
            const errorAlert = document.createElement('div');
            errorAlert.className = 'alert alert-danger alert-dismissible fade show';
            errorAlert.innerHTML = `
                Failed to submit reservation. Please try again.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            `;
            document.querySelector('.card-body').insertBefore(errorAlert, document.querySelector('.table-responsive'));
            
            // Auto-dismiss alert after 3 seconds
            setTimeout(() => {
                errorAlert.remove();
            }, 3000);
        }
    });
}); 