<%-- 
    Document   : login
    Created on : Oct 4, 2023, 10:24:55 PM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                height: 100vh;
            }

            .logo {
                width: 150px; /* Adjust the width of the logo as needed */
                height: auto;
                margin-top: 30px;
                margin-bottom: 50px;
            }

            form {
                background-color: #fff;
                padding: 60px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            h1 {
                color: orangered;
            }

            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            input[type="text"], input[type="password"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin-bottom: 10px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 5px;
                display: inline-block;
            }

            input[type="submit"] {
                width: 100%;
                background-color: #4caf50;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }
            footer {
                background-color: #333;
                color: white;
                text-align: center;
                padding: 10px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
            }
            .container {
                width: 80%;
                margin: 0 auto;
            }
            .form-group.remember-group {
                display: flex;
                align-items: center;
            }

            .form-group.remember-group input[type="checkbox"] {
                margin-right: 10px;
            }

        </style>

    </head>
    <body>
        <img src="img/logo-home-f72440cc.png" alt="School Logo" class="logo"/>
        <form action="login" method="post">
            <h1>FPT University Academic Portal</h1>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group  remember-group">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember"><i>Remember password</i></label>
            </div>
            <input type="submit" name="login" value="Login">
        </form>
        <footer>
            <div class="container">
                FPT University - since 2006
            </div>
        </footer>

    </body>

</html>
