open Lwt
open Dom_html
open Misc
open Engine

let i_am_poor_you_are_rich () =
  show
"\
I am poor and you are rich. \
What seems small to you is big for me. \
You know how to make a lot more money, I do not. \
You live. I am just trying to survive. \
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
I do not burn home of people that donate btc to me."

let tell_a_joke () =
  show "I have stolen a joke from /r/bitcoin \
        since I cannot invent one by myself.
        Ready? Here it is."
  >>= fun () -> pause 1. >>= fun () ->
                show ("\"" ^ Jokes.next_joke () ^ "\"" ^ " Funny, right?")

let you_won_money_so_give_me_some () =
  show "So you won some money thanks to me! If you had sell your bitcoins \
        instead of reading this beautiful website, you would have lost \
        a lot of money. I have got a point here, right?"

let you_lose_some_money_so_give_me_some () =
  show "That's probably a disapointment for you now that I tell you. \
        I could have distracted you from this loss but that would not \
        be entirely honest to ask you for money while knowing that you \
        just lost some in the meantime. Any reward for this gentle attention?"

let nothing_changed () =
  show "So you are as rich as before! Celebrate this with me!"

let bitcoin_price () =
  Js.(to_float (Unsafe.eval_string "get_btc_price ();"))

let initial_bitcoin_value =
  bitcoin_price ()

let bitcoin_value_now () =
  return (bitcoin_price ())

let in_the_meantime_btc_is_moving () =
  bitcoin_value_now () >>= fun now ->
  show
    (Printf.sprintf
       "By the way, when you arrived on that website page, BTC was worth $%f"
       initial_bitcoin_value)
  >>= fun () -> show (Printf.sprintf "and now its price is around $%f.\n" now)
  >>= fun () -> if initial_bitcoin_value = now then 
                  nothing_changed ()
                else if initial_bitcoin_value < now then
                  you_won_money_so_give_me_some ()
                else
                  you_lose_some_money_so_give_me_some ()

let do_a_good_deed () =
  show
"It is simple: doing a good deed is very important for your self-esteem.
 Since you are rich, it is now the time to take care of yourself. Self-esteem
 is one important aspect of self-caring. Let me help you!
"

let wikipedia_pascal_philosopher =
  "https://en.wikipedia.org/wiki/Blaise_Pascal"

let religious_reason () =
  show
    "If you are a religious person, charity is something you must do anyway.
     If you are not a religious person, let me introduce you to "
  >>= fun () -> link wikipedia_pascal_philosopher "Pascal's advice: "
  >>= fun () -> show "\
     just in case God exists, being charitable will help you in the after
     life while not being charitable will probably hurt you!
     "

let take_pity_of_my_situation () =
  show
    "Consider my situation, just a sec. I am making just enough money to pay \
     my rent and to provide basic needs for my two kids. If you tip me, I may \
     be able to offer some holidays to my daughter and to my son. They will \
     see the world! Do you picture them smiling? I do and I bet you do too. \
     So, please, tip me!"

let i_am_a_world_class_btc_beggar () =
  show
    "There people out there that try to be BTC beggars... Look
     for instance at "
  >>= fun () -> link "https://www.reddit.com/r/BitcoinBeggars/"
                  "this reddit group"
  >>= fun () ->  show ", "
  >>= fun () -> link "http://www.btcbeggar.org/questions.html"
                  "this website"
  >>= fun () -> show "or "
  >>= fun () -> link "http://cyberbeg.com/" "this one"
  >>= fun () -> show "These guys have no good argument, right? "
  >>= fun () -> show "Give me at least the pri[z|c]e for begin \
                      the best BTC beggar of the world! \
                      (And still very humble.)"

let i_can_give_you_a_gift () =
  show "Here is a gift." >>= fun () -> pause 2.
  >>= fun () -> show "Surprise!"
  >>= newline
  >>= fun () -> link "http://thecatapi.com"
        "<img src=\"http://thecatapi.com/api/images/get?format=src&type=gif\"
         />"
  >>= newline
  >>= fun () -> show
                  "I have been told that that kind of kitty is what people are \
                   looking for on the Internet. Let me do it for you!"

(* FIXME *)
let i_am_skilled_in_coding () =
  ""

let distance_to_christmas () =
  let days_to_christmas =
    int_of_string (Js.to_string (Js.Unsafe.eval_string ("to_christmas();")))
  in
  if days_to_christmas = 0 then
    "today!"
  else if days_to_christmas < 0 then
    (Printf.sprintf "was %d day%s ago. I can still feel its spirit, can't you?"
       (-days_to_christmas)) (if days_to_christmas = -1 then "" else "s")
  else
    (Printf.sprintf "is in %d day%s. Put me on your list!"
       days_to_christmas (if days_to_christmas = 1 then "" else "s"))

let it_is_christmas_season () =
  Printf.sprintf
    "Christmas is %s It is the right time to be generous and helpful!"
    (distance_to_christmas ())
  |> show

let honesty () =
  show
    "I am honest: I could have put a javascript coin miner on this page \
     but I did not. Being honest is the normal thing to do, and there is no \
     reward to be expected for that. Or maybe there is? Up to you!"

let reasons =
  ref (shuffle [|
           i_am_poor_you_are_rich;
           a_sad_story;
           threat;
           tell_a_joke;
           honesty;
           do_a_good_deed;
           religious_reason;
           take_pity_of_my_situation;
           it_is_christmas_season;
           i_can_give_you_a_gift;
           i_am_a_world_class_btc_beggar;
           in_the_meantime_btc_is_moving;
         |])

let continuation_messages = [
    "Still not convinced?";
    "What? You want another reason?";
    "You are still there? Thank you for giving me another chance!";
    "No tip? I am sorry to see that. What about a new try?";
    "Do you want to see my secret weapon?";
    "Getting more reasons to tip me is like an addiction for you now, right?";
    "Oh you are a tough one!"
]

let rec push_reason () =
  match !reasons with
  | [] ->
     show
    "Well. OK. I have no more arguments. You won.
     Your resistance is impressive.
     Maybe the fact that you won this battle is a good reason to tip me:
     you must celebrate!
     Do not be afraid of paradoxes! They make life so funny!";
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
