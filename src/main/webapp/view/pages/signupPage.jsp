<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Municipal CMS - Sign Up</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../styles/signuppage.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  </head>
  <body>
    <div class="main-container">
      <div class="signup-card">
        <!-- Brand Section -->
        <div class="brand-section">
          <div class="brand-icon">
            <i class="fas fa-user-plus"></i>
          </div>
          <h1 class="brand-title">Join Municipal CMS</h1>
          <p class="brand-subtitle">Create your account to get started</p>
        </div>

        <!-- Welcome Message -->
        <div class="welcome-message">
          <h6>Welcome to the Team!</h6>
          <p>
            Join our municipal complaint management system and help improve
            community services.
          </p>
        </div>

        <c:if test="${not empty sessionScope.success}">
          <script>
            Swal.fire({
              icon: 'success',
              title: 'Success!',
              text: '${success}'
            });
          </script>
          <c:remove var="success" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.userNotSaved}">
          <script>
            Swal.fire({
              icon: 'error',
              title: 'Oops!',
              text: '${userNotSaved}'
            });
          </script>
          <c:remove var="userNotSaved" scope="session"/>
        </c:if>

        <!-- Sign Up Form -->
        <form id="signupForm" action="${pageContext.request.contextPath}/signupServlet" method="POST">
          <!-- Name Field -->
          <div class="form-floating">
            <input
              type="text"
              class="form-control"
              id="fullName"
              placeholder="Full Name"
              required
              name="name"
            />
            <label for="fullName">Full Name</label>
            <i class="fas fa-user input-group-icon"></i>
          </div>

          <!-- Email Field -->
          <div class="form-floating">
            <input
              type="email"
              class="form-control"
              id="email"
              placeholder="Email Address"
              required
              name="email"
            />
            <label for="email">Email Address</label>
            <i class="fas fa-envelope input-group-icon"></i>
          </div>

          <!-- Password Field -->
          <div class="form-floating">
            <input
              type="password"
              class="form-control"
              id="password"
              placeholder="Password"
              required
              name="password"
            />
            <label for="password">Create Password</label>
            <i class="fas fa-lock input-group-icon"></i>
          </div>

          <!-- Password Strength Indicator -->
          <div class="password-strength">
            <div class="strength-bar">
              <div class="strength-fill" id="strengthBar"></div>
            </div>
            <div class="strength-text" id="strengthText">
              Password strength will appear here
            </div>
          </div>

          <!-- Sign Up Button -->
          <button type="submit" class="btn btn-signup">
            <i class="fas fa-user-plus me-2"></i>
            Create Account
          </button>
        </form>

        <!-- Footer -->
        <div class="footer-text">
          <p>
            Already have an account? <a href="signinPage.jsp" id="signinLink">Sign In</a>
          </p>
        </div>
      </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
      // Add subtle animations and interactions (UI only, no logic)
      document.addEventListener("DOMContentLoaded", function () {
        // Add focus/blur animations for form inputs
        const formInputs = document.querySelectorAll(".form-control");

        formInputs.forEach((input) => {
          input.addEventListener("focus", function () {
            this.parentElement.classList.add("focused");
          });

          input.addEventListener("blur", function () {
            this.parentElement.classList.remove("focused");
          });
        });

        // Password strength indicator (visual only)
        const passwordInput = document.getElementById("password");
        const strengthBar = document.getElementById("strengthBar");
        const strengthText = document.getElementById("strengthText");

        passwordInput.addEventListener("input", function () {
          const password = this.value;
          let strength = 0;
          let strengthLabel = "";

          // Basic strength calculation (visual only)
          if (password.length >= 8) strength++;
          if (/[A-Z]/.test(password)) strength++;
          if (/[a-z]/.test(password)) strength++;
          if (/[0-9]/.test(password)) strength++;
          if (/[^A-Za-z0-9]/.test(password)) strength++;

          // Remove existing strength classes
          strengthBar.className = "strength-fill";

          switch (strength) {
            case 0:
            case 1:
              strengthBar.classList.add("strength-weak");
              strengthLabel = "Weak password";
              break;
            case 2:
              strengthBar.classList.add("strength-fair");
              strengthLabel = "Fair password";
              break;
            case 3:
            case 4:
              strengthBar.classList.add("strength-good");
              strengthLabel = "Good password";
              break;
            case 5:
              strengthBar.classList.add("strength-strong");
              strengthLabel = "Strong password";
              break;
            default:
              strengthLabel = "Enter a password";
          }

          strengthText.textContent =
            password.length === 0
              ? "Password strength will appear here"
              : strengthLabel;
        });

        // Add loading animation to button on form submit (visual only)
        const form = document.getElementById("signupForm");
        const submitBtn = form.querySelector(".btn-signup");

        form.addEventListener("submit", function (e) {


        // Add floating effect to brand icon
        const brandIcon = document.querySelector(".brand-icon");
        let floatDirection = 1;

        setInterval(() => {
          const currentTransform =
            brandIcon.style.transform || "translateY(0px)";
          const currentY = parseFloat(
            currentTransform.match(/translateY\(([^)]+)\)/) || [0, 0]
          )[1];

          if (currentY >= 5) floatDirection = -1;
          if (currentY <= -5) floatDirection = 1;

          brandIcon.style.transform = `translateY(${
            currentY + floatDirection * 0.5
          }px)`;
        }, 100);
      })});
    </script>

  </body>
</html>
