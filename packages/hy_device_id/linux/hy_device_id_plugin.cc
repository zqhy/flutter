#include "include/hy_device_id/hy_device_id_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define HY_DEVICE_ID_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), hy_device_id_plugin_get_type(), \
                              HyDeviceIdPlugin))

struct _HyDeviceIdPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(HyDeviceIdPlugin, hy_device_id_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void hy_device_id_plugin_handle_method_call(
    HyDeviceIdPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getDeviceId") == 0) {
    FILE *rstream = NULL;
    char buf[1024] = {0};
    rstream = popen("dmidecode -s system-uuid","r");
    fread(buf, sizeof(char), sizeof(buf), rstream);
    pclose(rstream);
    g_autofree gchar *deviceId = g_strdup_printf("%s", buf);
    g_autoptr(FlValue) result = fl_value_new_string(deviceId);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void hy_device_id_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(hy_device_id_plugin_parent_class)->dispose(object);
}

static void hy_device_id_plugin_class_init(HyDeviceIdPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = hy_device_id_plugin_dispose;
}

static void hy_device_id_plugin_init(HyDeviceIdPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  HyDeviceIdPlugin* plugin = HY_DEVICE_ID_PLUGIN(user_data);
  hy_device_id_plugin_handle_method_call(plugin, method_call);
}

void hy_device_id_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  HyDeviceIdPlugin* plugin = HY_DEVICE_ID_PLUGIN(
      g_object_new(hy_device_id_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "hy_device_id",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
