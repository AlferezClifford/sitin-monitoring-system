const container = document.querySelector(".container"),
      pwShowHide = document.querySelectorAll(".show_hide"),
      pwFields = document.querySelectorAll(".password"),
      signup = document.querySelector(".signup-link"),
      login = document.querySelector(".login-link"),
      body = document.querySelector("body"),
      sidebar = body.querySelector(".sidebar"),
      toggle = body.querySelector(".toggle"),
      modeSwitch = body.querySelector(".toggle-switch"),
      modeText = body.querySelector(".mode-text");

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
    // Darkmode 
    toggle.addEventListener("click", () => {
        sidebar.classList.toggle("close");
    });

    modeSwitch.addEventListener("click", () => {
        body.classList.toggle("dark");

        if (body.classList.contains("dark")){
            modeText.innerText = "Light Mode"
        } else {
            modeText.innerText = "Dark Mode"
        }
    });
    
    //Login setup
    signup.addEventListener("click", ( ) => {
        container.classList.add("active");
      });
      
    login.addEventListener("click", () => {
        container.classList.remove("active");
    });