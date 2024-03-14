import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_solver/pages/home.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  void _enterApp(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => Home())));
    });
  }
      
   
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () => _enterApp(context));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sudoku Solver',
              style: GoogleFonts.handlee(
                textStyle: const TextStyle(fontSize: 50, color:Colors.white, fontWeight: FontWeight.w900)
              )),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
