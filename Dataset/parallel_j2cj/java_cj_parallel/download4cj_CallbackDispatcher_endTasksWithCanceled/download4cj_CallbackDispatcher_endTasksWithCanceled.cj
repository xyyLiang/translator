   func endTasksWithCanceled(canceledCollection:ArrayList<DownloadTask>):Unit{
       if (canceledCollection.size <= 0){
         return
       }
       for (task in canceledCollection) {
         task.getListener().taskEnd(task, Option<Exception>.None)
       }
   }