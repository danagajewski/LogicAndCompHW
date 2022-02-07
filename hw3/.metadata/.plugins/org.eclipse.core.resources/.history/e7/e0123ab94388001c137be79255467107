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

 CS 2800 Homework 3 - Spring 2022

 Due on Tuesday, Feb 8 by 10:00 pm.

 This homework is done in groups. 

  * Groups should consist of 2-3 people.

  * All students should register their group for the class in Canvas by
    following these steps :
    - Click on People in the left hand menu
    - Click on Groups tab
    - Click on + Group button
    - Invite your group members
    Please do not accept invitations from multiple groups.

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

 - Open this file in ACL2s.

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

 - When done, save your file and submit it without changing the name
   of the file.

 - Do not submit the session file (which shows your interaction with
   the theorem prover). This is not part of your solution. Only submit
   the lisp file.

 Instructions for programming problems:

 For all function definitions you must:

 (1) Perform contract-based testing (see Lecture Notes) by adding
     appropriate check= tests.  You only have to do this for functions
     where you are responsible for at least some part of the
     definition.  This should be done before you define the function,
     as it is intended to make sure you understand the spec.

 (2) For all functions, whether you defined them or not, provide
     enough check= tests so that you have 100% expression coverage
     (see Lecture Notes).  You can use whatever tests we provide and
     your contract-based tests to achieve expression coverage, e.g.,
     if the union of the tests we gave you and your contract-based
     tests provide 100% expression coverage, there is nothing left to
     do.

 (3) Contract-based testing and expression coverage are the minimal
     testing requirements.  Feel free to add other tests as you see
     fit that capture interesing aspects of the function.

 (4) For all functions where you are responsible for at least some
     part of the definition, add at least two interesting property
     forms. The intent here is to reinforce property-based testing.

 You can use any types, functions and macros listed on the ACL2s
 Language Reference (from class Webpage, click on "Lectures and Notes"
 and then on "ACL2s Language Reference"). 

|#

#|

 Instead of requiring ACL2s to prove termination and contracts, we
 allow ACL2s to proceed even if a proof fails.  However, if a
 counterexample is found, ACL2s will report it.  See the lecture notes
 for more information.  This is achieved using the following
 directives (do not remove them):

|#

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)
(set-defunc-generalize-contract-thm nil)

#|

 The next form tells ACL2s to not try proving properties unless we
 explicitly ask.  This means you can write

 (property ...
   ...)

 instead of

 (property ...
   :proofs? nil
   ...)

 If you define a function and ACL2s does not prove its contracts, then
 any properties involving the function cannot be contract checked, so
 you may get an error stating:

 **ERROR Determining Contract Checking Proof Obligation.** 

 If that happens add the keyword command shown below. 
 
 (property ...
   :check-contracts? nil
   ...)

 ACL2s will not complain, but you have to manually make sure that the
 property passes contract checking.

|#

(set-acl2s-property-table-proofs? nil)

#|

 We are going to model memories, as association lists (alists) from an
 address (which we define to be a nat) to data (which we define to be all).

|#

; defdata-alias is like defdata, but it instructs ACL2s to treat the
; data definition as an alias. This is analogous to how == is a macro
; that expands to equal.
(defdata-alias address nat)

(property (x :all)
  (== (addressp x) (natp x)))

(defdata-alias data all)

(property (x :all)
  (datap x))

(defdata loa (listof address))
(defdata lod (listof data))

(defdata memory (alistof address data))

