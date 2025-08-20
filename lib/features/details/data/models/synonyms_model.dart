import 'package:equatable/equatable.dart';

class SynonymsModel extends Equatable {
  const SynonymsModel({required this.informationList});

  final InformationList? informationList;

  factory SynonymsModel.fromJson(Map<String, dynamic> json) {
    return SynonymsModel(
      informationList: json["InformationList"] == null
          ? null
          : InformationList.fromJson(json["InformationList"]),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "InformationList": informationList?.toJson(),
  };

  @override
  List<Object?> get props => <Object?>[informationList];
}

class InformationList extends Equatable {
  const InformationList({required this.listOfSynonyms});

  final List<Synonym> listOfSynonyms;

  factory InformationList.fromJson(Map<String, dynamic> json) {
    return InformationList(
      listOfSynonyms: json["Information"] == null
          ? <Synonym>[]
          : List<Synonym>.from(
              json["Information"]!.map((dynamic x) => Synonym.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "Information": listOfSynonyms.map((Synonym x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => <Object?>[listOfSynonyms];
}

class Synonym extends Equatable {
  const Synonym({
    required this.cid,
    required this.listOfSynonym,
    required this.casNumber,
  });

  final int? cid;
  final List<String> listOfSynonym;
  final String casNumber;

  factory Synonym.fromJson(Map<String, dynamic> json) {
    final List<String> synonyms = json["Synonym"] == null
        ? <String>[]
        : List<String>.from(json["Synonym"]!.map((dynamic x) => x));

    final String cas = synonyms.firstWhere(
      (String synonym) => synonym.startsWith("CAS"),
      orElse: () => "",
    );
    return Synonym(cid: json["CID"], listOfSynonym: synonyms, casNumber: cas);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "CID": cid,
    "Synonym": listOfSynonym.map((String x) => x).toList(),
    "CAS": casNumber,
  };

  @override
  List<Object?> get props => <Object?>[cid, listOfSynonym];
}
