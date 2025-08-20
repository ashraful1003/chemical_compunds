import 'package:equatable/equatable.dart';

class CompoundAutocompleteModel extends Equatable {
  CompoundAutocompleteModel({
    required this.status,
    required this.total,
    required this.dictionaryTerms,
  });

  final Status? status;
  final int? total;
  final DictionaryTerms? dictionaryTerms;

  factory CompoundAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return CompoundAutocompleteModel(
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      total: json["total"],
      dictionaryTerms: json["dictionary_terms"] == null
          ? null
          : DictionaryTerms.fromJson(json["dictionary_terms"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status?.toJson(),
    "total": total,
    "dictionary_terms": dictionaryTerms?.toJson(),
  };

  @override
  List<Object?> get props => [status, total, dictionaryTerms];
}

class DictionaryTerms extends Equatable {
  DictionaryTerms({required this.compound});

  final List<String> compound;

  factory DictionaryTerms.fromJson(Map<String, dynamic> json) {
    return DictionaryTerms(
      compound: json["compound"] == null
          ? []
          : List<String>.from(json["compound"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "compound": compound.map((x) => x).toList(),
  };

  @override
  List<Object?> get props => [compound];
}

class Status extends Equatable {
  Status({required this.code});

  final int? code;

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(code: json["code"]);
  }

  Map<String, dynamic> toJson() => {"code": code};

  @override
  List<Object?> get props => [code];
}
