    public final PathNode previousSnake() {
        if (isBootstrap()) {
            return null;
        }
        if (!isSnake() && prev != null) {
            return prev.previousSnake();
        }
        return this;
    }