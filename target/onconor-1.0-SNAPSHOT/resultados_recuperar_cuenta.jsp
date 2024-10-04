<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultados de Recuperación - Onconor</title>
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
        /* Estilo para el contenedor del usuario */
        .user-item {
            display: flex; /* Usar flexbox para alinear en línea */
            align-items: center; /* Centrar verticalmente */
            margin-bottom: 10px; /* Espacio entre los usuarios */
        }
        
        .user-icon {
            width: 30px; /* Ancho del ícono */
            height: 30px; /* Alto del ícono */
            background-color: #007bff; /* Color de fondo del ícono (ajustar según el diseño) */
            color: white; /* Color de la inicial */
            border-radius: 50%; /* Hacer que el ícono sea redondo */
            display: flex; /* Usar flexbox para centrar el texto */
            justify-content: center; /* Centrar horizontalmente */
            align-items: center; /* Centrar verticalmente */
            margin-right: 10px; /* Espacio entre el ícono y el nombre */
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
        <!-- Parte derecha con los resultados -->
        <div class="right-section">
             <!-- Mueve la imagen del logo aquí para que esté sobre el formulario -->
            <img src="img/onconor_logo.jpg" alt="Onconor Logo" class="logo mobile-logo">
            <h2>Cuentas encontradas</h2>
            
            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>

            <c:if test="${not empty usuarios}">
                <ul style="list-style-type: none; padding: 0;"> <!-- Estilo para eliminar los puntos -->
                    <c:forEach var="usuario" items="${usuarios}">
                        <li class="user-item"> <!-- Aplicar clase para el contenedor del usuario -->
                            <div class="user-icon">
                                ${usuario.nombre.toUpperCase().charAt(0)} <!-- Muestra la inicial del usuario -->
                            </div>
                            <span>${usuario.nombre} ${usuario.apellidos}</span> <!-- Muestra el nombre y apellidos -->
                            <a href="cambiar_contrasena.jsp?usuarioId=${usuario.id}" style="margin-left: 10px; color: #007bff; text-decoration: underline;">Cambiar Contraseña</a> <!-- Hipervínculo para cambiar contraseña -->
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            
            <c:if test="${empty usuarios}">
                <p>No se encontraron cuentas para el correo ingresado.</p>
            </c:if>
                
            <div class="options">
                <a href="recuperar_cuenta.jsp">Volver a buscar otra cuenta</a>
            </div>
        </div>
    </div>
</body>
</html>
