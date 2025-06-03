import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sushi_store/components/button.dart';
import 'package:sushi_store/pages/models/food_model.dart';
import 'package:sushi_store/pages/models/shop.dart';
import 'package:sushi_store/themeColors.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: SushiTheme.sushiRed,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: SushiTheme.sushiWhite),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: SushiTheme.sushiRed,
          title: Text(
            'My Cart',
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: SushiTheme.sushiWhite),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            //Customer cart header

            Expanded(
                child: Builder(
                    builder: (context) {
                        // Group items by name and sum quantities and prices
                        final Map<String, Map<String, dynamic>> grouped = {};
                        for (final food in value.cart) {
                            if (grouped.containsKey(food.name)) {
                                grouped[food.name]!['quantity'] += 1;
                                grouped[food.name]!['totalPrice'] += food.price;
                            } else {
                                grouped[food.name] = {
                                    'food': food,
                                    'quantity': 1,
                                    'totalPrice': food.price,
                                };
                            }
                        }
                        final items = grouped.values.toList();

                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                                final food = items[index]['food'] as FoodModel;
                                final quantity = items[index]['quantity'] as int;
                                final totalPrice = items[index]['totalPrice'] as double;

                                return Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: SushiTheme.sushiRedLight,
                                    ),
                                    margin: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Quantity
                                          Text(
                                            '$quantity x',
                                            style: GoogleFonts.lato(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: SushiTheme.sushiWhite,
                                            ),
                                          ),
                                          // Food name
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                food.name,
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: SushiTheme.sushiWhite,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          // Total price
                                          Text(
                                            '\$ ${totalPrice.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+\.)'), (Match m) => '${m[1]},')}',
                                            style: GoogleFonts.lato(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: SushiTheme.sushiWhite,
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          // Remove button
                                          IconButton(
                                            icon: Icon(Icons.remove_shopping_cart_rounded, color: SushiTheme.sushiWhite),
                                            onPressed: () {
                                              value.removeFromCart(food);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                );
                            },
                        );
                    },
                ),
            ),

            //total price
            Container(
                padding: const EdgeInsets.all(16.0),
              color: SushiTheme.sushiWhite,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(
                                  'Total:',
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: SushiTheme.sushiRed,
                                  ),
                              ),
                              Text(
                                  '\$ ${value.cart.fold<double>(0, (sum, item) => sum + item.price).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+\.)'), (Match m) => '${m[1]},')}',
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: SushiTheme.sushiRed,
                                  ),
                              ),
                          ],
                      ),
                  ),
                  CustomButton(text: 'Pay now', onTap: () {
                    _showOrderConfirmation(context, value);
                  },
                  ),
                ],
              ),
            ),
          ],
        ) 
      ),
    );
  }

void _showOrderConfirmation(BuildContext context, Shop shop) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: SushiTheme.sushiWhite,
            title: Text(
                'Order Confirmed!',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: SushiTheme.sushiRed,
                ),
            ),
            content: Text(
                'Thank you for your purchase.',
                style: GoogleFonts.lato(
                    color: SushiTheme.sushiRed,
                ),
            ),
            actions: [
                TextButton(
                    onPressed: () {
                        shop.clearCart();
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).pop(); // Go back to menu page
                    },
                    child: Text(
                        'OK',
                        style: GoogleFonts.lato(
                            color: SushiTheme.sushiRed,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ),
            ],
        ),
    );
}
}