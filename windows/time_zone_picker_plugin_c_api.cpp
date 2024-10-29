#include "include/time_zone_picker/time_zone_picker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "time_zone_picker_plugin.h"

void TimeZonePickerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  time_zone_picker::TimeZonePickerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
