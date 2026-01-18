    protected override func encode(contents: String, hints: ?HashMap<EncodeHintType, Any>): Array<Bool> {
        let forcedCodeSet = check(contents, hints)

        let hasCompactionHint = if (let Some(h) = hints) {
            if (let Some(c) = h.get(EncodeHintType.CODE128_COMPACT)) {
                (c as Bool).getOrThrow()
            } else {
                false
            }
        } else {
            false
        }

        if (hasCompactionHint) {
            MinimalEncoder().encode(contents)
        } else {
            encodeFast(contents, forcedCodeSet)
        }
    }