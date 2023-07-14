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

/**
 *
 * @author lvhn1
 */
public class StatsDAO extends DBContext {

    public int getTotalNum(int id) {
        String sql = "SELECT COUNT(username) AS num FROM dbo.TrackStream\n"
                + "WHERE track_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public int getNumInDate(String date, String username) {
        String sql = "SELECT COUNT(*) - COUNT(username) + COUNT(username) AS num FROM dbo.TrackStream\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = TrackStream.track_id\n"
                + "WHERE date BETWEEN ? + ' 00:00:00.000' AND ? + ' 23:59:59.999' AND artist = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, date);
            ps.setString(3, username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    public int getNumInDate(String date, int id) {
        String sql = "SELECT COUNT(*) - COUNT(username) + COUNT(username) AS num FROM dbo.TrackStream\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = TrackStream.track_id\n"
                + "WHERE date BETWEEN ? + ' 00:00:00.000' AND ? + ' 23:59:59.999' AND Track_Artist.track_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, date);
            ps.setInt(3, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    public List<String> getTopFan(String artist, int id) {
        String sql = "SELECT TOP 5 Account.username FROM dbo.Account\n"
                + "JOIN dbo.TrackStream ON TrackStream.username = Account.username\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = TrackStream.track_id\n"
                + "WHERE artist = ?" + (id == 0 ? "" : " AND TrackStream.track_id = ?") + "\n"
                + "GROUP BY Account.username\n"
                + "ORDER BY COUNT(TrackStream.username) DESC";

        List<String> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, artist);
            if (id != 0)
                ps.setInt(2, id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("username"));
            }
        } catch (SQLException e) {
        }

        return list;
    }

    public int getNumOfFan(String artist, String username, int id) {
        String sql = "SELECT COUNT(username) AS num FROM dbo.TrackStream\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.track_id = TrackStream.track_id\n"
                + "WHERE artist = ? AND username = ?" + (id==0 ? "" : " AND TrackStream.track_id = ?");

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, artist);
            ps.setString(2, username);
            if (id != 0)
                ps.setInt(3, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("num");
            }
        } catch (SQLException e) {
        }

        return 0;
    }
}
