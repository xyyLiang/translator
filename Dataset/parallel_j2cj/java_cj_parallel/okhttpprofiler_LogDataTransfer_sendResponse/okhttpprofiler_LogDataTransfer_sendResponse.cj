      public func sendResponse(id: String, response: Response): Unit {

        let optionBody: Option<ResponseBody> = response.getBody()
        match(optionBody){
              case Some(v) => doSomeThingResponseBody(v,id)
              case _ => ()
        }


        logWithHandler(id, MessageType.RESPONSE_STATUS("RSS"), response.getCode().toString(), 0);

        let headers = response.getHeaders()
        for(header in headers){
                let name: String = header[0]
                let arrayList : ArrayList<String> = header[1]
                if(arrayList.size > 0){
                    if(arrayList.size == 1){
                        logWithHandler(id, MessageType.RESPONSE_HEADER("RSH"), name + HEADER_DELIMITER + arrayList.get(0).getOrThrow(), 0);
                    }else{
                        var strBuilder = StringBuilder();
                        for(str in arrayList){
                            strBuilder.append(str).append(",")
                        }
                        logWithHandler(id, MessageType.RESPONSE_HEADER("RSH"), name + HEADER_DELIMITER + strBuilder.toString(), 0);
                    }
                }
            }
    }