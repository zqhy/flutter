package com.hy.hy_device_id;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.nio.ByteBuffer;
import java.util.UUID;

import android.media.MediaDrm;
import android.util.Base64;

/** HyDeviceIdPlugin */
public class HyDeviceIdPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "hy_device_id");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getDeviceId")) {
      UUID wideVineUuid = UUID.fromString("edef8ba9-79d6-4ace-a3c8-27dcd51d21ed");
      try {
        MediaDrm wvDrm = new MediaDrm(wideVineUuid);
        byte[] wideVineId = wvDrm.getPropertyByteArray(MediaDrm.PROPERTY_DEVICE_UNIQUE_ID);
        ByteBuffer wideVineIdByteBuffer = ByteBuffer.wrap(wideVineId);
        result.success((new UUID(wideVineIdByteBuffer.getLong(), wideVineIdByteBuffer.getLong())).toString());
      } catch (Exception e) {
        result.success(null);
      }
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
