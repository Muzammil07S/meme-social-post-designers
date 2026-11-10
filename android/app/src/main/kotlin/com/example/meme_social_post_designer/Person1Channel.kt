package com.example.meme_social_post_designer

import android.app.Activity
import android.content.Context
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import java.util.Locale
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// PERSON 1: Toast, Device Info, Battery aur Screen Info
class Person1Channel(private val activity: Activity) {

    fun register(engine: FlutterEngine) {
        MethodChannel(engine.dartExecutor.binaryMessenger, "meme_app/person1")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "showToast" -> {
                        val msg = call.argument<String>("message") ?: ""
                        Toast.makeText(activity, msg, Toast.LENGTH_SHORT).show()
                        result.success(null)
                    }
                    "getDeviceInfo" -> result.success(deviceInfo())
                    "getBatteryLevel" -> result.success(batteryLevel())
                    "getScreenInfo" -> result.success(screenInfo())
                    "getLanguage" -> result.success(language())
                    "getAppName" -> result.success(appName())
                    else -> result.notImplemented()
                }
            }
    }

    private fun deviceInfo(): String {
        return "${Build.MANUFACTURER} ${Build.MODEL} " +
            "(Android ${Build.VERSION.RELEASE})"
    }

    private fun batteryLevel(): Int {
        val manager = activity.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return manager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

    private fun screenInfo(): String {
        val metrics = activity.resources.displayMetrics
        return "${metrics.widthPixels}x${metrics.heightPixels} @ ${metrics.densityDpi}dpi"
    }

    /** Phone ki current language, jaise "English" ya "Urdu". */
    private fun language(): String {
        return Locale.getDefault().displayLanguage
    }

    /** App ka naam jo launcher mein dikhta hai. */
    private fun appName(): String {
        val label = activity.applicationInfo.loadLabel(activity.packageManager)
        return label.toString()
    }
}
