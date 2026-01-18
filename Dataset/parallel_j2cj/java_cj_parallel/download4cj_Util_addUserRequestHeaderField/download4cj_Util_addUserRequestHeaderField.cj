     static func addUserRequestHeaderField(userHeaderField:HashMap<String,ArrayList<String>>,connection:DownloadConnection):Unit{
        inspectUserHeader(userHeaderField)
        addRequestHeaderFields(userHeaderField,connection)
    }