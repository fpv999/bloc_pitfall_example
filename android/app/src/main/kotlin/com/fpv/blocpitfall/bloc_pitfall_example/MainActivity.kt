package com.fpv.blocpitfall.bloc_pitfall_example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.fpv.blocpitfall/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getNativeData") {
                val data = getNativeData()

                // result.success(data) - intentionally commented out
                // causing a never returning async call
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getNativeData(): String {
        return "Hello from Android Native!"
    }
}
