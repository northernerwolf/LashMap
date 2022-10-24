class ClientList {
  final String fullName;
  final int id;
  ClientList({
    required this.fullName,
    required this.id,
  });

  ClientList.fromMap(Map<String, dynamic> json)
      : fullName = json["fullName"],
        id = json["id"];
}
