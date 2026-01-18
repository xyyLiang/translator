    func doMirror() {
        for (x in 0..this.bitMatrix.width) {
            for (y in (x + 1)..this.bitMatrix.height) {
                if (this.bitMatrix.get(x, y) != this.bitMatrix.get(y, x)) {
                    this.bitMatrix.flip(y, x)
                    this.bitMatrix.flip(x, y)
                }
            }
        }
    }