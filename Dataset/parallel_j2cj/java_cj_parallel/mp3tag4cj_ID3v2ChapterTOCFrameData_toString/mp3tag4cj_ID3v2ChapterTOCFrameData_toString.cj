    public func toString(): String {
        var builder: StringBuilder = StringBuilder()
        builder.append("ID3v2ChapterTOCFrameData [isRoot=")
        builder.append(isRoots)
        builder.append(", isOrdered=")
        builder.append(isOrdereds)
        builder.append(", id=")
        builder.append(id)
        builder.append(", children=");
        builder.append(children.toString());
        builder.append(", subframes=");
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            if (subframes.getOrThrow().size > 0) {
                for (frame in subframes.getOrThrow()) {
                    builder.append(frame.getId())
                    builder.append(frame.getData().toString())
                }
            } else {
                builder.append("[]")
            }
        }
        builder.append("]")
        return builder.toString()
    }