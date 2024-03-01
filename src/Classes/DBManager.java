package Classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBManager {
    private static Connection connection;
    static {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/newsdb","postgres","1234");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static List<News> getNews() {
        List<News> newsList= new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement
                    ("SELECT n.id, n.post_date, n.title, n.content, c.id, c.name" +
                            " FROM news AS n " +
                            " INNER JOIN news_cat c ON n.category_id = c.id");
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                News news = new News();
                news.setId(resultSet.getLong("id"));
                news.setPost_date(resultSet.getTimestamp("post_date"));
                news.setTitle(resultSet.getString("title"));
                news.setContent(resultSet.getString("content"));
                Category cat = new Category();
                cat.setId(resultSet.getLong("id"));
                cat.setName(resultSet.getString("name"));
                news.setCategory(cat);
                newsList.add(news);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return newsList;
    }
    public static News getNewsById(Long id) {
        News news = new News();
        try {
            PreparedStatement stmt = connection.prepareStatement
                    ("SELECT n.id, n.post_date, n.title, n.content, c.id, c.name" +
                    " FROM news AS n " +
                    " INNER JOIN news_cat c ON n.category_id = c.id" +
                    " WHERE n.id = ?");
            stmt.setLong(1, id);
            ResultSet resultSet = stmt.executeQuery();
            if(resultSet.next()) {
                news.setId(resultSet.getLong("id"));
                news.setPost_date(resultSet.getTimestamp("post_date"));
                Category cat = new Category();
                cat.setId(resultSet.getLong("id"));
                cat.setName(resultSet.getString("name"));
                news.setCategory(cat);
                news.setTitle(resultSet.getString("title"));
                news.setContent(resultSet.getString("content"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return news;
    }
    public static Category getCategory(Long id) {
        PreparedStatement stmt = null;
        Category category = new Category();
        try {
            stmt = connection.prepareStatement("SELECT * FROM news_cat " +
                    "WHERE id = ?");
            stmt.setLong(1, id);
            ResultSet resultSet = stmt.executeQuery();
            if(resultSet.next()) {
                category.setId(resultSet.getLong("id"));
                category.setName(resultSet.getString("name"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return category;
    }
    public static boolean addNews(News news) {
        int rows = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO news(post_date, category_id, title, content) " +
                    "VALUES (Now(), ?, ?, ?)");
            stmt.setLong(1, news.getCategory().getId());
            stmt.setString(2,news.getTitle());
            stmt.setString(3, news.getContent());
            rows = stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rows > 0;
    }
    public static User getUser(String email) {
        User user = null;
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
            stmt.setString(1, email);
            ResultSet resultSet = stmt.executeQuery();
            if(resultSet.next()) {
                user = new User();
                user.setId(resultSet.getLong("id"));
                user.setEmail(resultSet.getString("email"));
                user.setFullname(resultSet.getString("fullname"));
                user.setPassword(resultSet.getString("password"));
                user.setRoleId(resultSet.getString("role_id"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }
    public static boolean createUser(User user) {
        int rows = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO users(email, password, fullname, role_id)" +
                    "VALUES(?, ?, ?, 'user')");
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullname());
            rows = stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rows > 0;
    }
    public static boolean updateUser(User user) {
        int rows = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement
                    ("UPDATE users " +
                    "SET email=?, password =?, fullname=?, role_id=? " +
                    "WHERE id = ? ");
            stmt.setString(1, user.getEmail());
            stmt.setString(2,user.getPassword());
            stmt.setString(3, user.getFullname());
            stmt.setString(4, user.getRoleId());
            stmt.setLong(5, user.getId());
            rows = stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rows > 0;
    }
    public static boolean updateNews(News news) {
        int rows = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement("UPDATE  news " +
                    "SET post_date = ?, category_id = ?, title = ?, content =? " +
                    "WHERE id = ?");
            stmt.setTimestamp(1, news.getPost_date());
            stmt.setLong(2, news.getCategory().getId());
            stmt.setString(3, news.getTitle());
            stmt.setString(4, news.getContent());
            stmt.setLong(5, news.getId());
            rows = stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rows>0;
    }
    public static boolean deleteNews(Long id) {
        int rows = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement
                    ("DELETE FROM news " +
                    "WHERE id = ?");
            stmt.setLong(1,id);
            rows = stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rows > 0;
    }
    public static boolean addComment(Comment comment) {
        int rows = 0;
        try {
            PreparedStatement stmt = connection.prepareStatement
                    ("INSERT INTO comments(comment, post_date, user_id, news_id)" +
                    "VALUES (?, Now(), ?, ?)");
            stmt.setString(1, comment.getComment());
            stmt.setLong(2, comment.getUser_id().getId());
            stmt.setLong(3, comment.getNews_id().getId());
            rows = stmt.executeUpdate();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rows > 0;
    }
    public static List<Comment> getComments(Long id) {
        List<Comment> comments = new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement
                    ("SELECT c.id, c.comment, c.post_date, u.id AS user_id,u.fullname, n.id AS news_id\n" +
                            "    FROM comments AS c\n" +
                            "    INNER JOIN news n ON c.news_id = n.id\n" +
                            "    INNER JOIN users u ON c.user_id = u.id\n" +
                            "    WHERE c.news_id = ?");
            stmt.setLong(1, id);
            ResultSet resultSet = stmt.executeQuery();
            while(resultSet.next()) {
                Comment comment = new Comment();
                comment.setId(resultSet.getLong("id"));
                comment.setComment(resultSet.getString("comment"));
                comment.setPost_date(resultSet.getTimestamp("post_date"));
                User user = new User();
                user.setId(resultSet.getLong("user_id"));
                user.setFullname(resultSet.getString("fullname"));
                comment.setUser_id(user);
                News news = new News();
                news.setId(resultSet.getLong("news_id"));
                comment.setNews_id(news);
                comments.add(comment);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return comments;
    }
}
