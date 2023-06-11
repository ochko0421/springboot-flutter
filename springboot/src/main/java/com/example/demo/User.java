package com.example.demo;

import org.springframework.data.mongodb.core.mapping.Document;

@Document("userData")
public class User {
    private String firstName;
    private String lastName;
    private String gender;
    private String date;
    private double amount;

    public User(String firstName, String lastName, String gender, String date, double amount) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.date = date;
        this.amount = amount;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
