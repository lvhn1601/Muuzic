/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author lvhn1
 */
public class AccInfo {
    private String username;
    private String fname;
    private String lname;
    private String displayName;
    private String city;
    private String country;
    private String bio;
    private String email;
    private boolean gender;
    private boolean isAuthen;
    private String avatarURL;
    private String wallpaperURL;

    public AccInfo() {
    }

    public AccInfo(String username, String fname, String lname, String displayName, String city, String country, String bio, String email, boolean gender, boolean isAuthen, String avatarURL, String wallpaperURL) {
        this.username = username;
        this.fname = fname;
        this.lname = lname;
        this.displayName = displayName;
        this.city = city;
        this.country = country;
        this.bio = bio;
        this.email = email;
        this.gender = gender;
        this.isAuthen = isAuthen;
        this.avatarURL = avatarURL;
        this.wallpaperURL = wallpaperURL;
    }

    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public boolean isIsAuthen() {
        return isAuthen;
    }

    public void setIsAuthen(boolean isAuthen) {
        this.isAuthen = isAuthen;
    }

    public String getAvatarURL() {
        return avatarURL;
    }

    public void setAvatarURL(String avatarURL) {
        this.avatarURL = avatarURL;
    }

    public String getWallpaperURL() {
        return wallpaperURL;
    }

    public void setWallpaperURL(String wallpaperURL) {
        this.wallpaperURL = wallpaperURL;
    }
    
    
}
