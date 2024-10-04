package com.mycompany.onconor;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnection {
    public static void main(String[] args) {
        // Intentar conectar a la base de datos usando la clase ConexionDB
        try (Connection connection = ConexionDB.getConnection()) {
            if (connection != null) {
                System.out.println("Conexión a la base de datos establecida exitosamente.");
            } else {
                System.out.println("Error al establecer la conexión.");
            }
        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos:");
            e.printStackTrace();
        }
    }
}
