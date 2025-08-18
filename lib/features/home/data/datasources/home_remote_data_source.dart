import 'package:chemical_compounds/core/constants/app_endpoints.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  Future<void> fetchItems() async {
    String endPoint = API.details(
      'Aspirin',
    ); // Example endpoint, replace with actual endpoint if needed

    final response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      //ToDo: Handle the response data
      print(response.data);
      return;
    } else {
      throw Exception('Failed to load items');
    }
  }
}
