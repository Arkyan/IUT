public class Rover {
    private final Position position;
    private Direction direction;
    private final String name;

    public Rover(Position position, Direction direction, String name) {
        this.position = position;
        this.direction = direction;
        this.name = name;
    }

    public Rover(Integer x, Integer y, Direction direction, String name) {
        this(new Position(x, y),direction, name);
    }

    public Rover() {
        this(new Position(0, 0), Direction.NORTH, "Rover");
    }

    public Position getPosition() {
        return position;
    }

    public Direction getDirection() {
        return direction;
    }

    public String getLocation() {
        return  "at " + position.toString() + " towards the " + direction.toString();
    }

    @Override
    public String toString() {
        return "Rover{" +
                "position=" + position +
                ", direction=" + direction +
                ", name='" + name + '\'' +
                '}';
    }

    public void move(){
        switch(direction) {
            case NORTH:
                this.position.setY(position.getY() + 1);
                break;
            case EAST:
                this.position.setX(position.getX() + 1);
                break;
            case SOUTH:
                this.position.setY(position.getY() - 1);
                break;
            case WEST:
                this.position.setX(position.getX() - 1);
                break;
        }
    }

    public void turnLeft(){
        switch(direction){
            case NORTH:
                this.direction = Direction.WEST;
                break;
            case EAST:
                this.direction = Direction.NORTH;
                break;
            case SOUTH:
                this.direction = Direction.EAST;
                break;
            case WEST:
                this.direction = Direction.SOUTH;
                break;
        }
    }

    public void turnRight(){
        switch(direction){
            case NORTH:
                this.direction = Direction.EAST;
                break;
            case EAST:
                this.direction = Direction.SOUTH;
                break;
            case SOUTH:
                this.direction = Direction.WEST;
                break;
            case WEST:
                this.direction = Direction.NORTH;
                break;
        }
    }
}
