import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_store/pages/models/shop.dart';
import 'package:sushi_store/themeColors.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Tokyo Sushi',
              style: TextStyle(color: SushiTheme.sushiWhite, fontSize: 20),
            ),
            accountEmail: Text('tokyosushi@email.com',
                style: TextStyle(color: SushiTheme.sushiWhite)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('lib/images/sushi.png'),
            ),
            decoration: BoxDecoration(
              color: SushiTheme.sushiRed,
              image: DecorationImage(
                  image: AssetImage('lib/images/sushiBg.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_filled, color: SushiTheme.sushiRed),
            title: const Text('Home',
                style: TextStyle(color: SushiTheme.sushiRed)),
            onTap: () {
              Navigator.pushNamed(context, '/intropage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: SushiTheme.sushiRed),
            title: const Text('About',
                style: TextStyle(color: SushiTheme.sushiRed)),
            onTap: () {
              Navigator.pushNamed(context, '/activationKeyGenerator');
            },
          ),
          ListTile(
            leading: const Icon(Icons.ramen_dining, color: SushiTheme.sushiRed),
            title: const Text('Menus',
                style: TextStyle(color: SushiTheme.sushiRed)),
            onTap: () {
              Navigator.pushNamed(context, '/menupage');
            },
          ),
          ListTile(
              leading:
                  const Icon(Icons.shopping_cart, color: SushiTheme.sushiRed),
              title: const Text('View Cart',
                  style: TextStyle(color: SushiTheme.sushiRed)),
              onTap: () {
                Navigator.pushNamed(context, '/cartPage');
              },
              trailing: ClipOval(
                child: Container(
                  width: 24,
                  height: 24,
                  color: SushiTheme.sushiRed,
                  child: Center(
                    child: Text(
                      '${context.watch<Shop>().cart.length}',
                      style: const TextStyle(
                          color: SushiTheme.sushiWhite, fontSize: 12),
                    ),
                  ),
                ),
              )),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: SushiTheme.sushiRed),
            title: const Text('Device Info',
                style: TextStyle(color: SushiTheme.sushiRed)),
            onTap: () {
              Navigator.pushNamed(context, '/deviceInfoDetails');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: SushiTheme.sushiRed),
            title: const Text('Logout',
                style: TextStyle(color: SushiTheme.sushiRed)),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer first
              Future.delayed(const Duration(milliseconds: 200), () {
                exit(0);
              });
            },
          ),
        ],
      ),
    );
  }
}
