
document.addEventListener("DOMContentLoaded", function () {
    const fileUpload = document.getElementById("file-upload");
    const profilePic = document.getElementById("profile-pic");
    const profileIcon = document.getElementById("profile-img-icon");
    const editIcons = document.querySelectorAll(".bx-edit-alt");
    const inputs = document.querySelectorAll(".input-field input");
    const form = document.querySelector(".editProfileContainer");

    let originalValues = {};  // Store original input values
    let imageChanged = false; // Track if image was changed

    // Store initial values for tracking changes
    inputs.forEach(input => {
        originalValues[input.name] = input.value;
    });

    // Enable editing when clicking the edit icon
    editIcons.forEach(icon => {
        icon.addEventListener("click", function () {
            const input = this.previousElementSibling;
            input.readOnly = !input.readOnly;
            if (!input.readOnly) {
                input.focus();
            }
        });
    });

    // Detect image change
    profileIcon.addEventListener("click", () => {
        fileUpload.click();
    });

    fileUpload.addEventListener("change", function () {
        const file = fileUpload.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                profilePic.src = e.target.result;
                imageChanged = true;  // Mark image as changed
            };
            reader.readAsDataURL(file);
        }
    });

    // Form Submission - Only Send Changed Fields
    form.addEventListener("submit", function (event) {
        event.preventDefault(); // Prevent default submission

        let formData = new FormData();
        let isChanged = false;

        // Check for modified fields
        inputs.forEach(input => {
            if (input.name && input.value !== originalValues[input.name]) {
                formData.append(input.name, input.value);
                isChanged = true;
            }
        });

        // Add image if changed
        if (imageChanged && fileUpload.files[0]) {
            formData.append("profile_image", fileUpload.files[0]);
            isChanged = true;
        }

        // Stop submission if no changes
        if (!isChanged) {
            alert("No changes detected.");
            return;
        }

        // Send the form data via AJAX
        fetch("/update_profile", {
            method: "POST",
            body: formData
        })
        .then(response => response.json())  // Assuming JSON response
        .then(data => {
            alert(data.message); // Success message
            location.reload();   // Refresh page
        })
        .catch(error => console.error("Error:", error));
    });
});

