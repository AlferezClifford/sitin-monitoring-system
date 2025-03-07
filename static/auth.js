
const container = document.querySelector(".container"),
      pwShowHide = document.querySelectorAll(".show_hide"),
      pwFields = document.querySelectorAll(".password"),
      signup = document.querySelector(".signup-link"),
      login = document.querySelector(".login-link");



pwShowHide.forEach(eyeIcon => {
    eyeIcon.addEventListener("click",()=> {
        pwFields.forEach(pwField => {
            if (pwField.type === "password") {
                pwField.type = "text";

                pwShowHide.forEach(icon => {
                    icon.classList.replace("uil-eye-slash", "uil-eye");
                })
            } else {
                pwField.type = "password";
                
                pwShowHide.forEach(icon => {
                    icon.classList.replace("uil-eye", "uil-eye-slash",);
                })
            }
        })
    })
  });


//Login setup
signup.addEventListener("click", ( ) => {
    container.classList.add("active");
  });
  
login.addEventListener("click", () => {
    container.classList.remove("active");
});


