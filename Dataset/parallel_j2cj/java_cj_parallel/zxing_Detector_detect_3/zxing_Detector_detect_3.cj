    public func detect(hints: ?HashMap<DecodeHintType, Any>): DetectorResult {
        resultPointCallback = if (let Some(h) = hints) {
            h[DecodeHintType.NEED_RESULT_POINT_CALLBACK] as ResultPointCallback
        } else {
            None
        }
        let finder = FinderPatternFinder(image, resultPointCallback)
        processFinderPatternInfo(finder.find(hints))
    }