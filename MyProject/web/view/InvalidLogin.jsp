<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invalid Login</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                text-align: center;
                padding: 50px;
            }

            .error-container {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 300px;
                margin: 0 auto;
            }

            .error-message {
                font-size: 18px;
                color: #ff0000;
                margin-bottom: 20px;
            }

            .back-button {
                background-color: #4caf50;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <div class="error-message">
                Invalid username or password!
            </div>
            <button class="back-button"><a href="../login" style="color: white;">Back to login</a></button>
        </div>
    </body>
</html>
