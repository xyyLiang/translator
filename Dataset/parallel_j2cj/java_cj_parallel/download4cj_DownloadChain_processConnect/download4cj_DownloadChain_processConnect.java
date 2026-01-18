public synchronized DownloadConnection.Connected processConnect() throws IOException {
    if (cache.isInterrupt()) {
        throw InterruptException.SIGNAL;
    }
    if (connectIndex >= connectInterceptorList.size()) {
        throw new IllegalStateException("Connect index out of bounds");
    }
    return connectInterceptorList.get(connectIndex++).interceptConnect(this);
}