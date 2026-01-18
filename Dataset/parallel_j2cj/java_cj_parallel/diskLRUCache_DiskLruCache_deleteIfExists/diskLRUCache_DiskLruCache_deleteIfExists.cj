    private static func deleteIfExists(file: Path): Unit {
        if (File.exists(file)) {
            try {
                File.delete(file)
            }catch (e: Exception){
                throw DiskLruCacheException("failed to delete ")
            }  
            
        }
    }