<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.profileapp.ProfileBean, com.profileapp.ViewProfilesServlet, java.util.List" %>
<%
    String id = request.getParameter("id");
    ProfileBean profile = null;
    List<ProfileBean> all = ViewProfilesServlet.getAllProfiles();
    if (id != null) {
        for(ProfileBean p : all) {
            if(String.valueOf(p.getId()).equals(id)) {
                profile = p;
                break;
            }
        }
    }

    if (profile == null) {
        response.sendRedirect("viewProfiles.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | ISTUDENT PROFILE</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --uitm-blue: #002b5c;
            --uitm-purple: #702082;
            --uitm-gold: #ffcc00;
            --uitm-light: #f8f9fa;
            --white: #ffffff;
            --border-color: #dee2e6;
        }

        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Palatino', 'Palatino Linotype', 'Book Antiqua', serif;
        }

        body {
            background-color: var(--uitm-light);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .top-accent {
            background: var(--uitm-blue);
            height: 8px;
            width: 100%;
        }

        header {
            background: var(--white);
            padding: 25px 30px; 
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 4px solid var(--uitm-purple);
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }
        
        .brand-section {
           text-align: left;
           margin-left: 0;
           padding-left: 0;
        }

        .brand-section h2 {
            color: var(--uitm-blue);
            font-size: 1.6rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin: 0; 
        }

        .brand-section p {
            font-size: 0.85rem;
            color: #666;
            border-top: 2px solid var(--uitm-gold);
            display: inline-block;
            margin-top: 5px;
            padding-top: 2px;
        }

        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            background-image: radial-gradient(var(--border-color) 0.5px, transparent 0.5px);
            background-size: 20px 20px;
        }

        .edit-card {
            background: white;
            width: 100%;
            max-width: 750px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            border: 1px solid var(--border-color);
            border-radius: 4px;
            overflow: hidden;
        }

        .card-banner {
            background: var(--uitm-purple);
            color: white;
            padding: 25px;
            text-align: center;
            border-bottom: 5px solid var(--uitm-gold);
        }

        .card-banner h2 {
            font-size: 26px;
            text-transform: uppercase;
        }

        .form-content {
            padding: 30px 40px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: var(--uitm-blue);
            font-size: 14px;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 2px;
            font-size: 14px;
            background: #fafafa;
        }

        input[readonly] {
            background-color: #f0f0f0;
            cursor: not-allowed;
        }

        .btn-row {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            border: none;
            text-transform: uppercase;
            text-align: center;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: 0.3s ease;
        }

        /* Update Button: Navy Blue to Purple hover */
        .btn-update { 
            background: var(--uitm-blue); 
            color: white; 
            border-bottom: 4px solid #001a38; 
        }
        .btn-update:hover { 
            background: var(--uitm-purple); 
            border-bottom-color: #4a1556; 
        }

        .btn-cancel { 
            background: #666; 
            color: white; 
            border-bottom: 4px solid #444; 
        }
        .btn-cancel:hover { 
            background: var(--uitm-purple); 
            border-bottom-color: #4a1556; 
        }

        footer {
            background: var(--uitm-blue);
            color: var(--white);
            text-align: center;
            padding: 20px;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-group.full-width { grid-column: span 1; }
        }
    </style>
</head>
<body>

    <div class="top-accent"></div>

    <header>
        <div class="brand-section">
            <h2>ISTUDENT PROFILE</h2>
            <p>Universiti Teknologi MARA</p>
        </div>
    </header>

    <div class="container">
        <div class="edit-card">
            <div class="card-banner">
                <h2>Update Student Profile</h2>
            </div>

            <form action="EditProfileServlet" method="POST" class="form-content">
                <input type="hidden" name="id" value="<%= profile.getId() %>">

                <div class="form-grid">
                    <div class="form-group">
                        <label>STUDENT NAME</label>
                        <input type="text" name="name" value="<%= profile.getName() %>" required>
                    </div>

                    <div class="form-group">
                        <label>STUDENT ID</label>
                        <input type="text" name="studentId" value="<%= profile.getStudentId() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label>ACADEMIC PROGRAM</label>
                        <select name="program" required>
                            <option value="Computer Science" <%= "Computer Science".equals(profile.getProgram()) ? "selected" : "" %>>Computer Science</option>
                            <option value="Information Technology" <%= "Information Technology".equals(profile.getProgram()) ? "selected" : "" %>>Information Technology</option>
                            <option value="Software Engineering" <%= "Software Engineering".equals(profile.getProgram()) ? "selected" : "" %>>Software Engineering</option>
                            <option value="Data Science" <%= "Data Science".equals(profile.getProgram()) ? "selected" : "" %>>Data Science</option>
                            <option value="Cybersecurity" <%= "Cybersecurity".equals(profile.getProgram()) ? "selected" : "" %>>Cybersecurity</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>EMAIL</label>
                        <input type="email" name="email" value="<%= profile.getEmail() %>" required>
                    </div>

                    <div class="form-group full-width">
                        <label>HOBBIES & INTERESTS</label>
                        <input type="text" name="hobbies" value="<%= profile.getHobbies() %>" placeholder="e.g. Reading, Coding">
                    </div>

                    <div class="form-group full-width">
                        <label>SELF INTRODUCTION</label>
                        <textarea name="introduction" rows="4" required><%= profile.getIntroduction() %></textarea>
                    </div>
                </div>

                <div class="btn-row">
                    <button type="submit" class="btn btn-update">
                        <i></i> Save Changes
                    </button>
                    <a href="viewProfiles.jsp" class="btn btn-cancel">
                        <i></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <footer>
        &copy; 2025 UNIVERSITI TEKNOLOGI MARA (UiTM)
    </footer>

</body>
</html>