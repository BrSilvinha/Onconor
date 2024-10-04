<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Aqu� va la etiqueta viewport -->
    <title>Login - Onconor</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Media query para dispositivos m�viles */
        @media (max-width: 1050px) {
            .login-container {
                flex-direction: column; /* Cambia la direcci�n del contenedor a columna */
            }

            .left-section {
                display: none; /* Oculta la secci�n del logo en m�viles */
            }

            .line {
                display: none; /* Oculta la l�nea vertical en m�viles */
            }

            .mobile-logo {
                width: 300px; /* Cambia a un tama�o fijo que desees */
                height: auto; /* Mantiene la proporci�n de la imagen */
                margin: 0 auto; /* Centra el logo */
                display: block; /* Aseg�rate de que el logo se muestre como bloque */
                margin-bottom: 20px; /* Espacio entre el logo y el formulario */
            }

            .right-section {
                width: 100%; /* Asegura que el formulario ocupe todo el ancho */
                padding: 20px; /* Agrega un poco de padding */
                text-align: center; /* Centra el texto del formulario */
            }
        }

        /* Ocultar la imagen en dispositivos m�s grandes */
        @media (min-width: 1050px) {
            .mobile-logo {
                display: none; /* Oculta la imagen en pantallas m�s grandes */
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Parte izquierda con el logo -->
        <div class="left-section">
            <img src="img/onconor_logo.jpg" alt="Onconor Logo" class="logo">
        </div>
        <div class="line"></div> <!-- L�nea vertical -->
        <!-- Parte derecha con el formulario -->
        <div class="right-section">
            <!-- Mueve la imagen del logo aqu� para que est� sobre el formulario -->
            <img src="img/onconor_logo.jpg" alt="Onconor Logo" class="logo mobile-logo">
            <h2>LOGIN</h2>
            
            <!-- Mostrar mensaje de error si las credenciales son incorrectas -->
            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>

            <form action="LoginServlet" method="post">
                <div class="input-container">
                    <input type="email" name="correo" placeholder="Correo Electr�nico" required>
                </div>
                <div class="input-container">
                    <input type="password" name="contrase�a" placeholder="Contrase�a" required>
                </div>
                <div class="options">
                    <a href="crear_cuenta.jsp">Crear cuenta</a>
                    <a href="recuperar_cuenta.jsp">Recuperar cuenta</a>
                </div>
                <div class="button-container">
                    <button type="submit" class="login-btn">Ingresar</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
