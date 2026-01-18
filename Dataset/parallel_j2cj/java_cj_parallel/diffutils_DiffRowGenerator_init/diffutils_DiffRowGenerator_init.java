    private DiffRowGenerator(Builder builder) {
        showInlineDiffs = builder.showInlineDiffs;
        ignoreWhiteSpaces = builder.ignoreWhiteSpaces;
        oldTag = builder.oldTag;
        newTag = builder.newTag;
        columnWidth = builder.columnWidth;
        mergeOriginalRevised = builder.mergeOriginalRevised;
        inlineDiffSplitter = builder.inlineDiffSplitter;
        decompressDeltas = builder.decompressDeltas;

        if (builder.equalizer != null) {
            equalizer = builder.equalizer;
        } else {
            equalizer = ignoreWhiteSpaces ? IGNORE_WHITESPACE_EQUALIZER : DEFAULT_EQUALIZER;
        }

        reportLinesUnchanged = builder.reportLinesUnchanged;
        lineNormalizer = builder.lineNormalizer;
        processDiffs = builder.processDiffs;

        replaceOriginalLinefeedInChangesWithSpaces = builder.replaceOriginalLinefeedInChangesWithSpaces;

        Objects.requireNonNull(inlineDiffSplitter);
        Objects.requireNonNull(lineNormalizer);
    }