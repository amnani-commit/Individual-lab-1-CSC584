<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.profileapp.ProfileBean, com.profileapp.ViewProfilesServlet, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Records | ISTUDENT PROFILE</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            /* Official UiTM Corporate Colors matched to index.html */
            --uitm-blue: #002b5c;      
            --uitm-purple: #702082;    
            --uitm-gold: #ffcc00;      
            --uitm-light: #f8f9fa;
            --white: #ffffff;
            --border-color: #dee2e6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
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
            max-width: 1400px; /* Increased slightly for the extra column */
            margin: 30px auto;
            padding: 0 20px;
        }

        /* --- STATISTICS --- */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            padding: 15px;
            border-radius: 4px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-bottom: 3px solid var(--uitm-blue);
        }

        .stat-card.total { border-bottom-color: var(--uitm-gold); }

        .stat-value {
            display: block;
            font-size: 22px;
            font-weight: bold;
            color: var(--uitm-blue);
        }

        .stat-label {
            font-size: 11px;
            color: #666;
            text-transform: uppercase;
            font-weight: bold;
        }

        /* --- TABLE CARD --- */
        .main-card {
            background: white;
            border-radius: 4px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            border-top: 5px solid var(--uitm-gold);
        }

        .card-header {
            padding: 20px;
            background: #fff;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .filter-section {
            padding: 20px;
            background: #f9f9f9;
            border-bottom: 1px solid #eee;
        }

        .filter-row {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-box, .select-box {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px; /* Adjusted for extra column */
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            text-align: left;
            word-wrap: break-word; 
        }

        th { background: #f4f4f4; color: var(--uitm-blue); font-size: 13px; text-transform: uppercase;}

        .hobby-badge {
            background: var(--uitm-blue);
            color: white;
            padding: 2px 8px;
            font-size: 10px;
            margin: 2px;
            border-radius: 2px;
            display: inline-block;
        }

        .col-intro {
            max-width: 200px;
            font-size: 0.9rem;
            color: #555;
            font-style: italic;
            white-space: normal;
        }

        .btn {
            padding: 8px 15px;
            font-weight: bold;
            font-size: 12px;
            cursor: pointer;
            border: none;
            text-transform: uppercase;
            transition: 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-width: 100px;
        }

        .btn-navy, .btn-home { 
            background: var(--uitm-blue); 
            color: white; 
            border: none;
        }

        .btn-navy:hover, .btn-home:hover { 
            background: var(--uitm-purple); 
        }

        .btn-gold { background: var(--uitm-gold); color: var(--uitm-blue); }
        .btn-purple { background: var(--uitm-purple); color: white; }

        .btn-dismiss-only {
            background: var(--uitm-blue);
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            font-weight: bold;
            text-transform: uppercase;
            cursor: pointer;
            display: block;
        }
        
        .btn-dismiss-only:hover {
            background: var(--uitm-blue); 
            color: white;
        }

        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            z-index: 9999;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(2px);
        }

        .modal-content {
            background: white;
            padding: 40px;
            width: 450px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .modal-icon-circle {
            width: 80px; height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 40px;
            color: white;
        }

        .modal-success { border-top: 8px solid #2ecc71; }
        .modal-success .modal-icon-circle { background-color: #2ecc71; }

        .modal-delete { border-top: 8px solid #e74c3c; }
        .modal-delete .modal-icon-circle { background-color: #e74c3c; }

        .modal-title { font-size: 24px; font-weight: bold; color: var(--uitm-blue); margin-bottom: 10px; }
        .modal-desc { font-size: 16px; color: #555; margin-bottom: 30px; line-height: 1.4; }

        footer {
            background: var(--uitm-blue); color: var(--white);
            text-align: center; padding: 20px; font-size: 0.75rem;
            text-transform: uppercase; letter-spacing: 1.5px;
            margin-top: auto;
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

    <div id="successModal" class="modal-overlay">
        <div class="modal-content modal-success">
            <div class="modal-icon-circle"><i class="fas fa-check"></i></div>
            <div class="modal-title">SUCCESSFUL</div>
            <div id="successText" class="modal-desc">Action completed successfully!</div>
            <button onclick="closeModal('successModal')" class="btn-dismiss-only">DISMISS</button>
        </div>
    </div>

    <div id="deleteModal" class="modal-overlay">
        <div class="modal-content modal-delete">
            <div class="modal-icon-circle"><i class="fas fa-exclamation-triangle"></i></div>
            <div class="modal-title">CONFIRM DELETE</div>
            <div id="deleteMessageText" class="modal-desc">Are you sure?</div>
            <div style="display: flex; gap: 10px;">
                <button onclick="closeModal('deleteModal')" class="btn" style="background: #ccc; flex: 1;">CANCEL</button>
                <button id="confirmDeleteBtn" class="btn btn-navy" style="background: #e74c3c; color: white; flex: 1;">DELETE NOW</button>
            </div>
        </div>
    </div>

    <div class="container">
        <%
            List<ProfileBean> allProfiles = ViewProfilesServlet.getAllProfiles();
            int total = allProfiles.size();
            int ComputerScience = 0, InformationTechnology = 0, SoftwareEngineering = 0, DataScience = 0, CyberSecurity = 0;
            for(ProfileBean p : allProfiles) {
                String prog = p.getProgram();
                if("Computer Science".equals(prog)) ComputerScience++;
                else if("Information Technology".equals(prog)) InformationTechnology++;
                else if("Software Engineering".equals(prog)) SoftwareEngineering++;
                else if("Data Science".equals(prog)) DataScience++;
                else if("Cybersecurity".equals(prog)) CyberSecurity++;
            }

            List<ProfileBean> filteredProfiles = new ArrayList<ProfileBean>();
            String s = request.getParameter("search");
            String pf = request.getParameter("progFilter");
            for (ProfileBean p : allProfiles) {
                boolean ms = (s == null || s.isEmpty()) || (p.getName().toLowerCase().contains(s.toLowerCase()) || p.getStudentId().contains(s));
                boolean mp = (pf == null || pf.isEmpty()) || pf.equals(p.getProgram());
                if (ms && mp) filteredProfiles.add(p);
            }
        %>

        <div class="stats-container">
            <div class="stat-card total"><span class="stat-value"><%= total %></span><span class="stat-label">Total</span></div>
            <div class="stat-card"><span class="stat-value"><%= ComputerScience %></span><span class="stat-label">Computer Science</span></div>
            <div class="stat-card"><span class="stat-value"><%= InformationTechnology%></span><span class="stat-label">Information Technology</span></div>
            <div class="stat-card"><span class="stat-value"><%= SoftwareEngineering %></span><span class="stat-label">Software Engineering</span></div>
            <div class="stat-card"><span class="stat-value"><%= DataScience %></span><span class="stat-label">Data Science</span></div>
            <div class="stat-card"><span class="stat-value"><%= CyberSecurity %></span><span class="stat-label">Cyber Security</span></div>
        </div>

        <div class="main-card">
            <div class="card-header">
                <h2 style="color: var(--uitm-blue)">STUDENT RECORD LIST</h2>
                <div style="display: flex; gap: 10px;">
                    <a href="index.html" class="btn btn-home"><i class="fas fa-home"></i> HOME</a>
                    <a href="createProfile.jsp" class="btn btn-navy"><i class="fas fa-plus"></i> NEW REGISTER</a>
                </div>
            </div>

            <div class="filter-section">
                <form method="GET" action="viewProfiles.jsp" class="filter-row">
                    <input type="text" name="search" class="search-box" placeholder="Name or ID..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <select name="progFilter" class="select-box">
                        <option value="">-- All Programs --</option>
                        <option value="Computer Science" <%= "Computer Science".equals(pf) ? "selected" : "" %>>Computer Science</option>
                        <option value="Information Technology" <%= "Information Technology".equals(pf) ? "selected" : "" %>>Information Technology</option>
                        <option value="Software Engineering" <%= "Software Engineering".equals(pf) ? "selected" : "" %>>Software Engineering</option>
                        <option value="Data Science" <%= "Data Science".equals(pf) ? "selected" : "" %>>Data Science</option>
                        <option value="Cybersecurity" <%= "Cybersecurity".equals(pf) ? "selected" : "" %>>Cybersecurity</option>
                    </select>
                    <button type="submit" class="btn btn-gold">FILTER</button>
                    <% if(s != null || pf != null) { %><a href="viewProfiles.jsp" class="btn btn-purple">RESET</a><% } %>
                </form>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 50px;">No</th>
                            <th>Full Name</th>
                            <th>Student ID</th>
                            <th>Program</th>
                            <th>Email</th>
                            <th>Hobbies</th>
                            <th>Introduction</th>
                            <th style="text-align: center; width: 150px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (filteredProfiles.isEmpty()) { %>
                            <tr><td colspan="8" style="text-align:center; padding: 50px;">No records found.</td></tr>
                        <% } else {
                            int counter = 0;
                            for (ProfileBean p : filteredProfiles) { counter++; %>
                            <tr>
                                <td><%= counter %></td>
                                <td style="font-weight: bold; color: var(--uitm-blue);"><%= p.getName() %></td>
                                <td><%= p.getStudentId() %></td>
                                <td><%= p.getProgram() %></td>
                                <td style="font-size: 0.9rem; color: #555;"><%= p.getEmail() %></td>
                                <td>
                                    <% if (p.getHobbies() != null && !p.getHobbies().isEmpty()) {
                                        for (String h : p.getHobbies().split(",")) { %>
                                            <span class="hobby-badge"><%= h.trim() %></span>
                                    <% } } %>
                                </td>
                                <td class="col-intro">
                                    <%= (p.getIntroduction() != null && p.getIntroduction().length() > 80) ? p.getIntroduction().substring(0, 80) + "..." : p.getIntroduction() %>
                                </td>
                                <td style="text-align: center;">
                                    <a href="editProfile.jsp?id=<%= p.getId() %>" style="color: var(--uitm-purple); margin-right: 15px; font-size: 1.1rem;"><i class="fas fa-edit"></i></a>
                                    <a href="javascript:void(0)" onclick="showDeletePopup('<%= p.getId() %>', '<%= p.getName() %>')" style="color: #e74c3c; font-size: 1.1rem;"><i class="fas fa-trash-alt"></i></a>
                                </td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 Universiti Teknologi MARA (UiTM)
    </footer>

    <script>
        let currentDeleteId = null;
        function showDeletePopup(id, name) {
            currentDeleteId = id;
            document.getElementById('deleteMessageText').innerHTML = "Delete profile for <b>" + name + "</b>?<br>This action is permanent.";
            document.getElementById('deleteModal').style.display = 'flex';
        }
        document.getElementById('confirmDeleteBtn').onclick = function() {
            if(currentDeleteId) window.location.href = "DeleteProfileServlet?id=" + currentDeleteId;
        };
        function closeModal(id) { document.getElementById(id).style.display = 'none'; }
        window.onload = function() {
            const params = new URLSearchParams(window.location.search);
            if (params.has('deleted')) {
                document.getElementById('successText').innerText = "Record has been deleted successfully!";
                document.getElementById('successModal').style.display = 'flex';
            }
            if (params.has('updated')) {
                document.getElementById('successText').innerText = "Profile has been updated successfully!";
                document.getElementById('successModal').style.display = 'flex';
            }
        };
    </script>
</body>
</html>