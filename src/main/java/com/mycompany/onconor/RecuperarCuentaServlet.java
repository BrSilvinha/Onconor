package com.mycompany.onconor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/RecuperarCuentaServlet")
public class RecuperarCuentaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("correo");

        // Validación básica
        if (correo == null || correo.isEmpty()) {
            request.setAttribute("error", "Debe ingresar un correo.");
            request.getRequestDispatcher("recuperar_cuenta.jsp").forward(request, response);
            return;
        }

        // Lista de usuarios encontrados
        List<Usuario> usuarios = new ArrayList<>();

        try (Connection connection = ConexionDB.getConnection()) {
            // Consulta para obtener los usuarios con ese correo
            String sql = "SELECT id, nombre, apellidos FROM usuarios WHERE correo = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, correo);

            ResultSet resultSet = statement.executeQuery();

            // Procesar el resultado
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nombre = resultSet.getString("nombre");
                String apellidos = resultSet.getString("apellidos");

                Usuario usuario = new Usuario(id, nombre, apellidos, correo);
                usuarios.add(usuario);
            }

            // Imprimir el tamaño de la lista para depuración
            System.out.println("Número de cuentas encontradas: " + usuarios.size());

            // Comprobar si no se encontraron usuarios
            if (usuarios.isEmpty()) {
                request.setAttribute("error", "No se encontraron cuentas para el correo ingresado.");
            }

            // Redirigir a la página con los resultados
            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("resultados_recuperar_cuenta.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al conectar con la base de datos.");
            request.getRequestDispatcher("recuperar_cuenta.jsp").forward(request, response);
        }
    }
}
