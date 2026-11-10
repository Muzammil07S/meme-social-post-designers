package com.example.meme_social_post_designer

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

// OWNER (Person 1): teeno persons ke Kotlin channels yahan register hote hain
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Person1Channel(this).register(flutterEngine)
        Person2Channel(this).register(flutterEngine)
        Person3Channel(this).register(flutterEngine)
    }
}
