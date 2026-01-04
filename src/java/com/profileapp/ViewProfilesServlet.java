package com.profileapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewProfilesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static List<ProfileBean> getAllProfiles() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProfileBean> profiles = new ArrayList<>();

        try {
            System.out.println("DEBUG: Getting database connection...");
            conn = DBConnection.getConnection();
            
            if (conn == null) {
                System.out.println("DEBUG: Database connection is NULL!");
                return profiles;
            }
            
            System.out.println("DEBUG: Connection successful. Executing query...");
            String sql = "SELECT ID, NAME, STUDENT_ID, PROGRAM, EMAIL, HOBBIES, INTRODUCTION, CREATED_AT " +
                         "FROM APP.PROFILE ORDER BY CREATED_AT DESC";
            
            System.out.println("DEBUG: SQL Query: " + sql);

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            int count = 0;
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("ID"));
                profile.setName(rs.getString("NAME"));
                profile.setStudentId(rs.getString("STUDENT_ID"));
                profile.setProgram(rs.getString("PROGRAM"));
                profile.setEmail(rs.getString("EMAIL"));
                profile.setHobbies(rs.getString("HOBBIES"));
                profile.setIntroduction(rs.getString("INTRODUCTION"));
                profile.setCreatedAt(rs.getTimestamp("CREATED_AT"));
                
                profiles.add(profile);
                count++;
                
                // Debug output
                System.out.println("DEBUG: Retrieved profile #" + count + ": " + 
                                 profile.getName() + " (" + profile.getStudentId() + ")");
            }
            
            System.out.println("DEBUG: Total profiles retrieved: " + count);

        } catch (Exception e) {
            System.err.println("ERROR in getAllProfiles(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return profiles;
    }

    public static ProfileBean getProfileById(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProfileBean profile = null;

        try {
            System.out.println("DEBUG: Getting profile for ID: " + id);
            conn = DBConnection.getConnection();
            
            String sql = "SELECT ID, NAME, STUDENT_ID, PROGRAM, EMAIL, HOBBIES, INTRODUCTION, CREATED_AT " +
                         "FROM APP.PROFILE WHERE ID = ? OR STUDENT_ID = ?";
            
            pstmt = conn.prepareStatement(sql);
            
            try {
                int numericId = Integer.parseInt(id);
                pstmt.setInt(1, numericId);
                pstmt.setString(2, id);
            } catch (NumberFormatException e) {

                pstmt.setString(1, id);
                pstmt.setString(2, id);
            }
            
            rs = pstmt.executeQuery();

            if (rs.next()) {
                profile = new ProfileBean();
                profile.setId(rs.getInt("ID"));
                profile.setName(rs.getString("NAME"));
                profile.setStudentId(rs.getString("STUDENT_ID"));
                profile.setProgram(rs.getString("PROGRAM"));
                profile.setEmail(rs.getString("EMAIL"));
                profile.setHobbies(rs.getString("HOBBIES"));
                profile.setIntroduction(rs.getString("INTRODUCTION"));
                profile.setCreatedAt(rs.getTimestamp("CREATED_AT"));
                
                System.out.println("DEBUG: Found profile: " + profile.getName());
            } else {
                System.out.println("DEBUG: No profile found for ID: " + id);
            }

        } catch (Exception e) {
            System.err.println("ERROR in getProfileById(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return profile;
    }

    // Method untuk count total profiles
    public static int getTotalProfiles() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) AS TOTAL FROM APP.PROFILE";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt("TOTAL");
                System.out.println("DEBUG: Total profiles in DB: " + count);
            }

        } catch (Exception e) {
            System.err.println("ERROR in getTotalProfiles(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return count;
    }

    // Method untuk search profiles
    public static List<ProfileBean> searchProfiles(String keyword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProfileBean> profiles = new ArrayList<>();

        try {
            conn = DBConnection.getConnection();
            
            if (keyword == null || keyword.trim().isEmpty()) {
                return getAllProfiles();
            }
            
            // SQL searches both Name and Student ID columns
            String sql = "SELECT * FROM APP.PROFILE WHERE LOWER(NAME) LIKE LOWER(?) " +
                         "OR STUDENT_ID LIKE ? ORDER BY CREATED_AT DESC";

            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("ID"));
                profile.setName(rs.getString("NAME"));
                profile.setStudentId(rs.getString("STUDENT_ID"));
                profile.setProgram(rs.getString("PROGRAM"));
                profile.setEmail(rs.getString("EMAIL"));
                profile.setHobbies(rs.getString("HOBBIES"));
                profile.setIntroduction(rs.getString("INTRODUCTION"));
                profile.setCreatedAt(rs.getTimestamp("CREATED_AT"));
                
                profiles.add(profile);
            }
            
            System.out.println("DEBUG: Search found " + profiles.size() + " results for: " + keyword);

        } catch (Exception e) {
            System.err.println("ERROR in searchProfiles(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return profiles;
    }

    // Helper method to close resources safely
    private static void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) DBConnection.closeConnection(conn); } catch (Exception e) {}
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if single profile view is requested
        String profileId = request.getParameter("id");
        
        if (profileId != null && !profileId.trim().isEmpty()) {
            // Single profile view
            ProfileBean profile = getProfileById(profileId);
            request.setAttribute("profile", profile);
            
            if (profile == null) {
                request.setAttribute("error", "Profile not found with ID: " + profileId);
            }
            
            request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
        } else {
            // List all profiles view
            List<ProfileBean> profiles = getAllProfiles();
            request.setAttribute("profiles", profiles);
            request.setAttribute("totalProfiles", getTotalProfiles());
            
            // Check for search parameter
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                List<ProfileBean> searchResults = searchProfiles(search);
                request.setAttribute("profiles", searchResults);
                request.setAttribute("searchTerm", search);
            }
            
            request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
        }
    }
}