@ECHO Off
setlocal
echo ======== Restoring packages... =====

if not exist paket.exe (
	paket.bootstrapper.exe
)

paket.exe restore

if not %ERRORLEVEL% == 0 (
	echo ======= Failed to restore packages. =======
	exit 1
)

echo ====== Building... =====

if "%MSBUILD_PATH%" == "" (
	set MSBUILD_PATH="%ProgramFiles(x86)%\MSBuild\12.0\Bin\MSBuild.exe"
)

@ECHO OFF
setlocal

echo ======= Restoring packages... =======

if not exist paket.exe (
	paket.bootstrapper.exe
)

paket.exe restore

if not %ERRORLEVEL% == 0 (
	echo ==== Failed to restore packages. =======
	exit 1
)

echo ======= Building.... ======

if "%MSBUILD_PATH%" == "" (
	set MSBUILD_PATH="%ProgramFiles(x86)%\MSBuild\12.0\Bin\MSBuild.exe"
)

%MSBUILD_PATH% /p:Configuration=Release

if not %ERRORLEVEL% == 0 (
	echo ======= Build failed. =======
	exit 1
)

if not "%DEPLOYMENT_TARGET%" == "" (
	echo ====== Deploying... =====
	xcopy /y /e Warp "%DEPLOYMENT_TARGET%"
)

echo ====== Done. =======