    func isTrialSpecialPass(responseCode:Int64,instanceLength:Int64,isResumable:Bool):Bool{
        if (responseCode == Util.RANGE_NOT_SATISFIABLE && instanceLength >= 0 && isResumable) {
            // provide valid instance-length & resumable but backend response wrong code 416
            // for the range:0-0, because of values on response header is valid we pass it.
            return true
        }
        return false
    }