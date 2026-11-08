
import 'dart:convert';
import 'package:afaq3/View/Models/WorldStateApi.dart';
import 'package:afaq3/View/Utilities/Api_url.dart';
import 'package:http/http.dart' as http;

class WorldStatesViewModel {


  Future<WorldStatesModel> fetchWorldRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    var data ;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }

}


































//
//
// import 'dart:convert';
//











































// import 'package:afaq3/View/Models/WorldStateApi.dart';
// import 'package:afaq3/View/Utilities/Api_url.dart';
// import 'package:http/http.dart' as http;
//
// class StateServices{
//   Future<WorldStateApi> getapi()async{
//     final response = await http.get(Uri.parse(ApUrl.world));
//     if (response.statusCode == 200){
//
//       var data = jsonDecode(response.body);
//       return WorldStateApi.fromJson(data);
//     }else {
//       throw Exception('Error');
//     }
//
//   }
//
//   Future<List<dynamic>> countryapi()async{
//     var data;
//     final response = await http.get(Uri.parse(ApUrl.world));
//     if (response.statusCode == 200){
//
//        data = jsonDecode(response.body);
//       return data;
//     }else {
//       throw Exception('Error');
//     }
//
//   }
// }