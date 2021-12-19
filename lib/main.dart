import 'package:flutter/material.dart';
import 'data/database/local_database.dart';
import 'logic/repositories/habit_respository.dart';
import 'logic/repositories_impl/habit_repository_impl.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'presentation/extra_widgets/main_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database db = await LocalDatabase().db;
  BriteDatabase briteDatabase = BriteDatabase(db);

  HabitRepositoryImpl habitRepositoryImpl =
      HabitRepositoryImpl(db: briteDatabase);

  runApp(MyApp(
    habitRepository: habitRepositoryImpl,
  ));
}

class MyApp extends StatelessWidget {
  final HabitRepository habitRepository;

  const MyApp({required this.habitRepository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        return habitRepository;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: "Poppins",
        ),
        home: const MainNavBar(),
      ),
    );
  }
}
