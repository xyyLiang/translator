    func encodeSpecificVersion(version: Version): ResultList {
        let inputLength = stringToEncode.size

        let edges = Array<Array<Array<?Edge>>>(
            inputLength + 1,
            {
                n => Array<Array<?Edge>>(
                    1,
                    {
                        m => Array<?Edge>(4, item: None)
                    }
                )
            }
        )
        addEdges(version, edges, 0, None)

        for (i in 1..=inputLength) {
            for (k in 0..4) {
                if (let Some(e) = edges[i][0][k]) {
                    if (i < inputLength) {
                        addEdges(version, edges, i, e)
                    }
                }
            }
        }

        var minimalJ = -1
        var minimalK = -1
        var minimalSize = Int64.Max
        for (k in 0..4) {
            if (let Some(edge) = edges[inputLength][0][k]) {
                if (edge.cachedTotalSize < minimalSize) {
                    minimalSize = edge.cachedTotalSize
                    minimalJ = 0
                    minimalK = k
                }
            }
        }
        if (minimalJ < 0) {
            throw WriterException("Internal error: failed to encode \"${stringToEncode}\"")
        }
        ResultList(version, edges[inputLength][minimalJ][minimalK], this)
    }