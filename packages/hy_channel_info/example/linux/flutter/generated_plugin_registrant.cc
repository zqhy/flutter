//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hy_channel_info/hy_channel_info_other.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hy_channel_info_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HyChannelInfoOther");
  hy_channel_info_other_register_with_registrar(hy_channel_info_registrar);
}
