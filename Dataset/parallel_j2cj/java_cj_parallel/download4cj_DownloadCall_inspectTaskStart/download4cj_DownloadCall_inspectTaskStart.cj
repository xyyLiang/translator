    private func inspectTaskStart():Unit{
        store.onTaskStart(task.getId())
        Download4cj.withs().callbackDispatcher().dispatch().taskStart(task)
    }