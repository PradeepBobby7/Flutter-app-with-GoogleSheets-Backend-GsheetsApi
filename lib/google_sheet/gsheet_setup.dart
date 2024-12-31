import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

const String sheetID = '1ywHBLYg_E1nY8XgTPNOjIPlvJfY2ZIxhmYM1notYjDo';

//const String credentialString = r''' uncommand and Store your credential here'''


// final gsheet = GSheets(credentialString);
Spreadsheet? spreadsheet;
Worksheet? userSheet;
Worksheet? productSheet;

Future<void> initGSheets() async {
  try {
    final credentialString =
        await rootBundle.loadString('assets/credentials.json');
    final credential = jsonDecode(credentialString);
    final gsheet = GSheets(jsonEncode(credential));
    spreadsheet = await gsheet.spreadsheet(sheetID);
    if (spreadsheet == null) {
      print('spreadsheet is null check sheet id');
      return;
    }
    print('spreadsheet id: ${spreadsheet!.id}');
    userSheet = await spreadsheet?.worksheetByTitle('gsheetsApp_data');
    productSheet = await spreadsheet?.worksheetByTitle('product');
    if (userSheet == null) {
      print('usersheet is null check work sheet name');
      return;
    }
    if (productSheet == null) {
      print('productsheet is null check work sheet name');
      return;
    }
    // print(
    //     'Google sheet initialized Succesfully. userSheet:$userSheet,product sheet:$productSheet');
    // await userSheet?.values.appendRow(['testid', 'testphone', 'pass', 'name']);
    // print('test append Succesfully');
  } catch (e) {
    print('Error in Google Sheet: $e');
  }
}

// spreadsheet = await gsheet.spreadsheet(sheetID);
//   userSheet = await spreadsheet?.worksheetByTitle('users');
//   productSheet = await spreadsheet?.worksheetByTitle('product');



// var gsheetController;

// Worksheet? gsheetdata;

// // gsheetsApp_data

// GsheetData() async {
//   gsheetController = await gsheet.spreadsheet(sheetID);

//   gsheetdata = await gsheetController.worksheetByTitle('gsheetsApp_data');
// }
