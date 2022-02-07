#|

CS 2800 Homework 2 - Spring 2022

This homework is done in groups. 

 * Groups should consist of 2-3 people.

 * All students should register their group for the class in Canvas by
   following these steps :
   - Click on People in the left hand menu
   - Click on Groups tab
   - Click on + Group button
   - Invite your group members
   Please do not accept invitations from multiple groups.

 * Students should set up their group on Canvas by EOD January 28.
   Use the piazza "search for teammates" post to find teammates.

 * Submit the homework file (this file) on Gradescope. Every group
   member can submit the homework and we will only grade the last
   submission. You are responsible for making sure that your group
   submits the right version of the homework for your final
   submission. We suggest you submit early and often. Also, you will
   get feedback on some problems when you submit. 

 * When submitting on Gradescope, after you have clicked "Upload",
   make sure to add your group members to the submission by clicking
   on "Add Group Member" and then filling their names. Submission will
   be enabled typically only after labs, but well before the deadline.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm team membership with Canvas groups.
   If you fail to follow these instructions, it costs us
   time and it will cost you points, so please read carefully.

The format should be: FirstName1 LastName1, FirstName2 LastName2, ...

For example:
Names of ALL group members: Frank Sinatra, Billy Holiday

There will be a 10 pt penalty if your names do not follow this format.

Replace "..." below with the names as explained above.

Names of ALL group members: ...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 For this homework you will need to use ACL2s.

 Technical instructions:

 - Open this file in ACL2s as hwk02.lisp

 - Make sure you are in ACL2s mode. This is essential! Note that you can
   only change the mode when the session is not running, so set the correct
   mode before starting the session.

 - Insert your solutions into this file where indicated (usually as "...")

 - Only add to the file. Do not remove or comment out anything pre-existing.

 - Make sure the entire file is accepted by ACL2s. In particular, there must
   be no "..." left in the code. If you don't finish all problems, comment
   the unfinished ones out. Comments should also be used for any English
   text that you may add. This file already contains many comments, so you
   can see what the syntax is.

 - When done, save your file and submit it as hwk01.lisp

 - Do not submit the session file (which shows your interaction with the theorem
   prover). This is not part of your solution. Only submit the lisp file.

 Instructions for programming problems:

 For each function definition, you must provide both contracts and a body.

 You must also ALWAYS supply your own tests. This is in addition to the
 tests sometimes provided. Make sure you produce sufficiently many new test
 cases. This means: cover at least the possible scenarios according to the
 data definitions of the involved types. For example, a function taking two
 lists should have at least 4 tests: all combinations of each list being
 empty and non-empty.

 Beyond that, the number of tests should reflect the difficulty of the
 function. For very simple ones, the above coverage of the data definition
 cases may be sufficient. For complex functions with numerical output, you
 want to test whether it produces the correct output on a reasonable
 number of inputs.

 Use good judgment. For unreasonably few test cases we will deduct points.

 We will use ACL2s' check= function for tests. This is a two-argument
 function that rejects two inputs that do not evaluate equal. You can think
 of check= roughly as defined like this:

 (definec check= (x :all y :all) :bool
   :input-contract (equal x y)
   :output-contract (== (check= x y) t)
   t)

 That is, check= only accepts two inputs with equal value. For such inputs, t
 (or "pass") is returned. For other inputs, you get an error. If any
 check= test in your file does not pass, your file will be rejected.

 You can use any types, functions and macros listed on the ACL2s
 Language Reference (from class Webpage, click on "Lectures and Notes"
 and then on "ACL2s Language Reference").

 Since this is our first programming exercise, we will simplify the
 interaction with ACL2s somewhat. Instead of requiring ACL2s to prove
 termination and contracts, we allow ACL2s to proceed even if a proof
 fails.  However, if a counterexample is found, ACL2s will report it.
 See the lecture notes for more information.  This is achieved using
 the following directives (do not remove them):

|#

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)

; This directive forces ACL2s to generate contract theorems that
; correspond to what we describe in the lecture notes.

(set-defunc-generalize-contract-thm nil)

#|
Define the function rl.
rl: TL x Nat -> TL

(rl l n) rotates the true list (TL) l to the left n times.

