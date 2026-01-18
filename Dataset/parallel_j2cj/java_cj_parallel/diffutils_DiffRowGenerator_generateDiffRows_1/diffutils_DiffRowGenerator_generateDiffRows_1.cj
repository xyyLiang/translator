    public func generateDiffRows(original: ArrayList<String>, revised: ArrayList<String>, patch: Patch<String>): ArrayList<DiffRow> {
        // normalize the lines (expand tabs, escape html entities)
        var original_ = StringUtills.normalize(original)
        var revised_ = StringUtills.normalize(revised)

        // wrap to the column width
        original_ = StringUtills.wrapText(original, this.columnWidth)
        revised_ = StringUtills.wrapText(revised, this.columnWidth)

        var diffRows: ArrayList<DiffRow> = ArrayList<DiffRow>()
        var endPos: Int64 = 0
        let  deltaList: ArrayList<Delta<String>> = patch.getDeltas()
        var i: Int64 = 0
        while (i < deltaList.size) {
            var delta: Delta<String> = deltaList.get(i).getOrThrow()
            var orig: Chunk<String> = delta.getOriginal()
            var rev: Chunk<String> = delta.getRevised()

            // We should normalize and wrap lines in deltas too.
            setlineExtracted(original, diffRows, endPos, orig, rev)

            // Inserted DiffRow
            if (delta is InsertDelta<String>) {
                endPos = orig.last() + 1
                for (line in rev.getLines()) {
                    diffRows.append(DiffRow(Tag.INSERT, "", line))
                }
                i++
                continue
            }

            // Deleted DiffRow
            if (delta is DeleteDelta<String>) {
                endPos = orig.last() + 1
                for (line in orig.getLines()) {
                    diffRows.append(DiffRow(Tag.DELETE, line, ""))
                }
                i++
                continue
            }
            if (showInlineDiffs) { addInlineDiffs(delta) }
            //the changed size is match
            extracted(diffRows, orig, rev)
            endPos = orig.last() + 1
            i++
        }

        // Copy the final matching chunk if any.
        if (endPos == original.size) { return diffRows }
        for (line in original.slice(endPos..original.size)) {
            diffRows.append(DiffRow(Tag.EQUAL, line, line))
        }
        return diffRows
    }