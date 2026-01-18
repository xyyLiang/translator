    func setValue(value: Int64) {
        values[value] = if (let Some(confidence) = values.get(value)) {
            confidence + 1
        } else {
            1
        }
    }