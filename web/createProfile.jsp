<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.profileapp.ProfileBean" %>
<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    String name = "";
    String studentId = "";
    String program = "";
    String email = "";
    String hobbies = "";
    String introduction = "";
    
    if (profile != null) {
        name = profile.getName() != null ? profile.getName() : "";
        studentId = profile.getStudentId() != null ? profile.getStudentId() : "";
        program = profile.getProgram() != null ? profile.getProgram() : "";
        email = profile.getEmail() != null ? profile.getEmail() : "";
        hobbies = profile.getHobbies() != null ? profile.getHobbies() : "";
        introduction = profile.getIntroduction() != null ? profile.getIntroduction() : "";
    }
    
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("message");
    boolean hasError = error != null && !error.trim().isEmpty();
    boolean hasSuccess = success != null && !success.trim().isEmpty();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Enrolment | ISTUDENT PROFILE</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            
            --uitm-blue: #002b5c;      
            --uitm-purple: #702082;    
            --uitm-gold: #ffcc00;      
            --uitm-light: #f8f9fa;
            --white: #ffffff;
            --error-red: #d63031;
            --success-green: #2ecc71;
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
            background-image: radial-gradient(var(--border-color) 0.5px, transparent 0.5px);
            background-size: 20px 20px;
            color: var(--uitm-blue);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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

        /* Main Container */
        .container { 
            max-width: 900px; 
            margin: 3rem auto; 
            padding: 0 20px; 
            flex: 1; 
        }

        .form-card {
            background: var(--white);
            border: 1px solid var(--border-color);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border-radius: 4px;
            overflow: hidden;
        }

        .form-header {
            background: var(--uitm-purple);
            color: white;
            padding: 2rem;
            text-align: center;
            border-bottom: 4px solid var(--uitm-gold);
        }

        .form-body { padding: 3rem; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 1.5rem; }
        .form-group { margin-bottom: 1.5rem; }

        label { display: block; margin-bottom: 0.5rem; font-weight: 600; text-transform: uppercase; font-size: 0.8rem; color: #555; }

        input, select, textarea {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid var(--border-color);
            font-size: 1rem;
            transition: 0.3s;
            background: #fafafa;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--uitm-purple);
            background: var(--white);
            box-shadow: 0 0 0 3px rgba(112, 32, 130, 0.1);
        }

        .btn-submit {
            background: var(--uitm-blue);
            color: white;
            border: none;
            padding: 1rem 2rem;
            font-size: 1rem;
            text-transform: uppercase;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: 0.3s;
            border-bottom: 4px solid #001a38;
        }

        .btn-submit:hover { background: var(--uitm-purple); border-bottom-color: #4a1556; }

        .modal-overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.7);
            display: none; 
            align-items: center; justify-content: center;
            z-index: 1000;
        }

        .modal-box {
            background: white;
            padding: 2.5rem;
            text-align: center;
            max-width: 450px;
            width: 90%;
            border-radius: 4px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            animation: popIn 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes popIn {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-box i { font-size: 4rem; margin-bottom: 1.5rem; }
        .modal-box.error-modal { border-top: 10px solid var(--error-red); }
        .modal-box.error-modal i { color: var(--error-red); }
        .modal-box.success-modal { border-top: 10px solid var(--success-green); }
        .modal-box.success-modal i { color: var(--success-green); }

        .btn-modal {
            margin-top: 1.5rem;
            padding: 0.8rem 2rem;
            background: var(--uitm-blue);
            color: white;
            border: none;
            text-transform: uppercase;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
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

    <div class="modal-overlay" id="statusModal">
        <div class="modal-box" id="modalBox">
            <i id="modalIcon" class="fas"></i>
            <h2 id="modalTitle" style="color: var(--uitm-blue); margin-bottom: 0.5rem;"></h2>
            <p id="modalMessage" style="color: #666; line-height: 1.5;"></p>
            <button class="btn-modal" onclick="closeModal()">Dismiss</button>
        </div>
    </div>

    <div class="container">
        <div class="form-card">
            <div class="form-header"><h1>NEW STUDENT PROFILE</h1></div>
            <div class="form-body">
                <form action="ProfileServlet" method="POST" id="profileForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Student Name<span style="color:red">*</span></label>
                            <input type="text" id="name" name="name" value="<%= name %>" required placeholder="Full name">
                        </div>
                        <div class="form-group">
                            <label for="studentId">Student ID <span style="color:red">*</span></label>
                            <input type="text" id="studentId" name="studentId" value="<%= studentId %>" required 
                                   placeholder="e.g. 2023123456"
                                   oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="program">Academic Program <span style="color:red">*</span></label>
                            <select id="program" name="program" required>
                                <option value="">-- Please Select --</option>
                                <option value="Computer Science" <%= "Computer Science".equals(program) ? "selected" : "" %>>Computer Science</option>
                                <option value="Information Technology" <%= "Information Technology".equals(program) ? "selected" : "" %>>Information Technology</option>
                                <option value="Software Engineering" <%= "Software Engineering".equals(program) ? "selected" : "" %>>Software Engineering</option>
                                <option value="Data Science" <%= "Data Science".equals(program) ? "selected" : "" %>>Data Science</option>
                                <option value="Cybersecurity" <%= "Cybersecurity".equals(program) ? "selected" : "" %>>Cybersecurity</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="email"> Email <span style="color:red">*</span></label>
                            <input type="email" id="email" name="email" value="<%= email %>" required placeholder="email@gmail.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="hobbies">Hobbies & Interests</label>
                        <textarea id="hobbies" name="hobbies" placeholder="Separated by commas"><%= hobbies %></textarea>
                    </div>
                    <div class="form-group">
                        <label for="introduction">Self Introduction <span style="color:red">*</span></label>
                        <textarea id="introduction" name="introduction" required placeholder="Brief intro..."><%= introduction %></textarea>
                    </div>
                    <button type="submit" class="btn-submit" id="submitBtn">
                        <i></i> Submit Registration
                    </button>
                </form>
                <div style="text-align:center; margin-top:20px;">
                    <a href="index.html" style="color:var(--uitm-blue); text-decoration:none; font-size:0.9rem;"><i class="fas fa-arrow-left"></i> Return Home</a>
                </div>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2025 Universiti Teknologi MARA (UiTM)
    </footer>

    <script>
        const modal = document.getElementById('statusModal');
        const modalBox = document.getElementById('modalBox');
        const modalIcon = document.getElementById('modalIcon');
        const modalTitle = document.getElementById('modalTitle');
        const modalMessage = document.getElementById('modalMessage');

        function showPopup(type, title, msg) {
            modalBox.className = 'modal-box ' + (type === 'error' ? 'error-modal' : 'success-modal');
            modalIcon.className = 'fas ' + (type === 'error' ? 'fa-exclamation-circle' : 'fa-check-circle');
            modalTitle.innerText = title;
            modalMessage.innerText = msg;
            modal.style.display = 'flex';
        }

        function closeModal() {
            modal.style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function() {
            <% if (hasError) { 
                String popupTitle = "Input Error";
                String cleanError = error.replace("'", "\\'");
                if (error.toLowerCase().contains("already exists")) {
                    popupTitle = "ID Used";
                    cleanError = "Student ID has been used. Please re-enter a unique Student ID.";
                }
            %>
                showPopup('error', '<%= popupTitle %>', '<%= cleanError %>');
                document.getElementById('studentId').focus();
            <% } %>

            <% if (hasSuccess) { %>
                showPopup('success', 'Successful', '<%= success.replace("'", "\\'") %>');
            <% } %>

            document.getElementById('profileForm').addEventListener('submit', function(e) {
                const sid = document.getElementById('studentId').value;
                if (!/^\d+$/.test(sid)) {
                    e.preventDefault();
                    showPopup('error', 'Invalid ID', 'Student ID must contain numbers only!');
                    return;
                }
                document.getElementById('submitBtn').disabled = true;
                document.getElementById('submitBtn').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            });
        });
    </script>
</body>
</html>