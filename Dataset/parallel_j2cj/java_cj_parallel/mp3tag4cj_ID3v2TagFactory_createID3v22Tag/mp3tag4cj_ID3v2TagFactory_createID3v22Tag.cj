    private static func createID3v22Tag(bytes: Array<Int8>): Option<AbstractID3v2Tag> {
        var tag: ID3v22Tag = ID3v22Tag(bytes)
        if (tag.getFrameSets().isEmpty()) {
            tag = ID3v22Tag(bytes, true)
        }
        return Option<AbstractID3v2Tag>.Some(tag)
    }