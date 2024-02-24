import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  // Khởi tạo cơ sở dữ liệu hoặc mở nếu đã tồn tại
  void _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  // Đăng nhập
  // Trong hàm _login
void _login(BuildContext context) async {
  final username = _usernameController.text;
  final password = _passwordController.text;

  // Lưu thông tin người dùng vào cơ sở dữ liệu
  await _database.insert(
    'users',
    {'username': username, 'password': password},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  // Chuyển đến màn hình HomePage
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage(database: _database, username: username)),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Database database;
  final String username;

  const HomePage({Key? key, required this.database, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Xóa dữ liệu người dùng khi đăng xuất
              await database.delete('users');
              // Chuyển về màn hình đăng nhập
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $username!'),
            // Nội dung trang HomePage ở đây
          ],
        ),
      ),
    );
  }
}
