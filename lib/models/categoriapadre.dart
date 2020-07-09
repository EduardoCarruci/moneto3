import 'dart:convert';

class CategoriaPadre {
    CategoriaPadre({
        this.id,
        this.idCuentaContable,
        this.espadre,
        this.idtipoCliente,
        this.idpadre,
        this.codigo,
        this.nombre,
        this.idtipoCategoria,
        this.tipoCategoria,
    });

    String id;
    int idCuentaContable;
    int espadre;
    int idtipoCliente;
    dynamic idpadre;
    String codigo;
    String nombre;
    dynamic idtipoCategoria;
    dynamic tipoCategoria;

    factory CategoriaPadre.fromJson(String str) => CategoriaPadre.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CategoriaPadre.fromMap(Map<String, dynamic> json) => CategoriaPadre(
        id: json["\u0024id"],
        idCuentaContable: json["idCuentaContable"],
        espadre: json["espadre"],
        idtipoCliente: json["idtipoCliente"],
        idpadre: json["idpadre"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        idtipoCategoria: json["idtipoCategoria"],
        tipoCategoria: json["tipoCategoria"],
    );

    Map<String, dynamic> toMap() => {
        "\u0024id": id,
        "idCuentaContable": idCuentaContable,
        "espadre": espadre,
        "idtipoCliente": idtipoCliente,
        "idpadre": idpadre,
        "codigo": codigo,
        "nombre": nombre,
        "idtipoCategoria": idtipoCategoria,
        "tipoCategoria": tipoCategoria,
    };
}