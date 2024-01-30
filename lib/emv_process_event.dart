// ignore_for_file: public_member_api_docs, sort_constructors_first

class EmvProcessEvent {
  String? name;
  String? tipTitle;
  String? tipContent;
  List<String>? aids;
  String? cardNo;
  bool? isOnlinePin;
  String? amount;
  int? type;
  String? authContent;
  String? finalAid;
  int? transResult; // Dart doesn't have a Byte type, using int instead
  String? resultContent;
  int? errorId;
  String? errorMsg;
  EmvProcessEvent({
    this.name,
    this.tipTitle,
    this.tipContent,
    this.aids,
    this.cardNo,
    this.isOnlinePin,
    this.amount,
    this.type,
    this.authContent,
    this.finalAid,
    this.transResult,
    this.resultContent,
    this.errorId,
    this.errorMsg,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'tipTitle': tipTitle,
      'tipContent': tipContent,
      'aids': aids,
      'cardNo': cardNo,
      'isOnlinePin': isOnlinePin,
      'amount': amount,
      'type': type,
      'authContent': authContent,
      'finalAid': finalAid,
      'transResult': transResult,
      'resultContent': resultContent,
      'errorId': errorId,
      'errorMsg': errorMsg,
    };
  }

  factory EmvProcessEvent.fromMap(Map map) {
    return EmvProcessEvent(
      name: map['name'] != null ? map['name'] as String : null,
      tipTitle: map['tipTitle'] != null ? map['tipTitle'] as String : null,
      tipContent:
          map['tipContent'] != null ? map['tipContent'] as String : null,
      aids: map['aids'] != null ? List<String>.from(map['aids'] as List) : null,
      cardNo: map['cardNo'] != null ? map['cardNo'] as String : null,
      isOnlinePin:
          map['isOnlinePin'] != null ? map['isOnlinePin'] as bool : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      authContent:
          map['authContent'] != null ? map['authContent'] as String : null,
      finalAid: map['finalAid'] != null ? map['finalAid'] as String : null,
      transResult:
          map['transResult'] != null ? map['transResult'] as int : null,
      resultContent:
          map['resultContent'] != null ? map['resultContent'] as String : null,
      errorId: map['errorId'] != null ? map['errorId'] as int : null,
      errorMsg: map['errorMsg'] != null ? map['errorMsg'] as String : null,
    );
  }
}
