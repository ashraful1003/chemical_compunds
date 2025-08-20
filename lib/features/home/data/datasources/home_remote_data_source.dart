import 'package:chemical_compounds/core/constants/app_endpoints.dart';
import 'package:chemical_compounds/core/network/dio_provider.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
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
}
