    private List<Change> buildRevision(PathNode actualPath, List<T> orig, List<T> rev) {
        Objects.requireNonNull(actualPath, "path is null");
        Objects.requireNonNull(orig, "original sequence is null");
        Objects.requireNonNull(rev, "revised sequence is null");

        PathNode path = actualPath;
        List<Change> changes = new ArrayList<>();
        if (path.isSnake()) {
            path = path.prev;
        }
        while (path != null && path.prev != null && path.prev.j >= 0) {
            if (path.isSnake()) {
                throw new IllegalStateException("bad diffpath: found snake when looking for diff");
            }
            int i = path.i;
            int j = path.j;

            path = path.prev;
            int ianchor = path.i;
            int janchor = path.j;

            if (ianchor == i && janchor != j) {
                changes.add(new Change(DeltaType.INSERT, ianchor, i, janchor, j));
            } else if (ianchor != i && janchor == j) {
                changes.add(new Change(DeltaType.DELETE, ianchor, i, janchor, j));
            } else {
                changes.add(new Change(DeltaType.CHANGE, ianchor, i, janchor, j));
            }

            if (path.isSnake()) {
                path = path.prev;
            }
        }
        return changes;
    }
