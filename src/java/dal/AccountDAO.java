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
import model.AccInfo;
import model.Account;

/**
 *
 * @author lvhn1
 */
public class AccountDAO extends DBContext {

    public Account getAccount(String un, String pw) {
        String sql = "SELECT Acc_info.username, password, acc_role FROM dbo.Account JOIN dbo.Acc_info ON Acc_info.username = Account.username\n"
                + "WHERE (dbo.Acc_info.username = ? OR email = ?) AND password = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, un);
            ps.setString(2, un);
            ps.setString(3, pw);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(rs.getString("username"), rs.getString("password"), rs.getBoolean("acc_role"));
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public Account getAccount(String un) {
        String sql = "SELECT * FROM dbo.Account WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, un);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(rs.getString("username"));
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public boolean createAccount(String username, String email, String password, String displayName, String dob, String gender) {
        if (getAccount(username) != null) {
            return false;
        }

        String sql = "INSERT dbo.Account VALUES (?, ?, 0)\n"
                + "INSERT dbo.Acc_info (username, email, display_name, gender) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ps.setString(3, username);
            ps.setString(4, email);
            ps.setNString(5, displayName);
            ps.setBoolean(6, gender.equals("Male"));

            ps.executeQuery();
        } catch (SQLException e) {
        }

        return true;
    }

    public void editAccount(Account acc, String dname, String fname, String lname, String city, String country, String bio) {
        String sql = "UPDATE dbo.Acc_info SET display_name = ?, fname = ?, lname = ?, city = ?, country = ?, bio = ? WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setNString(1, dname);
            ps.setNString(2, fname);
            ps.setNString(3, lname);
            ps.setNString(4, city);
            ps.setNString(5, country);
            ps.setNString(6, bio);

            ps.setString(7, acc.getUsername());

            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void editAccImg(Account acc, String tag, String url) {
        String sql = "UPDATE dbo.Acc_info SET " + tag + " = ? WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, url);
            ps.setString(2, acc.getUsername());

            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public AccInfo getAccInfo(Account acc) {
        String sql = "SELECT * FROM dbo.Acc_info WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, acc.getUsername());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new AccInfo(rs.getString("username"), rs.getString("fname"), rs.getString("lname"), rs.getString("display_name"), rs.getString("city"), rs.getString("country"), rs.getString("bio"), rs.getString("email"), rs.getBoolean("gender"), rs.getBoolean("authen_artist"), rs.getString("avatar_url"), rs.getString("wallpaper_url"));
            }
        } catch (SQLException e) {
        }

        return null;
    }

    public boolean checkFollow(String user, String flwing) {
        String sql = "SELECT * FROM dbo.Follow WHERE username = ? AND follow = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, flwing);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }

    public void addFollow(String user, String flwing) {
        String sql = "INSERT dbo.Follow VALUES (?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, flwing);

            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteFollow(String user, String flwing) {
        String sql = "DELETE dbo.Follow WHERE username = ? AND follow = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, flwing);

            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public int countFollower(String username) {
        String sql = "SELECT COUNT(username) AS fnumber FROM dbo.Follow\n"
                + "WHERE follow = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("fnumber");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    public int countFollowing(String username) {
        String sql = "SELECT COUNT(follow) AS fnumber FROM dbo.Follow\n"
                + "WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("fnumber");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    public int countTracks(String username) {
        String sql = "SELECT COUNT(track_id) AS tnumber FROM dbo.Track_Artist\n"
                + "WHERE artist = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("tnumber");
            }
        } catch (SQLException e) {
        }

        return 0;
    }

    public List<AccInfo> searchArtist(String search, int genID) {
        String sql = "SELECT DISTINCT TOP 6 username, display_name, avatar_url FROM dbo.Acc_info\n"
                + "JOIN dbo.Track_Artist ON Track_Artist.artist = Acc_info.username\n"
                + "JOIN dbo.Track ON Track.id = Track_Artist.track_id\n"
                + "JOIN dbo.Genre ON Genre.id = Track.genre_ID\n"
                + "WHERE (username LIKE ? OR display_name LIKE ?)" + (genID == -1 ? "" : "AND Genre.id = ?");
        List<AccInfo> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            if (genID != -1)
                ps.setInt(3, genID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AccInfo acc = new AccInfo();
                acc.setUsername(rs.getString("username"));
                acc.setDisplayName(rs.getString("display_name"));
                acc.setAvatarURL(rs.getString("avatar_url"));
                list.add(acc);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<AccInfo> listTopAcc() {
        String sql = "SELECT Acc_info.username, display_name, avatar_url FROM dbo.Acc_info\n"
                + "LEFT JOIN dbo.Track_Artist ON Track_Artist.artist = Acc_info.username\n"
                + "JOIN dbo.TrackStream ON TrackStream.track_id = Track_Artist.track_id\n"
                + "GROUP BY Acc_info.username, display_name, avatar_url\n"
                + "ORDER BY COUNT(TrackStream.username) DESC";
        List<AccInfo> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AccInfo acc = new AccInfo();
                acc.setUsername(rs.getString("username"));
                acc.setDisplayName(rs.getString("display_name"));
                acc.setAvatarURL(rs.getString("avatar_url"));
                list.add(acc);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<AccInfo> recommendAcc(String username) {
        String sql = "SELECT TOP 10 Acc_info.username, display_name, avatar_url FROM dbo.Acc_info\n"
                + "WHERE username NOT IN (\n"
                + "	SELECT Acc_info.username FROM dbo.Acc_info\n"
                + "	JOIN dbo.Follow ON Follow.follow = Acc_info.username\n"
                + "	WHERE Follow.username = ?\n"
                + ") AND username != ?\n"
                + "ORDER BY NEWID()";

        List<AccInfo> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, username);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AccInfo acc = new AccInfo();
                acc.setUsername(rs.getString("username"));
                acc.setDisplayName(rs.getString("display_name"));
                acc.setAvatarURL(rs.getString("avatar_url"));
                list.add(acc);
            }
        } catch (SQLException e) {
        }
        return list;
    }
}
