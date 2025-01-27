import 'base_model.dart';
import 'package:equatable/equatable.dart';

class ApiError extends BaseModel with EquatableMixin {
  final int code;
  final String message;

  ApiError({
    required this.code,
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['cod'],
      message: json['message'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'cod': code,
        'message': message,
      };

  @override
  List<Object?> get props => [code, message];
}
