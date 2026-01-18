    public static func invert(map: Map<String, String>): Map<String, String> {
        let newMap = HashMap<String, String>(map.size);
        for ((k, v) in map) {
            newMap.put(v, k);
        }
        return newMap
    }