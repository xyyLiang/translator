    public func buildPath(orig:  ArrayList<T>, rev:  ArrayList<T>): PathNode{
        let N: Int64 = orig.size
        let M: Int64 = rev.size

        let MAX: Int64 = N + M + 1
        let size = 1 + 2 * MAX
        let middle = size / 2
        let diagonal: Array<PathNode> = Array<PathNode>(size,item: Snake(0, 0, Option<PathNode>.None))

        diagonal[middle + 1] =  Snake(0, -1, Option<PathNode>.None)
        var d: Int64 = 0
        while ( d < MAX ) {
            var  k = -d
            while ( k <= d) {
                let kmiddle: Int64 = middle + k
                let kplus: Int64 = kmiddle + 1
                let kminus: Int64 = kmiddle - 1
                var prev: Option<PathNode> = Option<PathNode>.None

                var ii: Int64
                if ( (k == -d) || (k != d && diagonal[kminus].i < diagonal[kplus].i) ) {
                    ii = diagonal[kplus].i
                    prev = diagonal[kplus]
                } else {
                    ii = diagonal[kminus].i + 1
                    prev = diagonal[kminus]
                }

                diagonal[kminus] = Snake(0, 0, Option<PathNode>.None) // no longer used

                var j = ii - k

                var node: PathNode = DiffNode(ii, j, prev)

                while (ii < N && j < M && equals(orig.get(ii).getOrThrow(), rev.get(j).getOrThrow())) {
                    ii++
                    j++
                }
                if (ii > node.i) {
                    node =  Snake(ii, j, node)
                }

                diagonal[kmiddle] = node

                if (ii >= N && j >= M) {
                    return diagonal[kmiddle]
                }

                k += 2
            }
            diagonal[middle + d - 1] = Snake(0, 0, Option<PathNode>.None)
            d++

        }
        throw  DifferentiationFailedException("could not find a diff path")
    }