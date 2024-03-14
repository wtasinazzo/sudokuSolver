import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku_solver/pages/start.dart';

import 'assistenza.dart';


class Home extends StatefulWidget{
  Home({Key? key}) : super(key: key);
  static const homePageName = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _selIdx = 0;

  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.videogame_asset),
      label: 'Risolvi',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_outlined),
      label: 'Assistenza',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return StartPage();
      case 1:
        return AssistancePage();
      default:
        return StartPage();
    }
  }

  @override
  Widget build(BuildContext context){
    print('${Home.homePageName} built');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 242, 254),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Sudoku Solver',
          style: GoogleFonts.handlee(
            textStyle: const TextStyle(fontSize: 28, color: Colors.white)
          )),
      ),
      body: _selectPage(index: _selIdx),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.blue.shade900,
          items: _navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        )
    );
  }
}