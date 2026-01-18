    @OverflowWrapping
    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = 1
        result = prime * result + endOffset
        result = prime * result + endTime
        if (id == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(id.getOrThrow().hashCode())
        }
        result = prime * result + startOffset
        result = prime * result + startTime
        if (subframes == Option<ArrayList<ID3v2Frame>>.None) {
            result = prime * result + 0
        } else {
            var subframesStr = ""
            if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
                for (frame in subframes.getOrThrow()) {
                    subframesStr += frame.getData().toString()
                }
            }
            result = prime * result + Int32(subframesStr.hashCode())
        }
        return Int64(result)
    }