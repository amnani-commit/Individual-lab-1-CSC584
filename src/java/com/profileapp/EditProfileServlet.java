package com.profileapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String introduction = request.getParameter("introduction");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE APP.PROFILE SET NAME=?, PROGRAM=?, EMAIL=?, HOBBIES=?, INTRODUCTION=? WHERE ID=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, program);
            pstmt.setString(3, email);
            pstmt.setString(4, hobbies);
            pstmt.setString(5, introduction);
            pstmt.setInt(6, id);

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("viewProfiles.jsp?updated=true");
    }
}