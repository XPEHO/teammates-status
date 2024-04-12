package com.xpeho.yaki

import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime

class MainActivity : FlutterActivity() {
  // The channel name used to communicate with the Flutter part
  private val CHANNEL = "com.xpeho.yaki/notification"
  // The alarm scheduler used to schedule the notifications
  private lateinit var alarmScheduler: AlarmSchedulerImpl
  // The alarm item to define the properties of the notification
  private val alarmItem =
      AlarmItem(
          time = LocalDateTime.of(LocalDate.now(), LocalTime.of(9, 0)),
          message = "It's time to do your daily declaration!"
      )

  /**
   * This method is called when the app is launched. We use it to initialize the alarm scheduler.
   */
  override fun onCreate(savedInstanceState: android.os.Bundle?) {
    println("Debug notification : onCreate")
    super.onCreate(savedInstanceState)
    alarmScheduler = AlarmSchedulerImpl(context = this)
  }

  /**
   * This method is called when the app is resumed. We use it to schedule the alarm if the following
   * conditions are met:
   * - the notifications are not already scheduled
   * - the notifications are permitted
   * - the notifications are activated in the Flutter part
   */
  override fun onResume() {
    super.onResume()

    // Check if the notifications are permitted
    if (!areNotificationsPermitted()) {
      cancelNotifications()
      return
    }

    // Check if the notifications are activated in the Flutter part
    flutterEngine?.let { engine ->
      val methodChannel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)

      // Call the areNotificationsActivated method in the Flutter part
      methodChannel.invokeMethod(
          "areNotificationsActivated",
          null,
          object : MethodChannel.Result {
            override fun success(result: Any?) {
              if (result as? Boolean == true) {
                // Notifications are activated, schedule the alarm.
                scheduleNotifications()
              } else {
                cancelNotifications()
                return
              }
            }
            override fun error(code: String, message: String?, details: Any?) {
              return
            }
            override fun notImplemented() {
              return
            }
          }
      )
    }
  }

  /**
   * This method define a channel connexion to Flutter. We use it to give the Flutter part the
   * ability to manage the notifications.
   */
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
        call,
        result ->
      when (call.method) {
        "scheduleNotifications" -> {
          scheduleNotifications()
          result.success(null)
        }
        "cancelNotifications" -> {
          cancelNotifications()
          result.success(null)
        }
        "arePermissionsEnabled" -> {
          result.success(areNotificationsPermitted())
        }
        else -> result.notImplemented()
      }
    }
  }

  /**
   * This method is a channel method that schedule the notifications if the permissions are granted
   * and ask the permissions if not. It also check before if the notifications are already scheduled
   * and if the android version is compatible.
   */
  private fun scheduleNotifications() {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
      return
    }

    // Get the shared preferences
    val sharedPreferences = getSharedPreferences("com.xpeho.yaki", Context.MODE_PRIVATE)

    // Check if the notifications are already scheduled
    val areNotificationsScheduled = sharedPreferences.getBoolean("areNotificationsScheduled", false)
    if (areNotificationsScheduled) {
      return
    }

    // Ask notification permission if needed
    if (!areNotificationsPermitted()) {
      askNotificationsPermission()
      return
    } else {
      // Schedule the alarm if the permission is already granted
      alarmScheduler.schedule(alarmItem)
    }
  }

  /** This method is a channel method that cancel the notifications. */
  private fun cancelNotifications() {
    alarmScheduler.cancel(alarmItem)
  }

  /** This method check if the notifications are permitted. */
  private fun areNotificationsPermitted(): Boolean {
    val notificationManager =
        this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    return notificationManager.areNotificationsEnabled()
  }

  /** This method ask the user to enable the notifications with a redirection to the settings. */
  private fun askNotificationsPermission() {
    val intent =
        Intent(Settings.ACTION_APP_NOTIFICATION_SETTINGS).apply {
          putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)
        }
    context.startActivity(intent)
  }
}
