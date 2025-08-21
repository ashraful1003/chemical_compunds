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
    this.compoundName,
  });

  final int? cid;
  final String? compoundName;
  final String? molecularFormula;
  final String? molecularWeight;
  final String? iupacName;

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      cid: json["CID"],
      compoundName: json["CompoundName"] ?? '',
      molecularFormula: json["MolecularFormula"],
      molecularWeight: json["MolecularWeight"],
      iupacName: json["IUPACName"],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "CID": cid,
      "CompoundName": compoundName ?? '',
      "MolecularFormula": molecularFormula,
      "MolecularWeight": molecularWeight,
      "IUPACName": iupacName,
    };
  }

  Property copyWith({
    int? cid,
    String? compoundName,
    String? molecularFormula,
    String? molecularWeight,
    String? iupacName,
  }) {
    return Property(
      cid: cid ?? this.cid,
      compoundName: compoundName ?? this.compoundName,
      molecularFormula: molecularFormula ?? this.molecularFormula,
      molecularWeight: molecularWeight ?? this.molecularWeight,
      iupacName: iupacName ?? this.iupacName,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    cid,
    molecularFormula,
    molecularWeight,
    iupacName,
  ];
}
