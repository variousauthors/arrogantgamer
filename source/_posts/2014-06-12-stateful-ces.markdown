---
layout: post
title: "State Machines + CES"
thumb: "quintus.png"
date: 2014-06-12 09:28:35 -0700
comments: true
published: false
categories: ["Prorgamming", "indie3", "Gamedev", "Darkest Path"]
subtitle: "This is my new jam."
---

Indie3 is here, and since I didn't have enough time to make a game I decided
to instead experiment with a new style of programming. My goal here is to better
manage the complexity of larger projects. This is a long boring post, and you
probably won't learn anything ^o^//

<!-- more -->

My first language, back in 2008, was Ruby. Because I learned to program in
Ruby, everything I did was object oriented by default. I actually had to
unlearn things in the first year of college, in order to be able to finish
simple assignments on time. Later, in my career as a web developer, I fell
deeper and deeper in love with javascript and the power and expressiveness
of functional programming.

Being an object oriented programmer raised by a pack of wild functional
principals means that I think I can solve every problem with some combination
of closures and callbacks (with a healthy side of promises and debounce). I
write a kind of pseudo object oriented mash, and it ends up looking like this:

{% codeblock class:half-width lang:javascript a vector is a point, right? %}
/* This is what I've come to call a "module" */
var Vector = function Vector (x, y) {
    var getX = function getX () {
            return x;
        },

        getY = function getY () {
            return y;
        };

    return {
        getX: getX,
        getY: getY
    }
}

var bob = Vector(0, 0);
console.log(bob.getX()); // logs 0

{% endcodeblock %}

Maybe you've programmed in javascript before and you know what
closures are and what this code does. The advantage that
I see here, the reason I've gravitated towards this style, is
that I can still cleave to encapsulation and the API pattern
(which is what my heart wants) but I don't have to muck about
with someone's ridiculous broken implementation of object
orientation. Instead I get to force everyone else to muck
about with mine. ^o^// It is also really easy to compose modules,
without too much pain.

Over the last months I had been shopping for a game development
framework. I tried
Quintus, and was about to give another JS framework a try when
I noticed LOVE2D. Love forced me to learn Lua, but it turns out
that's not so tricky. Lua has closures, and I can basically
do all the same things I do in javascript.

