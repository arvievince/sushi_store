import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sushi_store/components/button.dart';
import 'package:sushi_store/pages/food_details_page.dart';
import 'package:sushi_store/pages/models/food_model.dart';
import 'package:sushi_store/pages/models/shop.dart';
import 'package:sushi_store/themeColors.dart';

import '../components/food_tile.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  //navigate to item details page

  void navigateToItemDetails(int index) {
    
    //get the shop menu
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(
          food: foodMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //get the shop menu
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    return Scaffold(
      backgroundColor: SushiTheme.sushiWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: SushiTheme.darkGrey,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tokyo Sushi',
              style: TextStyle(color: SushiTheme.darkGrey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: SushiTheme.darkGrey,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cartPage');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //promo banner
          Container(
            decoration: BoxDecoration(
              color: SushiTheme.sushiRed,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get 20% off promo',
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //redeem button
                    CustomButton(
                      text: 'Redeem',
                      onTap: () {},
                    )
                  ],
                ),
                //image
                Image.asset(
                  'lib/images/sushi_1.png',
                  height: 100,
                )
              ],
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          //search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: SushiTheme.dimWhite,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: SushiTheme.sushiRed,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                hintText: 'Search your favorites',
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          //menu lines
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Food Menu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: SushiTheme.darkGrey,
                  fontSize: 18),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //popular items
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodMenu.length,
              itemBuilder: (context, index) => FoodTile(
                food: foodMenu[index],
                onTap: () => navigateToItemDetails(index),
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //image
                Row(
                  children: [
                    Image.asset(
                      'lib/images/sushi.png',
                      height: 60,
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    //name and price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salmon Eggs',
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '\349.00',
                          style: TextStyle(
                            color: SushiTheme.dimGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //heart icon

                const Icon(
                  Icons.favorite_outline,
                  color: SushiTheme.sushiRed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
