package com.profileapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id != null && !id.isEmpty()) {
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement("DELETE FROM APP.PROFILE WHERE ID = ?")) {
                
                pstmt.setInt(1, Integer.parseInt(id));
                int result = pstmt.executeUpdate();
                
                if (result > 0) {
                    response.sendRedirect("viewProfiles.jsp?deleted=true");
                    return;
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("viewProfiles.jsp");
    }
}