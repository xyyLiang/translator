    public func getPropertyGroup(prefix0:String,stripPrefix:Bool,excludedPrefixes:Array<String> ): Properties {
        let prefix = if( prefix0.endsWith(".") ) {prefix0 } else { prefix0 + "." }
        let group = Properties();

        for( key in p.keySet() ) {
            if (key.startsWith(prefix)) {
                
                var exclude = false;
                if (!excludedPrefixes.isEmpty()) {
                    for (i in 0 .. excludedPrefixes.size) {
                        exclude = key.startsWith(excludedPrefixes[i]);
                        if( exclude ) {
                            break;
                        }
                    }
                }

                if (!exclude) {
                    let value = getStringProperty(key, "");
                    
                    if (stripPrefix) { 
                        group.setProperty(substring(key,prefix.size), value);
                    } else {
                        group.setProperty(key, value);
                    }
                }
            }
        }

        return group;
    }