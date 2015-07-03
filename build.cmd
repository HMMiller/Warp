
@ECHO OFF 
setlocal 

echo ====== Restoring packages... ====== 
REM if not exist .paket\paket.exe ( 
REM   .paket\paket.bootstrapper.exe 
if not exist paket.exe (
	paket.bootstrapper.exe
) 
 
REM .paket\paket.exe restore 
paket.exe restore

if not %ERRORLEVEL% == 0 ( 
   echo ====== Failed to restore packages. ====== 
   exit 1 
) 

echo ====== Building... ====== 
 
REM Azure provides MSBUILD_PATH and DEPLOYMENT_TARGET. 
REM If we're not deploying to Azure (eg. building locally), 
REM we need to set MSBUILD_PATH. 
if "%MSBUILD_PATH%" == "" ( 
   set MSBUILD_PATH="%ProgramFiles(x86)%\MSBuild\12.0\Bin\MSBuild.exe" 
)  

@ECHO OFF
setlocal

echo ====== Restoring packages... ======

REM if not exist .paket\paket.exe (
REM  .paket\paket.bootstrapper.exe
if not exist paket.exe (
	paket.bootstrapper.exe
)

paket.exe restore

if not %ERRORLEVEL% == 0 (
  echo ====== Failed to restore packages. ======
  exit 1
)

echo ====== Building... ======

if "%MSBUILD_PATH%" == "" (
  set MSBUILD_PATH="%ProgramFiles(x86)%\MSBuild\12.0\Bin\MSBuild.exe"
)

%MSBUILD_PATH% /p:Configuration=Release

if not %ERRORLEVEL% == 0 (
  echo ====== Build failed. ======
  exit 1
)

if not "%DEPLOYMENT_TARGET%" == "" (
  echo ====== Deploying... ======
  xcopy /y /e Warp "%DEPLOYMENT_TARGET%"
)

echo ====== Done. ======

