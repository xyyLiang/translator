    private static List<String> getDeltaText(AbstractDelta<String> delta) {
        List<String> buffer = new ArrayList<>();
        for (String line : delta.getSource().getLines()) {
            buffer.add("-" + line);
        }
        for (String line : delta.getTarget().getLines()) {
            buffer.add("+" + line);
        }
        return buffer;
    }