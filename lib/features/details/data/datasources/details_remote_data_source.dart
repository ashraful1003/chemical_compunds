import 'package:chemical_compounds/core/constants/app_endpoints.dart';
import 'package:chemical_compounds/core/network/dio_provider.dart';
import 'package:chemical_compounds/features/details/data/models/description_model.dart';
import 'package:chemical_compounds/features/details/data/models/synonyms_model.dart';
import 'package:dio/dio.dart';

class DetailsRemoteDataSource {
  final Dio dio;

  DetailsRemoteDataSource(this.dio);

  Future<List<Description>> fetchDescription(int cid) async {
    final String endPoint = API.description(cid: cid);

    final Response<Map<String, dynamic>> response = await DioProvider.httpDio
        .get(endPoint);
    if (response.statusCode == 200) {
      final DescriptionModel descriptionModel = DescriptionModel.fromJson(
        response.data ?? <String, dynamic>{},
      );
      return descriptionModel.informationList?.listOfDescription ??
          <Description>[];
    } else {
      throw Exception('Failed to load description');
    }
  }

  Future<List<Synonym>> fetchSynonyms(int cid) async {
    final String endPoint = API.synonyms(cid: cid);

    final Response<Map<String, dynamic>> response = await DioProvider.httpDio
        .get(endPoint);
    if (response.statusCode == 200) {
      final SynonymsModel synonymsModel = SynonymsModel.fromJson(
        response.data ?? <String, dynamic>{},
      );
      return synonymsModel.informationList?.listOfSynonyms ?? <Synonym>[];
    } else {
      throw Exception('Failed to load synonyms');
    }
  }
}
