package com.profileapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Untuk Apache Derby
    private static final String URL = "jdbc:derby://localhost:1527/student_profiles";
    private static final String USER = "app";
    private static final String PASSWORD = "app"; 
    
    public static Connection getConnection() throws SQLException {
        try {
            // Load Derby driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            System.out.println("DEBUG: Connecting to: " + URL);
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("DEBUG: Connection successful!");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: Derby driver not found!");
            throw new SQLException("Derby driver not found", e);
        } catch (SQLException e) {
            System.err.println("ERROR: Database connection failed: " + e.getMessage());
            throw e;
        }
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("DEBUG: Connection closed");
            } catch (SQLException e) {
                System.err.println("ERROR closing connection: " + e.getMessage());
            }
        }
    }
}