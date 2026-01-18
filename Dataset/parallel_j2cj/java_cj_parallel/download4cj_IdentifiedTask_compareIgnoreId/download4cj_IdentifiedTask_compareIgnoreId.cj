     func compareIgnoreId(another : IdentifiedTask):Bool{
        try{
            if(!getUrl().equals(another.getUrl())){
                return false
            }
            if(getUrl().equals(EMPTY_URL) || getParentFile().info.path.toString().equals(EMPTY_FILEPATH)){
                return false
            }
            if(getProvidedPathFile().getOrThrow().info == another.getProvidedPathFile().getOrThrow().info){
                return true
            }
            if(getParentFile().info != another.getParentFile().info){
                return false
            }
            let fileName : String = getFilename().getOrThrow()
            let anotherFilename : String = another.getFilename().getOrThrow()
            return anotherFilename.equals(fileName)
        }catch(e:Exception){
            return false
        }
    }