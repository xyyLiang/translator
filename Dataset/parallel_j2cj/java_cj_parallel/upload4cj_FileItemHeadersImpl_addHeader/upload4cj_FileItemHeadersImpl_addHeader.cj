    public func addHeader(name: String, value: String): Unit {
        let nameLower: String = name.toAsciiLower()
        var headerValueList: Option<ArrayList<String>> = headerNameToValueListMap.get(nameLower)
        if (let Some(_) <- headerValueList) {}
        else {
            headerValueList = ArrayList<String>()
            headerNameToValueListMap.put(nameLower, headerValueList.getOrThrow())
        }
        headerValueList.getOrThrow().append(value)
    }