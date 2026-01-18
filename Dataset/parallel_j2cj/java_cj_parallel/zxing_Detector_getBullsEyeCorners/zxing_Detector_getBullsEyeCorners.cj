    func getBullsEyeCorners(pCenter: Point): Array<ResultPoint> {
        var pina = pCenter
        var pinb = pCenter
        var pinc = pCenter
        var pind = pCenter

        var color = true

        nbCenterLayers = 1
        while (nbCenterLayers < 9) {
            let pouta = getFirstDifferent(pina, color, 1, -1)
            let poutb = getFirstDifferent(pinb, color, 1, 1)
            let poutc = getFirstDifferent(pinc, color, -1, 1)
            let poutd = getFirstDifferent(pind, color, -1, -1)

            if (nbCenterLayers > 2) {
                let q = distance(poutd, pouta) * Float64(nbCenterLayers) / (distance(pind, pina) * Float64((nbCenterLayers+
                        2)))
                if (q < 0.75 || q > 1.25 || !isWhiteOrBlackRectangle(pouta, poutb, poutc, poutd)) {
                    break
                }
            }

            pina = pouta
            pinb = poutb
            pinc = poutc
            pind = poutd

            color = !color
            nbCenterLayers++
        }

        if (nbCenterLayers != 5 && nbCenterLayers != 7) {
            throw NotFoundException()
        }

        compact = nbCenterLayers == 5

        let pinax = ResultPoint(Float64(pina.x) + 0.5, Float64(pina.y) - 0.5)
        let pinbx = ResultPoint(Float64(pina.x) + 0.5, Float64(pina.y) + 0.5)
        let pincx = ResultPoint(Float64(pina.x) - 0.5, Float64(pina.y) + 0.5)
        let pindx = ResultPoint(Float64(pina.x) - 0.5, Float64(pina.y) - 0.5)

        expandSquare(
            [pinax, pinbx, pincx, pindx],
            2 * nbCenterLayers - 3,
            2 * nbCenterLayers
        )
    }