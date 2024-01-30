class TrackData {
  String? cardno;
  String? encryptCardNo;
  String? firstTrackData;
  String? secondTrackData;
  String? thirdTrackData;
  String? encryptTrackData;
  String? expiryDate;
  String? serviceCode;

  TrackData();

  TrackData.fromJson(Map json)
      : cardno = json['cardno'] as String?,
        encryptCardNo = json['encryptCardNo'] as String?,
        firstTrackData = json['firstTrackData'] as String?,
        secondTrackData = json['secondTrackData'] as String?,
        thirdTrackData = json['thirdTrackData'] as String?,
        encryptTrackData = json['encryptTrackData'] as String?,
        expiryDate = json['expiryDate'] as String?,
        serviceCode = json['serviceCode'] as String?;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "cardno": this.cardno,
        "encryptCardNo": this.encryptCardNo,
        "firstTrackData": this.firstTrackData,
        "secondTrackData": this.secondTrackData,
        "thirdTrackData": this.thirdTrackData,
        "encryptTrackData": this.encryptTrackData,
        "expiryDate": this.expiryDate,
        "serviceCode": this.serviceCode,
      };
}
