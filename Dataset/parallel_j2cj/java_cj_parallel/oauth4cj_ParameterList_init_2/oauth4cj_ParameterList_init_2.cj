    public init(map: HashMap<String, String>) {
        this.params = ArrayList<OAuth4cjParameter>(map.size)
        if (map.size > 0) {
            for ((k, v) in map) {
                params.append(OAuth4cjParameter(k, v))
            }
        }
    }