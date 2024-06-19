part of 'services.dart';

abstract final class ApiHelper {
  static http.StreamedResponse _onRequestTimeout() => http.StreamedResponse(
        Stream.fromIterable(
          [
            json.encode({'message': 'Request Timeout'}).codeUnits
          ],
        ),
        408,
      );

  static Future<dynamic> _request({
    required String method,
    required Uri uri,
    Map<String, dynamic>? body,
    bool decode = true,
    Duration? timeout,
  }) async {
    http.Request request = http.Request(method, uri);
    debugPrint('(http request) : $method ${request.url} ${request.headers} $body');
    if (body != null) request.body = json.encode(body);

    http.StreamedResponse response;
    if (timeout == null) {
      response = await request.send();
    } else {
      response = await request.send().timeout(timeout, onTimeout: _onRequestTimeout);
    }

    dynamic responseString = !decode ? await response.stream.toBytes() : await response.stream.bytesToString();
    if (!(response.statusCode > 199 && response.statusCode < 300)) {
      debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
      throw {
        'data': json.decode(responseString),
        'status_code': response.statusCode,
      };
    }

    if (!decode) {
      debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
      return responseString;
    }

    debugPrint('(http response) : $method ${request.url} ${request.headers} => $responseString');
    return json.decode(responseString);
  }

  static Future<dynamic> getUri({required Uri uri, Duration? timeout}) => _request(method: 'GET', uri: uri, timeout: timeout);
}
