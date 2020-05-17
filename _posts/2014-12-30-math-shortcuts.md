---
title: Math shortcuts for the LaTeX-inclined
description: A tip for how to type LaTeX math symbols anywhere by using Unicode characters
toc: false
layout: post
categories: [latex, efficiency-hacks]
keywords: []
---

When writing technical notes, you sometimes need to write mathematical symbols and expressions.  Most technical people who come from a math or computer science background learn how to write math expressions in TeX or LaTeX, but when writing in something *other* than a TeX/LaTeX-enabled application (say, a note-taking program like [Evernote](http://evernote.com)), you may not have direct access to TeX/LaTeX and you many not want to paste an image like something produced by [LaTeXiT](http://www.chachatelier.fr/latexit/).

I want to share an approach to easily typing many mathematical symbols using the *same* command sequences you would use for TeX or LaTeX documents—but *without* actually using TeX/LaTeX.  The approach is completely keyboard driven (no mousing around) and conceptually simple: use a text expansion program to define text abbreviations that are exactly the LaTeX commands for mathematical symbols, and make the abbreviations expand to those symbols when triggered.  This way, you don't need to learn different shortcuts or abbreviations, and it works in any application where you can type symbol characters (which on the Mac, is nearly everywhere). You can define the abbreviations with a text expansion program such as [TextExpander](http://smilesoftware.com/TextExpander/index.html), or a program such as [KeyboardMaestro](http://www.keyboardmaestro.com/main/) that offers this facility.  (The latter is what I actually use, because I already use KeyboardMaestro for other things and didn't want to run yet another background program—I have too many things running on my Mac already.)

In more detail, here is how to set it up:

<figure class="float-right width-33">
  <img src="/images/keyboard-maestro-latex-symbols.jpg"/>
</figure>

1. In text expansion program, define a group for the abbreviations.  In KeyboardMaestro (and I am sure in Textpander too), groups of abbreviations can be toggled active/inactive via a keyboard shortcut.  I use the sequence `command-option-control-'` (that's a normal single quote at the end), which is a key sequence that's easy to type and that I don't use for anything else.  The first press of that key combination activates the abbreviations group, and a second press deactivates it. 
2. Within that group of abbreviations, define shortcuts for all of the LaTeX symbols and other things that you want to use.  In KeyboardMaestro, this requires defining an abbreviation that inserts text, and the text to be inserted is the symbol that the LaTeX command represents.  So in other words, define `\alpha` to insert the character "α", define `\beta` to insert the character "β", and so on, all the way through to special symbols such as `\cup` for "∪" (set intersection), `\cap` for "∩" (set union), `\sum` for "∑", and so on. For Greek letters, I use capitalized names for the capitalized variants of the letters: `\omega` for ω and `\Omega` for Ω, etc.
3. When you want to access the symbols while writing, activate the abbreviations group using the keyboard shortcut you use (`command-option-control-'` in my case), then proceed to write things like `"P(A \cap B) = P(A)P(B)"` (which is what you would type when using LaTeX) and have it instantly turn into more readable text such as *"P(A ∩ B) = P(A)P(B)"* without actually running LaTeX (or having to click around in the Mac OS X "Special Character..." palette, or do other things).

You may wonder about the need for defining a keyboard sequence for toggling the active status of the abbreviations group.  You need that because otherwise, when you actually *did* want to write a LaTeX document, it would be impossible unless you could turn off the abbreviations!  So, you want to be able to toggle them on and off easily.

This approach does have its limitations, of course. The most significant is that it does not let you write full mathematical formulas.  Nonetheless, I personally find that for many things this scheme gets me very far.  I often combine this approach with [LaTeXiT](http://www.chachatelier.fr/latexit/) for bigger equations, and use this scheme for writing intermediate text, such as explanatory text that refers *to* the symbols in the equations created in LaTeXiT.  More often, I just need to write notes about something and only need to use a Greek letter or a very short expression, for which the full power of LaTeXiT is overkill.  Oh, I suppose if I could remember the Mac keyboard shortcuts for Greek letters and *if* they didn't *interfere* with other shortcuts that I've defined in [QuicKeys](http://startly.com/products/quickeys/mac/4/) or KeyboardMaestro, then I could just use them.  However, I find it easier to use the notation I already know (namely, LaTeX) than to learn new keyboard shorcuts.

Final bonus benefit: if you don't know the LaTeX sequences for various symbols, this approach also helps you learn them by giving you more opportunities to practice their use.
