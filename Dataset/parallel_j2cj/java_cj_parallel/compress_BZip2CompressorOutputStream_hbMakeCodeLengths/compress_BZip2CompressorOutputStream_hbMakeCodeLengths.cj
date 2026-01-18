    private static func hbMakeCodeLengths(
        len: Array<Byte>,
        freq: Array<Int64>,
        dat: BZip2OutputStreamData,
        alphaSize: Int64,
        maxLen: Int64
    ): Unit {
        /*
         * Nodes and heap entries run from 1.
         * Entry 0 for both the heap and nodes is a sentinel.
         */
        let (heap, weight, parent): (Array<Int64>, Array<Int64>, Array<Int64>) = (dat.heap, dat.weight, dat.parent)

        for (i in alphaSize - 1..=0 : -1) {
            weight[i + 1] = if (freq[i] == 0) {
                1
            } else {
                freq[i]
            } << 8
        }

        var tooLong: Bool = true
        let changable = Changable()
        while (tooLong) {
            tooLong = false

            (changable.nNodes, changable.nHeap) = (alphaSize, 0)
            (heap[0], weight[0], parent[0]) = (0, 0, -2)

            for (i in 1..=alphaSize) {
                parent[i] = -1
                changable.nHeap++
                heap[changable.nHeap] = i

                var zz: Int64 = changable.nHeap
                let tmp: Int64 = heap[zz]
                while (weight[tmp] < weight[heap[zz >> 1]]) {
                    heap[zz] = heap[zz >> 1]
                    zz >>= 1
                }
                heap[zz] = tmp
            }

            nheapLoop(heap, weight, parent, changable)

            for (i in 1..=alphaSize) {
                var (j, k): (Int64, Int64) = (0, i)

                while (parent[k] >= 0) {
                    k = parent[k]
                    j++
                }

                len[i - 1] = UInt8(j & 0xff)
                if (j > maxLen) {
                    tooLong = true
                }
            }

            if (tooLong) {
                for (i in 1..alphaSize) {
                    var j: Int64 = weight[i] >> 8
                    j = 1 + (j >> 1)
                    weight[i] = j << 8
                }
            }
        }
    }
    private static func nheapLoop(
        heap: Array<Int64>,
        weight: Array<Int64>,
        parent: Array<Int64>,
        changable: Changable
    ) {
        while (changable.nHeap > 1) {
            let n1: Int64 = heap[1]

            var (zz, tmp): (Int64, Int64) = yzloop(heap, weight, changable)

            let n2: Int64 = heap[1]

            (zz, tmp) = yzloop(heap, weight, changable)

            changable.nNodes++
            (parent[n1], parent[n2]) = (changable.nNodes, changable.nNodes)
            let (weight_n1, weight_n2): (Int64, Int64) = (weight[n1], weight[n2])
            weight[changable.nNodes] = ((weight_n1 & 0xffffff00) + (weight_n2 & 0xffffff00)) |
                (1 + math.max(
                weight_n1 & 0x000000ff,
                weight_n2 & 0x000000ff
            ))

            parent[changable.nNodes] = -1
            changable.nHeap++
            heap[changable.nHeap] = changable.nNodes

            zz = changable.nHeap
            tmp = heap[zz]
            let weight_tmp: Int64 = weight[tmp]
            while (weight_tmp < weight[heap[zz >> 1]]) {
                heap[zz] = heap[zz >> 1]
                zz >>= 1
            }
            heap[zz] = tmp
        }
    }
    private static func yzloop(heap: Array<Int64>, weight: Array<Int64>, changable: Changable): (Int64, Int64) {
        heap[1] = heap[changable.nHeap]
        changable.nHeap--
        var (yy, zz, tmp): (Int64, Int64, Int64) = (0, 1, heap[1])
        while (true) {
            yy = zz << 1
            if (yy > changable.nHeap) {
                break
            }
            if ((yy < changable.nHeap) && (weight[heap[yy + 1]] < weight[heap[yy]])) {
                yy++
            }
            if (weight[tmp] < weight[heap[yy]]) {
                break
            }
            heap[zz] = heap[yy]
            zz = yy
        }
        heap[zz] = tmp
        (zz, tmp)
    }