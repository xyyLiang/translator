   func endTasks(completedTaskCollection:ArrayList<DownloadTask>,sameTaskConflictCollection:ArrayList<DownloadTask>,fileBusyCollection:ArrayList<DownloadTask>){

      if (completedTaskCollection.size == 0 && sameTaskConflictCollection.size == 0&& fileBusyCollection.size == 0) {
            return
      }

      for (task in completedTaskCollection) {
         task.getListener().taskEnd(task, Option<Exception>.None)
      }
      for (task in sameTaskConflictCollection) {
         task.getListener().taskEnd(task, Option<Exception>.None)
      }
      for (task in fileBusyCollection) {
         task.getListener().taskEnd(task, Option<Exception>.None)
      }

   }