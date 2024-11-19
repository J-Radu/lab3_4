import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:lab_3/presentation/widgets/app_header.dart';
import 'package:lab_3/presentation/widgets/wine_card.dart';
import 'package:lab_3/presentation/widgets/wine_carrousel_card.dart';
import '../data/carrousel_data.dart';
import '../domain/wine.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Wine>> loadWinesFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> jsonList = jsonData['carousel'] ?? [];

      final List<Wine> wines = jsonList
          .map((item) => Wine.fromJson(item as Map<String, dynamic>))
          .toList();

      return wines;
    } catch (e) {
      print('Error on loading data: $e');
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              WineAppHeader(),
              SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  itemCount: winesCarrouselStatic.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 2.0, right: 2.0),
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 20);
                  },
                  itemBuilder: (context, index) {
                    return WineCategoryCard(wineCarrousel: winesCarrouselStatic[index]);
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wine',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF111827),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'view all',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink[300],
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Utilizează FutureBuilder pentru a încărca și afișa vinurile din JSON
              FutureBuilder<List<Wine>>(
                future: loadWinesFromJson(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Eroare la încărcarea vinurilor'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Niciun vin disponibil'));
                  }

                  // Mapează vinurile din JSON la WineCard-uri
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!.map((wine) {
                      return WineCard(wine: wine);
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}