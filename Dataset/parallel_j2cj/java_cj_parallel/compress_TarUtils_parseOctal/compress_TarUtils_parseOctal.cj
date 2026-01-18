    @OverflowWrapping
    public static func parseOctal(buffer: Array<Byte>, offset: Int64, length: Int64): Int64 {
        var result: Int64 = 0
        var end: Int64 = offset + length
        var start: Int64 = offset
        if (length < 2) {
            throw IllegalArgumentException(/* "Length " + length + " must be at least 2" */)
        }
        if (buffer[start] == 0) {
            return 0
        }

        // Skip leading spaces
        while (start < end) {
            if (buffer[start] != UInt8(UInt32(' '))) {
                break
            }
            start++
        }

        // Trim all trailing NULs and spaces.
        // The ustar and POSIX tar specs require a trailing NUL or
        // space but some implementations use the extra digit for big
        // sizes/uids/gids ...
        var trailer: Byte = buffer[end - 1]
        while (start < end && (trailer == 0 || trailer == UInt8(UInt32(' ')))) {
            end--
            trailer = buffer[end - 1]
        }
        for (i in start..end) {
            var currentByte: Byte = buffer[i]

            // CheckStyle:MagicNumber OFF
            if (currentByte < UInt8(UInt32('0')) || currentByte > UInt8(UInt32('7'))) {
                throw IllegalArgumentException(/* exceptionMessage(buffer, offset, length, start, currentByte) */)
            }

            // convert from ASCII
            result = (result << 3) + Int64(currentByte - UInt8(UInt32('0')))
            // CheckStyle:MagicNumber ON
        }
        return result
    }