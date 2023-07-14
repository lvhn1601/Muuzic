/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author lvhn1
 */
public class Track {
    private int id;
    private String title;
    private String genre;
    private List<Artist> artist;
    private String trackURL;
    private String coverURL;
    private String detail;

    public Track() {
    }

    public Track(int id, String title, String genre, List<Artist> artist, String trackURL, String coverURL, String detail) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.artist = artist;
        this.trackURL = trackURL;
        this.coverURL = coverURL;
        this.detail = detail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public List<Artist> getArtist() {
        return artist;
    }

    public void setArtist(List<Artist> artist) {
        this.artist = artist;
    }

    public String getTrackURL() {
        return trackURL;
    }

    public void setTrackURL(String trackURL) {
        this.trackURL = trackURL;
    }

    public String getCoverURL() {
        return coverURL;
    }

    public void setCoverURL(String coverURL) {
        this.coverURL = coverURL;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
    
    public String artistsToString() {
        String ret = "";
        for (Artist x : artist) {
            ret += x.getDisplayName() + ", ";
        }
        return ret.substring(0, ret.lastIndexOf(','));
    }
}
