     static func isEmpty(str:Option<String>):Bool{
        if(let Some(v) <- str){
            if(v.size == 0){
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }