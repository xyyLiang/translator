    public func sendRequest(id: String, request: Request): Unit {
        fastLog(id, MessageType.REQUEST_METHOD("RQM"), request.getMethod());
        let url = request.getUrl().toString();
        fastLog(id, MessageType.REQUEST_URL("RQU"),url);
        let nowSjc = Time.now().unixNano()
        fastLog(id, MessageType.REQUEST_TIME("RQT"), Time.now().toString());
        let copy = request.newBuilder().build();
        match(copy.getBody()){
             case Some(v) => doSomeThingRequestBody(v,id)
             case _ => ()
        }

        let headers = request.getHeaders()
        for(header in headers){
            let name: String = header[0]
            let nameUpper = name.toAsciiUpper();
            let conentTypeUpper = CONTENT_TYPE.toAsciiUpper();
            let conentLengthUpper = CONTENT_LENGTH.toAsciiUpper();
            if (conentTypeUpper.equals(nameUpper) || conentLengthUpper.equals(nameUpper)) {
                continue
            }
            let arrayList: ArrayList<String> = header[1]
            if(arrayList.size>0){
                if(arrayList.size == 1){
                    fastLog(id, MessageType.REQUEST_HEADER("RQH"), name + HEADER_DELIMITER + SPACE + arrayList.get(0).getOrThrow());
                }else{
                    var strBuilder = StringBuilder();
                    for(str in arrayList){
                        strBuilder.append(str).append(",")
                    }
                    fastLog(id, MessageType.REQUEST_HEADER("RQH"), name + HEADER_DELIMITER + SPACE + strBuilder.toString());
                }
            }
        }
    }