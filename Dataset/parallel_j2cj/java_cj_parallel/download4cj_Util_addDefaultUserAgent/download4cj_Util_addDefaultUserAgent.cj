     static func addDefaultUserAgent(connection:DownloadConnection):Unit{

        let userAgent:String = "Download4cj/"+VERSION_NAME
        connection.addHeader(USER_AGENT, userAgent)

    }