import 'package:app_papa_v2/models/my_card.dart';
import 'package:sqflite/sqflite.dart';

class CardsDatabase {
  static final CardsDatabase instance = CardsDatabase._init();

  static Database? _database;

  CardsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const nullTextType = 'TEXT';

    await db.execute('''
    CREATE TABLE $tableCards ( 
      ${CardFields.id} $idType, 
      ${CardFields.title} $textType,
      ${CardFields.logoPath} $nullTextType,
      ${CardFields.color} $intType,
      ${CardFields.barCode} $nullTextType,
      ${CardFields.isFav} $boolType)
      ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<MyCard> create(MyCard card) async {
    final db = await instance.database;

    final id = await db.insert(tableCards, card.toJson());

    return card.copy(id: id);
  }

  Future<MyCard> readCard(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCards,
      columns: CardFields.values,
      where: '${CardFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MyCard.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MyCard>> readAllCards() async {
    final db = await instance.database;

    const orderBy = '${CardFields.title} ASC';

    final result = await db.query(tableCards, orderBy: orderBy);

    return result.map((json) => MyCard.fromJson(json)).toList();
  }

  /// Function to update a card in the database
  /// return the number of lines modified
  Future<int> update(MyCard card) async {
    final db = await instance.database;

    // await delete(card.id!);
    return db.rawUpdate('''
    UPDATE $tableCards SET 
    ${CardFields.title} = ?,
    ${CardFields.logoPath} = ?,
    ${CardFields.color} = ?,
    ${CardFields.barCode} = ?,
    ${CardFields.isFav} = ?
    WHERE ${CardFields.id} = ?
    ''', [
      card.title,
      card.logoPath,
      card.color,
      card.barCode,
      card.isFav,
      card.id
    ]);

    // return db.update(
    //   tableCards,
    //   card.toJson(),
    //   where: '${CardFields.id} = ?',
    //   whereArgs: [card.id],
    // );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCards,
      where: '${CardFields.id} = ?',
      whereArgs: [id],
    );
  }
}
