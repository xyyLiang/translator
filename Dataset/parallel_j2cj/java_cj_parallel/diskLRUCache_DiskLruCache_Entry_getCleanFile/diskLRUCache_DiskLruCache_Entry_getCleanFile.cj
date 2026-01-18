    public func getCleanFile(i: Int64): File {
        if(File.exists(disk.directory.info.path.join(key+"."+"${i}"))) {
            return File(disk.directory.info.path.join(key+"."+"${i}"), Open(true,true))
        } else {
            return File(disk.directory.info.path.join(key+"."+"${i}"), Create(true))
        }
    }