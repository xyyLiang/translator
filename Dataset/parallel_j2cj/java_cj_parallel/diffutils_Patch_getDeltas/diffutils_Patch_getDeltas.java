    public List<AbstractDelta<T>> getDeltas() {
        deltas.sort(comparing(d -> d.getSource().getPosition()));
        return deltas;
    }