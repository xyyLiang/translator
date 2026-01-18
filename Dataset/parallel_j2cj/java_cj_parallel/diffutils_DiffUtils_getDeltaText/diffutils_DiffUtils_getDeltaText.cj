    private static func getDeltaText(delta: Delta<String>): ArrayList<String> {
        var buffer: ArrayList<String> = ArrayList<String>()
        for (line in delta.getOriginal().getLines()) {
            buffer.append("-" + line)
        }
        for (line in delta.getRevised().getLines()) {
            buffer.append("+" + line)
        }
        return buffer
    }