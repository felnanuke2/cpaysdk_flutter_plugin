class PrintState {
  int stateCode;
  String stateMsg;
  PrintState({required this.stateCode, required this.stateMsg});

  PrintState.fromJson(Map<String, dynamic> json)
      : stateCode = json['stateCode'] as int,
        stateMsg = json['stateMsg'] as String;

  Map<String, dynamic> toJson() => <String,dynamic>{
        "stateCode": this.stateCode,
        // "itemAlign": this.itemAlign,
        "stateMsg": this.stateMsg,
      };
}
