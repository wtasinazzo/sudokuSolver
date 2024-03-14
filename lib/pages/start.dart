import 'package:flutter/material.dart';
import 'package:sudoku_solver/pages/newSudoku.dart';


class StartPage extends StatelessWidget{
  StartPage({Key? key}) : super(key: key);

  static const startPageName = 'Homepage';

  @override
  Widget build(BuildContext context){
    print('${StartPage.startPageName} built');
    return Center(
      child: SizedBox(
        height: 100,
        width: 250,
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewSudokuPage()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          child: const Text(
            'START',
            style: TextStyle(fontSize: 28, color: Colors.white),
          )),
      ),
    );

  }
}