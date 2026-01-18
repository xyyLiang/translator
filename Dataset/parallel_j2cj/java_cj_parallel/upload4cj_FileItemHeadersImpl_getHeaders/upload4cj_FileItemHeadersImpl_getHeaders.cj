    public override func getHeaders(name: String): Iterator<String> {
        let nameLower: String = name.toAsciiLower()
        var headerValueList: Option<ArrayList<String>> = headerNameToValueListMap.get(nameLower)
        if (let Some(i) <- headerValueList) {
            return i.iterator()
        } else {
            headerValueList = ArrayList<String>()
            return headerValueList.getOrThrow().iterator()
        }
    }