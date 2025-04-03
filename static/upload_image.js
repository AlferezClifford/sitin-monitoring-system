document.addEventListener("DOMContentLoaded", function () {
    const fileUpload = document.getElementById("file-upload");
    const profilePic = document.getElementById("profile-pic");
    const profileIcon = document.getElementById("profile-img-icon");
    const editIcons = document.querySelectorAll(".bx-edit-alt");
    const inputs = document.querySelectorAll(".input-field input");
    const form = document.querySelector(".editProfileContainer");
    const logoutButton = document.getElementById("logout-btn");

    let originalValues = {};  
    let imageChanged = false;  

    // Store initial values
    inputs.forEach(input => {
        originalValues[input.name] = input.value;
    });

    // Enable editing when clicking the edit icon
    editIcons.forEach(icon => {
        icon.addEventListener("click", function () {
            const input = this.previousElementSibling;
            input.readOnly = !input.readOnly;
            if (!input.readOnly) {
                input.value = "";
                input.focus();
            } else {
                input.value = originalValues[input.name]; 
            }
        });
    });

    // Open file input when clicking profile image
    profileIcon.addEventListener("click", () => {
        fileUpload.click();
    });

    // Preview image on selection
    fileUpload.addEventListener("change", function () {
        const file = fileUpload.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                profilePic.src = e.target.result;
                imageChanged = true;
            };
            reader.readAsDataURL(file);
        }
    });

    // Submit the form, sending only changed fields
    form.addEventListener("submit", function (event) {
        event.preventDefault();

        let formData = new FormData();
        let hasChanges = false;

        // Check input fields and only add changed values
        inputs.forEach(input => {
            if (input.value !== originalValues[input.name] && input.value.trim() !== "") {
                formData.append(input.name, input.value);
                hasChanges = true;
            } else {
                formData.append(input.name, "null"); // Send "null" for unchanged fields
            }
        });

        // Check if image has changed
        if (imageChanged && fileUpload.files.length > 0) {
            formData.append("profile_image", fileUpload.files[0]);
            hasChanges = true;
        }

        if (!hasChanges) {
            alert("No changes detected.");
            return;
        }

        fetch(form.action, {
            method: "POST",
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
               
                window.location.reload();
            } else {
                alert("Error updating profile.");
            }
        })
        .catch(error => console.error("Error:", error));
    });

    // Logout action
    logoutButton.addEventListener("click", function () {
        window.location.href = "/logout";
    });
});
