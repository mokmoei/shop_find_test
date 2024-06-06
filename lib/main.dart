import 'package:find_shop_test/core/theme/theme_app.dart';
import 'package:find_shop_test/feature/location_search/data/repositories/location_search_repository.dart';
import 'package:find_shop_test/feature/location_search/presentations/providers/location_search_provider.dart';
import 'package:find_shop_test/feature/location_search/presentations/screens/location_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LocationSearchProvider(LocationSearchRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Find Shop App',
        theme: ThemeData(
          fontFamily: "Prompt",
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff00B3F0),
            primary: const Color(0xff00B3F0),
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 12,
            shadowColor: Colors.black.withOpacity(.12),
            surfaceTintColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            titleLarge: TextStyle(color: ThemeApp.blue),
          ),
        ),
        home: const LocationSearchScreen(),
      ),
    );
  }
}
