import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku_solver/utils/sudokuFunctions.dart';


class NewSudokuPage extends StatefulWidget{
  NewSudokuPage({Key? key}) : super(key: key);

  static const newSudokuPageName = 'Nuova Prenotazione';

  @override
  State<NewSudokuPage> createState() => _NewSudokuPageState();
}

class _NewSudokuPageState extends State<NewSudokuPage> {
  List<List<TextEditingController>> sudoku = [
    List.generate(9, (index) => TextEditingController()), //1
    List.generate(9, (index) => TextEditingController()), //2
    List.generate(9, (index) => TextEditingController()), //3
    List.generate(9, (index) => TextEditingController()), //4
    List.generate(9, (index) => TextEditingController()), //5
    List.generate(9, (index) => TextEditingController()), //6
    List.generate(9, (index) => TextEditingController()), //7
    List.generate(9, (index) => TextEditingController()), //8
    List.generate(9, (index) => TextEditingController()), //9
  ];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    print('${NewSudokuPage.newSudokuPageName} built');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 242, 254),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Sudoku Solver',
          style: GoogleFonts.handlee(
            textStyle: const TextStyle(fontSize: 30, color: Colors.white)
          )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Inserisci il tuo sudoku:',
                  style: GoogleFonts.jost(
                    textStyle: const TextStyle(fontSize: 28, color: Colors.blue)
                  )),
                const SizedBox(height: 30),
                Table(
                  border: TableBorder.all(width: 1.5),
                  children: List.generate(9, (rowIndex) => TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      children: List.generate(9,(columnIndex) => Container(
                          child: TextFormField(
                            controller: sudoku[rowIndex][columnIndex],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(4.0),
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: (){
                    List<List<int>>? sudokuInt = sudokuToInt(sudoku);
                    if (sudokuInt==null){
                      displayCaseError(context);
                    } else {
                      // risolvi sudoku
                      print('Sto risolvendo');
                      List<dynamic> risultato = solveSudoku(sudokuInt);
                      print(risultato[0]);
                      print(risultato[1]);
                      if (risultato[0]==false){ 
                        // caso: sudoku irrisolvibile
                        displayCaseUnsolvable(context);
                      } else{
                        // mostra sudoku risolto
                        displayCaseSolved(context, risultato[1]);
                      }
                      
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  child: Text(
                    'Risolvi',
                    style: GoogleFonts.jost(
                    textStyle: const TextStyle(fontSize: 25, color: Colors.white)
                  ) ))
              ],
            ),
          ),
        ),
      )
    );
  }

  void displayCaseSolved(BuildContext context, List<List<int>> sudokuInt) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          insetPadding: EdgeInsets.all(12.0),
          backgroundColor: Colors.blue,
          title: const Text('SOLUZIONE:', style: TextStyle(color: Colors.white)),
          content: Container(
            width:double.maxFinite,
            height: 400,
            child: Table(
              border: TableBorder.all(width: 1.5),
              children: List.generate(9, (rowIndex) => TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  children: List.generate(9,(columnIndex) => Container(
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text('${sudokuInt[rowIndex][columnIndex]}', textAlign: TextAlign.center,)
                        )
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.white)),
              child: const Text('Chiudi', style: TextStyle(color: Colors.blue ))
            ),
          ],
        );
      }
    );
  }

  void displayCaseUnsolvable(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('IRRISOLVIBILE', style: TextStyle(color: Colors.white)),
          content: const Text('Questo sudoku è irrisolvibile!', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.white)),
              child: const Text('Chiudi', style: TextStyle(color: Colors.blue ))
            ),
          ],
        );
      }
    );
  }

  void displayCaseError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('Attenzione!', style: TextStyle(color: Colors.white)),
          content: const Text('Hai inserito dei valori non validi', style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.white)),
              child: const Text('Chiudi', style: TextStyle(color: Colors.blue ))
            ),
          ],
        );
      }
    );
  }
}