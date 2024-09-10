import 'package:flutter/material.dart';
import 'prayer_times.dart';
import 'electronic_tasbeeh.dart';
import 'quran_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق إسلامي',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('مواقيت الصلاة'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrayerTimesPage()), // تم تغيير هذا السطر
                );
              },
            ),
            ElevatedButton(
              child: Text('السبحة الإلكترونية'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ElectronicTasbeeh()),
                );
              },
            ),
            ElevatedButton(
              child: Text('القرآن الكريم'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuranPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}