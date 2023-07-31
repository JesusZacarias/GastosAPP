import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  final FlutterLocalNotificationsPlugin _pluginNotif =
      FlutterLocalNotificationsPlugin();

  initialize() async {
    AndroidInitializationSettings _androidInit =
        const AndroidInitializationSettings('@mipmap/balance');

    InitializationSettings _initSetting = InitializationSettings(
      android: _androidInit,
    );

    await _pluginNotif.initialize(_initSetting);
  }

  ///notificación diaria, en la documentacion d ela libreria podemos
  /// encontrar mas información para crear notificaciones semanales, anauales, etc.
  dailyNotification(int hour, int minute) async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    tz.TZDateTime utcTimeNow = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      utcTimeNow.year,
      utcTimeNow.month,
      utcTimeNow.day,
      hour,
      minute
    );
    if (scheduledDate.isBefore(utcTimeNow)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    //Los titulos se muestran cuando se expande la notificación
    var bigImage = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('@mipmap/money'),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/balance'),
      contentTitle: 'Es hora de registrar tus gastos',
      summaryText: 'No olvides registrar los gastos de hoy',
      htmlFormatContent: true,
      htmlFormatTitle: true
    );

    var _androidDetails = AndroidNotificationDetails(
      '1',//channelId, 
    'name',//channelName
    styleInformation: bigImage
    );

    var _platform = NotificationDetails(
      android: _androidDetails

    );
    //Los titulos son cuando la notificación esta minimizada
    await _pluginNotif.zonedSchedule(
        1, //id,
        'Llego el momento', //title,
        'No olvides registrar tus gastos', //body,
        scheduledDate,
        _platform,
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        //Para que la notificacion se repita diariamente a la misma hora
        matchDateTimeComponents: DateTimeComponents.time);
  }

  cancelNotifications() async {
    await _pluginNotif.cancelAll();
  }
}
