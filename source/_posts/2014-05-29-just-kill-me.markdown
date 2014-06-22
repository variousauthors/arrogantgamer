---
layout: post
title: "Just Kill Me"
date: 2014-05-29 23:12:05 -0700
published: false
comments: true
subtitle: "I've got beef."
categories: ["Game Design"]
---

A while back I played Kinetectonic and Watch Your Step, two excellent entries in the
29th Ludum Dare. While playing both these games, I had a strange nagging feeling.
These are two great games that have RPG elements... but really shouldn't.

<!-- more -->

Arcade games are rad. They can be fun for a variety of reasons: they can be fast paced,
or brutally difficult, or colourful, or tricky, or competitive. They all share
one important element of play: skill building. When I make it onto a new leaderboard, or
manage to fight my way up a spot on an old leaderboard, I feel great. Arcade games may
not be the greatest or most productive way to spend time, but they are
inarguably compelling, and timeless.

Faif and Kinetectonic are somewhat abstract puzzle games. In Kinetectonic you pull columns
of sprites out of the ground, and then break them to unlock coins and treasure. Some of the
sprites represent evil, and do damage to you, others heal you. There are four diamonds buried
beneath the ground, and the game is over when you have dug them up. There is a large
element of randomness, because the configuration of columns is different every time and may
offer more or less access to diamonds. On the other hand, the "high score" metric is not
diamonds, it is the number of times you've pulled.

In Faif you are presented an enemy and a randomly generated board of symbols. These symbols
represent the actions you can take in the game: attack, heal, and penalty. There is also a
meta game currency, again diamonds. Each turn you choose five contiguous symbols, and one
of them is randomly selected as your action for the turn. Players are able to customize they
play-style, take risks, or play it safe, and the whole game really does feel like a careful
fencing game.

There are elements of skill and learning to both of these games, and I was looking forward
to developing these skills and leaving my mark on a leaderboard. Instead, both these games
use their meta-game currency to make the game easier and easier. Ultimately, they play a
lot like [Sophie Houldon][1]'s [The Linear RPG][2]. This wasn't
the first time I'd played a game like that -- one which devours its own skill
elements -- but this time I understood the problem and thought I should write a few

It can be super cool to splash RPG elements into your game, or include a meta-game currency.
It is instantly compelling!
I loved [Battlefield 2142][10], probably more than I should have, because the ability to unlock and customize my gear
made me feel like I was playing a role. I was the long-range sniper: my targets were
barely visible through the fog and snow, and I almost always missed. I was more invested in
that game than I've been in any other FPS. Similarly, Innomin's [Fear Less][7] openned up
the runner genre for me by adding just enough of a "level-up" element to get me hooked.
People love the feeling of unlocking upgrades, and customizing their character. Does every
game need this? What if this one hyper-appealing gameplay element starts to over-shadow
what your game is actually about?

Splashing the RPG elements can also be the "easy way out" of balancing your arcade title.
You don't have to decide on a reasonable difficulty curve, because the player will buy upgrades
until they feel like a power house, regardless of their skill at the game. Faif is straight
up impossible out of the box. There is no way anyone is going anywhere in that game without
their upgrades. Kinetectonic, on the other hand, can be played without upgrades. My high-score
is 50 laps and 2 diamonds sans-upgrades.

An RPG can get away with gradually getting easier. If the story is compelling and the challenge slopes are well tuned,
no one notices that the element of skill is an illusion. In an arcade game, this
bluff is immediately evident. Anyone who decides to play Kinetectonic
right through to the end will succeed. It is only a matter of time and interest.
Players are allowed to coast through the game; if you had trouble in your last
run, don't worry, it will be easier next time. What is the point in empowering the
player to "coast" through an arcade title? Is there something special at the end
of your arcade game that you just needed to show people? Why not put that at the beginning?

If you are making an arcade game, and you decide to add RPG-like elements, please
please please make sure they don't work directly against the skill-based elements.
Don't let the player keep their upgrades after they die, unless those
upgrades are orthogonal to the skill-based gameplay elements. [Doug Cowley][3]'s [Hoplite][4]
does a great job of this: the player gradually unlocks a variety of cool upgrades that must still
be earned on every run. This gives you the ability to customize your character in
each run, but doesn't result in the game getting easier and easier.

Just ask yourself "what was my goal". Faif is not "about" progressing
through the levels and finding more and more interesting characters or plot-points.
It is about gambling and fighting, and the sweet look and feel.
Making the player wade through the easy parts again and again, as they get easier and
easier... is just bad design. In Kinetectonic, after grinding upgrades for a while,
I can totally get those 4 diamonds every time... but why? What was your goal?
Is getting those diamonds so important that you have to force every player to get them?
Don't be afraid to kill the player.

(EDIT: [Faif has multiplayer now][9], so all is forgiven)

[0]: http://www.newgrounds.com/portal/view/638343
[1]: https://twitter.com/S0phieH
[2]: http://www.sophiehoulden.com/games/thelinearrpg/
[3]: https://twitter.com/MagmaFortress
[4]: http://www.magmafortress.com/p/hoplite.html
[5]: http://www.ludumdare.com/compo/ludum-dare-29/?action=preview&uid=4232
[6]: http://www.beavl.com/faif/
[7]: http://www.newgrounds.com/portal/view/619262
[8]: https://twitter.com/BeavlGames
[9]: https://twitter.com/BeavlGames/status/477570936477343744
[10]: http://www.battlefield.com/battlefield-2142
