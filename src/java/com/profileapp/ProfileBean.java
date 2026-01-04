package com.profileapp;

import java.io.Serializable;
import java.sql.Timestamp;

public class ProfileBean implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String name;
    private String studentId;
    private String program;
    private String email;
    private String hobbies;
    private String introduction;
    private Timestamp createdAt;
    
    
    // Default constructor 
    public ProfileBean() {
    }
    
    // Constructor with parameter (
    public ProfileBean(String name, String studentId, String program, 
                       String email, String hobbies, String introduction) {
        this.name = name;
        this.studentId = studentId;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.introduction = introduction;
    }
    
    // Constructor with all field
    public ProfileBean(int id, String name, String studentId, String program, 
                       String email, String hobbies, String introduction, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.studentId = studentId;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.introduction = introduction;
        this.createdAt = createdAt;
    }
    
    // 3. Public getters and setters
    
    // Getter and setter untuk id
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    // Getter and setter untuk name
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    // Getter and setter for studentId
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    // Getter and setter for program
    public String getProgram() {
        return program;
    }
    
    public void setProgram(String program) {
        this.program = program;
    }
    
    // Getter and setter for email
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    // Getter and setter for hobbies
    public String getHobbies() {
        return hobbies;
    }
    
    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }
    
    // Getter and setter for introduction
    public String getIntroduction() {
        return introduction;
    }
    
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
    
    // Getter and setter for createdAt
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    

    @Override
    public String toString() {
        return "ProfileBean{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", studentId='" + studentId + '\'' +
                ", program='" + program + '\'' +
                ", email='" + email + '\'' +
                ", hobbies='" + hobbies + '\'' +
                ", introduction='" + introduction + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}