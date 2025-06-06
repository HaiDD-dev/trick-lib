package com.tricklib.model;

import java.sql.Timestamp;

public class VideoTrick {
    private int id;
    private String title;
    private String description;
    private String url;
    private int categoryId;
    private String categoryName;
    private String thumbnailUrl;
    private String duration;
    private String difficultyLevel;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int userId;

    public VideoTrick() {
    }

    public VideoTrick(String title, String description, String url, int categoryId) {
        this.title = title;
        this.description = description;
        this.url = url;
        this.categoryId = categoryId;
    }

    public VideoTrick(String title, String description, String url, int categoryId, String difficultyLevel) {
        this.title = title;
        this.description = description;
        this.url = url;
        this.categoryId = categoryId;
        this.difficultyLevel = difficultyLevel;
    }

    // Getters and Setters
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(String difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "VideoTrick{" + "id=" + id + ", title='" + title + '\'' + ", description='" + description + '\'' + ", url='" + url + '\'' + ", categoryId=" + categoryId + ", difficultyLevel='" + difficultyLevel + '\'' + '}';
    }
}