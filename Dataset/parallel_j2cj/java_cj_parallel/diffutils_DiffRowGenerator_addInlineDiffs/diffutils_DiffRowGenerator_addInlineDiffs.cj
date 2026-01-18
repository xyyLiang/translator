    private func addInlineDiffs(delta: Delta<String>): Unit {
        var orig = delta.getOriginal().getLines()
        var rev = delta.getRevised().getLines()
        var origList = ArrayList<String>()
        
        for (character in join(orig, "\n")) {
            origList.append(Char(character).toString())
        }
        var revList = ArrayList<String>()
        for (character in join(rev, "\n")) {
            revList.append(Char(character).toString())
        }
        var inlineDeltas: ArrayList<Delta<String>> = DiffUtils.diff(origList, revList).getDeltas()
        if (inlineDeltas.size < 3) {
            inlineDeltas.reverse()
            for (inlineDelta in inlineDeltas) {
                var inlineOrig = inlineDelta.getOriginal()
                var inlineRev = inlineDelta.getRevised()
                if (inlineDelta is DeleteDelta<String>) {
                    origList = wrapInTag(origList, inlineOrig.getPosition(), inlineOrig.getPosition()+ inlineOrig.size() + 1, this.InlineOldTag, this.InlineOldCssClass)
                } else if (inlineDelta is InsertDelta<String>) {
                    revList = wrapInTag(revList, inlineRev.getPosition(), inlineRev.getPosition()+ inlineRev.size() + 1, this.InlineNewTag, this.InlineNewCssClass)
                } else if (inlineDelta is ChangeDelta<String>) {
                    origList = wrapInTag(origList, inlineOrig.getPosition(), inlineOrig.getPosition()+ inlineOrig.size() + 1, this.InlineOldTag, this.InlineOldCssClass)
                    revList = wrapInTag(revList, inlineRev.getPosition(), inlineRev.getPosition()+ inlineRev.size() + 1, this.InlineNewTag, this.InlineNewCssClass)
                }
            }
            var origResult =  StringBuilder()
            var revResult =  StringBuilder()
            for (character in origList) {
                origResult.append(character)
            }
            for (character in revList) {
                revResult.append(character)
            }
            delta.getOriginal().setLines(ArrayList(origResult.toString().split("\n")))
            delta.getRevised().setLines(ArrayList(revResult.toString().split("\n")))
        }
    }