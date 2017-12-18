open Lwt
open Dom_html
open Misc
open Engine
open Reasons

let main =
  Dom_html.window##.onload :=
    Dom_html.handler (fun _ ->
        async (fun () ->
            newline () >>= fun _ ->
            continue "Don't you want to know why you should?" push_reason 
            >>= fun () -> newline () >>= fun _ ->
            loop ());
        Js._false)
