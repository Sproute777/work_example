import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/presentation/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = TextEditingController();
  var searchString = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.0,
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: loadJson(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              // while data is loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // data loaded:
              final listCities = _search(snapshot.data);
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
                child: Center(
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchString = value;
                          });
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: "Поиск",
                            contentPadding: const EdgeInsets.all(15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: silverGrayColor,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: silverGrayColor,
                                width: 1.5,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: listCities.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listCities[index]['city']
                                    .contains(searchString)
                                ? GestureDetector(
                                    onTap: () => {
                                      Navigator.pop(
                                          context, listCities[index]['city'])
                                    },
                                    child: Text(
                                      listCities[index]['city'] +
                                          ", ${listCities[index]['region']}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: "GloryMedium",
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => {
                                      Navigator.pop(
                                          context, listCities[index]['city'])
                                    },
                                    child: Text(
                                      listCities[index]['city'] +
                                          ", ${listCities[index]['region']}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: "GloryMedium",
                                      ),
                                    ),
                                  );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  List<dynamic> _search(List<dynamic>? employee) {
    if (searchString.isNotEmpty == true) {
      //search logic what you want
      return employee
              ?.where((element) =>
                  element["city"].toLowerCase().contains(searchString))
              .toList() ??
          <dynamic>[];
    }

    return employee ?? <dynamic>[];
  }

  Future<List<dynamic>> loadJson() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final data = await json.decode(response);
    return data;
  }
}
