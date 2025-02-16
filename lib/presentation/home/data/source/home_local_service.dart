import 'package:sqflite/sqflite.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:path/path.dart';

class HomeLocalService {
  static final HomeLocalService _instance = HomeLocalService._internal();
  factory HomeLocalService() => _instance;
  HomeLocalService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'cart.db');

    // ✅ Buka database tanpa `onCreate`
    final db = await openDatabase(path, version: 1);

    // ✅ Buat tabel jika belum ada
    await db.execute('''
    CREATE TABLE IF NOT EXISTS cart (
      id INTEGER PRIMARY KEY,
      title TEXT,
      price REAL,
      image TEXT,
      quantity INTEGER
    )
  ''');

    // ✅ Aktifkan WAL dengan rawQuery() setelah database terbuka
    await db.rawQuery('PRAGMA journal_mode=WAL;');

    return db;
  }

  Future<void> addToCart(ProductModel product) async {
    final db = await database;
    final existing =
        await db.query('cart', where: 'id = ?', whereArgs: [product.id]);
    if (existing.isNotEmpty) {
      await db.update(
        'cart',
        {'quantity': (existing.first['quantity'] as int) + 1},
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } else {
      await db.insert(
        'cart',
        {
          'id': product.id,
          'title': product.title,
          'price': product.price,
          'image': product.image,
          'quantity': 1,
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // ✅ Prevent duplication
      );
    }
  }

  Future<List<Map<String, Object?>>> getCartItems() async {
    final db = await database;
    final items = await db.query('cart');

    // ✅ Pastikan tidak mengembalikan null
    return items.isNotEmpty ? items : [];
  }

  Future<void> updateQuantity(int id, int quantity) async {
    final db = await database;
    await db.update('cart', {'quantity': quantity},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> removeFromCart(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  Future<double> getTotalPrice() async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT SUM(price * quantity) as total FROM cart');
    return result.first['total'] as double? ?? 0.0;
  }
}
