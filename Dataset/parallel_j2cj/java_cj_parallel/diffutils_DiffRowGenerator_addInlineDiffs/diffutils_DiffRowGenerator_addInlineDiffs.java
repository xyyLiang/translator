    private List<DiffRow> generateInlineDiffs(AbstractDelta<String> delta) {
        List<String> orig = normalizeLines(delta.getSource().getLines());
        List<String> rev = normalizeLines(delta.getTarget().getLines());
        List<String> origList;
        List<String> revList;
        String joinedOrig = String.join("\n", orig);
        String joinedRev = String.join("\n", rev);

        origList = inlineDiffSplitter.apply(joinedOrig);
        revList = inlineDiffSplitter.apply(joinedRev);

        List<AbstractDelta<String>> inlineDeltas = DiffUtils.diff(origList, revList, equalizer).getDeltas();

        Collections.reverse(inlineDeltas);
        for (AbstractDelta<String> inlineDelta : inlineDeltas) {
            Chunk<String> inlineOrig = inlineDelta.getSource();
            Chunk<String> inlineRev = inlineDelta.getTarget();
            if (inlineDelta.getType() == DeltaType.DELETE) {
                wrapInTag(origList, inlineOrig.getPosition(), inlineOrig
                        .getPosition()
                        + inlineOrig.size(), Tag.DELETE, oldTag, processDiffs, replaceOriginalLinefeedInChangesWithSpaces && mergeOriginalRevised);
            } else if (inlineDelta.getType() == DeltaType.INSERT) {
                if (mergeOriginalRevised) {
                    origList.addAll(inlineOrig.getPosition(),
                            revList.subList(inlineRev.getPosition(),
                                    inlineRev.getPosition() + inlineRev.size()));
                    wrapInTag(origList, inlineOrig.getPosition(),
                            inlineOrig.getPosition() + inlineRev.size(),
                            Tag.INSERT, newTag, processDiffs, false);
                } else {
                    wrapInTag(revList, inlineRev.getPosition(),
                            inlineRev.getPosition() + inlineRev.size(),
                            Tag.INSERT, newTag, processDiffs, false);
                }
            } else if (inlineDelta.getType() == DeltaType.CHANGE) {
                if (mergeOriginalRevised) {
                    origList.addAll(inlineOrig.getPosition() + inlineOrig.size(),
                            revList.subList(inlineRev.getPosition(),
                                    inlineRev.getPosition() + inlineRev.size()));
                    wrapInTag(origList, inlineOrig.getPosition() + inlineOrig.size(),
                            inlineOrig.getPosition() + inlineOrig.size() + inlineRev.size(),
                            Tag.CHANGE, newTag, processDiffs, false);
                } else {
                    wrapInTag(revList, inlineRev.getPosition(),
                            inlineRev.getPosition() + inlineRev.size(),
                            Tag.CHANGE, newTag, processDiffs, false);
                }
                wrapInTag(origList, inlineOrig.getPosition(),
                        inlineOrig.getPosition() + inlineOrig.size(),
                        Tag.CHANGE, oldTag, processDiffs, replaceOriginalLinefeedInChangesWithSpaces && mergeOriginalRevised);
            }
        }
        StringBuilder origResult = new StringBuilder();
        StringBuilder revResult = new StringBuilder();
        for (String character : origList) {
            origResult.append(character);
        }
        for (String character : revList) {
            revResult.append(character);
        }

        List<String> original = Arrays.asList(origResult.toString().split("\n"));
        List<String> revised = Arrays.asList(revResult.toString().split("\n"));
        List<DiffRow> diffRows = new ArrayList<>();
        for (int j = 0; j < Math.max(original.size(), revised.size()); j++) {
            diffRows.
                    add(buildDiffRowWithoutNormalizing(Tag.CHANGE,
                            original.size() > j ? original.get(j) : "",
                            revised.size() > j ? revised.get(j) : ""));
        }
        return diffRows;
    }
