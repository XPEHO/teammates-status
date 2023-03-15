// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _StatusApi implements StatusApi {
  _StatusApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<DeclarationModel>> getDeclaration(teamMateId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
<<<<<<< HEAD:yaki_mobile/lib/data/sources/remote/status_api.g.dart
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<DeclarationModel>>(Options(
      method: 'GET',
=======
    final _data = <String, dynamic>{};
    _data.addAll(declaration.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DeclarationModel>(Options(
      method: 'POST',
>>>>>>> main:yaki_mobile/lib/data/sources/declaration_api.g.dart
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/status/${teamMateId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeclarationModel.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
