/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Artist;
import model.Genre;
import model.Track;

/**
 *
 * @author lvhn1
 */
public class MusicDAO extends DBContext {

    public void addTrack(String title, int genreID, String artists, String detail, String trackURL, String coverURL) {
        String sql = "INSERT dbo.Track (title, track_url, cover_url, genre_ID, detail) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, trackURL);
            ps.setString(3, coverURL);
            ps.setInt(4, genreID);
            ps.setString(5, detail);

            ps.executeQuery();
        } catch (SQLException e) {
        }

        String[] listArtist = artists.split(",");
        int trackID = getNewID();
        for (String ar : listArtist) {
            addTrackArtist(trackID, ar.trim());
        }
    }

    public int getNewID() {
        String sql = "SELECT MAX(id) AS [maxid] FROM dbo.Track";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("maxid");
            }
        } catch (SQLException e) {
        }

        return 1;
    }

    public void updateTrack(int id, String title, int genreID, String artists, String coverURL) {
        String sql;
        if (coverURL.equals("")) {
            sql = "UPDATE dbo.Track SET title = ?, genre_ID = ?\n"
                    + "WHERE id = ?";
        } else {
            sql = "UPDATE dbo.Track SET title = ?, genre_ID = ?, cover_url = ?\n"
                    + "WHERE id = ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2, genreID);

            if (coverURL.equals("")) {
                ps.setInt(3, id);
            } else {
                ps.setString(3, coverURL);
                ps.setInt(4, id);
            }

            ps.executeUpdate();
        } catch (SQLException e) {
        }

        deleteTrackArtist(id);
        String[] listArtist = artists.split(",");
        for (String ar : listArtist) {
            addTrackArtist(id, ar.trim());
        }
    }

    public void deleteTrack(int id) {

        deleteTrackArtist(id);

        String sql = "DELETE FROM dbo.Track_Artist WHERE track_id = ?\n"
                + "DELETE FROM dbo.TrackStream WHERE track_id = ?\n"
                + "DELETE FROM dbo.Track WHERE id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, id);
            ps.setInt(3, id);

            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void addTrackArtist(int trackID, String aUsername) {
        String sql = "INSERT dbo.Track_Artist VALUES (?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trackID);
            ps.setString(2, aUsername);

            ps.executeQuery();
        } catch (SQLException e) {
        }
    }

    public void deleteTrackArtist(int trackID) {
        String sql = "DELETE dbo.Track_Artist WHERE track_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trackID);

            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<Genre> listGenre() {
        String sql = "SELECT * FROM dbo.Genre";
        List<Genre> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Genre(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Track getTrack(int trackId) {
        String sql = "SELECT Track.id, title, name, track_url, cover_url FROM dbo.Track\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "WHERE Track.id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trackId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Track(trackId, rs.getString("title"), rs.getString("name"), getArtists(trackId), rs.getString("track_url"), rs.getString("cover_url"), null);
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public List<Artist> getArtists(int trackID) {
        String sql = "SELECT track_id, artist, display_name FROM dbo.Track_Artist\n"
                + "JOIN dbo.Acc_info ON Acc_info.username = Track_Artist.artist\n"
                + "WHERE track_id = ?";
        List<Artist> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trackID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Artist(rs.getString("artist"), rs.getString("display_name")));
            }
        } catch (SQLException e) {
        }

        return list;
    }

    public String getfArtist(int id, String username) {
        String sql = "SELECT artist FROM dbo.Track_Artist\n"
                + "WHERE track_id = ? AND artist != ?";
        String str = "";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, username);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                str += rs.getString("artist");
            }
        } catch (SQLException e) {
        }

        return str;
    }

    public List<Track> getListTrack(String artist) {
        String sql = "SELECT Track.id, title, name, track_url, cover_url FROM dbo.Track\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = Track.id\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "WHERE artist = ?\n"
                + "ORDER BY id DESC";
        List<Track> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, artist);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Track(rs.getInt("id"), rs.getString("title"), rs.getString("name"), getArtists(rs.getInt("id")), rs.getString("track_url"), rs.getString("cover_url"), null));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public void addStream(int trackId) {
        String sql = "INSERT dbo.TrackStream (track_id) VALUES (?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trackId);

            ps.execute();
        } catch (SQLException e) {
        }
    }

    public void addStream(int trackId, String username) {
        String sql = "INSERT dbo.TrackStream (track_id, username) VALUES (?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, trackId);
            ps.setString(2, username);

            ps.execute();
        } catch (SQLException e) {
        }
    }

    public List<Track> searchTrack(String search, int genId, String order, String arr) {
        String sql = "SELECT id, title, genre_ID, cover_url, track_url, COUNT(id) FROM dbo.Track\n"
                + "LEFT JOIN dbo.TrackStream ON Track.id = TrackStream.track_id\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = Track.id\n"
                + "WHERE (title LIKE ? OR artist LIKE ?)" + (genId == -1 ? "\n" : "AND genre_ID = ?\n")
                + "GROUP BY id, title, genre_ID, cover_url, track_url\n"
                + "ORDER BY " + order + " " + arr;
        List<Track> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            if (genId != -1)
                ps.setInt(3, genId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Track(rs.getInt("id"), rs.getString("title"), null, getArtists(rs.getInt("id")), rs.getString("track_url"), rs.getString("cover_url"), null));
            }
        } catch (SQLException e) {
        }

        return list;
    }

    public String getRecGenre(String username) {
        String sql = "SELECT TOP 1 name FROM dbo.Track\n"
                + "JOIN dbo.TrackStream ON TrackStream.track_id = Track.id\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "WHERE username = ?\n"
                + "ORDER BY date DESC";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public List<Track> listFollowNewest(String username) {
        String sql = "SELECT DISTINCT TOP 20 Track.id, title, track_url, cover_url, name FROM dbo.Track\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = Track.id\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "WHERE artist IN (\n"
                + "	SELECT Acc_info.username FROM dbo.Follow \n"
                + "	JOIN dbo.Acc_info ON Acc_info.username = Follow.follow\n"
                + "	WHERE Follow.username = ?\n"
                + ") ORDER BY Track.id DESC";

        List<Track> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Track(rs.getInt("id"), rs.getString("title"), rs.getString("name"), getArtists(rs.getInt("id")), rs.getString("track_url"), rs.getString("cover_url"), null));

            }
        } catch (SQLException e) {
        }

        return list;
    }

    public List<Track> listRecently(String username) {
        String sql = "SELECT TOP 20 Track.id, title, track_url, cover_url, name FROM dbo.Track\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "JOIN dbo.TrackStream ON TrackStream.track_id = Track.id\n"
                + "WHERE username = ?\n"
                + "GROUP BY Track.id, title, track_url, cover_url, name\n"
                + "ORDER BY MAX(date) DESC";

        List<Track> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Track(rs.getInt("id"), rs.getString("title"), rs.getString("name"), getArtists(rs.getInt("id")), rs.getString("track_url"), rs.getString("cover_url"), null));

            }
        } catch (SQLException e) {
        }

        return list;
    }

    public List<Track> listTop() {
        String sql = "SELECT TOP 20 Track.id, title, track_url, cover_url, name FROM dbo.Track\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "LEFT JOIN dbo.TrackStream ON TrackStream.track_id = Track.id\n"
                + "GROUP BY dbo.Track.id, title, track_url, cover_url, name\n"
                + "ORDER BY COUNT(track_id) DESC";

        List<Track> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Track(rs.getInt("id"), rs.getString("title"), rs.getString("name"), getArtists(rs.getInt("id")), rs.getString("track_url"), rs.getString("cover_url"), null));

            }
        } catch (SQLException e) {
        }

        return list;
    }

    public List<Track> listTop(String genre, int top) {
        String sql = "SELECT TOP " + top + " Track.id, title, track_url, cover_url, name FROM dbo.Track\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "LEFT JOIN dbo.TrackStream ON TrackStream.track_id = Track.id\n"
                + "WHERE name = ?\n"
                + "GROUP BY dbo.Track.id, title, track_url, cover_url, name\n"
                + "ORDER BY COUNT(track_id) DESC";
        List<Track> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, genre);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Track(rs.getInt("id"), rs.getString("title"), rs.getString("name"), getArtists(rs.getInt("id")), rs.getString("track_url"), rs.getString("cover_url"), null));
            }
        } catch (SQLException e) {
        }

        return list;
    }
}
