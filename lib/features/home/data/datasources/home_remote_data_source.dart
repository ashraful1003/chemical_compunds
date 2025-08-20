import 'package:chemical_compounds/core/constants/app_endpoints.dart';
import 'package:chemical_compounds/core/network/dio_provider.dart';
import 'package:chemical_compounds/features/home/data/models/compound_autocomplete_model.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:chemical_compounds/features/home/data/models/search_result_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  Future<List<Property>> fetchItems({
    required String cids,
    required String properties,
  }) async {
    String endPoint = API.details(
      cids: cids,
      properties: properties,
    ); // Example endpoint, replace with actual endpoint if needed

    final Response<Map<String, dynamic>> response = await DioProvider.httpDio
        .get(endPoint);
    if (response.statusCode == 200) {
      final PropertiesModel propertiesModel = PropertiesModel.fromJson(
        response.data ?? <String, dynamic>{},
      );
      return propertiesModel.propertyTable?.properties ?? <Property>[];
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<String>> searchCompound({required String query}) async {
    String endPoint = API.search(
      query: query,
    ); // Example endpoint, replace with actual endpoint if needed

    final Response<Map<String, dynamic>> response = await DioProvider.httpDio
        .get(endPoint);
    if (response.statusCode == 200) {
      final CompoundAutocompleteModel compoundAutocompleteModel =
          CompoundAutocompleteModel.fromJson(
            response.data ?? <String, dynamic>{},
          );
      return compoundAutocompleteModel.dictionaryTerms?.compound ?? <String>[];
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<int>> getCID({required String compoundName}) async {
    String endPoint = API.getCID(
      compoundName: compoundName,
    ); // Example endpoint, replace with actual endpoint if needed

    final Response<Map<String, dynamic>> response = await DioProvider.httpDio
        .get(endPoint);
    if (response.statusCode == 200) {
      final SearchResultModel searchResultModel = SearchResultModel.fromJson(
        response.data ?? <String, dynamic>{},
      );
      return searchResultModel.identifierList?.cid ?? <int>[];
    } else {
      throw Exception('Failed to load items');
    }
  }
}
