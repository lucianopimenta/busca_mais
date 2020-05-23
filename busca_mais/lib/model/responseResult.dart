class ResponseResult {
  bool success;
  String errorMessage;
  Object data;

  ResponseResult.fromJson(Map<String,dynamic> map){
    success = map["success"];
    errorMessage = map["errorMessage"];
    data = map["data"];
  }


}