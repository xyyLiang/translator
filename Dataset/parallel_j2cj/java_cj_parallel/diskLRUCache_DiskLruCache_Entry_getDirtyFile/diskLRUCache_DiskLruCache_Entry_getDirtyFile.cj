    public func getDirtyFile(i: Int64): File {
        if(File.exists(disk.directory.info.path.join(key+"."+"${i}"+".tmp"))) {
            return File(disk.directory.info.path.join(key+"."+"${i}"+".tmp"), Open(true,true))
        } else {
            return File(disk.directory.info.path.join(key+"."+"${i}"+".tmp"), Create(true))
        }
    }