import java.util.Objects;

public class Device {
    private final String name;
    private final Integer inventionYear;

    public Device(String name, Integer inventionYear) {
        this.name = name;
        this.inventionYear = inventionYear;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Device device = (Device) o;
        return Objects.equals(name, device.name) && Objects.equals(inventionYear, device.inventionYear);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, inventionYear);
    }

    public String toString() {
        return "The " + this.name + " was invented in " + this.inventionYear;
    }
}