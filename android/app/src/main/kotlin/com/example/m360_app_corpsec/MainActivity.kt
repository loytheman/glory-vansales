package com.meyzer360.app_corpsec

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterFragmentActivity;

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL1 = "channel1"
    private val CHANNEL2 = "channel2"
    private lateinit var methodChannel1: MethodChannel
    private lateinit var methodChannel2: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel1 = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL1)
        methodChannel2 = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL2)

        // Set up the MethodChannel with the same name as defined in Dart
        methodChannel1.setMethodCallHandler { call, result ->
            if (call.method == "method1") {
                result.success(666)
            } else if (call.method == "parent_push") {
                invokeChannelMethodWithCallback(methodChannel2, "parent_push", call.arguments, result);
            } else if (call.method == "parent_pull") {
                invokeChannelMethodWithCallback(methodChannel2, "parent_pull", null, result);
            } else {
                result.notImplemented()
            }
        }

        methodChannel2.setMethodCallHandler { call, result ->
            if (call.method == "method1") {
                result.success(999)
            } else if (call.method == "child_push") {
                invokeChannelMethodWithCallback(methodChannel1, "child_push", call.arguments, result);
            } else if (call.method == "child_pull") {
                invokeChannelMethodWithCallback(methodChannel1, "child_pull", call.arguments, result);
            } else {
                result.notImplemented()
            }
        }
    }

    
    fun invokeChannelMethodWithCallback (channel:MethodChannel, methodName:String, params:Any?, callback:MethodChannel.Result) {

        channel.invokeMethod(methodName, params, object:MethodChannel.Result {
            override fun success(r: Any?) {
                callback.success(r);
            }
            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                println(errorCode);
                println(errorMessage);
            }
            override fun notImplemented() {
                println("Not Implemented")
            }
        })



    }
    

}
