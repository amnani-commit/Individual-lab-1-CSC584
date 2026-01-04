<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.profileapp.ProfileBean" %>
<%

    ProfileBean p = (ProfileBean) session.getAttribute("profile");
    String showSuccess = (String) session.getAttribute("showSuccess");
    
    if (p == null) {
        response.sendRedirect("index.html"); 
        return;
    }

    session.removeAttribute("showSuccess");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Details | ISTUDENT PROFILE</title>
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
            display: flex; 
            justify-content: center; 
            align-items: center; 
            padding: 40px 20px; 
        }

        .profile-card {
            background: white; 
            width: 100%; 
            max-width: 900px; 
            display: flex;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); 
            border: 1px solid var(--border-color);
            border-radius: 4px; 
            overflow: hidden;
        }

        .sidebar {
            background: var(--uitm-blue);
            color: white;
            width: 35%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-right: 5px solid var(--uitm-gold);
            text-align: center;
        }

        .avatar-box {
            background: white;
            width: 120px;
            height: 120px;
            border: 4px solid var(--uitm-gold);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .avatar-box span { 
            color: var(--uitm-purple);
            font-size: 60px;
            font-weight: bold;
        }

        .sidebar h2 { 
            font-size: 20px;
            text-transform: uppercase;
            margin-bottom: 10px;
        }

        .prog-badge {
            background: var(--uitm-purple);
            color: white;
            padding: 5px 15px;
            border-left: 4px solid var(--uitm-gold);
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .content { 
            padding: 40px;
            width: 65%;
        }

        .content h1 { 
            color: var(--uitm-blue);
            text-transform: uppercase;
            border-bottom: 2px solid var(--uitm-purple);
            padding-bottom: 10px;
            margin-bottom: 30px;
            font-size: 22px;
        }

        .info-row { 
            display: flex;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        .label { 
            width: 150px;
            color: var(--uitm-purple);
            font-weight: bold;
            text-transform: uppercase;
            font-size: 13px;
        }

        .value { 
            color: var(--uitm-blue);
            font-size: 15px;
        }

        .hobby-tag { 
            background: var(--uitm-blue);
            color: white;
            padding: 3px 10px;
            font-size: 11px;
            border-radius: 2px;
            margin-right: 5px;
        }

        .intro-box { 
            background: #f9f9f9;
            padding: 20px;
            border-left: 5px solid var(--uitm-gold);
            margin: 20px 0;
            font-style: italic;
            color: #555;
            line-height: 1.6;
        }

        /* --- BUTANG DI BAWAH LAGI --- */
        .btn-row { 
            display: flex;
            gap: 12px;
            margin-top: 50px; /* Jarak ke bawah ditambah */
            justify-content: flex-end; 
        }

        .btn { 
            background: var(--uitm-blue);
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            font-size: 0.85rem;
            text-transform: uppercase;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            border-bottom: 3px solid #001a38;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn:hover { 
            background: var(--uitm-purple); 
            border-bottom-color: #4a1556; 
        }

        .modal-overlay {
            display: <%= (showSuccess != null) ? "flex" : "none" %>;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
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
            border-radius: 4px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border-top: 8px solid #2ecc71;
        }

        .modal-icon-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #2ecc71;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 40px;
            color: white;
        }

        .btn-dismiss {
            width: 100%;
            background-color: var(--uitm-blue);
            color: white;
            padding: 10px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            text-transform: uppercase;
            margin-top: 20px;
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
    <div class="modal-content">
        <div class="modal-icon-circle"><i class="fas fa-check"></i></div>
        <div style="font-size: 24px; font-weight: bold; color: var(--uitm-blue); margin-bottom: 10px;">SUCCESSFUL</div>
        <div style="font-size: 16px; color: #666;">Profile saved successfully!</div>
        <button onclick="document.getElementById('successModal').style.display='none'" class="btn-dismiss">DISMISS</button>
    </div>
</div>

<div class="container">
    <div class="profile-card">
        <div class="sidebar">
            <div class="avatar-box">
                <span><%= p.getName().substring(0,1).toUpperCase() %></span>
            </div>
            <h2><%= p.getName() %></h2>
            <div class="prog-badge"><%= p.getProgram() %></div>
        </div>

        <div class="content">
            <h1>PROFILE INFORMATION</h1>
            
            <div class="info-row">
                <span class="label">Full Name</span>
                <span class="value"><%= p.getName() %></span>
            </div>
            <div class="info-row">
                <span class="label">Student ID</span>
                <span class="value"><%= p.getStudentId() %></span>
            </div>
            <div class="info-row">
                <span class="label">Academic Program</span>
                <span class="value"><%= p.getProgram() %></span>
            </div>
            <div class="info-row">
                <span class="label">Email Address</span>
                <span class="value"><%= p.getEmail() %></span>
            </div>
            <div class="info-row">
                <span class="label">Hobbies</span>
                <div style="display: flex; gap: 5px; flex-wrap: wrap;">
                    <% 
                        if(p.getHobbies() != null && !p.getHobbies().isEmpty()) {
                            for(String s : p.getHobbies().split(",")) { 
                    %>
                        <span class="hobby-tag"><%= s.trim() %></span>
                    <% 
                            } 
                        } 
                    %>
                </div>
            </div>

            <div class="intro-box">
                "<%= p.getIntroduction() %>"
            </div>

            <div class="btn-row">
                <a href="index.html" class="btn"><i class="fas fa-home" style="margin-right: 8px;"></i> HOME</a>
            </div>
        </div>
    </div>
</div>

<footer>
    &copy; 2025 UNIVERSITI TEKNOLOGI MARA (UITM)
</footer>

</body>
</html>