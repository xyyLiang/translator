    static func encodeMinimally(stringToEncode: String, fnc1: Int64): Array<Int64> {
        let inputLength = stringToEncode.size

        let edges = Array<?InputEdge>(inputLength + 1, item: None)
        addEdges(stringToEncode, edges, 0, None, fnc1)
        for (i in 1..edges.size) {
            if (let Some(n) = edges[i]) {
                if (i < inputLength) {
                    addEdges(stringToEncode, edges, i, n, fnc1)
                }
            }
            edges[i - 1] = None
        }
        var minimalJ = -1
        var minimalSize = Int64.Max
        if (let Some(edge) = edges[inputLength]) {
            if (edge.cachedTotalSize < minimalSize) {
                minimalSize = edge.cachedTotalSize
                minimalJ = 0
            }
        }
        if (minimalJ < 0) {
            throw IllegalArgumentException("Failed to encode \"${stringToEncode}\"")
        }
        let intsAL = ArrayList<Int64>()
        var current: ?InputEdge = edges[inputLength]
        while (let Some(cur) = current) {
            if (cur.isFNC1()) {
                intsAL.insert(0, 1000)
            } else {
                let bytes = "${cur.c}".toUtf8Array()
                for (i in (bytes.size - 1)..-1 : -1) {
                    intsAL.insert(0, Int64(bytes[i]) & 0xFF)
                }
            }
            let previousEncoderIndex = if (let Some(pre) = cur.previous) {
                pre.encoderIndex
            } else {
                0
            }
            if (previousEncoderIndex != cur.encoderIndex) {
                intsAL.insert(0, 256 + 1)
            }
            current = cur.previous
        }
        intsAL.toArray()
    }