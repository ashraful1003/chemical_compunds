import 'package:equatable/equatable.dart';

class CompoundAutocompleteModel extends Equatable {
  const CompoundAutocompleteModel({
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

  Map<String, dynamic> toJson() => <String, dynamic>{
    "status": status?.toJson(),
    "total": total,
    "dictionary_terms": dictionaryTerms?.toJson(),
  };

  @override
  List<Object?> get props => <Object?>[status, total, dictionaryTerms];
}

class DictionaryTerms extends Equatable {
  const DictionaryTerms({required this.compound});

  final List<String> compound;

  factory DictionaryTerms.fromJson(Map<String, dynamic> json) {
    return DictionaryTerms(
      compound: json["compound"] == null
          ? <String>[]
          : List<String>.from(json["compound"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "compound": compound.map((String x) => x).toList(),
  };

  @override
  List<Object?> get props => <Object?>[compound];
}

class Status extends Equatable {
  const Status({required this.code});

  final int? code;

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(code: json["code"]);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{"code": code};

  @override
  List<Object?> get props => <Object?>[code];
}
