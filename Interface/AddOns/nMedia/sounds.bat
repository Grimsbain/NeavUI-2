@echo off
echo local path = "Interface\\AddOns\\nMedia\\sounds\\"
echo local LSM = LibStub("LibSharedMedia-3.0")
for /F "delims==" %%G in ('dir /b sounds') do echo LSM:Register("sound", "%%~nG", path.."%%G")
