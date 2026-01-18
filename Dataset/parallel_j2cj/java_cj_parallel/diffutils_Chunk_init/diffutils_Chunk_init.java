    public Chunk(int position, List<T> lines, List<Integer> changePosition) {
        this.position = position;
        this.lines = new ArrayList<>(lines);
        this.changePosition = changePosition != null ? new ArrayList<>(changePosition) : null;
    }