(check= (memoryp nil) t)
(check= (memoryp '((12 . "hi") (0 . 11) (7 . a))) t)
(check= (memoryp '((12 . "hi") (12 . 11) (7 . a))) t)
(check= (memoryp '(1 2 3)) nil)

#|

 Basic operations on memories include reading and writing, which are
 defined as follows. Familiarize yourself with the match notation.

|#

(definec read-mem (a :address m :memory) :data
  (match m
    (nil nil)
    (((!a . d) . &) d)
    ((& . r) (read-mem a r))))

(check= (read-mem 1 '((1 . 2) (1 . 3))) 2)

; Add tests as per the instructions. (Your tests should provide 100%
; expression coverage.)

(check= (read-mem 1 nil) nil)
(check= (read-mem 2 '((1 . 3))) nil)
(check= (read-mem 1 '((1 . 4))) 4)
(check= (read-mem 1 '((0 . 5)(1 . 4))) 4)
(check= (read-mem 1 '((4 . "c")(1 . "a"))) "a")


(definec write-mem (a :address d :data m :memory) :memory
  (match m
    (nil (acons a d nil))
    (((!a . &) . r) (acons a d r))
    ((f . r) (cons f (write-mem a d r)))))

; Add tests as per the instructions. 

(check= (write-mem 1 3 nil) '((1 . 3)))
(check= (write-mem 1 3 '((2 . 4)(1 . 5))) '((2 . 4)(1 . 3)))
(check= (write-mem 1 3 '((2 . 4)(1 . 5)(1 . 5))) '((2 . 4)(1 . 3)(1 . 5)))
(check= (write-mem 5 3 '((2 . 4)(1 . 5))) '((2 . 4)(1 . 5)(5 . 3)))


#|

 The function mem-addresses creates a list of the addresses appearing
 in m, in the order in which they appear.

|#

(definec mem-addresses (m :memory) :loa
  (match m
    (nil nil)
    (((a . &) . r) (cons a (mem-addresses r)))))

; Add tests as per the instructions. 

(check= (mem-addresses '((1 . 3)(2 . 5)(3 . 5))) '(1 2 3))
(check= (mem-addresses nil) nil)
(check= (mem-addresses '()) '())

; Define the function mem-data, which creates a list of the data
; appearing in m, in the order in which they appear. Use mem-addresses
; as a template. 

(definec mem-data (m :memory) :lod
  (match m
    (nil nil)
    (((& . d) . r) (cons d (mem-data r)))))

; Add tests and properties as per the instructions. (Here you need
; contract-based tests, expression coverage tests and properties).
(check= (mem-data '((1 . 3)(2 . 5)(3 . 5))) '(3 5 5))
(check= (mem-data nil) nil)
(check= (mem-data '()) '())
(property (m :memory)
  (== (mem-data nil)
      nil))
(property (m :memory)
          (== (mem-data '())
              '()))

; Address-in-memp checks if address a is an address in memory m 
(definec address-in-memp (a :address m :memory) :bool
  (in a (mem-addresses m)))

; Add tests as per the instructions. 
(check= (address-in-memp 1 '((1 . 3)(2 . 5)(3 . 5))) t)
(check= (address-in-memp 8 '((1 . 3)(2 . 5)(3 . 5))) nil)
(check= (address-in-memp 4 nil) nil)
(check= (address-in-memp 1 '()) nil)


; Data-in-memp checks if data d is associated with any address in memory m 
(definec data-in-memp (d :data m :memory) :bool
  (in d (mem-data m)))

; Add tests as per the instructions. 

(check= (data-in-memp 5 '((1 . 3)(2 . 5)(3 . 5))) t)
(check= (data-in-memp 8 '((1 . 3)(2 . 5)(3 . 5))) nil)
(check= (data-in-memp 4 nil) nil)
(check= (data-in-memp 1 '()) nil)
(property (d :data m :memory)
          (== (data-in-memp d nil)
              nil))
(property (d :data m :memory)
          (== (data-in-memp d '())
              nil))

; Define no-dupsp, a function that give a TL (true list), l, returns a
; Boolean. If l has no duplicates, no-dupsp returns t, else it returns
; nil.
(definec no-dupsp (l :tl) :bool
  (match l
    (nil t)
    ((f . r) (and (not (in f r)) (no-dupsp r)))))

; Add tests as per the instructions. 

(check= (no-dupsp nil) t)
(check= (no-dupsp '(1 2 3 4)) t)
(check= (no-dupsp '(1 2 3 4 4)) nil)
(property (l :tl)
          (== (no-dupsp nil)
              t))
(property (l :tl)
          (== (no-dupsp '())
              t))
; No-adupsp is a recognizer for memories that have no address
; duplicates. Define it and remember that a recognizer takes anything
; as input and returns a Boolean.
(definec no-adupsp (m :all) :bool
  (if (memoryp m)(no-dupsp (mem-addresses m)) nil))

; Add tests as per the instructions. 
(check= (no-adupsp nil) t)
(check= (no-adupsp '((1 . 5)(2 . 4))) t)
(check= (no-adupsp '((1 . 5)(1 . 4))) nil)
(check= (no-adupsp '()) t)
(property (m :memory)
          (== (no-adupsp nil)
              t))
(property (m :memory)
          (== (no-adupsp '())
              t))
(property (m :all)
          :hyps (not (memoryp m))
          (== (no-adupsp m)
              nil))
; No-ddupsp is a recognizer for memories that have no data
; duplicates. Define it and remember that a recognizer takes anything
; as input and returns a Boolean.
(definec no-ddupsp (m :all) :bool
  (if (memoryp m)(no-dupsp (mem-data m)) nil))

; Add tests as per the instructions. 
(check= (no-ddupsp nil) t)
(check= (no-ddupsp '((1 . 5)(2 . 4))) t)
(check= (no-ddupsp '((1 . 5)(1 . 5))) nil)
(check= (no-ddupsp '()) t)
(property (m :memory)
          (== (no-ddupsp nil)
              t))
(property (m :memory)
          (== (no-ddupsp '())
              t))
(property (m :all)
          :hyps (not (memoryp m))
          (== (no-ddupsp m)
              nil))#|ACL2s-ToDo-Line|#


; We are now going to write down some properties involving memories.
; I will be providing English descriptions of the properties and you
; will formalize them using the property form.


; Formalize the property:
; Writing to memory cannot decrease the llen of the memory.
; Remember llen is a function mentioned in the ACL2s reference on the
; class webpage.
;
; Reminder: do not remove anything in this file except ...'s. In
; particular, leave the strings before properties alone, as we use
; them for generating automatic feedback in gradescope.
"Property 1"

(property ...
  ...)

; Formalize the property:
; Reading from an address after writing to it gives the value written.
"Property 2"

(property ...
  ...)

; Fill in the ...'s so that you wind up with a true property.
; Your answer can only include the functions: if, == and read-mem.
; Note that a1 might be equal to a2; just because they are different
; variables does not mean that they have different values.
"Property 3"

(property (a1 :address a2 :address d :data m :memory)
  (== (read-mem a1 (write-mem a2 d m))
      ...))

; Reading from (rev m) is not necessarily the same as reading from m.
; Replace the ...'s below to show an example. 
(defconst *rev-counterexample* ...)


(property ()
  (and (memoryp *rev-counterexample*)
       (!= (read-mem ... (rev *rev-counterexample*))
           (read-mem ... *rev-counterexample*))))

; Formalize the property:
; Provide appropriate hypotheses that are as general as you can make
; them so that the property below holds.
; Hint: you do not have to define any new functions.
"Property 4"

(property (a :address m :memory)
  :hyps ...
  (== (read-mem a (rev m))
      (read-mem a m)))

; We'll define a proper-memory to be a memory that contains no
; duplicate addresses.
; Here is a recognizer for proper-memories:
(definec proper-memoryp (m :all) :bool
  (and (memoryp m)
       (no-adupsp m)))

; Add tests as per the instructions. 

...

; Formalize the property:
; Writing to a proper-memory yields a proper memory.
"Property 5"

(property ...
  ...)

; Formalize the property:
; The rev of a proper-memory is also a proper-memory.
"Property 6"

(property ...
  ...)

; A proper-memory may contain data duplicates.
; Replace the ... below to show an example.
(defconst *proper-memory-with-data-dups* ...)

(property ()
  (and (proper-memoryp *proper-memory-with-data-dups*)
       (! (no-ddupsp *proper-memory-with-data-dups*))))

; Formalize the property:
; If two proper-memories both contain (cons a d), then they agree on
; the contents of address a.
"Property 7"

(property ...
  ...)

; Formalize the property:
; The result of read-mem after writing to two distinct addresses of a
; memory does not depend on the order in which those addresses were
; written to.
"Property 8"

(property ...
  ...)

; Define a function properfy that takes a memory m and returns a
; proper memory p such that (read-mem a m) = (read-mem a p) for all
; addresses a.

(definec properfy (m :memory) :memory
  ...)

; Add tests as per the instructions. You do not have to add properties
; for properfy. We've got that covered below.

...

; Specify the property that properfy returns a proper memory.
"Property 9"

(property ...
  ...)

; Specify the property that a properfied memory agrees with the
; original memory for any read.
"Property 10"

(property ...
  ...)
