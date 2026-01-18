    public List<DiffRow> generateDiffRows(final List<String> original, Patch<String> patch) {
        List<DiffRow> diffRows = new ArrayList<>();
        int endPos = 0;
        final List<AbstractDelta<String>> deltaList = patch.getDeltas();

        if (decompressDeltas) {
            for (AbstractDelta<String> originalDelta : deltaList) {
                for (AbstractDelta<String> delta : decompressDeltas(originalDelta)) {
                    endPos = transformDeltaIntoDiffRow(original, endPos, diffRows, delta);
                }
            }
        } else {
            for (AbstractDelta<String> delta : deltaList) {
                endPos = transformDeltaIntoDiffRow(original, endPos, diffRows, delta);
            }
        }

        // Copy the final matching chunk if any.
        for (String line : original.subList(endPos, original.size())) {
            diffRows.add(buildDiffRow(Tag.EQUAL, line, line));
        }
        return diffRows;
    }
/**
     * Transforms one patch delta into a DiffRow object.
     */
    private int transformDeltaIntoDiffRow(final List<String> original, int endPos, List<DiffRow> diffRows, AbstractDelta<String> delta) {
        Chunk<String> orig = delta.getSource();
        Chunk<String> rev = delta.getTarget();

        for (String line : original.subList(endPos, orig.getPosition())) {
            diffRows.add(buildDiffRow(Tag.EQUAL, line, line));
        }

        switch (delta.getType()) {
            case INSERT:
                for (String line : rev.getLines()) {
                    diffRows.add(buildDiffRow(Tag.INSERT, "", line));
                }
                break;
            case DELETE:
                for (String line : orig.getLines()) {
                    diffRows.add(buildDiffRow(Tag.DELETE, line, ""));
                }
                break;
            default:
                if (showInlineDiffs) {
                    diffRows.addAll(generateInlineDiffs(delta));
                } else {
                    for (int j = 0; j < Math.max(orig.size(), rev.size()); j++) {
                        diffRows.add(buildDiffRow(Tag.CHANGE,
                                orig.getLines().size() > j ? orig.getLines().get(j) : "",
                                rev.getLines().size() > j ? rev.getLines().get(j) : ""));
                    }
                }
        }

        return orig.last() + 1;
    }