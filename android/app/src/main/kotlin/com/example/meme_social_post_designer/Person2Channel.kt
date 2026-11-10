package com.example.meme_social_post_designer

import android.app.Activity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// PERSON 2: Template / Editor / Sticker platform channel helper
class Person2Channel(private val activity: Activity) {
    fun register(engine: FlutterEngine) {
        MethodChannel(engine.dartExecutor.binaryMessenger, "meme_app/person2")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    else -> result.notImplemented()
                }
            }
    }
}
