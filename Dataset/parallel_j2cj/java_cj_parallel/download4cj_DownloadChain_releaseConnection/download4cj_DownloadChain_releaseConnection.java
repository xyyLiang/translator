    public synchronized void releaseConnection() {
        if (connection != null) {
            connection.release();
            Util.d(TAG, "release connection " + connection + " task[" + task.getId()
                    + "] block[" + blockIndex + "]");
        }
        connection = null;
    }