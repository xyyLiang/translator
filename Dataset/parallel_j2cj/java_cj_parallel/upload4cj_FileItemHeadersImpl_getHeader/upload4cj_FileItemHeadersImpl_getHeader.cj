    public override func getHeader(name: String): Option<String> {
        let nameLower: String = name.toAsciiLower()
        let headerValueList: Option<ArrayList<String>> = headerNameToValueListMap.get(nameLower)
        if (let Some(i) <- headerValueList) {
            return i.get(0)
        } else {
            return Option<String>.None
        }
    }