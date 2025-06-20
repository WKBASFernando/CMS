<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Municipal CMS - Sign In</title>
  <link
          href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
          rel="stylesheet"
  />
  <link
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          rel="stylesheet"
  />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js"></script>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #0f0f0f 0%, #1a1a2e 50%, #16213e 100%);
      min-height: 100vh;
      overflow-x: hidden;
      position: relative;
    }

    /* Animated background particles */
    body::before {
      content: '';
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image:
              radial-gradient(circle at 20% 20%, rgba(120, 119, 198, 0.1) 0%, transparent 50%),
              radial-gradient(circle at 80% 80%, rgba(255, 119, 198, 0.1) 0%, transparent 50%),
              radial-gradient(circle at 40% 40%, rgba(120, 219, 226, 0.1) 0%, transparent 50%);
      animation: float 20s ease-in-out infinite;
      z-index: -1;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0px) rotate(0deg); }
      33% { transform: translateY(-20px) rotate(120deg); }
      66% { transform: translateY(10px) rotate(240deg); }
    }

    .main-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem;
      position: relative;
    }

    .signin-card {
      background: rgba(15, 15, 15, 0.9);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 24px;
      padding: 3rem;
      width: 100%;
      max-width: 450px;
      box-shadow:
              0 32px 64px rgba(0, 0, 0, 0.5),
              0 0 0 1px rgba(255, 255, 255, 0.05),
              inset 0 1px 0 rgba(255, 255, 255, 0.1);
      position: relative;
      overflow: hidden;
      animation: slideUp 0.8s ease-out;
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(50px) scale(0.95);
      }
      to {
        opacity: 1;
        transform: translateY(0) scale(1);
      }
    }

    .signin-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.05), transparent);
      animation: shimmer 3s infinite;
    }

    @keyframes shimmer {
      0% { left: -100%; }
      100% { left: 100%; }
    }

    .brand-section {
      text-align: center;
      margin-bottom: 2.5rem;
    }

    .brand-icon {
      width: 80px;
      height: 80px;
      margin: 0 auto 1.5rem;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-radius: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      box-shadow: 0 16px 32px rgba(102, 126, 234, 0.3);
      animation: glow 2s ease-in-out infinite alternate;
    }

    @keyframes glow {
      from { box-shadow: 0 16px 32px rgba(102, 126, 234, 0.3); }
      to { box-shadow: 0 16px 48px rgba(102, 126, 234, 0.5); }
    }

    .brand-icon i {
      font-size: 2.5rem;
      color: white;
      filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
    }

    .brand-title {
      font-size: 2.2rem;
      font-weight: 700;
      background: linear-gradient(135deg, #ffffff 0%, #a8a8a8 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-bottom: 0.5rem;
      letter-spacing: -0.5px;
    }

    .brand-subtitle {
      color: #888;
      font-size: 1rem;
      font-weight: 400;
      letter-spacing: 0.5px;
    }

    .form-group {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .form-control {
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 16px;
      color: #fff;
      font-size: 1rem;
      padding: 1rem 1rem 1rem 3.5rem;
      transition: all 0.3s ease;
      height: auto;
    }

    .form-control:focus {
      background: rgba(255, 255, 255, 0.08);
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      outline: none;
      transform: translateY(-2px);
    }

    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.5);
    }

    .input-icon {
      position: absolute;
      left: 1.2rem;
      top: 50%;
      transform: translateY(-50%);
      color: rgba(255, 255, 255, 0.4);
      font-size: 1.1rem;
      transition: all 0.3s ease;
      z-index: 2;
    }

    .form-group:focus-within .input-icon {
      color: #667eea;
      transform: translateY(-50%) scale(1.1);
    }

    .form-check {
      margin: 2rem 0;
      display: flex;
      align-items: center;
    }

    .form-check-input {
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 6px;
      width: 1.2rem;
      height: 1.2rem;
      margin-right: 0.75rem;
    }

    .form-check-input:checked {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border-color: #667eea;
    }

    .form-check-label {
      color: rgba(255, 255, 255, 0.7);
      font-size: 0.9rem;
      user-select: none;
      cursor: pointer;
    }

    .btn-signin {
      width: 100%;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border: none;
      border-radius: 16px;
      color: white;
      font-size: 1.1rem;
      font-weight: 600;
      padding: 1rem;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
      margin-bottom: 2rem;
    }

    .btn-signin::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s ease;
    }

    .btn-signin:hover {
      transform: translateY(-2px);
      box-shadow: 0 12px 24px rgba(102, 126, 234, 0.4);
    }

    .btn-signin:hover::before {
      left: 100%;
    }

    .btn-signin:active {
      transform: translateY(0);
    }

    .btn-signin.loading {
      pointer-events: none;
      opacity: 0.8;
    }

    .btn-signin.loading i {
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }

    .footer-text {
      text-align: center;
      color: rgba(255, 255, 255, 0.6);
      font-size: 0.9rem;
    }

    .footer-text a {
      color: #667eea;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .footer-text a:hover {
      color: #764ba2;
      text-shadow: 0 0 8px rgba(102, 126, 234, 0.5);
    }

    .error-message {
      background: rgba(220, 53, 69, 0.1);
      border: 1px solid rgba(220, 53, 69, 0.3);
      border-radius: 12px;
      color: #ff6b6b;
      padding: 1rem;
      margin-bottom: 1.5rem;
      text-align: center;
      animation: shake 0.5s ease-in-out;
    }

    @keyframes shake {
      0%, 100% { transform: translateX(0); }
      25% { transform: translateX(-5px); }
      75% { transform: translateX(5px); }
    }

    /* Responsive */
    @media (max-width: 480px) {
      .signin-card {
        padding: 2rem 1.5rem;
        margin: 1rem;
      }

      .brand-title {
        font-size: 1.8rem;
      }
    }
  </style>
