import 'package:flutter/material.dart';



// Questa funzione ritorna null nel caso siano stati introdotti numeri sbagliati
// altrimenti trasforma il sudoku in una lista di liste di interi con valore -1 
// dove ci sono spazi vuoti. 
List<List<int>>? sudokuToInt(List<List<TextEditingController>> sudoku) {
  const int righe = 9;
  const int colonne = 9;
  List<List<int>> sudokuInt = List.generate(9, (_) => List<int>.filled(9, -1));

  for (var riga=0; riga<righe; riga++){
    for(var colonna=0; colonna<colonne; colonna++){
      int? numero = int.tryParse(sudoku[riga][colonna].text);

      // ignore: prefer_conditional_assignment
      if(numero==null){ // se nullo lo setta a -1
        numero =-1;
      }  

      if (numero>9 || numero==0 || numero<-1){
        return null; // caso in cui c'è qualche errore di inserimento
      }

      sudokuInt[riga][colonna] = numero;
    }
  }
  return sudokuInt;
}






List<int?> trovaPrimoSpazio(sudoku){
  // restituisce [riga, colonna] o [null,null]
  for (var riga=0; riga<9; riga++){
    for (var col=0; col<9; col++){
      if (sudoku[riga][col]==-1){
        return [riga,col];
      }
    }
  }
  return [null,null];
}



bool isValid(List<List<int>> sudoku, int num, int rig, int col){
  // vero se num è numero valido altrimenti false, 
  // ovvero se può essere inserito in quel posto

  // controllo la riga
  List<int> valoriRiga = sudoku[rig]; 
  if (valoriRiga.contains(num)){
    return false;
  }

  // controllo riga
  List<int> valoriCol = [];
  for (var riga=0; riga<9; riga++){
     valoriCol.add(sudoku[riga][col]);
  }
  if (valoriCol.contains(num)){
    return false;
  }

  // Controllo casa 3x3
  int rigaDiInizio = (rig/3).floor() *3;
  int colDiInizio = (col/3).floor() *3;
  for (var riga=rigaDiInizio; riga<rigaDiInizio+3; riga++){
    for (var colonna=colDiInizio; colonna<colDiInizio+3; colonna++){
      if (sudoku[riga][colonna]==num) {
        return false;
      }
    }
  }

  return true;
}



List<dynamic> solveSudoku(List<List<int>> sudoku) {
  // usando backtracking: a.k.a. a tentativi
  
  // 1. Trovare primo spazio libero
  int? primaRigaLibera;
  int? primaColonnaLibera;
  [primaRigaLibera, primaColonnaLibera] = trovaPrimoSpazio(sudoku);  

  //1.1 Se non ce ne sono è completo
  if (primaRigaLibera==null){
    return [true,sudoku];  
  }

  // 2. se c'è uno spazio metto un numero e vedo se funziona
  for (var numeroDiProva=1; numeroDiProva<=9; numeroDiProva++){
    // 3. controllo se va bene il numero di prova
    if (isValid(sudoku, numeroDiProva, primaRigaLibera, primaColonnaLibera!)){
      // 3.1 inserisco il valore dato che è valido 
      sudoku[primaRigaLibera][primaColonnaLibera]=numeroDiProva;

      // 4. Ripeto ricorsivamente
      if (solveSudoku(sudoku)[0]){
        return [true,sudoku];
      }
    }

  // 5. se non valido o il numero di prova non funziona
  // si riprova con altro numero
  sudoku[primaRigaLibera][primaColonnaLibera]=-1; // cancello il numero di prova inserito
  }

  // 6. Se  le abbiamo provate tutte e non hanno funzionato
  // allora è irrisolvibile
  return [false,null];
}

