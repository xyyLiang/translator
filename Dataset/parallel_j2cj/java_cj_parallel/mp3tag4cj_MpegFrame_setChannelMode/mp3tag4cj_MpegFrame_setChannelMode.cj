    public func setChannelMode(channelMode: Int32): Unit {
        match (channelMode) {
            case 0 => this.channelMode = CHANNEL_MODE_STEREO
            case 1 => this.channelMode = CHANNEL_MODE_JOINT_STEREO
            case 2 => this.channelMode = CHANNEL_MODE_DUAL_MONO
            case 3 => this.channelMode = CHANNEL_MODE_MONO
            case _ => throw InvalidDataException("Invalid channel mode in frame header")
        }
    }