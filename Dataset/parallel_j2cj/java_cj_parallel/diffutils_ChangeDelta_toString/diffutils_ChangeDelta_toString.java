    @Override
    public String toString() {
        return "[ChangeDelta, position: " + getSource().getPosition() + ", lines: "
                + getSource().getLines() + " to " + getTarget().getLines() + "]";
    }