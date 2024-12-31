import 'package:gsheet_app/google_sheet/gsheet_setup.dart';
import 'package:gsheet_app/models/produce_model.dart';
import 'package:gsheet_app/models/user_model.dart';

class GoogleSheetRepository {
  Future<User?> login(String phone, String password) async {
    try {
      final rows = await userSheet?.values.allRows();
      if (rows == null) {
        return null;
      }
      for (var row in rows) {
        if (row.length >= 3 && row[1] == phone && row[2] == password) {
          return User(id: row[0], name: row[3], phone: row[1]);
        }
      }
      return null;
    } catch (e) {
      print('error:$e');
      return null;
    }
  }

  Future<User?> signUp(String name, String phone, String password) async {
    try {
      if (userSheet == null) {
        print('user sheet is null');
        return null;
      }
      final newRow = [
        DateTime.now().millisecondsSinceEpoch.toString(),
        phone,
        password,
        name
      ];
      final appendresult = await userSheet?.values.appendRow(newRow);
      if (appendresult == null) {
        print('append row is failed');
        return null;
      }
      print('Append result : $appendresult');
      print('Signup Succesfully');
      return User(id: newRow[0], name: name, phone: phone);
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }

  Future<List<Product>> getProducts() async {
    final rows = await productSheet?.values.allRows();
    List<Product> products = [];

    if (rows != null) {
      for (var row in rows) {
        products.add(Product(
          id: row[0],
          name: row[1],
          description: row[2],
          price: double.tryParse(row[3]) ?? 0.0,
          imageUrl: row[4],
        ));
      }
    }
    return products;
  }

  Future<void> addProduct(Product product, String description, String price,
      String imageUrl) async {
    try {
      final newProduct = [
        DateTime.now().millisecondsSinceEpoch.toString(),
        product.name,
        product.description,
        product.price.toString(),
        product.imageUrl,
      ];
      print('Adding product: $newProduct');
      await productSheet?.values.appendRow(newProduct);
    } catch (e) {
      print('Error add product: $e');
      rethrow;
    }
  }

  Future<User?> getUser(String userId) async {
    final rows = await userSheet?.values.allRows();
    if (rows != null) {
      for (var row in rows) {
        if (row[0] == userId) {
          return User(id: row[0], name: row[3], phone: row[1]);
        }
      }
    }
    return null;
  }
}





// class GoogleSheetRespository {
//   final GSheets _gSheets;
//   final String sheetId;

//   GoogleSheetRespository(this._gSheets, this.sheetId);

//   Future<Worksheet?> getWorkSheet(String title) async {
//     final spreadsheet = await _gSheets.spreadsheet(sheetId);
//     return spreadsheet.worksheetByTitle(title);
//   }

//   Future<List<User>> fetchUser() async {
//     final sheet = await getWorkSheet('users');
//     final rows = await sheet?.values.allRows() ?? [];
//     return rows.skip(1).map((row) => User.fromRow(row)).toList();
//   }

//   Future<void> addUser(User user) async {
//     final sheet = await getWorkSheet('users');
//     await sheet?.values.appendRow(user.toRow());
//   }

//   Future<List<Product>> fetchProduct() async {
//     final sheet = await getWorkSheet('products');
//     final rows = await sheet?.values.allRows() ?? [];
//     return rows.skip(1).map((row) => Product.fromRow(row)).toList();
//   }

//   Future<void> addProduct(Product product) async {
//     final sheet = await getWorkSheet('products');
//     await sheet?.values.appendRow(product.toRow());
//   }
// }
