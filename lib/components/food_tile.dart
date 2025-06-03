import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_store/themeColors.dart';

import '../pages/models/food_model.dart';

class FoodTile extends StatelessWidget {
  final void Function()? onTap;
  final FoodModel food;
  const FoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: SushiTheme.dimWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Image.asset(food.imagePath,
            height: 140,),
      
            //text
            Text(food.name,
            style: GoogleFonts.dmSerifDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: SushiTheme.darkGrey,
            ),
            ),
      
            //price + rating
      
            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
      
                  //price
                  Text('\$${food.price}', style: TextStyle(color: SushiTheme.dimGrey, fontWeight: FontWeight.bold),
                  ),
      
                  //rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[900],),
                      Text(food.rating.toString(), style: TextStyle(color: Colors.grey),),
                    ],
                  ),
      
                ],
                ),
            )
      
          ],
        ),
      
      ),
    );
  }
}