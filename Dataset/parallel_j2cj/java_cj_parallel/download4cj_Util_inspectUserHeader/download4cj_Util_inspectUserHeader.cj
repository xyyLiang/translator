     static func inspectUserHeader(headerField:HashMap<String,ArrayList<String>>):Unit{
        if(headerField.contains(IF_MATCH) || headerField.contains(RANGE)){
            throw  ReadWriteException(IF_MATCH + " and " + RANGE + " only can be handle by internal!")
        }
    }