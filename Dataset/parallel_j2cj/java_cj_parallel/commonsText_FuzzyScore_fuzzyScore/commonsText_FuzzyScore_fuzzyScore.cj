    private func fuzzyScore(term: String, query: String, t:Int32): Int32{
        var score: Int32 = 0
        var previousMatchingCharaterIndex: Int64 = -2147483647
        var lowQuery :String = ""; 
        var lowTerm: String = "";
        if (t == 0){
            lowQuery = query.toAsciiLower()
            lowTerm = term.toAsciiLower()
        } else{
            lowQuery = query.toLower()
            lowTerm = term.toLower()
        }
        var queryIndex:Int64 = 0
        var termIndex: Int64 = 0
        while(queryIndex < lowQuery.size){
            let c = lowQuery.get(queryIndex)
            while(termIndex<lowTerm.size){
                 let t = lowTerm.get(termIndex)
                 if (c == t){
                    score++
                    if (previousMatchingCharaterIndex+1==termIndex){
                        score +=2
                    }
                    previousMatchingCharaterIndex = termIndex
                    termIndex++
                    break
                }
                termIndex++
            }
            queryIndex++;
        }
        return score
    }