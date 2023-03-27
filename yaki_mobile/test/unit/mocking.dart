import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:retrofit/retrofit.dart';

@GenerateMocks(
  [
    Response,
  ],
  customMocks: [
    MockSpec<HttpResponse<Map<String, dynamic>>>(
      as: #MockHttpResponse,
    ),
    MockSpec<HttpResponse<List<Map<String, dynamic>>>>(
      as: #MockHttpResponseList,
    ),
    MockSpec<HttpResponse<String>>(
      as: #MockHttpResponseString,
    ),
  ],
)
void main() {
  test(
    'share mock',
    () {
      expect(true, true);
    },
  );
}
