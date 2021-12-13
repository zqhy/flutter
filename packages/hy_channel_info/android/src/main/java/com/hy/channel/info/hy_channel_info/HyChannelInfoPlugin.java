package com.hy.channel.info.hy_channel_info;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.leon.channel.helper.ChannelReaderUtil;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** HyChannelInfoPlugin */
public class HyChannelInfoPlugin implements FlutterPlugin, MethodCallHandler {

  private static final String TAG = HyChannelInfoPlugin.class.getSimpleName();

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private static final String FILE_NAME_AGENT = "channel_info";
  private String channelInfo;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    Context context = flutterPluginBinding.getApplicationContext();
    channelInfo = getChannel(context);

    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "hy_channel_info");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getChannelInfo")) {
      result.success(channelInfo);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public static String getChannel(Context context, String fileName) {
    String channelInfo = getAssetsText(context, fileName);
    if (TextUtils.isEmpty(channelInfo)) {
      channelInfo = ChannelReaderUtil.getChannel(context);
    }
    return channelInfo;
  }

  public static String getChannel(Context context) {
    return getChannel(context, FILE_NAME_AGENT);
  }

  public static String getAssetsText(Context context, String fileName) {
    InputStream in = null;
    try {
      //得到资源中的asset数据流
      in = context.getResources().getAssets().open(fileName);
      return toString(in);
    } catch (Exception ex) {
      Log.e(TAG, String.format("加载 `%s` 失败", fileName), ex);
      return null;
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch (IOException ex) {
          ex.printStackTrace();
        }
      }
    }
  }

  final static int BUFFER_SIZE = 4096;
  public static String toString(InputStream in) throws IOException {
    return toString(in, "UTF-8");
  }

  public static String toString(InputStream in, String encoding) throws IOException {
    ByteArrayOutputStream outStream = new ByteArrayOutputStream();
    byte[] data = new byte[BUFFER_SIZE];
    int count;
    while((count = in.read(data,0,BUFFER_SIZE)) != -1)
      outStream.write(data, 0, count);

    return outStream.toString(encoding);
  }
}
