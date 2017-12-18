open Lwt
open Dom_html
open Misc
open Engine

let i_am_poor_you_are_rich () =
  show
"\
I am poor and you are rich.\
What seems small to you is big for me.\
You know how to make a lot more money, I do not.\
You live. I am just trying to survive.\
"

let a_sad_story () =
  show
"\
I can tell you a story.
" >>= slowly >>= fun () ->
  show "A" >>= fun () ->
  emphasize " sad " >>= fun () ->
  show "one. " >>= normal >>= fun () ->
  show "Back in 2010, several of my friends told me about bitcoins." 
  >>= slowly >>= fun () ->
  show "They told me I should mine some coins. Just in case." >>= fun () ->
  emphasize " I did not listen to them. " >>= fast >>= fun () ->
  show "This was the biggest mistake of my life." 
  >>= normal >>= fun () ->
  show "Now, I am here, with almost nothing, begging for help." >>= fun () ->
  emphasize "I feel so guilty. This could have happened to you too."

let location () =
  Js.(to_string (Unsafe.eval_string "get_location ();"))

let threat () =
  show
"\
Let me just say this: I know where you live."
>>= fun () -> pause 1.5 >>= fun () -> show
"What? You do not believe me?"
>>= fun () -> pause 1.5 >>= fun () -> show
(Printf.sprintf "You live near %s. That was easy to know." (location ()))
>>= fun () -> pause 1.5 >>= fun () -> show
"Do not be afraid. I will not burn your home: \
I do not burn home of people that tip me."

let tell_a_joke () =
  show "I have stolen a joke from /r/bitcoin \
        since I cannot invent one by myself.
        Ready? Here it is."
>>= fun () -> pause 1. >>= fun () -> show (Jokes.next_joke ())

let in_the_meantime_btc_is_moving () =
  ""

let do_a_good_deed () =
  ""

let religious_reason () =
  ""

let take_pity_of_my_situation () =
  ""

let reasons =
  ref (shuffle [|
           (* i_am_poor_you_are_rich; *)
           (* a_sad_story; *)
           (* threat *)
           tell_a_joke;
           tell_a_joke;
           tell_a_joke;
           tell_a_joke;
           tell_a_joke;
         |])

let continuation_messages = [
    "Still not convinced?";
    "What? You want another reason?";
    "You are still there? Thank you for giving me another chance!";
    "No tip? Are you kidding me?";
    "Do you want to see my secret weapon?"
]

let rec push_reason () =
  match !reasons with
  | [] ->
     show
    "I have no more arguments. You won. \
     Maybe the fact that you won this battle is a good reason to tip me! \
     Do not be afraid of paradox!";
  | r :: rs ->
     reasons := rs;
     r () >>= fun () ->
     push_continuation_message ()

and push_continuation_message () =
  newline () >>= fun _ ->
  continue (pick_random_list_element continuation_messages) (fun () -> 
      newline () >>= fun _ ->
      push_reason ()
    )
