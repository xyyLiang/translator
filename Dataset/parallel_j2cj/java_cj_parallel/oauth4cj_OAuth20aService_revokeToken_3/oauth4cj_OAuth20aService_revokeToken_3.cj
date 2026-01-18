    public func revokeToken(tokenToRevoke: String, callback: Option<OAuthAsyncRequestCallback>,
            tokenTypeHint: Option<TokenTypeHint>): Future<Unit> {
        let request: OAuth4cjRequest = createRevokeTokenRequest(tokenToRevoke, tokenTypeHint)

        let rc: ResponseConverterRevokeToken = ResponseConverterRevokeToken()
        let res: Future<Any> = execute(request, callback, Some(rc))

        let nowFuture: Future<Unit> = spawn {
            let result = res.get()

            func insideGet(): Exception {
                let err: String = "Exception in parsing Unit, response is: ${rc.responseString}"
                let ex: Exception = (result as Exception) ?? OAuth4cjException(err)
                return OAuth4cjException(ex.message)
            }

            let revokeToken: Option<ResponseConverterRevokeToken> = result as ResponseConverterRevokeToken
            revokeToken.getOrThrow(insideGet)
            return ()
        }
        return nowFuture
    }