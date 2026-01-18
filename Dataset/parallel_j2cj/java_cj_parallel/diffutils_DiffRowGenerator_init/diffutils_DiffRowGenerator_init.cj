    protected init(builder: Builder) {
        showInlineDiffs = builder.showInlineDiffs_
        ignoreWhiteSpaces = builder.ignoreWhiteSpaces_
        ignoreBlankLines = builder.ignoreBlankLines_
        InlineOldTag = builder.InlineOldTag_
        InlineNewTag = builder.InlineNewTag_
        InlineOldCssClass = builder.InlineOldCssClass_
        InlineNewCssClass = builder.InlineNewCssClass_
        columnWidth = builder.columnWidth_
        equalizer = Stringequalizer(builder.ignoreWhiteSpaces_)
    }