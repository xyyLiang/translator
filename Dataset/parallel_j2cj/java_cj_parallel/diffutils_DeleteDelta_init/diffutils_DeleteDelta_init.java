    public DeleteDelta(Chunk<T> original, Chunk<T> revised) {
        super(DeltaType.DELETE, original, revised);
    }