import 'package:equatable/equatable.dart';

class PropertiesModel extends Equatable {
  const PropertiesModel({required this.propertyTable});

  final PropertyTable? propertyTable;

  factory PropertiesModel.fromJson(Map<String, dynamic> json) {
    return PropertiesModel(
      propertyTable: json["PropertyTable"] == null
          ? null
          : PropertyTable.fromJson(json["PropertyTable"]),
    );
  }

  @override
  List<Object?> get props => <Object?>[propertyTable];
}

class PropertyTable extends Equatable {
  const PropertyTable({required this.properties});

  final List<Property> properties;

  factory PropertyTable.fromJson(Map<String, dynamic> json) {
    return PropertyTable(
      properties: json["Properties"] == null
          ? <Property>[]
          : List<Property>.from(
              json["Properties"]!.map((x) => Property.fromJson(x)),
            ),
    );
  }

  @override
  List<Object?> get props => <Object?>[properties];
}

class Property extends Equatable {
  const Property({
    required this.cid,
    required this.molecularFormula,
    required this.molecularWeight,
    required this.iupacName,
  });

  final int? cid;
  final String? molecularFormula;
  final String? molecularWeight;
  final String? iupacName;

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      cid: json["CID"],
      molecularFormula: json["MolecularFormula"],
      molecularWeight: json["MolecularWeight"],
      iupacName: json["IUPACName"],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "CID": cid,
      "MolecularFormula": molecularFormula,
      "MolecularWeight": molecularWeight,
      "IUPACName": iupacName,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    cid,
    molecularFormula,
    molecularWeight,
    iupacName,
  ];
}
