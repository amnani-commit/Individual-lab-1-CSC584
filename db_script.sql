CREATE TABLE profile (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    student_id VARCHAR(20) NOT NULL UNIQUE,
    program VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hobbies TEXT,
    introduction TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);