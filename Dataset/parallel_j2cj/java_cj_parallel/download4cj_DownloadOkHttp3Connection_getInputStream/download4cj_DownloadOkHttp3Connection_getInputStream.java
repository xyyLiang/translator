@Override
public InputStream getInputStream() throws IOException {
    if (response == null) throw new IOException("Please invoke execute first!");
    final ResponseBody body = response.body();
    if (body == null) throw new IOException("no body found on response!");
    return body.byteStream();
}