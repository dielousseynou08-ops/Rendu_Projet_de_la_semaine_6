class Users {
  final int? id;
  final String usrName;
  final String usrPassword;

  Users({
    this.id,
    required this.usrName,
    required this.usrPassword,
    // ignore: non_constant_identifier_names
    required VALUES,
  });

  factory Users.fromMap(Map<String, dynamic> map) => Users(
    usrName: map["usrName"],
    usrPassword: map["usrPassword"],
    id: null,
    VALUES: null,
  );

  Map<String, dynamic> toMap() => {
    "usrName": usrName,
    "usrPassword": usrPassword,
  };
}
