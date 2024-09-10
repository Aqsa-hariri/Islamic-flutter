import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimesPage extends StatefulWidget {
  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  PrayerTimes? _prayerTimes;
  String _location = 'جاري تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    _getPrayerTimes();
  }

  Future<void> _getPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      final date = DateComponents.from(DateTime.now());
      final prayerTimes = PrayerTimes(coordinates, date, params);

      setState(() {
        _prayerTimes = prayerTimes;
        _location = '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      });
    } catch (e) {
      print('Error getting prayer times: $e');
      setState(() {
        _location = 'حدث خطأ في تحديد الموقع';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مواقيت الصلاة'),
      ),
      body: Center(
        child: _prayerTimes == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('الموقع: $_location'),
            SizedBox(height: 20),
            _buildPrayerTimeRow('الفجر', _prayerTimes!.fajr),
            _buildPrayerTimeRow('الشروق', _prayerTimes!.sunrise),
            _buildPrayerTimeRow('الظهر', _prayerTimes!.dhuhr),
            _buildPrayerTimeRow('العصر', _prayerTimes!.asr),
            _buildPrayerTimeRow('المغرب', _prayerTimes!.maghrib),
            _buildPrayerTimeRow('العشاء', _prayerTimes!.isha),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeRow(String prayerName, DateTime? time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prayerName, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text(_formatTime(time)),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    return time != null ? DateFormat.jm().format(time.toLocal()) : 'N/A';
  }
}