<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clothing Store - Login</title>
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

        .login-container {
            width: 100%;
            max-width: 900px;
            display: flex;
            overflow: hidden;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            background-color: white;
            height: 550px;
        }

        .login-branding {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 100%);
            padding: 40px;
            color: white;
            width: 45%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
        }

        .login-branding h1 {
            font-size: 2.4rem;
            margin-bottom: 15px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .login-branding p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .store-icon {
            font-size: 70px;
            margin-bottom: 30px;
        }

        .welcome-message {
            margin-top: 30px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            backdrop-filter: blur(5px);
        }

        .welcome-message h3 {
            margin-bottom: 10px;
            font-size: 1.3rem;
        }

        .welcome-message p {
            font-size: 0.95rem;
            margin-bottom: 0;
        }

        .login-form-container {
            width: 55%;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-form-header {
            margin-bottom: 40px;
        }

        .login-form-header h2 {
            color: var(--secondary-color);
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .login-form-header p {
            color: #718096;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary-color);
            font-size: 0.95rem;
        }

        .form-group .input-wrapper {
            position: relative;
        }

        .form-group .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
            font-size: 18px;
        }

        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border-radius: 10px;
            border: 1.5px solid var(--border-color);
            font-size: 1rem;
            transition: all 0.3s ease;
            color: var(--secondary-color);
            background-color: #fcfcfc;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(107, 70, 193, 0.15);
            background-color: white;
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 10px;
            letter-spacing: 0.5px;
        }

        .login-btn:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(107, 70, 193, 0.2);
        }

        .register-link {
            text-align: center;
            margin-top: 30px;
            color: #718096;
            font-size: 0.95rem;
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .register-link a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        /* Responsive adjustments */
        @media screen and (max-width: 900px) {
            .login-container {
                flex-direction: column;
                max-width: 500px;
                height: auto;
            }

            .login-branding {
                width: 100%;
                padding: 40px 20px;
            }

            .login-form-container {
                width: 100%;
                padding: 40px 30px;
            }

            .welcome-message {
                display: none;
            }
        }

        @media screen and (max-width: 480px) {
            .login-form-container {
                padding: 30px 20px;
            }

            .login-form-header h2 {
                font-size: 1.6rem;
            }

            .social-button {
                width: 35px;
                height: 35px;
            }

            .login-branding {
                padding: 25px 15px;
            }

            .store-icon {
                font-size: 50px;
                margin-bottom: 15px;
            }

            .login-branding h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-branding">
            <i class="fas fa-tshirt store-icon"></i>
            <h1>Style Haven</h1>
            <p>Welcome back to your fashion journey</p>

            <div class="welcome-message">
                <h3>Exclusive Summer Collection</h3>
                <p>Log in to explore our new arrivals and seasonal discounts!</p>
            </div>
        </div>

        <div class="login-form-container">
            <div class="login-form-header">
                <h2>Welcome Back</h2>
                <p>Enter your credentials to access your account</p>
            </div>

            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="your@email.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                </div>

                <button type="submit" class="login-btn">Sign In</button>
            </form>
        </div>
    </div>
</body>
</html>