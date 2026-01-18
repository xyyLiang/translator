    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        var childStr = ""
        if (children != Option<Array<String>>.None) {
            for (child in children.getOrThrow()) {
                childStr += child
            }
        }
        result = prime * result + Int32(childStr.hashCode())
        if (id == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(id.getOrThrow().hashCode())
        }
        if (isOrdereds) {
            result = prime * result + 1231
        } else {
            result = prime * result + 1237
        }
        if (isRoots) {
            result = prime * result + 1231
        } else {
            result = prime * result + 1237
        }
        if (subframes == Option<ArrayList<ID3v2Frame>>.None) {
            result = (prime * result) + 0
        } else {
            var subframesStrs = ""
            if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
                for (frame in subframes.getOrThrow()) {
                    subframesStrs += frame.getData().toString()
                }
            }
            result = (prime * result) + Int32(subframesStrs.hashCode())
        }
        return Int64(result)
    }