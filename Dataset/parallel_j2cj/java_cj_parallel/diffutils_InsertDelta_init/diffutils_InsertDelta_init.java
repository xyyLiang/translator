    public InsertDelta(Chunk<T> original, Chunk<T> revised) {
        super(DeltaType.INSERT, original, revised);
    }