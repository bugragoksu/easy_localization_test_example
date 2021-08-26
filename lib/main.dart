import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_example/generated/codegen_loader.g.dart';
import 'package:test_example/localization_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      assetLoader: CodegenLoader(),
      supportedLocales: LocalizationManager.instance.supportedLocales,
      path: LocalizationManager.instance.assetPath,
      fallbackLocale: LocalizationManager.instance.trLocale,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('hello'.tr()), Text('world'.tr())],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LocalizationManager.instance.changeLocale(context);
        },
        tooltip: 'Change Language',
        child: Icon(Icons.language),
      ),
    );
  }
}
