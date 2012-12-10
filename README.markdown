# PHP Ternary Operator in Ruby

## Rather uninteresting backstory

So after the [Manchester Raspberry Jam 7][jam] in December 2012, a few people hung around in [Common][common] after, and [@JackWeardy][jack] showed us this image:

![Go home, PHP, you're drunk][image]

(Presumably it's from the [Imgur link][imgur] in this [App.net post][post]). As I'm currently working through [Language Implementation Patterns][book] I thought... I can do that!

Turns out I couldn't.

## Implementing the operator

I attempted the solution using [Treetop][treetop], the Ruby library for [Parsing Expression Grammars][peg]. I'm currently only partly familiar with PEGs - I've only been using them a few days.

The basic form of the terary is quite easy:

    condition ? value_if_true : value_if_false

The example from the image looks like this:

	TRUE ? "a" : TRUE ? "b" : "c"

Which (if you squint at it) you'll realise PHP must be interpreting like this...

    (TRUE ? "a" : TRUE) ? "b" : "c"

... not this ...

    TRUE ? ("a" : TRUE ? "b" : "c")

... which is how you'd expect any sane language to see it.

The problem with implementing this with a PEG is that the obvious description of the grammar is _left-recursive_:

    ternary: (ternary / value) "?" value : value

A PEG can't parse this becase left-recursion without consuming any characters creates an infinite loop. I read quite a lot of examples of how to make this right-recursive, but the one that finally made the penny drop was [this arithmetic grammar][arithmetic].

Thus was born my Ruby / Treetop implementation of the PHP ternary operator, in all it's insane glory.

The RSpec examples contain a nested nested ternary operator:

    'TRUE ? "a" : TRUE ? "b" : TRUE ? "c" : "d"'

I'd love to test how this behaves in a real interpreter, but I don't have PHP installed.

[jam]: http://madlab.org.uk/content/manchester-raspberry-jam-7/
[common]: http://www.aplacecalledcommon.co.uk/
[jack]: https://twitter.com/JackWeirdy
[image]: img/php_ternary.png "Go home, PHP, you're drunk"
[post]: https://alpha.app.net/wildpeaks/post/1667694
[imgur]: http://i.imgur.com/aAY28.png
[book]: http://pragprog.com/book/tpdsl/language-implementation-patterns
[treetop]: http://treetop.rubyforge.org/
[peg]: http://en.wikipedia.org/wiki/Parsing_expression_grammar
[arithmetic]: http://stackoverflow.com/questions/6629397/help-with-left-factoring-a-grammar-to-remove-left-recursion/6629610