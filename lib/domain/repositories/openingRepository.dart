import 'package:trainer_app/domain/models/model.dart';
import 'package:trainer_app/global/openingApi.dart';

class OpeningRepository {
  final OpeningApi apiOpeningApi;

  OpeningRepository(this.apiOpeningApi);

 Future<List<OpeningSchedule>> getAllOpeningApi(String token) async {
  try {
    final List<dynamic> openingData = await apiOpeningApi.getAllOpeningApi(token);
    
    return openingData.map((item) {
      return OpeningSchedule.fromJson(item as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print("Error en OpeningRepository: $e");
    rethrow;
  }
}
}