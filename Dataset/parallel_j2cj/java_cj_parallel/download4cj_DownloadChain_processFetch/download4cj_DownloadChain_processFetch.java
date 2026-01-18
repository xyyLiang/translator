public long processFetch() throws IOException {
    if (cache.isInterrupt()) throw InterruptException.SIGNAL;
    return fetchInterceptorList.get(fetchIndex++).interceptFetch(this);
}