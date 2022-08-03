#include "hy_device_id_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getDeviceId; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <stdio.h>
#include <string.h>
#include <map>
#include <memory>
#include <sstream>

namespace hy_device_id {

// static
void HyDeviceIdPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "hy_device_id",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<HyDeviceIdPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

HyDeviceIdPlugin::HyDeviceIdPlugin() {}

HyDeviceIdPlugin::~HyDeviceIdPlugin() {}

void HyDeviceIdPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getDeviceId") == 0) {
    rstream = _popen("wmic csproduct get UUID","r");
    fread(buf, sizeof(char), sizeof(buf), rstream);
    _pclose(rstream);
    deviceIdResult = buf;
    std::size_t pos = deviceIdResult.find("\n");
    deviceId = deviceIdResult.substr(pos+1);
    result->Success(flutter::EncodableValue(deviceId));
  } else {
    result->NotImplemented();
  }
}

}  // namespace hy_device_id
