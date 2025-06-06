package com.tricklib.dao;

import com.tricklib.model.User;
import com.tricklib.util.DatabaseConnection;
import com.tricklib.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    /**
     * Finds a user by their username.
     *
     * @param username The username to search for.
     * @return A User object if found, otherwise null.
     */
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setFullName(rs.getString("full_name"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Validates a user's credentials.
     *
     * @param username The user's username.
     * @param password The user's plain text password.
     * @return A User object if validation is successful, otherwise null.
     */
    public User validateUser(String username, String password) {
        User user = findByUsername(username);
        if (user != null && PasswordUtil.checkPassword(password, user.getPasswordHash())) {
            return user;
        }
        return null;
    }

    /**
     * Creates a new user in the database.
     * The password from the user object should be plain text, as it will be hashed by this method.
     *
     * @param user The User object containing the new user's information.
     * @return true if the user was created successfully, false otherwise.
     * @throws SQLException if a database access error occurs.
     */
    public boolean createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, password_hash, full_name) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            // Hash the password before storing it in the database
            stmt.setString(2, PasswordUtil.hashPassword(user.getPasswordHash()));
            stmt.setString(3, user.getFullName());

            int result = stmt.executeUpdate();
            return result > 0;
        }
    }
}