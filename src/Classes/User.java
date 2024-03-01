package Classes;

public class User {
    private Long id;
    private String email;
    private String password;
    private String fullname;
    private String roleId;

    public User(Long id, String email, String password, String fullname, String roleId) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.roleId = roleId;
    }

    public User() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
}
