<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Created - <%= request.getAttribute("name") != null ? request.getAttribute("name") : "User" %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-purple: #6a0dad;
            --light-purple: #9b59b6;
            --dark-purple: #4b0082;
            --primary-gold: #ffd700;
            --light-gold: #fff9c4;
            --dark-gold: #fbc02d;
            --white: #ffffff;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #495057;
            --text-dark: #2c3e50;
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--gradient);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
            padding: 2rem 0;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(255, 215, 0, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(155, 89, 182, 0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        .profile-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 
                var(--shadow),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
            transform: translateY(0);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 
                0 15px 40px rgba(0, 0, 0, 0.15),
                0 0 0 1px rgba(255, 255, 255, 0.3);
        }

        .profile-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-gold), var(--primary-purple));
            border-radius: 4px 4px 0 0;
        }

        .header {
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
        }

        .header h1 {
            color: var(--dark-purple);
            font-size: 2.8rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--dark-purple), var(--primary-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .accent-bar {
            height: 4px;
            background: linear-gradient(90deg, var(--primary-gold), var(--primary-purple), var(--light-purple));
            border-radius: 2px;
            margin: 1.5rem auto;
            width: 80px;
            position: relative;
        }

        .accent-bar::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: inherit;
            border-radius: inherit;
            filter: blur(3px);
            opacity: 0.7;
        }

        .profile-content {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 3rem;
            align-items: start;
        }

        .profile-sidebar {
            text-align: center;
            padding: 2.5rem 2rem;
            background: linear-gradient(135deg, var(--light-gray), var(--white));
            border-radius: 16px;
            border: 1px solid var(--medium-gray);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            position: sticky;
            top: 2rem;
        }

        .avatar {
            width: 140px;
            height: 140px;
            background: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--white);
            font-size: 3rem;
            font-weight: bold;
            border: 4px solid var(--primary-gold);
            box-shadow: 0 8px 25px rgba(106, 13, 173, 0.3);
            transition: all 0.3s ease;
        }

        .avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 12px 35px rgba(106, 13, 173, 0.4);
        }

        .profile-name {
            color: var(--dark-purple);
            margin-bottom: 0.5rem;
            font-weight: 700;
            font-size: 1.6rem;
        }

        .profile-program {
            color: var(--primary-purple);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .profile-id {
            color: var(--dark-gray);
            font-size: 0.95rem;
            background: var(--light-gray);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            display: inline-block;
            margin-top: 0.5rem;
        }

        .profile-details {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .section {
            margin-bottom: 2.5rem;
            background: var(--white);
            padding: 2rem;
            border-radius: 16px;
            border: 1px solid var(--medium-gray);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .section:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .section-title {
            color: var(--dark-purple);
            margin-bottom: 1.5rem;
            padding-bottom: 0.8rem;
            border-bottom: 3px solid var(--primary-gold);
            font-weight: 700;
            font-size: 1.4rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .section-title i {
            color: var(--primary-purple);
            font-size: 1.2rem;
        }

        .detail-group {
            margin-bottom: 1.8rem;
        }

        .detail-label {
            font-weight: 600;
            color: var(--dark-purple);
            margin-bottom: 0.8rem;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-label i {
            color: var(--primary-gold);
            font-size: 0.9rem;
        }

        .detail-value {
            background: linear-gradient(135deg, var(--light-gray), var(--white));
            padding: 1.2rem;
            border-radius: 12px;
            border-left: 4px solid var(--primary-gold);
            color: var(--text-dark);
            line-height: 1.7;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .hobbies-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
            margin-top: 0.8rem;
        }

        .hobby-tag {
            background: linear-gradient(135deg, var(--light-gold), var(--primary-gold));
            color: var(--dark-purple);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid rgba(180, 149, 31, 0.2);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(255, 215, 0, 0.2);
        }

        .hobby-tag:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 215, 0, 0.3);
        }

        .actions {
            text-align: center;
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid var(--medium-gray);
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            background: linear-gradient(135deg, var(--primary-purple), var(--dark-purple));
            color: white;
            text-decoration: none;
            padding: 1.2rem 2.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(106, 13, 173, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-back::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-back:hover::before {
            left: 100%;
        }

        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 
                0 8px 25px rgba(106, 13, 173, 0.4),
                0 0 0 1px rgba(255, 255, 255, 0.2);
        }

        @media (max-width: 768px) {
            .profile-content {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
            
            .profile-card {
                padding: 2.5rem 1.8rem;
            }
            
            .profile-sidebar {
                position: relative;
                top: 0;
            }
            
            .header h1 {
                font-size: 2.2rem;
            }
            
            .avatar {
                width: 120px;
                height: 120px;
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-card">
            <div class="header">
                <h1>Profile Created Successfully!</h1>
                <div class="accent-bar"></div>
            </div>
            
            <div class="profile-content">
                <div class="profile-sidebar">
                    <div class="avatar">
                        <%= request.getAttribute("name") != null ? 
                            ((String)request.getAttribute("name")).substring(0, 1).toUpperCase() : "U" %>
                    </div>
                    <h3 class="profile-name"><%= request.getAttribute("name") != null ? request.getAttribute("name") : "User" %></h3>
                    <p class="profile-program"><%= request.getAttribute("program") != null ? request.getAttribute("program") : "Program" %></p>
                    <div class="profile-id">
                        <i class="fas fa-id-card"></i> 
                        <%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : "N/A" %>
                    </div>
                </div>
                
                <div class="profile-details">
                    <div class="section">
                        <h3 class="section-title">
                            <i class="fas fa-user-circle"></i> Personal Information
                        </h3>
                        
                        <div class="detail-group">
                            <div class="detail-label">
                                <i class="fas fa-qrcode"></i> Student ID
                            </div>
                            <div class="detail-value">
                                <%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : "N/A" %>
                            </div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">
                                <i class="fas fa-envelope"></i> Email Address
                            </div>
                            <div class="detail-value">
                                <%= request.getAttribute("email") != null ? request.getAttribute("email") : "N/A" %>
                            </div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">
                                <i class="fas fa-heart"></i> Hobbies & Interests
                            </div>
                            <div class="detail-value">
                                <% 
                                    String hobbies = (String) request.getAttribute("hobbies");
                                    if (hobbies != null && !hobbies.trim().isEmpty()) {
                                        String[] hobbiesArray = hobbies.split(",");
                                %>
                                    <div class="hobbies-list">
                                        <% for (String hobby : hobbiesArray) { %>
                                            <span class="hobby-tag"><%= hobby.trim() %></span>
                                        <% } %>
                                    </div>
                                <% } else { %>
                                    <em style="color: var(--dark-gray);">No hobbies specified</em>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="detail-group">
                            <div class="detail-label">
                                <i class="fas fa-comment-dots"></i> Self Introduction
                            </div>
                            <div class="detail-value" style="font-style: italic; line-height: 1.7;">
                                "<%= request.getAttribute("introduction") != null ? request.getAttribute("introduction") : "No introduction provided." %>"
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="actions">
                <a href="index.html" class="btn-back">
                    <i class="fas fa-plus"></i> Create Another Profile
                </a>
            </div>
        </div>
    </div>
</body>
</html>