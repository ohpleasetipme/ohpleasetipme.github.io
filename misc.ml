let _ = Random.self_init ()

let shuffle a =
  let n = Array.length a in
  Array.iteri (fun i x ->
      let j = Random.int n in
      let tmp = a.(j) in
      a.(j) <- x;
      a.(i) <- tmp
    ) a;
  Array.to_list a

let pick_random_list_element l = List.(nth l (Random.int (length l)))

let split c s =
  let words = ref [] in
  let accu = Buffer.create 13 in
  let flush () = 
    Buffer.add_char accu ' ';
    words := (Buffer.contents accu) :: !words;
    Buffer.clear accu
  in
  for i = 0 to String.length s - 1 do
    if s.[i] = c then flush () else Buffer.add_char accu s.[i]
  done;
  flush ();
  List.rev !words
