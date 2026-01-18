    public func getPropertyGroups(prefix0:String): ArrayList<String> {
        let groups = HashSet<String>()
        let prefix = if( prefix0.endsWith(".") ) {prefix0 } else { prefix0 + "." }
        for( key in p.keySet()) {
            if( key.startsWith(prefix) ) {
                let idxOpt = key.indexOf( ".", prefix.size)
                if( let Some(idx) <- idxOpt ) {
                    let groupName = substring(key,prefix.size, idx - prefix.size)
                    groups.put(groupName);
                }
            }
        }

        return ArrayList(groups)
    }