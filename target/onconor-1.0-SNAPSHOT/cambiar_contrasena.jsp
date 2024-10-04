<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar Contraseña - Onconor</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Media query para dispositivos móviles */
        @media (max-width: 1050px) {
            .login-container {
                flex-direction: column; /* Cambia la dirección del contenedor a columna */
            }

            .left-section {
                display: none; /* Oculta la sección del logo en móviles */
            }

            .line {
                display: none; /* Oculta la línea vertical en móviles */
            }

            .mobile-logo {
                width: 300px; /* Cambia a un tamaño fijo que desees */
                height: auto; /* Mantiene la proporción de la imagen */
                margin: 0 auto; /* Centra el logo */
                display: block; /* Asegúrate de que el logo se muestre como bloque */
                margin-bottom: 20px; /* Espacio entre el logo y el formulario */
            }

            .right-section {
                width: 100%; /* Asegura que el formulario ocupe todo el ancho */
                padding: 20px; /* Agrega un poco de padding */
                text-align: center; /* Centra el texto del formulario */
            }
        }

        /* Ocultar la imagen en dispositivos más grandes */
        @media (min-width: 1050px) {
            .mobile-logo {
                display: none; /* Oculta la imagen en pantallas más grandes */
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
        <div class="line"></div> <!-- Línea vertical -->
        <!-- Parte derecha con el formulario -->
        <div class="right-section">
             <!-- Mueve la imagen del logo aquí para que esté sobre el formulario -->
            <img src="img/onconor_logo.jpg" alt="Onconor Logo" class="logo mobile-logo">
            <h2>Cambiar Contraseña</h2>

            <!-- Mostrar mensajes de error o éxito -->
            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>
            <c:if test="${not empty mensaje}">
                <p class="success-message">${mensaje}</p>
            </c:if>

            <!-- Formulario de cambio de contraseña -->
            <form action="CambioContrasenaServlet" method="POST">
                <input type="hidden" name="usuarioId" value="<%= request.getParameter("usuarioId") %>">
                <div class="input-container">
                    <input type="password" name="nuevaContrasena" placeholder="Nueva Contraseña" required>
                </div>
                <div class="button-container">
                    <button type="submit" class="login-btn">Cambiar</button>
                </div>
            </form>

            <!-- Hipervínculo para volver al login -->
            <div class="link-container">
                <a href="index.jsp" class="back-link">Volver al Login</a>
            </div>
        </div>
    </div>
</body>
</html>