{% codeblock class:half-width-left lang:lua and again in lua %}
-- Lua doesn't have comment blocks
local Vector = function (x, y)
    local getX = function ()
        return x
    end

    local getY = function () {
        return y
    end

    return {
        getX = getX,
        getY = getY
    }
end

local bob = Vector(0, 0);
print(bob.getX()); // prints 0

{% endcodeblock %}

Having a style is good. It means that when you sit down
and say "hmm, I need a vector" you don't have to think too
hard to get it done. This is important when you are a hobby
gamedev (or any dev I guess) because time is in short supply.
You want your code to flow from your fingers into comfortable
configurations that you understand. This is what patterns are
for.

Super Plumber Bros is a beast. It is brimming with comfortable
configurations that have just been mashed together in an endless
sea of control statements. It is the biggest game I've written,
and the first engine I've created. There is a lot wrong with
it, but a big part of getting better is retrospection and post
mortem thinking. Clearly there were problems with the original
collision detection: if you compare the LD29 version with the
post-compo version you will feel the difference right away. That's
well and good, and I kind of thought that "better collision" was
my big take-away from SPB. I only saw the real take away recently,
when I started working on The Darkest Path.


{% codeblock class:half-width lang:lua and again in lua %}
Level = function (tmx, options)
    local map = Map(tmx)

    map.setName(options.name)
    map.setItem(options.item)
    map.setEvents(options.doors)
    map.setOrigin(options.origin, options.start)

    map.setDeathHandler(function ()
        map.setFinished(true)

        map.setProceedHandler(function ()

            -- nop because we want to change worlds
        end)
    end)

    map.setVictoryHandler(function ()
        map.setFinished(true)
        map.resetTimer()

        map.setProceedHandler(function ()
            -- you aren't finished here mario...
            map.setFinished(false)

            map.glitch(options.glitches)
        end)
    end)

    map.sprite = options.sprite
    map.scenes = options.scenes

    return map
end
{% endcodeblock %}

A huge pain point in SPB was state transitions. At first it was
easy: Mario dies, queue the next level. Each map has a callback
that gets called when mario encounters something that will kill
him, and the callback sets up the state of the map object so that
it can help the game decide what to do next. Done! The levels are
modules that mainly just set up an instance of the Map module,
so that different levels can treat death and victory differently.
At first this was great! Lovely elegant code (I mean, um... in my
opinion).

The problem is that this didn't grow well, and it didn't play
well with other bits of code. The "proceed handler" gets called
in the update loop, and the code that relies on it is a mess.
The `main.lua` became this crowded, messy nightmare... and I dreaded
every new change. When we considered adding the GameJolt API
integration, one of my main concerns was just "how the hell are
we going to implement a menu that shows before the game?" It
turned out not to be too difficult to get that in there... but
it just made the code bigger and bloatier, and harder to understand,
and more frightening. I mean, every time I add something the fear
barrier grows thicker. At some point, I just won't be able to
add anything new!
I won't put any code from `main.lua` directly in this post, but
if you want to check it out, you can do so [here][0].

When I started working on The Darkest Path, I remembered that
pain and dread. I think that's the best part about bad code:
the pain stays with you and encourages you not to end up in
that same, tangles place. I came up with a new strategy for
handling the coordination of the game's state: a finite state
machine!

{% codeblock class:half-width lang:lua darkest_path/main.lua %}
state_machine.addState({
    name       = "run",
    init       = function ()
        game.init(score_band)
    end,
    draw       = function ()
        game.draw()
        score_band.draw()
    end,
    update     = game.update,
    keypressed = game.keypressed
})

state_machine.addState({
    name       = "start",
    draw       = function ()
        love.graphics.printf("TITLE SCREEN", -10, W_HEIGHT / 2 - global.tile_size * 5.5, W_WIDTH, "center")
    end,
    keypressed = function (key)
        menu.choice = key
    end
})

state_machine.addState({
    name       = "stop",
    draw       = function ()
        love.graphics.printf("WAT", -10, W_HEIGHT / 2 - global.tile_size * 5.5, W_WIDTH, "center")
    end,
})

-- start the game when the player chooses a menu option
state_machine.addTransition({
    from      = "start",
    to        = "run",
    condition = function ()
        return menu.choice ~= nil
    end
})

-- reset the game if there is a winner
state_machine.addTransition({
    from      = "run",
    to        = "win",
    condition = function ()
        return game.getWinner() ~= nil
    end
})
{% endcodeblock %}

Each "part" of the game is represented as a state, and the code
that runs in that state. To move between states, there are transition
functions that monitor variables. No nested control statements,
no complex conditions. This turned out to be really nice.
The code in that `main.lua` file
is much easier to read, and it is almost declarative. It got me
thinking about a programming paradigm I had previously read about,
but never tried.

This year indiE3 falls in the middle of a particularly busy week, so
I knew I wouldn't have time to write a full game. Instead I figured
I should take the opportunity to experiment with weaving together
this state-machine pattern and the Component Entity System programming
paradigm.

Now, as a terrible programmer, I'm not going to go do research about
CES. I'm just going to go by "feels". I highly recommend this technique.

My understanding is that I should have a table of "Entities", which
are not objects but are really just tables of "Components". Each component
is just a collection of data with a theme. For example, and entity
might have "position" and "player_controlled" as well as "collision"
components. The position component might just have an x, y coordinate
pair. The collision component might just have a flag to mark whether
the entity tried to update its position, and maybe an x,y pair for
the old position. Just data; no functions. Probably components should
be implemented as modules, but for now I'm just using plain tables.

The components serve a second purpose: they flag the entity as one
that wants to participate in certain Systems. For example, the
Collision system might act on every entity that declares a collision
component. The PlayerControl system will react to keypresses by
updating the x, y position component of every entity that declares
a player_control component.

This is where the FSM comes in: if the collision system and the player
control system are both active in a given state... then the player will
be able to control their avatar, and bump into walls.

That's my understanding! Systems are functions that are allowed to
iterate over the Entity table, looking for entities that declare
a particular set of Components. The system then runs for each such
entity (or for all of them together) and adjusts the data in the
relevant components. This blends really well with the state machine
pattern I described above, because it means we can reduce the above
code to this:

{% codeblock class:half-width lang:lua declarative code rocks %}

state_machine = FSM()

state_machine.addState({
    name       = "run",
    systems = {
        "Game",
        "ScoreBand"
    }
})

state_machine.addState({
    name       = "start",
    systems    = {
        "TitleScreen"
    }
})

state_machine.addState({
    name       = "stop",
    systems    = {
        "EndScreen"
    }
})

-- start the game when the player chooses a menu option
state_machine.addTransition({
    from      = "start",
    to        = "run",
    condition = function ()
        return menu.choice ~= nil
    end
})

-- reset the game if there is a winner
state_machine.addTransition({
    from      = "run",
    to        = "win",
    condition = function ()
        return game.getWinner() ~= nil
    end
})

love.update     = state_machine.update
love.keypressed = state_machine.keypressed
love.draw       = state_machine.draw

state_machine.start()
{% endcodeblock %}

Early on in my Ruby career I read (in some rspec book?) that we
should always try to "write the code we wish we had". That is,
instead of starting from the small pieces and building up, we
should start by writing a file at the highest possible level that
relies on imaginary code that we don't have. After working on
a full game, after experiencing the nightmare of working with
all those tangled control statements, this is how I would like
to write code. I haven't actually written it yet ^o^//

At the time of this writing, I'm relatively far along with this
experiment. There are still a bunch of questions, though. I mean
for example, what happens if one system wants to affect another?
How about adding or removing components from entities? What
sorts of indexing should I perform on the entities table to keep
lookups from growing too costly? These are all considerations
that I didn't think of at the start, but I'm definitely well on
my way to having a mental framework to guide my decisions when
making more and bigger games.

[0]: https://github.com/variousauthors/LD29/blob/master/main.lua

