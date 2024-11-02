package unoeste.fipp.playmysongs.security;

public class User {
    private String name;
    private boolean access;
    public User(String name) {
        this.name = name;
        access=false;
    }

    public void setAccess(boolean access) {
        this.access = access;
    }

    public String getName() {
        return name;
    }
    public boolean isAccess() {
        return access;
    }
}
