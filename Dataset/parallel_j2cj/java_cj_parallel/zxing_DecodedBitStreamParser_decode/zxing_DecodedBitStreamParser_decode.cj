    static func decode(bytes: Array<UInt8>, mode: Int64): DecoderResult {
        let result = StringBuilder()
        func deocde0() {
            let postcode = if (mode == 2) {
                let pc = getPostCode2(bytes)
                let ps2Length = getPostCode2Length(bytes)
                if (ps2Length > 10) {
                    throw FormatException()
                }
                pc.format("${ps2Length}")
            } else {
                getPostCode3(bytes)
            }
            let country = getCountry(bytes).format("3")
            let service = getServiceClass(bytes).format("3")
            result.append(getMessage(bytes, 10, 84))
            if (result.toString().startsWith("[)>" + RS + "01" + GS)) {
                result.insert(9, postcode + GS + country + GS + service + GS)
            } else {
                result.insert(0, postcode + GS + country + GS + service + GS)
            }
        }
        match (mode) {
            case 2 => deocde0()
            case 3 => deocde0()
            case 4 => result.append(getMessage(bytes, 1, 93))
            case 5 => result.append(getMessage(bytes, 1, 77))
            case _ => ()
        }
        DecoderResult(bytes, result.toString(), None, "${mode}")
    }