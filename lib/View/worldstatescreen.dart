 import 'package:afaq3/View/Models/WorldStateApi.dart';
 import 'package:afaq3/View/Services/state_service.dart';
 import 'package:afaq3/View/countrieslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  _WorldStatesState createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {


  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }


  WorldStatesViewModel newsListViewModel = WorldStatesViewModel();

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height:  MediaQuery.of(context).size.height * .01,),
                FutureBuilder(
                    future: newsListViewModel.fetchWorldRecords(),
                    builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                      if(!snapshot.hasData){
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      }else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              animationDuration: Duration(milliseconds: 1200),
                              chartLegendSpacing: 32,
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 25,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: true,
                                decimalPlaces: 1,
                              ),

                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                    ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                    ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                    ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                    ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                    ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                    ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius:BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Text('Track Countries'),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value ;
  ReusableRow({super.key , required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}












































// import 'package:afaq3/View/Models/WorldStateApi.dart';
// import 'package:afaq3/View/Services/state_service.dart';
// import 'package:afaq3/View/countrieslist.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:pie_chart/pie_chart.dart';
//
// class Worldstatescreen extends StatefulWidget {
//   const Worldstatescreen({super.key});
//
//   @override
//   State<Worldstatescreen> createState() => _WorldstatescreenState();
// }
//
// class _WorldstatescreenState extends State<Worldstatescreen> with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(seconds: 3),
//     vsync: this,
//   )..repeat();
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   final colorList = <Color>[
//     Color(0xff4285F4),
//     Color(0xff1aa260), // ✅ fixed hex code
//     Color(0xffde5246),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     StateServices stateServices = StateServices();
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height *0.01),
//             FutureBuilder(
//                 future: stateServices.getapi(),
//                 builder: (context, AsyncSnapshot<WorldStateApi> snapshot){
//                   if (snapshot.hasData){
//                     return Expanded(
//                       flex: 1,
//                         child: SpinKitFadingCircle(
//                           color: Colors.white,
//                           size: 50.0,
//
//                         )
//                     );
//                   } else{
//                     return Column(
//                     children: [
//                       PieChart(
//                         dataMap: {
//                            "Total": 20,//double.parse(snapshot.data!.cases!.toString()),
//                           "Recovered": 13,//double.parse(snapshot.data!.recovered.toString()),
//                           "Death":7,//double.parse(snapshot.data!.deaths.toString()),
//                         },
//                         chartValuesOptions: ChartValuesOptions(
//                           showChartValuesInPercentage: true
//                         ),
//                         chartRadius: MediaQuery.of(context).size.width / 3.2,
//                         colorList: colorList, // optional, colors add karne ke liye
//                         animationDuration: Duration(milliseconds: 1200) ,
//                         legendOptions: LegendOptions(
//                             legendPosition: LegendPosition.left
//                         ),
//                         chartType: ChartType.ring,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             vertical: MediaQuery.of(context).size.height  * 0.06,horizontal: MediaQuery.of(context).size.height  * 0.01),
//                         child: Card(
//                           child: Column(
//                             children: [
//                               ReusebaleRow(title: 'Total', value: '100'),
//                               ReusebaleRow(title: 'Total', value: '100'),
//                               ReusebaleRow(title: 'Total', value: '100'),
//                               ReusebaleRow(title: 'Total', value: '100'),
//                               ReusebaleRow(title: 'Total', value: '100'),
//                               ReusebaleRow(title: 'Total', value: '100'),
//                               ReusebaleRow(title: 'Total', value: '100'),
//                             ],
//                           ),
//                         ),
//                       ),
//                            GestureDetector(
//                              onTap: (){
//                                Navigator.push(context,
//                                MaterialPageRoute(builder: (context)=> Countrieslist()));
//                             },
//                            child:  Container(
//                           height: 50,
//                           decoration:BoxDecoration(
//                          color: Color(0xff1aa260),
//                         borderRadius: BorderRadius.circular(10)),
//                        child: Center(child: Text('Track Countries'))),
//                   ),
//                     ],
//                    );
//                   }
//                 }
//              ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ReusebaleRow extends StatelessWidget {
//   String title ,value;
//    ReusebaleRow({super.key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10,right: 15,left: 10,bottom: 5),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(title),
//             Text(value),
//             ],
//           ),
//           SizedBox(height: 5,),
//           Divider()
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
