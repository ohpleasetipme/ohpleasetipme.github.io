open Lwt
open Dom_html

let pace = ref 0.1

let slowly () = return (pace := 0.5)

let normal () = return (pace := 0.1)

let fast () = return (pace := 0.07)

type style =
  | Normal
  | Emphasize

let class_of_style = function
  | Normal -> "talk"
  | Emphasize -> "talk emph"

type atom =
  | Msg of style * string
  | Link of string * string
  | Elt of Dom_html.element Js.t

let push ?onclick atom =
  let elt = getElementById "content" in
  let msg_elt =
    match atom with
        | Msg (style, msg) ->
           begin match onclick with
           | None ->
              let span = createSpan document in
              span##.innerHTML := Js.string msg;
              span##.className := Js.string (class_of_style style);
              (span :> Dom.node Js.t)
           | Some onclick ->
              let a = createA document in
              let cb = fun _ -> (async onclick; Js._false) in
              a##.onclick := Dom_html.handler cb;
              a##.innerHTML := Js.string msg;
              a##.className := Js.string "talk clickme";
              (a :> Dom.node Js.t)
           end
        | Link (url, caption) ->
           let a = createA document in
           a##.href := Js.string url;
           a##.innerHTML := Js.string caption;
           (a :> Dom.node Js.t)
        | Elt e -> (e :> Dom.node Js.t)
  in
  Lwt_js.sleep !pace >>= fun () -> 
  ignore (elt##appendChild msg_elt);
  ignore (Js.Unsafe.eval_string ("sync_scroll ();"));
  return ()

type command =
  | Continuation of string * (unit -> unit Lwt.t)
  | Show of string
  | ShowLink of string * string
  | NewLine

let queue = Queue.create ()

let push_word ?(style=Normal) w =
  push (Msg (style, w))

let push_typing text =
  let words = Misc.split ' ' text in
  Lwt_list.iter_s push_word words

let emphasize text =
  push (Msg (Emphasize, text))

let pause duration =
  pace := duration;
  push (Msg (Normal, "")) >>= normal

let rec produce_text () =
  if not (Queue.is_empty queue) then (
    begin match Queue.pop queue with
    | Show text -> push_typing text
    | Continuation (text, k) -> push ~onclick:k (Msg (Normal, text))
    | NewLine -> push (Elt (createBr document))
    | ShowLink (url, caption) -> push (Link (url, caption))
    end >>= produce_text
  ) else return ()

let push x =
  Queue.push x queue;
  produce_text ()

let continue text reason = push (Continuation (text, reason))
let show text = push (Show text)
let newline () = push NewLine
let link url caption = push (ShowLink (url, caption))
let loop = produce_text
