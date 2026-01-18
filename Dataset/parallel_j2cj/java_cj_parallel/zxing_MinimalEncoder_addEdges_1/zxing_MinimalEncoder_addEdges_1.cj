    func addEdges(version: Version, edges: Array<Array<Array<?Edge>>>, fro: Int64, previous: ?Edge) {
        addEdge(edges, fro, Edge(Mode.BYTE, fro, 0, 1, previous, version, this))

        let inputLength = stringToEncode.size
        if (canEncode(Mode.ALPHANUMERIC, stringToEncode.charAt(fro))) {
            addEdge(
                edges,
                fro,
                Edge(
                    Mode.ALPHANUMERIC,
                    fro,
                    0,
                    if (fro + 1 >= inputLength || !canEncode(Mode.ALPHANUMERIC, stringToEncode.charAt(fro + 1))) {
                        1
                    } else {
                        2
                    },
                    previous,
                    version,
                    this
                )
            )
        }

        if (canEncode(Mode.NUMERIC, stringToEncode.charAt(fro))) {
            addEdge(
                edges,
                fro,
                Edge(
                    Mode.NUMERIC,
                    fro,
                    0,
                    if (fro + 1 >= inputLength || !canEncode(Mode.NUMERIC, stringToEncode.charAt(fro + 1))) {
                        1
                    } else if (fro + 2 >= inputLength || !canEncode(Mode.NUMERIC, stringToEncode.charAt(fro + 2))) {
                        2
                    } else {
                        3
                    },
                    previous,
                    version,
                    this
                )
            )
        }
    }