import 'package:flutter/material.dart';
import 'package:lab_3/domain/wine_carrousel.dart';

class WineCategoryCard extends StatelessWidget {
  final WineCarrousel wineCarrousel;

  const WineCategoryCard({Key? key, required this.wineCarrousel})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
                child: Image.asset(
                  wineCarrousel.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
            ),
          ),
          Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
          Container(
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  wineCarrousel.title,
                  style: TextStyle(
                    fontFamily: 'Archivo',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}