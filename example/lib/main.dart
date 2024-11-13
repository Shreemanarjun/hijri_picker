import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'USA'),
          const Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primaryColor: Colors.brown, brightness: Brightness.light),
        home: MyHomePage(title: "Umm Alqura Calendar"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedDate = HijriCalendarConfig.fromHijri(1446, 01, 01);

  @override
  Widget build(BuildContext context) {
    HijriCalendarConfig.setLocal(Localizations.localeOf(context).languageCode);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Gregorian: ${selectedDate.hijriToGregorian(selectedDate.hYear, selectedDate.hMonth, selectedDate.hDay).toLocal()}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Hijri: ${selectedDate.fullDate()}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectDate(context),
        tooltip: 'Pick Date',
        child: Icon(Icons.event),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final HijriCalendarConfig? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: HijriCalendarConfig.fromHijri(1460, 09, 25),
      firstDate: HijriCalendarConfig.fromHijri(1448, 12, 25),
      initialDatePickerMode: DatePickerMode.day,
    );
    print("$picked here");
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }
}
