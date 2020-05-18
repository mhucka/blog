---
title: Git prepare-commit-msg hook for running Python pep8
description: Setting up a code style check
toc: false
layout: post
categories: [software-development]
keywords: [git]
---

Code style guidelines are important for enabling [collective code ownership](http://agileinaflash.blogspot.com/2009/02/collective-code-ownership.html):

> “[T]he team adopts a single style so that they can freely work on any part of the system. They don't have to obey personal standards when visiting "another person's" code (silly idea, that). They don't have to keep more than one group of editor settings. They don't have to argue over K&R bracing or ANSI, they don't have to worry about whether they need a prefix or suffix wart. They can just work. When silly issues are out of the way, more important ones take their place.” — Tim Ottinger and Jeff Langr

It’s sometimes hard to stick to a consistent style, though, especially when you’re switching from one project to another, each with their own collaborators and possibly different styles.  One way to help code follow guidelines is to automatically format code (for instance, upon check-in, or on some regular interval), but in my opinion, this is too dictatorial; moreover, there are legitimate cases were you want to format the code in a certain way so that the reader can understand it better, and doing that may break the coding guidelines. Such custom formatting would get obliterated by auto-formatting the code.

Instead, I prefer the idea of running code through format checkers that _inform_ you when the code breaks conventions (whatever your conventions are) but _does not change_ the code for you. This helps you by pointing out where you might have unintentionally strayed from your project’s conventions, yet doesn’t destroy carefully-constructed parts of the code that knowingly do not follow the conventions.

When using git, you can achieve this by taking advantage of its _prepare-commit-msg_ hook system. For a Python project I’m involved with, I developed a short script that runs [pep8](http://pep8.readthedocs.org/en/latest/), a Python code checker.  The hook script runs `pep8` on Python files that are about to be committed.  If `pep8` reports anything, the report is inserted as comments into the commit message template.  The person about to commit code will see the comments and can correct the issues before they continue with the commit.

This approach was the best that I could come up with in order to handle the following situation: if you use an editor like Emacs, and your commit message is thrown into an editing buffer, _you may not see messages printed on stdout or stderr by the git commit command_.  By putting the pep8 output into the commit message template, it helps ensure you see it before committing.

To use it, first copy the [script from my GitHub repository](https://github.com/mhucka/small-scripts/blob/master/git-scripts/python.prepare-commit-msg) to some location in _your_ git repository that you use for developer scripts or tools. Next, look inside the script for the following line near the top,

```
IGNORE=E221,E226,E241,E303,E501
```

and modify the values to fit your project's coding conventions. See [the pep8 documentation](http://pep8.readthedocs.org/en/latest/intro.html#error-codes) for an explanation of the codes.  The settings in my copy of the script reflect my personal preferences; your project’s conventions may differ, so make sure to adjust this as you see fit. (And it goes without saying that everyone in a project needs to use the same settings.)

Finally, to use it on a project, every member of your project needs to do the following:

1. copy the script to the `.git/hooks/` subdirectory of their local git repository
2. rename the script to `prepare-commit-msg`
3. make it executable (`chmod +x` on the file)

(The reason every person needs to do this individually is that git hooks are only run in a user’s local repository.) The code assumes that `pep8` is installed on the user’s computer. If that’s not the case, then make sure everyone also downloads and installs it on their computers.

If you have improvements to this or a better way to do it entirely, please do let me know.
