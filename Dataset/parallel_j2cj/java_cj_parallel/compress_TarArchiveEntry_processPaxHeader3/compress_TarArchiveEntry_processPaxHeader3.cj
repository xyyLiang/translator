    private func processPaxHeader3(key: String, val: String, headers: Map<String, String>): Unit {
        match (key) {
            case "path"     => this.setName(val)
            case "linkpath" => this.setLinkName(val)
            case "gid"      => this.setGroupIdLong(Int64.parse(val))
            case "gname"    => this.setGroupName(val)
            case "uid"      => this.setUserIdLong(Int64.parse(val))
            case "uname"    => this.setUserName(val)
            case "size" => 
                let size: Int64 = Int64.parse(val)
                if (size < 0) {
                    throw  Exception("Corrupted TAR archive. Entry size is negative")
                }
                this.setSize(size)
            case "mtime"    => this.setModTime(Int64.parse(val) * 1000)
            case "SCHILY.devminor" => 
                let devMinor: Int64 = Int64.parse(val)
                if (devMinor < 0) {
                    throw  Exception("Corrupted TAR archive. Dev-Minor is negative")
                }
                this.setDevMinor(devMinor)
            case "SCHILY.devmajor" => 
                let devMajor: Int64 = Int64.parse(val)
                if (devMajor < 0) {
                    throw  Exception("Corrupted TAR archive. Dev-Major is negative")
                }
                this.setDevMajor(devMajor)
            case "GNU.sparse.size" => this.fillGNUSparse0xData(headers)
            case "GNU.sparse.realsize" =>  this.fillGNUSparse1xData(headers)
            case "SCHILY.filetype" => 
                if ("sparse" == val) {
                    this.fillStarSparseData(headers)
                }
            case _  => this.extraPaxHeaders.put(key, val)
        }
    }