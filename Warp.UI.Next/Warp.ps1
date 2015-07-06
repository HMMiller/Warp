#
# Warp.ps1
#

# .\paket.bootstrapper.exe
.\paket.exe restore
# .\paket.exe install
.\paket.exe add nuget WebSharper project Warp
# .\paket.exe add nuget WebSharper.Warp project Warp
# The following only necessary when configuring the project the first time
# .\paket.exe add nuget FSharp.Compiler.Tools
