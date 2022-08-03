//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hy_device_id/hy_device_id_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hy_device_id_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HyDeviceIdPlugin");
  hy_device_id_plugin_register_with_registrar(hy_device_id_registrar);
}
