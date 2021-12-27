import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data/database/local_database.dart';
import 'data/preferences/preferences.dart';
import 'logic/repositories/habit_respository.dart';
import 'logic/repositories_impl/habit_repository_impl.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:provider/provider.dart';
import 'logic/strings/messages.dart';
import 'presentation/extra_widgets/main_nav_bar.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences().currentPreferences;
  Database db = await LocalDatabase().db;
  BriteDatabase briteDatabase = BriteDatabase(db, logger: null);

  tz.initializeTimeZones();

  HabitRepositoryImpl habitRepositoryImpl =
      HabitRepositoryImpl(db: briteDatabase);

  String currentLanguageCode =
      await Preferences().getPreference(Preferences.SELECTED_LANGUAGE);
  Messages messages = Messages.loadMessages(currentLanguageCode);

  String fontFamily = currentLanguageCode == "KO" ? "CookieRun" : "Poppins";

  if (kDebugMode) {
    await habitRepositoryImpl.createTestData();
  }

  runApp(MyApp(
    habitRepository: habitRepositoryImpl,
    messages: messages,
    fontFamily: fontFamily,
  ));
}

class MyApp extends StatelessWidget {
  final HabitRepository habitRepository;
  final Messages messages;
  final String fontFamily;

  const MyApp(
      {required this.habitRepository,
      required this.messages,
      required this.fontFamily,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HabitRepository>(create: (_) => habitRepository),
        Provider<Messages>(create: (_) => messages),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just 66',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: fontFamily,
        ),
        home: const MainNavBar(),
      ),
    );
  }
}
