    func fallbackSimpleSort(fmap: Array<Int64>, eclass: Array<Int64>, lo: Int64, hi: Int64): Unit {
        if (lo == hi) {
            return
        }

        if (hi - lo > 3) {
            for (i in (hi - 4)..=lo : -1) {
                let tmp: Int64 = fmap[i]
                let ec_tmp: Int64 = eclass[tmp]
                var j = i + 4
                while (j <= hi && (ec_tmp > eclass[fmap[j]])) {
                    fmap[j - 4] = fmap[j]
                    j += 4
                }
                fmap[j - 4] = tmp
            }
        }

        for (i in (hi - 1)..=lo : -1) {
            let tmp: Int64 = fmap[i]
            let ec_tmp: Int64 = eclass[tmp]
            var j = i + 1
            while (j <= hi && ec_tmp > eclass[fmap[j]]) {
                fmap[j - 1] = fmap[j]
                j++
            }
            fmap[j - 1] = tmp
        }
    }