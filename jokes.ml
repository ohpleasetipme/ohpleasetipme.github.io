let jokes_data = [|
"What’s the difference between an average bitcoin miner and an average plumber?
 An average plumber can at least solve a block.";
"What’s the difference between Bitcoin and NASA?
 Bitcoin’s actually going to the moon.";
"Why won’t the government embrace bitcoin?
They hate the idea of a ‘Proof Of Work’.";
"How many miners does it take to change a lightbulb?
A million - One to do it and 999,999 to verify that he did.";
"What’s the difference between Mt Gox and marriage?
There’s still hope of recovering some of your coins after Gox";
"Why won’t the Icelandic government embrace bitcoin?
They don’t trust anything they can’t freeze.";
"What’s the difference between bitcoin and marriage?
 You only lose the house, kids and half your wealth when your marriage turns to shit.
I paid a hooker with bitcoins once and asked if I’d ever see her again.
She said sure, next week you’ll find me just a few blocks away.";
"In Bitcoin news the real Satoshi Namakoto was found and arrested this week.
He was charged with indecent exposure for revealing himself to a minor in the pool.
There were concerns that photo evidence in his trial would be deemed too \"cryptographic\" for public release.
Satoshi’s miraculous escape from his cell moments later was witnessed by at least 200 of his peers…
but is still yet to be confirmed.";
"What is an Irish cryptocurrency investor most worried about?
\"Forking Bitcoin!\"";
"Q. Why do Bitcoin cryptologists drive recklessly?
A. The chance of a collision is 1 in 3,675,829,765,987,568,478";
"A boy asked his bitcoin-investing father for $10.
Father: $9.82? What do you need $10.08 for?";
"How many Core devs does it take to change a light bulb?
None. They will just tell everyone that the risk of getting electrocuted while changing the bulb is too high, and that it's much safer to create a market for candles instead.";
"Yo momma's blocksize limit so small she neutered the largest cryptographic network on the planet!";
"Where does an Eskimo keep his Bitcoins? In a cold wallet.";
"Bitcoin jokes are not funny, unless at least 50% of readers laugh at them.";
"What's Satoshi's favorite brand of sneakers? ASICS";
"What's the difference between Elon Musk's SpaceX and Bitcoin?
SpaceX will actually return to earth, after takeoff...";
"I created a way to control your Bitcoin miner through the telephone keypad. To start mining, press Hash.";
"What do you call a bitcoin in the bathroom? Shitcoin";
"What do you call a teenage bitcoin? Zitcoin";
"What do you call a bitcoin in a cuspidor? Spitcoin";
"What do you call a bitcoin at the gym? Fitcoin";
"What do you call a bitcoin in a hole? Pitcoin";
"What do you call a bitcoin that poses for porn? Titcoin";
"What do you call a bitcoin that tells jokes? Witcoin"
              |]

let jokes = ref (Misc.shuffle jokes_data)

let rec next_joke () =
  match !jokes with
  | [] -> jokes := Misc.shuffle jokes_data; next_joke ()
  | j :: js -> jokes := js; j