</head>
<body>
<div class="main-container">
  <div class="signin-card">
    <!-- Brand Section -->
    <div class="brand-section">
      <div class="brand-icon">
        <i class="fas fa-city"></i>
      </div>
      <h1 class="brand-title">Municipal CMS</h1>
      <p class="brand-subtitle">Complaint Management System</p>
    </div>

    <!-- JSP Error Display -->
    <c:if test="${not empty error}">
      <div class="error-message">
        <i class="fas fa-exclamation-triangle me-2"></i>
          ${error}
      </div>
    </c:if>

    <%
      // Check if user is already logged in
      if (session.getAttribute("loggedIn") != null && (Boolean) session.getAttribute("loggedIn")) {
        response.sendRedirect(request.getContextPath() + "/view/pages/dashboard.jsp");
        return;
      }

      // Display error message if any
      String error = (String) session.getAttribute("error");
      if (error != null && !error.isEmpty()) {
    %>

    <script>
      Swal.fire({
        icon: 'error',
        title: 'Login Failed!',
        text: '<%= error %>',
        background: 'rgba(15, 15, 15, 0.95)',
        color: '#fff',
        confirmButtonColor: '#667eea'
      });
    </script>
    <%
        session.removeAttribute("error");
      }
    %>

    <!-- Sign In Form -->
    <form id="signinForm" action="${pageContext.request.contextPath}/loginServlet" method="post">
      <!-- Name Field -->
      <div class="form-group">
        <i class="fas fa-user input-icon"></i>
        <input
                name="name"
                type="text"
                class="form-control"
                id="fullName"
                placeholder="Enter your full name"
                required
        />
      </div>

      <!-- Email Field -->
      <div class="form-group">
        <i class="fas fa-envelope input-icon"></i>
        <input
                name="email"
                type="email"
                class="form-control"
                id="email"
                placeholder="Enter your email address"
                required
        />
      </div>

      <!-- Password Field -->
      <div class="form-group">
        <i class="fas fa-lock input-icon"></i>
        <input
                name="password"
                type="password"
                class="form-control"
                id="password"
                placeholder="Enter your password"
                required
        />
      </div>

      <!-- Remember Me Checkbox -->
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="rememberMe" />
        <label class="form-check-label" for="rememberMe">
          Remember me on this device
        </label>
      </div>

      <!-- Sign In Button -->
      <button type="submit" class="btn btn-signin">
        <i class="fas fa-sign-in-alt me-2"></i>
        Sign In to CMS
      </button>
    </form>

    <!-- Footer -->
    <div class="footer-text">
      <p>
        If you don't have an account -
        <a href="signupPage.jsp" id="signupLink">Sign Up</a>
      </p>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    // Enhanced form input interactions
    const formControls = document.querySelectorAll(".form-control");

    formControls.forEach((input) => {
      input.addEventListener("focus", function () {
        this.parentElement.style.transform = "translateY(-2px)";
      });

      input.addEventListener("blur", function () {
        this.parentElement.style.transform = "translateY(0)";
      });

      // Add typing animation effect
      input.addEventListener("input", function () {
        const icon = this.parentElement.querySelector(".input-icon");
        icon.style.transform = "translateY(-50%) scale(1.1)";
        setTimeout(() => {
          icon.style.transform = "translateY(-50%) scale(1)";
        }, 200);
      });
    });

    // Enhanced form submission with loading animation
    const form = document.getElementById("signinForm");
    const submitBtn = form.querySelector(".btn-signin");
    const originalText = submitBtn.innerHTML;

    form.addEventListener("submit", function (e) {
      // Add loading state
      submitBtn.classList.add("loading");
      submitBtn.innerHTML = '<i class="fas fa-spinner me-2"></i>Signing In...';
      submitBtn.disabled = true;

      // Simulate loading (remove this setTimeout in production)
      setTimeout(() => {
        submitBtn.classList.remove("loading");
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
      }, 2000);
    });

    // Brand icon hover effect
    const brandIcon = document.querySelector(".brand-icon");
    brandIcon.addEventListener("mouseenter", function () {
      this.style.transform = "scale(1.1) rotate(5deg)";
    });

    brandIcon.addEventListener("mouseleave", function () {
      this.style.transform = "scale(1) rotate(0deg)";
    });

    // Add subtle parallax effect to background
    document.addEventListener("mousemove", function (e) {
      const x = e.clientX / window.innerWidth;
      const y = e.clientY / window.innerHeight;

      document.body.style.backgroundPosition =
              `${x * 50}px ${y * 50}px, ${x * -30}px ${y * -30}px, ${x * 20}px ${y * 20}px`;
    });

    // Add particle animation
    createParticles();
  });

  function createParticles() {
    const particleCount = 15;
    const colors = ['#667eea', '#764ba2', '#ffffff', '#a8a8a8'];

    for (let i = 0; i < particleCount; i++) {
      const particle = document.createElement('div');
      particle.style.cssText = `
                    position: fixed;
                    width: 4px;
                    height: 4px;
                    background: ${colors[Math.floor(Math.random() * colors.length)]};
                    border-radius: 50%;
                    opacity: 0.6;
                    pointer-events: none;
                    z-index: -1;
                    animation: float-particle ${5 + Math.random() * 10}s linear infinite;
                    left: ${Math.random() * 100}vw;
                    top: ${Math.random() * 100}vh;
                `;
      document.body.appendChild(particle);

      // Remove particle after animation
      setTimeout(() => {
        if (particle.parentNode) {
          particle.parentNode.removeChild(particle);
        }
      }, 15000);
    }

    // Create new particles periodically
    setTimeout(createParticles, 3000);
  }

  // Add CSS animation for particles
  const style = document.createElement('style');
  style.textContent = `
            @keyframes float-particle {
                0% {
                    transform: translateY(100vh) rotate(0deg);
                    opacity: 0;
                }
                10% {
                    opacity: 0.6;
                }
                90% {
                    opacity: 0.6;
                }
                100% {
                    transform: translateY(-100vh) rotate(360deg);
                    opacity: 0;
                }
            }
        `;
  document.head.appendChild(style);
</script>
</body>
</html>