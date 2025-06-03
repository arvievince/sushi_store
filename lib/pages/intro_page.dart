import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_store/components/button.dart';
import 'package:sushi_store/themeColors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SushiTheme.sushiRed,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 25,
            ),
            //shop name
            Text(
              'Sushi Store',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //icon
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('lib/images/sushi.png'),
            ),

            //title
            const SizedBox(
              height: 25,
            ),
            Text(
              'The Taste of Japanese Food',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            //subtitle
            Text(
              'We deliver the freshest sushi to your doorstep. Order now and enjoy the best sushi in town.',
              style: TextStyle(
                height: 2,
                color: Colors.grey[300],
              ),
            ),

            //getstarted button
            const SizedBox(
              height: 25,
            ),

            CustomButton(
              text: 'Get Started',
              onTap: () {
                Navigator.pushNamed(context, '/menupage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
