package com.iamonthephone.app

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "audio_route").setMethodCallHandler { call, result ->
            val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
            when (call.method) {
                "routeToEarpiece" -> {
                    // Set the audio mode to communication mode
                    audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
                    audioManager.isSpeakerphoneOn = false
                    audioManager.isMicrophoneMute = false
                    audioManager.setBluetoothScoOn(false)
                    audioManager.setSpeakerphoneOn(false)
                    result.success(null)
                }
                "setLowVolume" -> {
                    val max = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                    val low = (max * 0.2).toInt().coerceAtLeast(1)
                    audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, low, 0)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
