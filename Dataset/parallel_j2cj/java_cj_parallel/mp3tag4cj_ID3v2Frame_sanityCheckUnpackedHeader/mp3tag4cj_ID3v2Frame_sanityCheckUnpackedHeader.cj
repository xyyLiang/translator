    protected func sanityCheckUnpackedHeader(): Unit {
        for (i in 0..id.toRuneArray().size) {
            if (!((id.toRuneArray()[i] >= 'A' && id.toRuneArray()[i] <= 'Z') || (id.toRuneArray()[i] >= '0' && id.toRuneArray()[i] <= '9'))) {
                throw InvalidDataException("Not a valid frame - invalid tag ")
            }
        }
    }