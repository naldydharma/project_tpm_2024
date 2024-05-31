import 'package:flutter/material.dart';
import 'package:project_tpm1/controllers/waktu_control.dart';

class TimeConverterPage extends StatefulWidget {
  @override
  _TimeConverterPageState createState() => _TimeConverterPageState();
}

class _TimeConverterPageState extends State<TimeConverterPage> {
  final TimeConversionController _controller = TimeConversionController();
  TimeOfDay? _selectedTime;
  String _selectedStartZone = 'WIB';
  String _selectedEndZone = 'WIB';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konversi Waktu',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTimeZoneDropdown('Start', _selectedStartZone, (newValue) {
              setState(() {
                _selectedStartZone = newValue!;
                _updateConvertedTime();
              });
            }),
            SizedBox(height: 16.0),
            _buildSelectTimeButton(),
            SizedBox(height: 16.0),
            if (_selectedTime != null) _buildSelectedTimeCard(),
            SizedBox(height: 16.0),
            _buildTimeZoneDropdown('End', _selectedEndZone, (newValue) {
              setState(() {
                _selectedEndZone = newValue!;
                _updateConvertedTime();
              });
            }),
            SizedBox(height: 16.0),
            if (_selectedTime != null && _controller.convertedTime != null) _buildConvertedTimeCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeZoneDropdown(String label, String value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select $label Time Zone:'),
        DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: _controller.timeZones.map<DropdownMenuItem<String>>((String zone) {
            return DropdownMenuItem<String>(
              value: zone,
              child: Text(zone),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelectTimeButton() {
    return ElevatedButton(
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (time != null) {
          setState(() {
            _selectedTime = time;
          });
          _updateConvertedTime();
        }
      },
      child: Text('Select Time'),
    );
  }

  Widget _buildSelectedTimeCard() {
    return Card(
      color: Colors.blueGrey,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(Icons.access_time),
        title: Text(
          '${_formatTimeOfDay24Hour(_selectedTime!)} ($_selectedStartZone)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildConvertedTimeCard() {
    return Card(
      color: Colors.blueGrey,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(Icons.access_time),
        title: Text(
          '${_controller.convertedTime!.convertedDuration.inHours.toString().padLeft(2, '0')}:${(_controller.convertedTime!.convertedDuration.inMinutes.remainder(60)).toString().padLeft(2, '0')} (${_controller.convertedTime!.endZone})',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _updateConvertedTime() {
    if (_selectedTime != null) {
      _controller.convertTime(_selectedTime!, _selectedStartZone, _selectedEndZone);
    }
  }

  String _formatTimeOfDay24Hour(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
