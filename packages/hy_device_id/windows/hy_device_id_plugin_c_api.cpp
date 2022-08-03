#include "include/hy_device_id/hy_device_id_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hy_device_id_plugin.h"

void HyDeviceIdPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hy_device_id::HyDeviceIdPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
