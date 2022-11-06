class ClientList {
  final String fullName;
  final String phone;
  final int id;

  ClientList({
    required this.fullName,
    required this.phone,
    required this.id,
  });

  ClientList.fromMap(Map<String, dynamic> json)
      : fullName = json["fullName"],
        id = json["id"],
        phone = json["phone"];
}
