    public static List<String> wrapText(List<String> list, int columnWidth) {
        return list.stream()
                .map(line -> wrapText(line, columnWidth))
                .collect(toList());
    }