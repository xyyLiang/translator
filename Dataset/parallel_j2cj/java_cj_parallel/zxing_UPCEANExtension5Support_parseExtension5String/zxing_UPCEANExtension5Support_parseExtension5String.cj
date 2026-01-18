    static func parseExtension5String(raw: String): ?String {
        let currency = match (raw.charAt(0)) {
            case '0' => "£"
            case '5' => "$"
            case '9' =>
                if (raw == "90000") {
                    return None
                } else if (raw == "99991") {
                    return "0.00"
                } else if (raw == "99990") {
                    return "Used"
                }
                ""
            case _ => ""
        }
        let rawAmount = Int64.parse(raw[1..raw.size])
        let unitsString = "${rawAmount / 100}"
        let hundredths = rawAmount % 100
        let hundredthsString = if (hundredths < 10) {
            "0${hundredths}"
        } else {
            "${hundredths}"
        }
        currency + unitsString + '.' + hundredthsString
    }