# Download via dockerfile + environment
# https://sdk.lunarg.com/sdk/download/1.1.77.0/windows/VulkanSDK-1.1.77.0-Installer.exe?Human=true;u=
.\VulkanSDK.exe /S /D=C:\VulkanSDK | Out-Null
Remove-Item VulkanSDK.exe

[Environment]::SetEnvironmentVariable( "CUSTOM_INCLUDE", [System.Environment]::GetEnvironmentVariable("CUSTOM_INCLUDE","Machine") + ";C:\VulkanSDK\Include", [System.EnvironmentVariableTarget]::Machine )
[Environment]::SetEnvironmentVariable( "CUSTOM_LIB", [System.Environment]::GetEnvironmentVariable("CUSTOM_LIB","Machine") + ";C:\VulkanSDK\lib", [System.EnvironmentVariableTarget]::Machine )