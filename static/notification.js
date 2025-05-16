document.addEventListener('DOMContentLoaded', function() {
    const notificationIcon = document.getElementById('notificationIcon');
    const notificationBox = document.getElementById('notificationBox');
    
    // Toggle notification box visibility when clicking the bell icon
    notificationIcon.addEventListener('click', function(e) {
        e.stopPropagation();
        if (notificationBox.style.display === 'none' || notificationBox.style.display === '') {
            notificationBox.style.display = 'block';
        } else {
            notificationBox.style.display = 'none';
        }
    });
    
    // Close notification box when clicking outside
    document.addEventListener('click', function(e) {
        if (!notificationBox.contains(e.target) && e.target !== notificationIcon) {
            notificationBox.style.display = 'none';
        }
    });
    
    // Clear notifications functionality
    document.getElementById('clearNotifications').addEventListener('click', function() {
        // Send a POST request to clear notifications
        fetch('/clear-notification', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json()) // Parse the JSON response
        .then(data => {
            if (data.status === "success") {
                // Clear the notifications from the frontend
                document.getElementById('notificationList').innerHTML = '<strong style="font-size: 15px;">No notification available</strong>';
                document.getElementById('notificationCount').textContent = '0';
            } else {
                alert('Error: No session found or failed to clear notifications.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Something went wrong!');
        });
    });
});