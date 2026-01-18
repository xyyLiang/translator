    public func putUrlParams(key: String, values: ArrayList<String>): Unit {
        if (!(key.isEmpty()) && !(values.isEmpty())) {
            for (value in values) {
                put(key, value)
            }
        }
    }