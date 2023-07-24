import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/team.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Team> teams = [];
  //get Teams
  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(response.body);
    for (var eachTeam in jsonData['data']) {
      final team =
          Team(abbreviation: eachTeam['abbreviation'], city: eachTeam['city']);
      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(
                color: Color.fromARGB(255, 214, 214, 214), width: 2)),
        backgroundColor: const Color.fromARGB(255, 5, 43, 87),
        centerTitle: true,
        title: const Text(
          'NBA APP API FETCH',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 214, 214, 214),
              fontFamily: 'Courier New'),
        ),
      ),
      body: FutureBuilder(
        future: getTeams(), //FUNCTION
        builder: (context, snapshot) {
          //if its is done loading return data
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 40.0, right: 40.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(50, 160, 156, 156),
                          border: Border.all(
                              color: Color.fromARGB(255, 5, 43, 87),
                              width: 2.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: ListTile(
                        title: Text(
                          teams[index].abbreviation,
                          style: TextStyle(
                              color: Colors.grey[350],
                              fontSize: 18.0,
                              fontFamily: 'Courier New'),
                        ),
                        subtitle: Text(
                          teams[index].city,
                          style: TextStyle(
                              color: Colors.grey[350],
                              fontSize: 16.0,
                              fontFamily: 'Courier New'),
                        ),
                      ),
                    ),
                  );
                });
          }
          //if its is done loading return data
          else {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 7, 39, 75),
            ));
          }
        },
      ),
    );
  }
}
