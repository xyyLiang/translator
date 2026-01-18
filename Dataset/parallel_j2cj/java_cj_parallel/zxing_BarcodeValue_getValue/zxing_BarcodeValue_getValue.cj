    func getValue(): Array<Int64> {
        var maxConfidence = -1
        let result = ArrayList<Int64>()
        for ((key, value) in values) {
            if (value > maxConfidence) {
                maxConfidence = value
                result.clear()
                result.append(key)
            } else if (value == maxConfidence) {
                result.append(key)
            }
        }
        PDF417Common.toIntArray(result)
    }