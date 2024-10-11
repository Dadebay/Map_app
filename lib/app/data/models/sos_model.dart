class SOSModel {
  final int id;
  final String sendName;
  final String title;
  final String sendID;
  final String sendTime;
  final String isread;
  final String content;
  final String lat;
  final String long;
  final String typeId;

  SOSModel({
    required this.id,
    required this.sendName,
    required this.title,
    required this.sendID,
    required this.sendTime,
    required this.isread,
    required this.content,
    required this.lat,
    required this.long,
    required this.typeId,
  });

  factory SOSModel.fromJson(Map<dynamic, dynamic> json) {
    return SOSModel(
      id: json['id'] ?? 0,
      sendName: json['send_name'] ?? '',
      title: json['title'] ?? '',
      sendID: json['send_id'] ?? '',
      sendTime: json['send_time'] ?? '',
      isread: json['isread'] ?? '',
      content: json['content'] ?? '',
      lat: json['lat'] ?? '',
      long: json['lon'] ?? '',
      typeId: json['type_id'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'send_name': sendName,
      'title': title,
      'send_id': sendID,
      'send_time': sendTime,
      'isread': isread,
      'content': content,
      'lat': lat,
      'lon': long,
      'type_id': typeId,
    };
  }
}
