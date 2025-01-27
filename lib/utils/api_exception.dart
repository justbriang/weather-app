class ApiException implements Exception {
  final int statusCode;

  final dynamic response;

  ApiException(this.statusCode, [this.response]);

  @override
  String toString() => 'ApiException: [$statusCode] ';

  factory ApiException.fromJson(Map<String, dynamic> json) {
    return ApiException(
      json['cod'] as int,
      json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'cod': statusCode,
      };
}
