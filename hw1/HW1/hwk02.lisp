; ****************** BEGIN INITIALIZATION FOR ACL2s MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);
(make-event
 (er-progn
  (set-deferred-ttag-notes t state)
  (value '(value-triple :invisible))))

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/ccg/ccg" :uncertified-okp nil :dir :system :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/base-theory" :dir :system :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/custom" :dir :system :ttags :all)

;; guard-checking-on is in *protected-system-state-globals* so any
;; changes are reverted back to what they were if you try setting this
;; with make-event. So, in order to avoid the use of progn! and trust
;; tags (which would not have been a big deal) in custom.lisp, I
;; decided to add this here.
;; 
;; How to check (f-get-global 'guard-checking-on state)
;; (acl2::set-guard-checking :nowarn)
(acl2::set-guard-checking :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)
;(acl2::xdoc acl2s::defunc) ;; 3 seconds is too much time to spare -- commenting out [2015-02-01 Sun]

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "acl2s/acl2s-sigs" :dir :system :ttags :all)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s mode.") (value :invisible))

(acl2::xdoc acl2s::defunc) ; almost 3 seconds

; Non-events:
;(set-guard-checking :none)

(set-inhibit-warnings! "Invariant-risk" "theory")

(in-package "ACL2")
(redef+)
(defun print-ttag-note (val active-book-name include-bookp deferred-p state)
  (declare (xargs :stobjs state)
	   (ignore val active-book-name include-bookp deferred-p))
  state)

(defun print-deferred-ttag-notes-summary (state)
  (declare (xargs :stobjs state))
  state)

(defun notify-on-defttag (val active-book-name include-bookp state)
  (declare (xargs :stobjs state)
	   (ignore val active-book-name include-bookp))
  state)
(redef-)

(acl2::in-package "ACL2S")

; ******************* END INITIALIZATION FOR ACL2s MODE ******************* ;
;$ACL2s-SMode$;ACL2s
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

 The result tells us that the original list ha s 2 occurrences of 1,
 followed by 1 occurrence of 2, followed by 4 occurrences of 3,
 followed by 2 occurrences of 0.

 Hint: consider using a helper function.
|#

#|

 Define 

 uncompress: Alon -> TL

 so that 

 (uncompress (compress l)) = l

|#
#|
(definec tolist (el :all times :nat) :tl
  (cond 
   ((equal times 0) '())
   (t (append (list el) (tolist el (- times 1))))))
(check= (tolist '(0 . 1)  2) (list '(0 . 1) '(0 . 1)))
(check= (tolist 0 3) '(0 0 0))
  

(check= (right '(1 . 3)) 3)

(definec uncompress (l :alon) :tl
  (cond 
   ((lendp l) l)
   (t (append (tolist (left (left l)) (right '(left l))) (uncompress (rest l))))))

(check= (uncompress '((1 . 3) (2 . 1) (3 . 2) (2 . 4)) '(1 1 1 2 3 3 2 2 2 2)))
|#
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

(check= (equal '(1 2 3) '(1 2 3)) t)

(definec deleter (el :all l :tl) :tl
  (cond
   ((lendp l) l)
   ((equal el (first l)) (rest l))
   (t (cons (first l) (deleter el (rest l))))))

(check= (deleter 6 '(1 2 3 4)) '(1 2 3 4))
(check= (deleter 3 '(1 2 3 4)) '(1 2 4))
(check= (deleter 3 '(1 2 3 3 4)) '(1 2 3 4))

(definec permp (l1 :tl l2 :tl) :bool
  (cond 
   ((equal l1 l2) t)
   ((lendp l1) nil)
   (t (and (in (first l1) l2) (permp (rest l1) (deleter (first l1) l2))))))

(check= (permp '(a 1 2 nil) '(nil 2 1 a)) t)
(check= (permp '(a 1 2 nil) '(nil 2 1 a nil)) nil)
(check= (permp '() '()) t)
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

(definec finder (element :all l :tl acc :nat) :nat
  (cond
   ((lendp l) acc) ; I know this looks bad but it will never hit this. Used to pass termination contract.
   ((equal (first l) element) acc)
   (t (finder element (rest l) (1+ acc)))))
(check= (finder 3 '(1 2 3 4 5) 0) 2)

(definec replace-occurence (old :all new :all x :all) :all
  (match x
    (!old new)
    (:atom x)
    ((a . b) (cons (replace-occurence old new a)
                   (replace-occurence old new b)))))
(check= (replace-occurence 3 1 '(1 2 3 4)) '(1 2 1 4))#|ACL2s-ToDo-Line|#


(definec swaphelper (sofar :swaps x :tl y :tl depth :nat) :swaps
  (cond 
   ((not (permp x y)) nil)
   ((and (lendp y) (lendp x)) sofar)
   ((equal (first x) (first y)) (swaphelper sofar (rest x) (rest y) (1+ depth)))
   (t (swaphelper (append sofar (list '(depth . (+ depth (finder (first y) x)))))
                  (replace-occurence (first y) (first x) (rest x))
                  (rest y)
                  (1+ depth)))))

(definec find-swaps (x :tl y :tl) :swaps
  ((swaphelper '() x y 0)))

