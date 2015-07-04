namespace Forte

open WebSharper
open WebSharper.JavaScript
open WebSharper.Sitelets
open WebSharper.Html.Server
open WebSharper.UI.Next
open WebSharper.UI.Next.Templating


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
                    Head = 
                         [
                            Link [Rel "stylesheet"; Type "text/css"; HRef "stylesheet.css"]
                         ], 
                    Body =
                        [
                            H1 [Text "Hello world from Warp!"]
                            "About" => Endpoints.About          
                        ]
              )   
              
            | Endpoints.About ->
                Warp.Page(
                    Head = 
                         [
                            Link [Rel "stylesheet"; Type "text/css"; HRef "stylesheet.css"]     
                         ],
                    Body =
                        [
                            P [Text "This is a simple apple"]
                            "Home" => Endpoints.Home
                        ]
                )
            )

    [<EntryPoint>]
    do Warp.RunAndWaitForInput(MySite) |> ignore
