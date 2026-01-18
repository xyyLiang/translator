    public func addResultPoints(newPoints: ?Array<ResultPoint>) {
        this.resultPoints = if (let Some(e) = this.resultPoints) {
            if (let Some(nP) = newPoints) {
                if (nP.size > 0) {
                    let oSize = e.size
                    Array<ResultPoint>(
                        oSize + nP.size,
                        {
                            n => if (n < oSize) {
                                e[n]
                            } else {
                                nP[n - oSize]
                            }
                        }
                    )
                } else {
                    None
                }
            } else {
                None
            }
        } else {
            newPoints
        }
    }