// class FlutterPinInfo {
//   int _pikId;
//   int _keytype;
//   String _cardno;
//   int _cardNoDealType = 1;
//   String _random;
//   int _minLenth;
//   int _maxLenth;
//   bool _needCardCalc;
//   int _timeout;
//   bool _isCanclable;
//   bool _isBeep;
//   bool _isShowInputBox;
//   bool _isRandomKeybord;
//   bool _isMask;
//   int _inputTimes;
//   int _encryMode;


//   FlutterPinInfo() {
//     _minLenth = 4;
//     _maxLenth = 6;
//     _pikId = 0;
//     _isShowInputBox = true;
//     _encryMode = 0;
//     _inputTimes = 0;
//     _keytype = 0;
//     _timeout = 60000;
//   }

//   FlutterPinInfo.fromJson(Map<String, dynamic> json)
//       : _pikId = json['pikId'],
//         _keytype = json['keytype'],
//         _cardno = json['cardno'],
//         _cardNoDealType = json['cardNoDealType'],
//         _minLenth = json['minLenth'],
//         _maxLenth = json['maxLenth'],
//         _random = json['random'],
//         _encryMode = json['encryMode'],
//         _needCardCalc = json['needCardCalc'],
//         _inputTimes = json['inputTimes'],
//         _isCanclable = json['isCanclable'],
//         _isBeep = json['isBeep'],
//         _isShowInputBox = json['isShowInputBox'],
//         _isRandomKeybord = json['isRandomKeybord'],
//         _timeout = json['timeout'],
//         _isMask = json['isMask'];

//   Map<String, dynamic> toJson() => {
//         'pikId': _pikId,
//         'keytype': _keytype,
//         'cardno': _cardno,
//         'cardNoDealType': _cardNoDealType,
//         'minLenth': _minLenth,
//         'maxLenth': _maxLenth,
//         'random': _random,
//         'encryMode': _encryMode,
//         'needCardCalc': _needCardCalc,
//         'inputTimes': _inputTimes,
//         'isCanclable': _isCanclable,
//         'isBeep': _isBeep,
//         'timeout': _timeout,
//         'isShowInputBox': _isShowInputBox,
//         'isRandomKeybord': _isRandomKeybord,
//         'isMask': _isMask,
//       };




//   String get cardno {
//     if (_cardno.isEmpty) {
//       return '0000000000000000';
//     } else if (1 == _cardNoDealType) {
//       if (_cardno.replaceAll(' ', '').trim().length < 13) {
//         _cardno = '00000000'.substring(0, 13 - _cardno.length) + _cardno;
//       }
//       _cardno = _cardno.replaceAll(' ', '');
//       int indexEnd = _cardno.length - 1;
//       int indexStart = indexEnd - 12;
//       String pan = _cardno.substring(indexStart, indexEnd);
//       pan = '0000' + pan;
//       return pan;
//     } else if (0 != _cardNoDealType) {
//       return 2 == _cardNoDealType ? _cardno : '0000000000000000';
//     } else {
//       for (_cardno = _cardno.replaceAll(' ', '');
//           _cardno.length < 16;
//           _cardno = _cardno + 'F') {}
//       String pan = _cardno.substring(3, 15);
//       pan = '0000' + pan;
//       return pan;
//     }
//   }

//   set cardno(String value) {
//     _cardno = value;
//   }

//   int get encryMode => _encryMode;

//   set encryMode(int value) {
//     _encryMode = value;
//   }

//   int get inputTimes => _inputTimes;

//   set inputTimes(int value) {
//     _inputTimes = value;
//   }

//   bool get isMask => _isMask;

//   set isMask(bool value) {
//     _isMask = value;
//   }

//   bool get isRandomKeybord => _isRandomKeybord;

//   set isRandomKeybord(bool value) {
//     _isRandomKeybord = value;
//   }

//   bool get isShowInputBox => _isShowInputBox;

//   set isShowInputBox(bool value) {
//     _isShowInputBox = value;
//   }

//   bool get isBeep => _isBeep;

//   set isBeep(bool value) {
//     _isBeep = value;
//   }

//   bool get isCanclable => _isCanclable;

//   set isCanclable(bool value) {
//     _isCanclable = value;
//   }

//   int get timeout => _timeout;

//   set timeout(int value) {
//     _timeout = value;
//   }

//   bool get needCardCalc => _needCardCalc;

//   set needCardCalc(bool value) {
//     _needCardCalc = value;
//   }

//   int get maxLenth => _maxLenth;

//   set maxLenth(int value) {
//     _maxLenth = value;
//   }

//   int get minLenth => _minLenth;

//   set minLenth(int value) {
//     _minLenth = value;
//   }

//   String get random => _random;

//   set random(String value) {
//     _random = value;
//   }

//   int get cardNoDealType => _cardNoDealType;

//   set cardNoDealType(int value) {
//     _cardNoDealType = value;
//   }

//   int get keytype => _keytype;

//   set keytype(int value) {
//     _keytype = value;
//   }

//   int get pikId => _pikId;

//   set pikId(int value) {
//     _pikId = value;
//   }
// }



