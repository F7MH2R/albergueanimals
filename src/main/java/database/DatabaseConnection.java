/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://127.0.0.1:3306/vete"; // Asegúrate de que el nombre de la base de datos sea correcto
        String dbUsername = "root"; // Usuario de MySQL
        String dbPassword = null; // Sin contraseña

        Class.forName(dbDriver);
        Connection connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        
        // Mensaje en consola para indicar que la conexión fue exitosa
        if (connection != null && !connection.isClosed()) {
            System.out.println("Conexión exitosa a la base de datos 'vete'");
        }
        
        return connection; // La conexión no se cierra aquí
    }
}
