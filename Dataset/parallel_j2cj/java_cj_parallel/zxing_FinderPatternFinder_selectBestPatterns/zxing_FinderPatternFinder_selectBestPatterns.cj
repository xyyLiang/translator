    func selectBestPatterns(): Array<FinderPattern> {
        let startSize = possibleCenters.size
        if (startSize < 3) {
            throw NotFoundException()
        }

        var i = 0
        while (i < possibleCenters.size) {
            let item = possibleCenters[i]
            if (item.count < CENTER_QUORUM) {
                possibleCenters.remove(i)
            } else {
                i++
            }
        }

        possibleCenters.sortBy(moduleComparator)

        var distortion = Float64.Max
        let bestPatterns: Array<FinderPattern> = Array<FinderPattern>(3, item: FinderPattern(0.0, 0.0, 0.0))

        for (i in 0..(possibleCenters.size - 2)) {
            let fpi = possibleCenters[i]
            let minModuleSize = fpi.estimatedModuleSize

            for (j in (i + 1)..(possibleCenters.size - 1)) {
                let fpj = possibleCenters[j]
                let squares0 = squaredDistance(fpi, fpj)

                for (k in (j + 1)..possibleCenters.size) {
                    let fpk = possibleCenters[k]
                    let maxModuleSize = fpk.estimatedModuleSize
                    if (maxModuleSize > minModuleSize * 1.4) {
                        continue
                    }

                    var a = squares0
                    var b = squaredDistance(fpj, fpk)
                    var c = squaredDistance(fpi, fpk)

                    if (a < b) {
                        if (b > c) {
                            if (a < c) {
                                let temp = b
                                b = c
                                c = temp
                            } else {
                                let temp = a
                                a = c
                                c = b
                                b = temp
                            }
                        }
                    } else {
                        if (b < c) {
                            if (a < c) {
                                let temp = a
                                a = b
                                b = temp
                            } else {
                                let temp = a
                                a = b
                                b = c
                                c = temp
                            }
                        } else {
                            let temp = a
                            a = c
                            c = temp
                        }
                    }

                    let d = math.abs(c - 2.0 * b) + math.abs(c - 2.0 * a)
                    if (d < distortion) {
                        distortion = d
                        bestPatterns[0] = fpi
                        bestPatterns[1] = fpj
                        bestPatterns[2] = fpk
                    }
                }
            }
        }

        if (distortion == Float64.Max) {
            throw NotFoundException()
        }

        bestPatterns
    }