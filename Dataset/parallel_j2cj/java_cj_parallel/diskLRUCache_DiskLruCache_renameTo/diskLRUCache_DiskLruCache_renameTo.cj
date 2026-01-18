    private static func renameTo(fo: Path, to: Path, deleteDestination: Bool): Unit {
        if (deleteDestination) {
            deleteIfExists(to)
        }
        File.move(fo,to, true)

    }