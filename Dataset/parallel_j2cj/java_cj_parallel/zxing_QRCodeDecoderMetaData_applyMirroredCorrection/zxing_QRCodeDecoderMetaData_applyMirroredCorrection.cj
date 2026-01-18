    public func applyMirroredCorrection(points: ?Array<ResultPoint>) {
        if (!mirrored) {
            return
        }
        if (let Some(p) = points) {
            if (p.size < 3) {
                return
            }
            let bottomLeft = p[0]
            p[0] = p[2]
            p[2] = bottomLeft
        } else {
            return
        }
    }