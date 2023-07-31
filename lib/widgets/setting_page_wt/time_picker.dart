import 'package:exp_app/providers/local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:exp_app/providers/shared_pref.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _prefs = UserPrefs();
  final _notifs = LocalNotifications();
  bool _isEnable = false;
  String _title = 'Activar Notificaciones';

  @override
  Widget build(BuildContext context) {
    final DateTime getDate = DateTime.now();
    String currentTime;

    if (_prefs.hour != 99) {
      final DateTime getTime = DateTime(
          getDate.year, getDate.month, getDate.day, _prefs.hour, _prefs.minute);
      currentTime = DateFormat.jm().format(getTime);
      _title = 'Desactivar Notificaciones';
      _isEnable = true;
    } else {
      currentTime = "Desactivado";
      _title = 'Activar Notificaciones';
      _isEnable = false;
    }

    _cancelNotif(bool value) {
      if (value == true) {
        //define una hora y minunto predeterminada cuando el usuario activa las notificaciones
        _prefs.hour = 21;
        _prefs.minute = 30;
        //inicializa las notificaciones a una hora determinada si se activan las notificaciones
        _notifs.dailyNotification(21, 30);
      } else {
        //borra y cancela la hora del timepicker y las notificaciones respectivamente
        _prefs.deleteTime();
        _notifs.cancelNotifications();
      }
    }

    return Column(
      children: [
        SwitchListTile(
          value: _isEnable,
          title: Text(_title),
          onChanged: (value) {
            setState(() {
              _isEnable = value;
              _cancelNotif(value);
            });
          },
        ),
        ListTile(
          enabled: _isEnable,
          leading: (_isEnable)
              ? const Icon(
                  Icons.notifications_active_outlined,
                  size: 35.0,
                )
              : const Icon(
                  Icons.notifications_off_outlined,
                  size: 35.0,
                ),
          title: const Text('Recordatorio Diario'),
          subtitle: Text(currentTime),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () {
            _selectedTime();
          },
        ),
      ],
    );
  }

  _selectedTime() {
    int? _hour;
    int? _minute;
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 350.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TimePickerSpinner(
                //La hora que muestra al abrir el timepicker
                time: DateTime.now(),
                is24HourMode: false,
                spacing: 60,
                itemHeight: 60,
                itemWidth: 60,
                isForce2Digits: true,
                //Datos seleccionado
                highlightedTextStyle: const TextStyle(
                  fontSize: 35,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
                //Datos que no estan enfocados
                normalTextStyle:
                    TextStyle(fontSize: 25.0, color: Colors.grey[500]),
                onTimeChange: (time) {
                  setState(() {
                    _hour = time.hour;
                    _minute = time.minute;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Constants.customButtom(
                        Colors.transparent,
                        Colors.red,
                        'Cancelar',
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Constants.customButtom(
                        Colors.transparent,
                        Colors.green,
                        'Aceptar',
                      ),
                      onTap: () {
                        setState(() {
                          _prefs.hour = _hour!;
                          _prefs.minute = _minute!;
                          _notifs.dailyNotification(_hour!, _minute!);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
