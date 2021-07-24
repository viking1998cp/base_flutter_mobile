class ResponseCommon {
  final String code;
  String? message;
  String? userId;
  ResponseCommon({required this.code, this.message, this.userId});

  static ResponseCommon fromJson(Map map) {
    return ResponseCommon(
        code: map['code'] ?? "",
        message: map['message'],
        userId: map['user_id'] ?? "");
  }
}
