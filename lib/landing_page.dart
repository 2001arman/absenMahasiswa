import 'package:flutter/material.dart';

import 'absen.dart';

class LandingPage extends StatelessWidget {
  double diameterKecil(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double diameterBesar(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: Stack(
        children: [
          Positioned(
            right: -diameterKecil(context) / 3,
            top: -diameterKecil(context) / 3,
            child: Container(
              width: diameterKecil(context),
              height: diameterKecil(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFFC5E1A5), Color(0xFF8BC34A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -diameterBesar(context) / 4,
            top: -diameterBesar(context) / 4,
            child: Container(
              width: diameterBesar(context),
              height: diameterBesar(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF9CCC65), Color(0xFF7CB342)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -diameterBesar(context) / 2,
            bottom: -diameterBesar(context) / 2,
            child: Container(
              width: diameterBesar(context),
              height: diameterBesar(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFC5E1A5),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(30, 200, 30, 10),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('unmul.png'),
                          fit: BoxFit.cover,
                        )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Nama Kelompok : ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8),
                            child: Text(
                              "- Rifqi M. Riefard                          1915026009",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8),
                            child: Text(
                              "- Muhamad Fauzan                      1915026034",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8),
                            child: Text(
                              "- Muhammad Arman Maulana   1915026035",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8),
                            child: Text(
                              "- Muhammad Rizqi Maulana       1915026051",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PageAbsen();
                              }));
                            },
                            child: Text("Masuk")),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}