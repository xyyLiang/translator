    public func generateDiffRows(original: ArrayList<String>, revised: ArrayList<String>): ArrayList<DiffRow> {
        return generateDiffRows(original, revised, DiffUtils.diff(original, revised, equalizer))
    }