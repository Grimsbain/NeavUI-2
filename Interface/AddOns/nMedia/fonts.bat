@echo off
echo local path = "Interface\\AddOns\\nMedia\\fonts\\"
echo local LSM = LibStub("LibSharedMedia-3.0")
for /F "delims==" %%G in ('dir /b fonts') do echo LSM:Register("font", "%%~nG", path.."%%G")
