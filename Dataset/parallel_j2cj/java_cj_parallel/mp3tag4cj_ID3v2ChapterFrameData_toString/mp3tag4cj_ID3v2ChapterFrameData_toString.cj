    public func toString(): String {
        var builder: StringBuilder = StringBuilder()
        builder.append("ID3v2ChapterFrameData [id=")
        builder.append(id)
        builder.append(", startTime=")
        builder.append(startTime)
        builder.append(", endTime=")
        builder.append(endTime)
        builder.append(", startOffset=")
        builder.append(startOffset)
        builder.append(", endOffset=")
        builder.append(endOffset)
        builder.append(", subframes=")
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            for (frame in subframes.getOrThrow()) {
                builder.append(frame.getId())
                builder.append(frame.getData().toString())
            }
        }
        builder.append("]")
        return builder.toString()
    }