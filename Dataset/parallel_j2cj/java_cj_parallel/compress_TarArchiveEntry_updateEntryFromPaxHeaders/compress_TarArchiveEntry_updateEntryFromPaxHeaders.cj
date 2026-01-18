    protected func updateEntryFromPaxHeaders(headers: Map<String, String>): Unit {
        for ((key, value) in headers){
            this.processPaxHeader3(key, value, headers)
        }
    }