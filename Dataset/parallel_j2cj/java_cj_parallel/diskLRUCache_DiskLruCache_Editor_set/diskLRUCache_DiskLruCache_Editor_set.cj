    public func set(index: Int64, value: String): Unit {
        let writer = newOutputStream(index)
        try {
            if (writer.canWrite()) {
                writer.write(value.toArray())
            }
        } finally {
            writer.close()
        }
        
    }