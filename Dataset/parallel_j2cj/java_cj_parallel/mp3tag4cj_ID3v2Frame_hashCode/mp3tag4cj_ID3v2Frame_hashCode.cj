    @OverflowWrapping
    public open func hashCode(): Int64 {
        var arr: Array<String> = [
            compression.toString(),
            dataLength.toString(),
            dataLengthIndicator.toString(),
            encryption.toString(),
            group.toString(),
            id.toString(),
            preserveFile.toString(),
            preserveTag.toString(),
            readOnly.toString(),
            unsynchronisation.toString()
        ]
        return 31 * arr.toString().hashCode() + data.toString().hashCode()
    }