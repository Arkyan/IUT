 package computerpioneer.model;

public class ComputerPioneer {
    private final String lastName;
    private final String firstName;
    private final Device device;

    public ComputerPioneer(String lastName, String firstName, Device device) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.device = device;
    }

    public String toString() {
        return this.firstName +" "+ this.lastName + " is a computer pioneer";
    }

    public Boolean worksOn(Device device) {
        if (this.device.equals(device)) return true;
        else {
            return false;
        }
    }
}
