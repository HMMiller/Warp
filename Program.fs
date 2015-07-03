namespace Forte

open WebSharper
open WebSharper.Sitelets
open WebSharper.Html.Server

module Warp =
    
    type Endpoints = 
        | [<EndPoint "GET /">] Home
        | [<EndPoint "GET /about">] About

    let MySite =
        Warp.CreateApplication (fun ctx endpoint ->
            let (=>) label endpoint = A [HRef (ctx.Link endpoint)] -< [Text label]
            match endpoint with
            | Endpoints.Home ->
                Warp.Page(
                    Body =
                        [
                            H1 [Text "Hello world!"]
                            "About" => Endpoints.About
                        
                        ]
                 )
            |Endpoints.About ->
                Warp.Page(
                    Body =
                        [
                            P [Text "This is a simple app"]
                            "Home" => Endpoints.Home
                        ]
                )
            )

    [<EntryPoint>]
    do Warp.RunAndWaitForInput(MySite) |> ignore
