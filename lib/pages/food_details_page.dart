import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sushi_store/components/button.dart';
import 'package:sushi_store/pages/models/food_model.dart';
import 'package:sushi_store/pages/models/shop.dart';
import 'package:sushi_store/themeColors.dart';

class FoodDetailsPage extends StatefulWidget {
  final FoodModel food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
//quantity count
  int quantityCount = 0;

  //decreament quantity
  void decreamentQuantity() {
    setState(() {
     if(quantityCount > 0) {
        quantityCount--;
     }
    });
  }

  //increment quantity
  void increamentQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void addToCart() {
    // Function to add the food item to the cart
    if (quantityCount > 0) {
      final shop = context.read<Shop>();
      //add to cart
      shop.addToCart(widget.food, quantityCount);

      //short dialog box for successfully added
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: SushiTheme.sushiRed,
          title: const Text('Added to Cart', style: TextStyle(color: SushiTheme.sushiWhite, fontSize: 24, fontWeight: FontWeight.w600),),
          content: Text('${widget.food.name} x$quantityCount has been added to your cart.', style: const TextStyle(color: SushiTheme.dimWhite, fontSize: 18, fontWeight: FontWeight.w500),),
            actions: [
            IconButton(
              icon: const Icon(Icons.done, color: SushiTheme.sushiWhite, size: 30,),
              onPressed: () {
                Navigator.of(context).pop();
                //pop the dialog twice
                Navigator.of(context).pop();

              },
            ),
          ],
        ),
      );
      

      print('Added ${widget.food.name} x$quantityCount to cart');
    } else {
      print('Quantity must be greater than 0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: SushiTheme.dimGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  //image
                  Image.asset(
                    widget.food.imagePath,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.food.rating.toString(),
                        style: TextStyle(
                            color: SushiTheme.dimGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //food name

                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //description
                  Text(
                    'Description',
                    style: TextStyle(
                        color: SushiTheme.dimGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Fresh salmon sushi with perfectly seasoned rice, wrapped in seaweed. A classic favorite for sushi lovers. Enjoy the delicate balance of flavors and textures, with tender fish, fluffy rice, and a hint of wasabi. Served with pickled ginger and soy sauce for an authentic Japanese experience.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //price + quantity
          Container(
            color: SushiTheme.sushiRed,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text(
                      '\$${widget.food.price}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    //decerease quantity
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: SushiTheme.sushiRedLight,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: decreamentQuantity,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              )),
                        ),

                        //quantity
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        //increament button
                        Container(
                          decoration: const BoxDecoration(
                            color: SushiTheme.sushiRedLight,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: increamentQuantity,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                //add to cart button

                CustomButton(text:'Add to Cart',
                  onTap: () {
                    //add to cart function
                   addToCart();
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
