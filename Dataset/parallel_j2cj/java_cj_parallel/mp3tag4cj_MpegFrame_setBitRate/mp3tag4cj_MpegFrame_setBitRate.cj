    public func setBitRate(bitrate: Int32): Unit {
        if (MPEG_VERSION_1_0 == this.version) {
            if (this.layer == 1) {
                matchSetBitRateV1L1(bitrate)
                return
            } else if (layer == 2) {
                matchSetBitRateV1L2(bitrate)
                return
            } else if (layer == 3) {
                matchSetBitRateV1L3(bitrate)
                return
            }
        } else if (MPEG_VERSION_2_0 == version || MPEG_VERSION_2_5 == version) {
            if (layer == 1) {
                matchSetBitRateV2xL1(bitrate)
                return
            } else if (layer == 2 || layer == 3) {
                matchSetBitRateV2xL23(bitrate)
                return
            }
        }
        throw InvalidDataException("Invalid bitrate in frame header")
    }
    private func matchSetBitRateV1L1(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 64
                return
            case 3 =>
                this.bitrate = 96
                return
            case 4 =>
                this.bitrate = 128
                return
            case 5 =>
                this.bitrate = 160
                return
            case 6 =>
                this.bitrate = 192
                return
            case 7 =>
                this.bitrate = 224
                return
            case 8 =>
                this.bitrate = 256
                return
            case 9 =>
                this.bitrate = 288
                return
            case 10 =>
                this.bitrate = 320
                return
            case 11 =>
                this.bitrate = 352
                return
            case 12 =>
                this.bitrate = 384
                return
            case 13 =>
                this.bitrate = 416
                return
            case 14 =>
                this.bitrate = 448
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV1L2(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 48
                return
            case 3 =>
                this.bitrate = 56
                return
            case 4 =>
                this.bitrate = 64
                return
            case 5 =>
                this.bitrate = 80
                return
            case 6 =>
                this.bitrate = 96
                return
            case 7 =>
                this.bitrate = 112
                return
            case 8 =>
                this.bitrate = 128
                return
            case 9 =>
                this.bitrate = 160
                return
            case 10 =>
                this.bitrate = 192
                return
            case 11 =>
                this.bitrate = 224
                return
            case 12 =>
                this.bitrate = 256
                return
            case 13 =>
                this.bitrate = 320
                return
            case 14 =>
                this.bitrate = 384
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV1L3(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 40
                return
            case 3 =>
                this.bitrate = 48
                return
            case 4 =>
                this.bitrate = 56
                return
            case 5 =>
                this.bitrate = 64
                return
            case 6 =>
                this.bitrate = 80
                return
            case 7 =>
                this.bitrate = 96
                return
            case 8 =>
                this.bitrate = 112
                return
            case 9 =>
                this.bitrate = 128
                return
            case 10 =>
                this.bitrate = 160
                return
            case 11 =>
                this.bitrate = 192
                return
            case 12 =>
                this.bitrate = 224
                return
            case 13 =>
                this.bitrate = 256
                return
            case 14 =>
                this.bitrate = 320
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV2xL1(bitrates: Int32): Unit {
        match (bitrates) {
            case 1 =>
                this.bitrate = Int32(32)
                return
            case 2 =>
                this.bitrate = Int32(48)
                return
            case 3 =>
                this.bitrate = Int32(56)
                return
            case 4 =>
                this.bitrate = Int32(64)
                return
            case 5 =>
                this.bitrate = Int32(80)
                return
            case 6 =>
                this.bitrate = Int32(96)
                return
            case 7 =>
                this.bitrate = Int32(112)
                return
            case 8 =>
                this.bitrate = Int32(128)
                return
            case 9 =>
                this.bitrate = Int32(144)
                return
            case 10 =>
                this.bitrate = Int32(160)
                return
            case 11 =>
                this.bitrate = Int32(176)
                return
            case 12 =>
                this.bitrate = Int32(192)
                return
            case 13 =>
                this.bitrate = Int32(224)
                return
            case 14 =>
                this.bitrate = Int32(256)
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV2xL23(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 8
                return
            case 2 =>
                this.bitrate = 16
                return
            case 3 =>
                this.bitrate = 24
                return
            case 4 =>
                this.bitrate = 32
                return
            case 5 =>
                this.bitrate = 40
                return
            case 6 =>
                this.bitrate = 48
                return
            case 7 =>
                this.bitrate = 56
                return
            case 8 =>
                this.bitrate = 64
                return
            case 9 =>
                this.bitrate = 80
                return
            case 10 =>
                this.bitrate = 96
                return
            case 11 =>
                this.bitrate = 112
                return
            case 12 =>
                this.bitrate = 128
                return
            case 13 =>
                this.bitrate = 144
                return
            case 14 =>
                this.bitrate = 160
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }