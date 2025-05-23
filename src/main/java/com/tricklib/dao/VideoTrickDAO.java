package com.tricklib.dao;

import com.tricklib.util.DatabaseConnection;
import com.tricklib.model.VideoTrick;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VideoTrickDAO {

    public List<VideoTrick> getAllVideoTricks() {
        List<VideoTrick> videoTricks = new ArrayList<>();
        String sql = "SELECT vt.*, c.name as category_name " + "FROM video_tricks vt " + "LEFT JOIN categories c ON vt.category_id = c.id " + "ORDER BY vt.created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                VideoTrick videoTrick = mapResultSetToVideoTrick(rs);
                videoTricks.add(videoTrick);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return videoTricks;
    }

    public List<VideoTrick> getVideoTricksByCategory(int categoryId) {
        List<VideoTrick> videoTricks = new ArrayList<>();
        String sql = "SELECT vt.*, c.name as category_name " + "FROM video_tricks vt " + "LEFT JOIN categories c ON vt.category_id = c.id " + "WHERE vt.category_id = ? " + "ORDER BY vt.created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    VideoTrick videoTrick = mapResultSetToVideoTrick(rs);
                    videoTricks.add(videoTrick);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return videoTricks;
    }

    public VideoTrick getVideoTrickById(int id) {
        String sql = "SELECT vt.*, c.name as category_name " + "FROM video_tricks vt " + "LEFT JOIN categories c ON vt.category_id = c.id " + "WHERE vt.id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVideoTrick(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addVideoTrick(VideoTrick videoTrick) {
        String sql = "INSERT INTO video_tricks (title, description, url, category_id, thumbnail_url, duration, difficulty_level) " + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, videoTrick.getTitle());
            stmt.setString(2, videoTrick.getDescription());
            stmt.setString(3, videoTrick.getUrl());
            stmt.setInt(4, videoTrick.getCategoryId());
            stmt.setString(5, videoTrick.getThumbnailUrl());
            stmt.setString(6, videoTrick.getDuration());
            stmt.setString(7, videoTrick.getDifficultyLevel());

            int result = stmt.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateVideoTrick(VideoTrick videoTrick) {
        String sql = "UPDATE video_tricks SET title = ?, description = ?, url = ?, category_id = ?, " + "thumbnail_url = ?, duration = ?, difficulty_level = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, videoTrick.getTitle());
            stmt.setString(2, videoTrick.getDescription());
            stmt.setString(3, videoTrick.getUrl());
            stmt.setInt(4, videoTrick.getCategoryId());
            stmt.setString(5, videoTrick.getThumbnailUrl());
            stmt.setString(6, videoTrick.getDuration());
            stmt.setString(7, videoTrick.getDifficultyLevel());
            stmt.setInt(8, videoTrick.getId());

            int result = stmt.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteVideoTrick(int id) {
        String sql = "DELETE FROM video_tricks WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int result = stmt.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<VideoTrick> searchVideoTricks(String keyword) {
        List<VideoTrick> videoTricks = new ArrayList<>();
        String sql = "SELECT vt.*, c.name as category_name " + "FROM video_tricks vt " + "LEFT JOIN categories c ON vt.category_id = c.id " + "WHERE vt.title LIKE ? OR vt.description LIKE ? " + "ORDER BY vt.created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    VideoTrick videoTrick = mapResultSetToVideoTrick(rs);
                    videoTricks.add(videoTrick);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return videoTricks;
    }

    private VideoTrick mapResultSetToVideoTrick(ResultSet rs) throws SQLException {
        VideoTrick videoTrick = new VideoTrick();
        videoTrick.setId(rs.getInt("id"));
        videoTrick.setTitle(rs.getString("title"));
        videoTrick.setDescription(rs.getString("description"));
        videoTrick.setUrl(rs.getString("url"));
        videoTrick.setCategoryId(rs.getInt("category_id"));
        videoTrick.setCategoryName(rs.getString("category_name"));
        videoTrick.setThumbnailUrl(rs.getString("thumbnail_url"));
        videoTrick.setDuration(rs.getString("duration"));
        videoTrick.setDifficultyLevel(rs.getString("difficulty_level"));
        videoTrick.setCreatedAt(rs.getTimestamp("created_at"));
        videoTrick.setUpdatedAt(rs.getTimestamp("updated_at"));
        return videoTrick;
    }
}