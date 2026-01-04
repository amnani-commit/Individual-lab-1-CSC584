package com.profileapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String introduction = request.getParameter("introduction");

        ProfileBean profile = new ProfileBean(name, studentId, program, email, hobbies, introduction);
        
        try (Connection conn = DBConnection.getConnection()) {
            

            String checkSql = "SELECT COUNT(*) FROM PROFILE WHERE STUDENT_ID = ?";
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setString(1, studentId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("error", "Student ID already exists.");
                        request.setAttribute("profile", profile);
                        request.getRequestDispatcher("createProfile.jsp").forward(request, response);
                        return;
                    }
                }
            }

            String insertSql = "INSERT INTO PROFILE (NAME, STUDENT_ID, PROGRAM, EMAIL, HOBBIES, INTRODUCTION) VALUES (?,?,?,?,?,?)";
            try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                psInsert.setString(1, name);
                psInsert.setString(2, studentId);
                psInsert.setString(3, program);
                psInsert.setString(4, email);
                psInsert.setString(5, hobbies);
                psInsert.setString(6, introduction);
                psInsert.executeUpdate();
            }

            HttpSession session = request.getSession();
            session.setAttribute("profile", profile);
            session.setAttribute("showSuccess", "true");
            
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            request.setAttribute("error", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("createProfile.jsp").forward(request, response);
        }
    }
}