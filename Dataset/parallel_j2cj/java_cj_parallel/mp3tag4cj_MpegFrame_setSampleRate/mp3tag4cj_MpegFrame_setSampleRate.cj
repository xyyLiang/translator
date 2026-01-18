    public func setSampleRate(sampleRate: Int32): Unit {
        if (MPEG_VERSION_1_0 == version) {
            match (sampleRate) {
                case 0 =>
                    this.sampleRate = 44100
                    return
                case 1 =>
                    this.sampleRate = 48000
                    return
                case 2 =>
                    this.sampleRate = 32000
                    return
                case _ => throw InvalidDataException("Invalid sample rate in frame header")
            }
        } else if (MPEG_VERSION_2_0 == version) {
            match (sampleRate) {
                case 0 =>
                    this.sampleRate = 22050
                    return
                case 1 =>
                    this.sampleRate = 24000
                    return
                case 2 =>
                    this.sampleRate = 16000
                    return
                case _ => throw InvalidDataException("Invalid sample rate in frame header")
            }
        } else if (MPEG_VERSION_2_5 == version) {
            match (sampleRate) {
                case 0 =>
                    this.sampleRate = 11025
                    return
                case 1 =>
                    this.sampleRate = 12000
                    return
                case 2 =>
                    this.sampleRate = 8000
                    return
                case _ => throw InvalidDataException("Invalid sample rate in frame header")
            }
        }
        throw InvalidDataException("Invalid sample rate in frame header")
    }