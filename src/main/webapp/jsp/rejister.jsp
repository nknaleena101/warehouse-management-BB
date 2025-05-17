<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clothing Store - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6b46c1;
            --primary-hover: #553c9a;
            --secondary-color: #4a5568;
            --accent-color: #805ad5;
            --light-bg: #f7fafc;
            --border-color: #e2e8f0;
            --error-color: #e53e3e;
            --success-color: #38a169;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f6f8fb 0%, #e9f1f9 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            line-height: 1.6;
        }

        .register-container {
            width: 100%;
            max-width: 1000px;
            display: flex;
            overflow: hidden;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background-color: white;
        }

        .register-branding {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            padding: 40px;
            color: white;
            width: 40%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
        }

        .register-branding h1 {
            font-size: 2.2rem;
            margin-bottom: 15px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .register-branding p {
            font-size: 1rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .store-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }

        .benefits-list {
            list-style-type: none;
            text-align: left;
            width: 100%;
            margin-top: 30px;
        }

        .benefits-list li {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            font-size: 0.95rem;
        }

        .benefits-list li i {
            margin-right: 10px;
            font-size: 18px;
            color: rgba(255, 255, 255, 0.9);
        }

        .register-form-container {
            width: 60%;
            padding: 40px 50px;
            background-color: white;
        }

        .register-form-header {
            margin-bottom: 30px;
            text-align: center;
        }

        .register-form-header h2 {
            color: var(--secondary-color);
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .register-form-header p {
            color: #718096;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary-color);
            font-size: 0.9rem;
        }

        .form-group .input-wrapper {
            position: relative;
        }

        .form-group .input-wrapper i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border-radius: 8px;
            border: 1.5px solid var(--border-color);
            font-size: 0.95rem;
            transition: all 0.3s ease;
            color: var(--secondary-color);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(107, 70, 193, 0.15);
        }

        .form-control::placeholder {
            color: #cbd5e0;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 80px;
            padding-left: 40px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .register-btn {
            width: 100%;
            padding: 14px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 10px;
        }

        .register-btn:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            color: #718096;
            font-size: 0.9rem;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .login-link a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        /* Password strength indicator - removed since password field is removed */

        /* Responsive adjustments */
        @media screen and (max-width: 900px) {
            .register-container {
                flex-direction: column;
                max-width: 550px;
            }

            .register-branding {
                width: 100%;
                padding: 30px 20px;
            }

            .register-form-container {
                width: 100%;
                padding: 30px 25px;
            }

            .benefits-list {
                display: none;
            }
        }

        @media screen and (max-width: 480px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .register-form-header h2 {
                font-size: 1.5rem;
            }

            .register-branding {
                padding: 25px 15px;
            }

            .store-icon {
                font-size: 50px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-branding">
            <i class="fas fa-tshirt store-icon"></i>
            <h1>Style Haven</h1>
            <p>Join our fashion community and enjoy a seamless shopping experience.</p>

            <ul class="benefits-list">
                <li><i class="fas fa-check-circle"></i> Exclusive deals and discounts</li>
                <li><i class="fas fa-check-circle"></i> Early access to new collections</li>
                <li><i class="fas fa-check-circle"></i> Quick and easy checkout</li>
                <li><i class="fas fa-check-circle"></i> Stay updated with latest trends</li>
            </ul>
        </div>

        <div class="register-form-container">
            <div class="register-form-header">
                <h2>Create Your Account</h2>
                <p>Fill in your details to join our community</p>
            </div>

            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <label for="fullname">Full Name</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" id="fullname" name="fullname" class="form-control" placeholder="John Doe" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="your@email.com" required>
                    </div>
                </div>

                <button type="submit" class="register-btn">Create Account</button>
                <div class="login-link">
                    Already have an account? <a href="login.jsp">Login here</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // No longer needed since password field is removed
    </script>
</body>
</html>