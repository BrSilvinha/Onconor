<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
    <title>Bienvenido a Onconor</title>
    <script>
        let menuOpen = false; // Estado del menú

        function toggleUserInfo() {
            var userInfo = document.getElementById("user-info");
            userInfo.style.display = userInfo.style.display === "none" || userInfo.style.display === "" ? "flex" : "none"; // Alternar visibilidad
        }

        function toggleMenu() {
            var menu = document.getElementById("menu");
            var mainImage = document.getElementById("main-image");
            if (menuOpen) {
                menu.style.display = "none"; // Oculta el menú
                mainImage.style.marginLeft = "0"; // Restaura el margen
                menuOpen = false; // Cambia el estado del menú
            } else {
                menu.style.display = "flex"; // Muestra el menú
                mainImage.style.marginLeft = "300px"; // Deja espacio para el menú
                menuOpen = true; // Cambia el estado del menú
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="main-content">
            <div class="header"></div>
            <div class="bar-rectangular">
                <div class="logo-container">
                    <img src="img/Logo.png" alt="Logo" class="logo-image">
                </div>

                <div class="user-info-inside">
                    <div id="user-info" style="display: none; flex-direction: column; align-items: flex-start;">
                        <span id="user-name">
                            <%= session.getAttribute("nombre") != null ? session.getAttribute("nombre") : "Invitado" %>
                        </span>
                        <a href="logout.jsp" class="logout">Cerrar sesión</a>
                    </div>

                    <div class="user-icon" onclick="toggleUserInfo()" style="cursor: pointer;">
                        <%= session.getAttribute("nombre") != null ? ((String) session.getAttribute("nombre")).toUpperCase().charAt(0) : "?" %>
                    </div>
                </div>

                <div class="menu-icon" onclick="toggleMenu()" style="cursor: pointer;">
                    &#9776; <!-- Símbolo de tres rayas -->
                </div>
            </div>

            <div id="menu" style="display: none; background-color: #e7ebee; position: fixed; top: 0; left: 0; width: 300px; height: 100%; z-index: 1000; flex-direction: column; padding: 20px;">
                <h2 style="text-align: center; font-weight: bold; margin: 20px 0; font-size: 36px;">Onconor</h2>
                <ul style="list-style-type: none; padding: 0; margin: 0;">
                    <li style="padding: 8px 12px;">Opción 1</li>
                    <li style="padding: 8px 12px;">Opción 2</li>
                    <li style="padding: 8px 12px;">Opción 3</li>
                </ul>
            </div>

            <div class="main-image" id="main-image" style="margin-left: 0; transition: margin-left 0.3s;">
                <img src="img/Onconor_inicio.png" alt="Onconor Inicio" style="width: 100%; height: auto;">
            </div>
        </div>
    </div>
</body>
</html>
