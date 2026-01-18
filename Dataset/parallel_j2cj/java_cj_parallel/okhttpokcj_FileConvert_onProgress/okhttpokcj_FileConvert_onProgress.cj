    private func onProgress(progress: Progress): Unit {
        spawn {
            callback.downloadProgress(progress)
        }
    }