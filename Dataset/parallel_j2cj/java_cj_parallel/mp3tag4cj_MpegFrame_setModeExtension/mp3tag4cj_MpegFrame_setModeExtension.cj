    public func setModeExtension(modeExtension: Int32): Unit {
        if (CHANNEL_MODE_JOINT_STEREO != channelMode) {
            this.modeExtension = MODE_EXTENSION_NA
        } else {
            if (layer == 1 || layer == 2) {
                match (modeExtension) {
                    case 0 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_4_31
                        return
                    case 1 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_8_31
                        return
                    case 2 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_12_31
                        return
                    case 3 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_16_31
                        return
                    case _ => throw InvalidDataException("Invalid mode extension in frame header")
                }
            } else if (layer == 3) {
                match (modeExtension) {
                    case 0 =>
                        this.modeExtension = MODE_EXTENSION_NONE
                        return
                    case 1 =>
                        this.modeExtension = MODE_EXTENSION_INTENSITY_STEREO
                        return
                    case 2 =>
                        this.modeExtension = MODE_EXTENSION_M_S_STEREO
                        return
                    case 3 =>
                        this.modeExtension = MODE_EXTENSION_INTENSITY_M_S_STEREO
                        return
                    case _ => throw InvalidDataException("Invalid mode extension in frame header")
                }
            }
            throw InvalidDataException("Invalid mode extension in frame header")
        }
    }