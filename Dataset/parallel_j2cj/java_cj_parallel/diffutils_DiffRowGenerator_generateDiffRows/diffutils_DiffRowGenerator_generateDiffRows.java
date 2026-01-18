    public List<DiffRow> generateDiffRows(List<String> original, List<String> revised) {
        return generateDiffRows(original, DiffUtils.diff(original, revised, equalizer));
    }