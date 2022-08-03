#include "include/hy_channel_info/hy_channel_info_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hy_channel_info_plugin.h"

void HyChannelInfoPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hy_channel_info::HyChannelInfoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
