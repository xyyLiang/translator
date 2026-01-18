    func fallbackSort(data: BZip2OutputStreamData, last: Int64): Unit {
        data.block[0] = data.block[last + 1]
        fallbackSort(data.fmap, data.block, last + 1)
        for (i in 0..(last + 1)) {
            data.fmap[i] -= 1
        }
        for (i in 0..(last + 1)) {
            if (data.fmap[i] == -1) {
                data.fmap[i] = last
                break
            }
        }
    }