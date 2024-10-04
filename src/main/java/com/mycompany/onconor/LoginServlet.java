package com.mycompany.onconor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("contraseña");

        // Conectar a la base de datos y verificar el usuario
        try (Connection con = ConexionDB.getConnection()) {
            String sql = "SELECT * FROM usuarios WHERE correo = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, correo);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Obtener el hash de la contraseña almacenada en la base de datos
                String hashedContraseña = rs.getString("contraseña");
                String nombre = rs.getString("nombre"); // Obtener el nombre del usuario

                // Verificar la contraseña ingresada con la contraseña encriptada
                if (PasswordUtils.verifyPassword(contraseña, hashedContraseña)) {
                    // Usuario y contraseña válidos, crear sesión
                    HttpSession session = request.getSession();
                    session.setAttribute("correo", correo); // Cambiado a "correo" para mantener coherencia
                    session.setAttribute("nombre", nombre); // Almacenar el nombre en la sesión

                    // Redirigir a la página de bienvenida
                    response.sendRedirect("bienvenida.jsp");
                } else {
                    // Si la contraseña no es válida
                    request.setAttribute("error", "Correo o contraseña incorrectos.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                // Si el correo no se encuentra
                request.setAttribute("error", "Correo o contraseña incorrectos.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error al conectarse a la base de datos", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
