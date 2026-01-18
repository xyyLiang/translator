    public ChangeDelta(Chunk<T> source, Chunk<T> target) {
        super(DeltaType.CHANGE, source, target);
        Objects.requireNonNull(source, "source must not be null");
        Objects.requireNonNull(target, "target must not be null");
    }