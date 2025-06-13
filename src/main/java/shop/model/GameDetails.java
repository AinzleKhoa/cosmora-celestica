/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.model;

import java.sql.Date;

/**
 *
 * @author HoangSang
 */
public class GameDetails {
    private int gameDetailsId;
    private String developer;
    private String genre; 
    private Date releaseDate;

    public GameDetails() {
    }

    public GameDetails(int gameDetailsId, String developer, String genre, Date releaseDate) {
        this.gameDetailsId = gameDetailsId;
        this.developer = developer;
        this.genre = genre;
        this.releaseDate = releaseDate;
    }

    public int getGameDetailsId() {
        return gameDetailsId;
    }

    public void setGameDetailsId(int gameDetailsId) {
        this.gameDetailsId = gameDetailsId;
    }

    public String getDeveloper() {
        return developer;
    }

    public void setDeveloper(String developer) {
        this.developer = developer;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }
    
}
