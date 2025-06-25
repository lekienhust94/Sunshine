# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BINARY_7Z "OFF")
set(CPACK_BINARY_IFW "OFF")
set(CPACK_BINARY_INNOSETUP "OFF")
set(CPACK_BINARY_NSIS "ON")
set(CPACK_BINARY_NUGET "OFF")
set(CPACK_BINARY_WIX "OFF")
set(CPACK_BINARY_ZIP "OFF")
set(CPACK_BUILD_SOURCE_DIRS "C:/msys64/home/GOLFZON/Sunshine;C:/msys64/home/GOLFZON/Sunshine")
set(CPACK_CMAKE_GENERATOR "Ninja")
set(CPACK_COMPONENTS_ALL "Unspecified;application;assets;audio;autostart;dxgi;firewall;gamepad")
set(CPACK_COMPONENT_APPLICATION_DEPENDS "assets")
set(CPACK_COMPONENT_APPLICATION_DESCRIPTION "Sunshine main application and required components.")
set(CPACK_COMPONENT_APPLICATION_DISPLAY_NAME "Sunshine")
set(CPACK_COMPONENT_APPLICATION_GROUP "Core")
set(CPACK_COMPONENT_APPLICATION_REQUIRED "true")
set(CPACK_COMPONENT_ASSETS_DESCRIPTION "Shaders, default box art, and web UI.")
set(CPACK_COMPONENT_ASSETS_DISPLAY_NAME "Required Assets")
set(CPACK_COMPONENT_ASSETS_GROUP "Core")
set(CPACK_COMPONENT_ASSETS_REQUIRED "true")
set(CPACK_COMPONENT_AUDIO_DESCRIPTION "CLI tool providing information about sound devices.")
set(CPACK_COMPONENT_AUDIO_DISPLAY_NAME "audio-info")
set(CPACK_COMPONENT_AUDIO_GROUP "Tools")
set(CPACK_COMPONENT_AUTOSTART_DESCRIPTION "If enabled, launches Sunshine automatically on system startup.")
set(CPACK_COMPONENT_AUTOSTART_DISPLAY_NAME "Launch on Startup")
set(CPACK_COMPONENT_AUTOSTART_GROUP "Core")
set(CPACK_COMPONENT_DXGI_DESCRIPTION "CLI tool providing information about graphics cards and displays.")
set(CPACK_COMPONENT_DXGI_DISPLAY_NAME "dxgi-info")
set(CPACK_COMPONENT_DXGI_GROUP "Tools")
set(CPACK_COMPONENT_FIREWALL_DESCRIPTION "Scripts to enable or disable firewall rules.")
set(CPACK_COMPONENT_FIREWALL_DISPLAY_NAME "Add Firewall Exclusions")
set(CPACK_COMPONENT_FIREWALL_GROUP "Scripts")
set(CPACK_COMPONENT_GAMEPAD_DESCRIPTION "Scripts to install and uninstall Virtual Gamepad.")
set(CPACK_COMPONENT_GAMEPAD_DISPLAY_NAME "Virtual Gamepad")
set(CPACK_COMPONENT_GAMEPAD_GROUP "Scripts")
set(CPACK_COMPONENT_GROUP_CORE_EXPANDED "true")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "C:/msys64/ucrt64/share/cmake/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "Sunshine built using CMake")
set(CPACK_DMG_SLA_USE_RESOURCE_FILE_LICENSE "ON")
set(CPACK_GENERATOR "NSIS")
set(CPACK_INNOSETUP_ARCHITECTURE "x64")
set(CPACK_INSTALL_CMAKE_PROJECTS "C:/msys64/home/GOLFZON/Sunshine;Sunshine;ALL;/")
set(CPACK_INSTALL_PREFIX "C:/Program Files (x86)/Sunshine")
set(CPACK_MODULE_PATH "C:/msys64/home/GOLFZON/Sunshine/cmake")
set(CPACK_NSIS_CONTACT "https://app.lizardbyte.dev/Sunshine/support")
set(CPACK_NSIS_CREATE_ICONS_EXTRA "
        SetOutPath '$INSTDIR'
        CreateShortCut '$SMPROGRAMS\\$STARTMENU_FOLDER\\Sunshine.lnk'             '$INSTDIR\\Sunshine.exe' '--shortcut'
        ")
set(CPACK_NSIS_DELETE_ICONS_EXTRA "
        Delete '$SMPROGRAMS\\$MUI_TEMP\\Sunshine.lnk'
        ")
set(CPACK_NSIS_DISPLAY_NAME "Sunshine")
set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL "ON")
set(CPACK_NSIS_EXECUTABLES_DIRECTORY ".")
set(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
        IfSilent +2 0
        ExecShell 'open' 'https://docs.lizardbyte.dev/projects/sunshine'
        nsExec::ExecToLog 'icacls \"$INSTDIR\" /reset'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\update-path.bat\" add'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\migrate-config.bat\"'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\add-firewall-rule.bat\"'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\install-gamepad.bat\"'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\install-service.bat\"'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\autostart-service.bat\"'
        NoController:
        ")
set(CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS "
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\delete-firewall-rule.bat\"'
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\uninstall-service.bat\"'
        nsExec::ExecToLog '\"$INSTDIR\\Sunshine.exe\" --restore-nvprefs-undo'
        MessageBox MB_YESNO|MB_ICONQUESTION             'Do you want to remove Virtual Gamepad?'             /SD IDNO IDNO NoGamepad
            nsExec::ExecToLog '\"$INSTDIR\\scripts\\uninstall-gamepad.bat\"'; skipped if no
        NoGamepad:
        MessageBox MB_YESNO|MB_ICONQUESTION             'Do you want to remove $INSTDIR (this includes the configuration, cover images, and settings)?'             /SD IDNO IDNO NoDelete
            RMDir /r \"$INSTDIR\"; skipped if no
        nsExec::ExecToLog '\"$INSTDIR\\scripts\\update-path.bat\" remove'
        NoDelete:
        ")
set(CPACK_NSIS_HELP_LINK "https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2getting__started.html")
set(CPACK_NSIS_INSTALLED_ICON_NAME "Sunshine.exe")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64")
set(CPACK_NSIS_MANIFEST_DPI_AWARE "true")
set(CPACK_NSIS_MENU_LINKS "https://docs.lizardbyte.dev/projects/sunshine;Sunshine documentation;https://app.lizardbyte.dev;LizardByte Web Site;https://app.lizardbyte.dev/support;LizardByte Support")
set(CPACK_NSIS_MODIFY_PATH "OFF")
set(CPACK_NSIS_PACKAGE_NAME "Sunshine")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_NSIS_URL_INFO_ABOUT "https://app.lizardbyte.dev/Sunshine")
set(CPACK_OBJCOPY_EXECUTABLE "C:/msys64/ucrt64/bin/objcopy.exe")
set(CPACK_OBJDUMP_EXECUTABLE "C:/msys64/ucrt64/bin/objdump.exe")
set(CPACK_OUTPUT_CONFIG_FILE "C:/msys64/home/GOLFZON/Sunshine/CPackConfig.cmake")
set(CPACK_PACKAGE_CONTACT "https://app.lizardbyte.dev")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION "Self-hosted game stream host for Moonlight")
set(CPACK_PACKAGE_DESCRIPTION_FILE "C:/msys64/ucrt64/share/cmake/Templates/CPack.GenericDescription.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Self-hosted game stream host for Moonlight")
set(CPACK_PACKAGE_DIRECTORY "C:/msys64/home/GOLFZON/Sunshine/cpack_artifacts")
set(CPACK_PACKAGE_FILE_NAME "Sunshine")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://app.lizardbyte.dev/Sunshine")
set(CPACK_PACKAGE_ICON "C:/msys64/home/GOLFZON/Sunshine\\sunshine.ico")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "Sunshine")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "Sunshine")
set(CPACK_PACKAGE_NAME "Sunshine")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "LizardByte")
set(CPACK_PACKAGE_VERSION "0.0.0.60323dd5.dirty")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_READELF_EXECUTABLE "C:/msys64/ucrt64/bin/readelf.exe")
set(CPACK_RESOURCE_FILE_LICENSE "C:/msys64/home/GOLFZON/Sunshine/LICENSE")
set(CPACK_RESOURCE_FILE_README "C:/msys64/ucrt64/share/cmake/Templates/CPack.GenericDescription.txt")
set(CPACK_RESOURCE_FILE_WELCOME "C:/msys64/ucrt64/share/cmake/Templates/CPack.GenericWelcome.txt")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_7Z "ON")
set(CPACK_SOURCE_GENERATOR "7Z;ZIP")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "C:/msys64/home/GOLFZON/Sunshine/CPackSourceConfig.cmake")
set(CPACK_SOURCE_ZIP "ON")
set(CPACK_STRIP_FILES "YES")
set(CPACK_SYSTEM_NAME "win64")
set(CPACK_THREADS "1")
set(CPACK_TOPLEVEL_TAG "win64")
set(CPACK_WIX_SIZEOF_VOID_P "8")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "C:/msys64/home/GOLFZON/Sunshine/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()
