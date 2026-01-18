     static func resetBlockIfDirty(info:BlockInfo):Unit{
        var isDirty:Bool = false

        if (info.getCurrentOffset() < 0) {
            isDirty = true
        } else if (info.getCurrentOffset() > info.getContentLength()) {
            isDirty = true
        }

        if (isDirty) {
            info.resetBlock()
        }

    }