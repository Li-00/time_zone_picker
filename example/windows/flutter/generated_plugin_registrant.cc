//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_timezone/flutter_timezone_plugin_c_api.h>
#include <time_zone_picker/time_zone_picker_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterTimezonePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterTimezonePluginCApi"));
  TimeZonePickerPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("TimeZonePickerPluginCApi"));
}
