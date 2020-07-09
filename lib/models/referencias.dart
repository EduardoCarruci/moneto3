import 'dart:convert';

class Referencias {
  String id;
  int idOperacionFinanciera;
  String referencia;

  Referencias({
    this.id,
    this.idOperacionFinanciera,
    this.referencia,
  });

  factory Referencias.fromJson(String str) =>
      Referencias.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Referencias.fromMap(Map<String, dynamic> json) => Referencias(
        id: json["\u0024id"],
        idOperacionFinanciera: json["IdOperacionFinanciera"],
        referencia: json["Referencia"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024id": id,
        "IdOperacionFinanciera": idOperacionFinanciera,
        "Referencia": referencia,
      };
}
