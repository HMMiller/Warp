
#r @"Paket.Core.dll"
open Paket

let dependencies = Dependencies.Locate(__SOURCE_DIRECTORY__)

dependencies.Add("WebSharper")
dependencies.Add("WebSharper.Warp")
dependencies.Add("WebSharper.D3")
dependencies.Add("WebSharper.UI.Next")
dependencies.Add("WebSharper.Sitelets")
dependencies.Add("WebSharper.HTML.Server")
dependencies.Add("Fsharp.Compiler.Tools")

Paket.NuGetConvert.replaceNugetWithPaket

dependencies.GetInstalledPackages()