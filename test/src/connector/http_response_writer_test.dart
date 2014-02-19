part of restlib.connector_test;

void httpResponseWriterTestGroup() {
  group("writeHttpResponse()", (){
    test("with fully composed Response", () {
      final int age = 10;
      final ImmutableSet<RangeUnit> acceptedRangeUnits =
          EMPTY_SET; // FIXME:
      final ImmutableSet<Method> allowedMethods =
          EMPTY_SET.addAll([Method.GET, Method.PUT]);
      final ImmutableSet<ChallengeMessage> authenticationChallenges =
          EMPTY_SET.add(
              ChallengeMessage.parse("basic realm=\"test\", encoding=\"UTF-8\""));
      final ImmutableSet<CacheDirective> cacheDirectives =
          EMPTY_SET.add(CacheDirective.MAX_STALE);
      final ImmutableSequence<ContentEncoding> contentEncodings =
          EMPTY_SEQUENCE; // FIXME
      final ImmutableSequence<Language> contentLanguages =
          EMPTY_SEQUENCE; // FIXME
      final int contentLength = 10;
      final URI contentLocation = URI_.parseValue("htt://www.example.com");
      final ContentRange contentRange = null; // FIXME
      final MediaRange contentType = APPLICATION_ATOM_XML;
      final DateTime date = null; // FIXME:
      final String entity = "hello";
      final EntityTag etag = new EntityTag.strong("abc");
      final DateTime expires = null; // FIXME:
      final DateTime lastModified = null; // FIXME
      final URI location = URI_.parseValue("www.example.com");
      final DateTime retryAfter = null; // FIXME
      final UserAgent userAgent = UserAgent.parse("test/1.1");
      final Status status = Status.CLIENT_ERROR_BAD_REQUEST;
      final ImmutableSet<Header> varyHeaders =
          EMPTY_SET.addAll([Header.ACCEPT, Header.CONTENT_TYPE]);
      final ImmutableSet<Warning> warnings =
          EMPTY_SET; //FIXME

      final ContentInfo contentInfo =
          new ContentInfo(
              length : contentLength,
              location : contentLocation,
              mediaRange : contentType,
              range : contentRange,
              encodings : contentEncodings,
              languages : contentLanguages);

      final Response<String> response =
          new Response(
              status,
              acceptedRangeUnits : acceptedRangeUnits,
              allowedMethods : allowedMethods,
              age : age,
              authenticationChallenges :authenticationChallenges,
              cacheDirectives : cacheDirectives,
              contentInfo : contentInfo,
              date : date,
              entity : entity,
              entityTag : etag,
              expires : expires,
              lastModified : lastModified,
              location : location,
              proxyAuthenticationChallenges : authenticationChallenges,
              retryAfter : retryAfter,
              server : userAgent,
              vary : varyHeaders,
              warnings : warnings);

      final Dictionary<String,String> headerToValues =
          new Dictionary<String, String>.wrapMap({
              // FIXME: HttpHeaders.ACCEPT_RANGES : response.acceptedRangeUnits,
              Header.AGE.toString() : response.age,
              Header.ALLOW.toString() : response.allowedMethods,
              Header.CACHE_CONTROL.toString() : response.cacheDirectives,
              // FIXME: HttpHeaders.CONTENT_ENCODING : response.contentInfo.encodings,
              // FIXME: HttpHeaders.CONTENT_LANGUAGE : response.contentInfo.languages,
              Header.CONTENT_LOCATION.toString() : response.contentInfo.location,
              // FIXME: HttpHeaders.CONTENT_RANGE : response.contentInfo.range,
              Header.CONTENT_TYPE.toString() : response.contentInfo.mediaRange,
              // FIXME: HttpHeaders.DATE : response.date,
              Header.ENTITY_TAG.toString() : response.entityTag,
              // FIXME: HttpHeaders.EXPIRES : response.expires,
              // FIXME: HttpHeaders.LAST_MODIFIED : response.lastModified,
              Header.LOCATION.toString() : response.location,
              Header.PROXY_AUTHENTICATE.toString() : response.proxyAuthenticationChallenges,
              // FIXME: HttpHeaders.RETRY_AFTER : response.retryAfter,
              Header.SERVER.toString() : response.server,
              Header.VARY.toString() : response.vary,
              // FIXME: HttpHeaders.WARNING : response.warnings,
              Header.WWW_AUTHENTICATE.toString() : response.authenticationChallenges}).mapValues(Header.asHeaderValue);

      final MockHttpHeaders httpResponseHeaders =
          new MockHttpHeaders()
            ..when(callsTo("set"))
              .alwaysCall((final String header, final String value) =>
                  expect(headerToValues[header].value, equals(value)));

      final HttpResponse httpResponse =
          new MockHttpResponse()
            ..when(callsTo("get headers")).alwaysReturn(httpResponseHeaders);

      writeHttpResponse(response, httpResponse);

      headerToValues.keys.forEach((final String key) =>
          httpResponseHeaders.getLogs(callsTo("set", key, anything)).verify(happenedOnce));
    });
  });
}
