package com.mycompany.onconor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/CrearCuentaServlet")
public class CrearCuentaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Capturar los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("contraseña");

        // Validación simple
        if (nombre == null || apellidos == null || correo == null || contraseña == null) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("crear_cuenta.jsp").forward(request, response);
            return;
        }

        // Intentar guardar el usuario en la base de datos
        try (Connection connection = ConexionDB.getConnection()) {
            // Encriptar la contraseña antes de almacenarla
            String contraseñaEncriptada = encriptarContrasena(contraseña);
            
            // Imprimir para depuración
            System.out.println("Contraseña Original: " + contraseña);
            System.out.println("Contraseña Encriptada: " + contraseñaEncriptada);
            
            String sql = "INSERT INTO usuarios (nombre, apellidos, correo, contraseña) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, nombre);
            statement.setString(2, apellidos);
            statement.setString(3, correo);
            statement.setString(4, contraseñaEncriptada); // Almacenar la contraseña encriptada

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                // Redirigir al login después de la creación exitosa
                response.sendRedirect("index.jsp?mensaje=cuenta_creada");
            } else {
                request.setAttribute("error", "Error al crear la cuenta.");
                request.getRequestDispatcher("crear_cuenta.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al conectarse a la base de datos: " + e.getMessage());
            request.getRequestDispatcher("crear_cuenta.jsp").forward(request, response);
        }
    }

    private String encriptarContrasena(String contraseña) {
        try {
            // Crear una instancia de MessageDigest para SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            // Realizar el hash de la contraseña
            byte[] hash = md.digest(contraseña.getBytes());

            // Convertir el hash a un formato hexadecimal
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString(); // Retornar la contraseña encriptada
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar la contraseña", e);
        }
    }
}
