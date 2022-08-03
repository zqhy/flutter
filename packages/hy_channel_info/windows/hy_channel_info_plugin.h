#ifndef FLUTTER_PLUGIN_HY_CHANNEL_INFO_PLUGIN_H_
#define FLUTTER_PLUGIN_HY_CHANNEL_INFO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace hy_channel_info {

class HyChannelInfoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  HyChannelInfoPlugin();

  virtual ~HyChannelInfoPlugin();

  // Disallow copy and assign.
  HyChannelInfoPlugin(const HyChannelInfoPlugin&) = delete;
  HyChannelInfoPlugin& operator=(const HyChannelInfoPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace hy_channel_info

#endif  // FLUTTER_PLUGIN_HY_CHANNEL_INFO_PLUGIN_H_
