---
title: Adapting Emacs's vc diff for word-oriented diffs
description: Modifying vc-mode's diff to work better when soft-wrapping
toc: false
layout: post
categories: [emacs]
keywords: [hummingbirds]
---

A few years back, I changed how I work with text files (including LaTeX files) in Emacs: instead of using hard newlines to format paragraphs into lines, I use soft wrapping, and do not insert hard newlines except to break paragraphs.  This change was driven by the fact that, except for software development work, most modern editing environments (and most of what my colleagues send) assume soft-wrapped paragraphs.  This was an annoying change at first, but I worked out how to set up soft wrapping in Emacs so that I no longer really notice the difference.  However, one problem that remained involved the use of version control systems such as git: most of those systems are line-oriented by nature and they show differences in a line-oriented way by default.  The resulting diffs are basically unreadable if the source text does not contain hard line breaks.

Here is how I set up git and Emacs's standard *vc* version control package for word-oriented diffs.  I put the following code in my `.emacs` file.  First, make sure to load the `vc` Emacs package:

```emacs-lisp
(require 'vc)
```

Next, set `vc-git-diff-switches` to the following value to tell git to use word-oriented diffs instead of line-oriented diffs:

```emacs-lisp
(setq vc-git-diff-switches "--word-diff")
```

If you do the above, you'll get word oriented diffs from Emacs' `vc-diff`, but IMHO the format is very difficult to read: it's expressed as in-line text codes, with `{+ ...}` and `[- ... ]` markers inserted by git diff to indicate what has been added or removed between the two versions of a file.  These are hard for the human visual system to pick out quickly.  What you really want is to use color to distinguish changes.  I searched and found [someone else’s solution](https://gist.github.com/syohex/1521407) to colorize the diff output, but I couldn't get it to work well in my environment.  So, I rewrote it.  My version uses Emacs's advising functionality to modify Emacs' `vc-diff` function to edit the git diff output and colorize it using Emacs overlays.  The colors are set by the two variables `vc-diff-added-face` and `vc-diff-deleted-face`.  Here's the code:

```emacs-lisp
(make-face 'vc-diff-added-face)
(make-face 'vc-diff-deleted-face)
(set-face-background 'vc-diff-added-face "lawn green")
(set-face-background 'vc-diff-deleted-face "RosyBrown1")

(defadvice vc-diff (after vc-diff-advice last
                          activate compile)
  (save-window-excursion
    (with-current-buffer "*vc-diff*"
      (let ((inhibit-read-only t))
        (goto-char (point-min))
        (while (re-search-forward "\\({\\(\\+\\)\\|\\[\\(-\\)\\)" nil t)
          (let* ((front-start (match-beginning 0))
                 (front-end   (match-end 0))
                 (addition-p  (match-beginning 2))
                 back-start
                 back-end)
            (cond (addition-p
                   (re-search-forward "\\+}" nil t)
                   (setq back-start (match-beginning 0))
                   (setq back-end (match-end 0)))
                  (t
                   (re-search-forward "\\-\\]" nil t)
                   (setq back-start (match-beginning 0))
                   (setq back-end (match-end 0))))
            (if addition-p
                (overlay-put (make-overlay front-end back-start)
                             'face 'vc-diff-added-face)
              (overlay-put (make-overlay front-end back-start)
                           'face 'vc-diff-deleted-face))
            ;; Make sure to delete back-to-front, because the text will shift.
            (delete-region back-start back-end)
            (delete-region front-start front-end)
            (goto-char front-end)))
        (goto-char (point-min)) ))))
```

Here's an example of what the output looks like in an Emacs buffer.  You can see the effect is to color deletions in red and additions in green. 

This example uses code and not plain text, to demonstrate that the change does not make code diffs any worse. (And actually, I think the result is better for code diffs too.) The result is basically equivalent to what you would get with `git diff —color-words` in a terminal, but designed for Emacs.

By the way, I’m still using Aquamacs 2.x, which is based on Emacs 23, so while I *think* the code above should work in later versions of Emacs or Aquamacs, I have not tested it there.

If you find problems or improvements, please let me know!
