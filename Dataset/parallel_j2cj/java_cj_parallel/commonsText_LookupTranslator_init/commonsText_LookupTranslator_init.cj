    public init(lookupMap: Map<String, String>) {
        this.lookupMap = lookupMap
        this.prefixSet = HashSet<Char>()
        var currentShortest = 0x10FFFF;
        var currentLongest = 0;

        for ((key, value) in lookupMap) {
            if(key.size < 1) {
                continue;
            }
            this.prefixSet.put(key.get(0) ?? Char(0x10FFFF));
            this.lookupMap.put(key, value);
            let sz = key.size;
            if (sz < currentShortest) {
                currentShortest = sz
            }
            if (sz > currentLongest) {
                currentLongest = sz
            }
        }
        this.shortest = currentShortest
        this.longest = currentLongest
    }