Hint: We defined this in class.
|#

(definec rl (l :tl n :nat) :tl
  ...)

(check= (rl '(1 2 3) 1) '(2 3 1))
(check= (rl '(1 2 3) 2) '(3 1 2))
(check= (rl '(1 2 3) 3) '(1 2 3))

#|
Define the function erl, an efficient version of rl.
erl: TL x Nat -> TL

(erl l n) returns the list obtained by rotating l to the left n times
but it does this efficiently because it actually never rotates more than
(len l) times.

|#

(definec erl ...
  ...)

(check= (erl '(1 2 3) 1) '(2 3 1))
(check= (erl '(1 2 3) 2) '(3 1 2))
(check= (erl '(1 2 3) 3) '(1 2 3))

#|
Make sure that erl is efficient by timing it with a large n
and comparing the time with rl.

Replace the ...'s below with the times you observed.  |#

(time$ (rl  '(a b c d e f g) 10000000))
; The amount of time the above form takes on your machine.
(defconst *rl-time* ...)

(time$ (erl '(a b c d e f g) 10000000))
; The amount of time the above form takes on your machine.
(defconst *erl-time* ...)


#|
Define the function rr.
rr: TL x Nat -> TL

(rr l n) rotates the true list (TL) l to the right n times.

You must use rl to define rr. You can use any arithmetic functions
and any existing functions (such as if, endp, len, etc) but
you cannot define any auxiliary functions and you cannot use 
recursion.

|#

(definec rr (l :tl n :nat) :tl
  ...)

#|

 An alist is a true list of conses. We can define a new type, alon, to
 be an alist where the cdr of each cons is a natural number as
 follows. See the book for more details.

|#

(defdata alon (alistof all nat))

; Here are some examples
(check= (alonp '((x . 2) ("hi" . 1) (g . 0))) t)
(check= (alonp '((x . 2) ("hi" . 1/2) (g . 0))) nil)

#|

 Define.

 compress : TL -> alon

 Compress will merge consecutive occurrences of an element together,
 keeping track of the number of such occurrences.

 Here is an example:

 (compress '(1 1 2 3 3 3 3 0 0)) = '((1  . 2) (2 . 1) (3 . 4) (0 . 2))

 The result tells us that the original list has 2 occurrences of 1,
 followed by 1 occurrence of 2, followed by 4 occurrences of 3,
 followed by 2 occurrences of 0.

 Hint: consider using a helper function.
|#

 (definec compress (l :tl) :alon
   ...)

 (check= (compress '(1 1 1 2 3 3 2 2 2 2)) 
                   '((1 . 3) (2 . 1) (3 . 2) (2 . 4)))

#|

 Define 

 uncompress: Alon -> TL

 so that 

 (uncompress (compress l)) = l

|#

(definec uncompress (l :alon) :tl
  ...)


#|

The permutations of a (true) list are all the lists you can obtain by
swapping any two of its elements (repeatedly). For example, starting
with the list

(1 2 3)

I can obtain

(3 2 1)

by swapping 1 and 3.

So the permutations of (1 2 3) are

(1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1)

Notice that if the list is of length n and all of its elements are
distinct, it has n! (n factorial) permutations.

Define a function, permp, that given two TLs (True lists) returns t if
they are permutations of each other and nil otherwise.

|#

(definec permp ...
  ...)

(check= (permp '(a 1 2 nil) '(nil 2 1 a)) nil)
(check= (permp '(a 1 2 nil) '(nil 2 1 a nil)) nil)

#|

 Given two lists, if they are permutations of each other, return a
 list of swaps that can be used to go from the first list to the
 second.

 For example, if the lists are (1 2 3) and (2 3 1) then one solution
 is 

 ((0 . 1) (1 . 2))

 indicating that I should swap the 0th and 1st element of the first
 list, which gives rise to the list

 (2 1 3)

 and then I should swap the 1st and 2nd element of this list, which
 gives rise to the list

 (2 3 1)

 Define the function find-swaps that given two lists either returns
 nil if they are not permutations or returns a list of swaps that get
 us from the first to the second list.

|#

(defdata swaps (alistof nat nat))

(definec find-swaps (x :tl y :tl) :swaps
  ...)

