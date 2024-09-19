class MapModel {
  final String id;
  final String gpsName;
  final String sortID;
  final String driveID;
  final String strUID;
  final String wlID;
  final String pic;
  final String vol;
  final String vbt;
  final String islac;
  final String sta;
  final String gprs;
  final String gps;
  final String stateFlag;
  final String itvtime;
  final String gpsTime;
  final String imei;
  final String tel;
  final String sign;
  final String deviceType;
  final String jindu;
  final String weidu;
  final String serTime;
  final String iconType;
  final String isOnline;
  final String lastTime;
  final String addre;
  final String lat;
  final String long;
  final String spe;
  final String dir;
  String howMuchKM;
  MapModel({
    required this.id,
    required this.weidu,
    required this.serTime,
    required this.iconType,
    required this.isOnline,
    required this.lastTime,
    required this.addre,
    required this.lat,
    required this.long,
    required this.spe,
    required this.dir,
    required this.imei,
    required this.tel,
    required this.gpsName,
    required this.sortID,
    required this.driveID,
    required this.strUID,
    required this.wlID,
    required this.pic,
    required this.vol,
    required this.vbt,
    required this.islac,
    required this.sta,
    required this.gprs,
    required this.gps,
    required this.stateFlag,
    required this.itvtime,
    required this.gpsTime,
    required this.sign,
    required this.deviceType,
    required this.jindu,
    required this.howMuchKM,
  });

  factory MapModel.fromJson(Map<dynamic, dynamic> json) {
    return MapModel(
      id: json['id'] ?? 0,
      gpsName: json['gpsname'] ?? '',
      sortID: json['sortID'] ?? '',
      driveID: json['driveID'] ?? '',
      strUID: json['strUiD'] ?? '',
      wlID: json['wlID'] ?? '',
      pic: json['pic'] ?? '',
      vol: json['vol'] ?? '',
      vbt: json['vbt'] ?? '',
      islac: json['islac'] ?? '',
      sta: json['sta'] ?? '',
      gprs: json['gprs'] ?? '',
      gps: json['gps'] ?? '',
      stateFlag: json['stateFlag'] ?? '',
      itvtime: json['itvtime'] ?? '',
      gpsTime: json['gpsTime'] ?? '',
      imei: json['imei'] ?? '',
      tel: json['tel'] ?? '',
      sign: json['sign'] ?? '',
      deviceType: json['deviceType'] ?? '',
      jindu: json['jindu'] ?? '',
      weidu: json['weidu'] ?? '',
      serTime: json['sertime'] ?? '',
      iconType: json['iconType'] ?? '',
      isOnline: json['isOnline'] ?? '',
      lastTime: json['lastttime'] ?? '',
      addre: json['addre'] ?? '',
      lat: json['lat'] ?? '',
      long: json['lon'] ?? '',
      spe: json['spe'] ?? '',
      dir: json['dir'] ?? '',
      howMuchKM: '0.0',
    );
  }
}
