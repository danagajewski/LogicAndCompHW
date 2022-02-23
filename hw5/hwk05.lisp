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

 CS 2800 Homework 5 - Spring 2022

 Due on Wednesday, Feb 23 by 10:00 pm.

 This homework is done in groups. 

 * You may not work alone.  Working alone will lead to an automatic 10
   point penalty on your grade.

 * Groups should consist of 2-3 people.

 * Submit the homework file (this file) on Gradescope. After clicking
   on "Upload", you must add your group members to the submission by
   clicking on "Add Group Member" and then filling their names.  If
   you do not do this you will get a 10 point penalty.  Every group
   member can submit the homework and we will only grade the last
   submission. You are responsible for making sure that your group
   submits the right version of the homework for your final
   submission. We suggest you submit early and often. Also, you will
   get feedback on some problems when you submit. However, this
   feedback does not determine your final grade, as we will manually
   review submissions.

 * Submission will be enabled typically only after labs, but well
   before the deadline.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm team membership with gradescope
   groups.  

 The format should be: FirstName1 LastName1, FirstName2 LastName2, ...

 For example:
 Names of ALL group members: Frank Sinatra, Billy Holiday

 Replace "..." below with the names as shown above.
 Names of ALL group members: ...

 There will be a 10 pt penalty if your names do not follow this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 For this homework you will need to use ACL2s.

 Technical instructions:

 - Open this file in ACL2s.

 - Make sure you are in ACL2s mode. This is essential! Note that you can
   only change the mode when the session is not running, so set the correct
   mode before starting the session.

 - Insert your solutions into this file where indicated (usually as "XXX")

 - Only add to the file. Do not remove or comment out anything pre-existing.

 - Make sure the entire file is accepted by ACL2s. In particular, there must
   be no "XXX" left in the code. If you don't finish all problems, comment
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

; Let's not worry about failed proofs, so as per the lecture
; notes, we will not require ACL2s to prove function and body
; contracts, to not take too much time testing, etc.
;
; You may see some warnings here and there. Just ignore them. As
; long as the output is green, you are good to go.

(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)
(set-defunc-generalize-contract-thm nil)

(set-defunc-timeout 7)
(acl2s-defaults :set cgen-timeout 2)

; The next form tells ACL2s to not try proving properties, unless
; we explicitly ask.
(set-acl2s-property-table-proofs? nil)

; The next form tells ACL2s to not check contracts. As seen in the the
; previous homework, if ACL2s does not prove function contracts when
; defining functions, then the property form will generate errors if
; it then tries to reason about the contracts of these
; functions. Instead of asking you to add the :check-contracts?
; keyword command, we are just turning this testing off, which means
; you may not get as much checking as would otherwise be the case, so
; make sure your properties pass contract checking.
(set-acl2s-property-table-check-contracts? nil)

#|

We use the following ASCII character combinations to represent the Boolean
connectives:

  NOT     !

  AND     ^
  OR      v
  NOR     !v
  NAND    !^

  IMPLIES =>

  EQUIV   =
  XOR     <>

The binding powers of these functions are listed from highest to lowest
in the above table. Within one group (no blank line), the binding powers
are equal. This is the same as in class.

The symbols for the operators are different than used in the homeworks
and previous labs. That is on purpose.  Different books use different
symbols, so it is good to get accustomed to that.

(p !v q) is equivalent to !(p v q).  It is called "NOR" because it 
is the Negation of an Or.

(p !^ q) is equivalent to !(p ^ q).  It is called "NAND" because it 
is the Negation of an And.

|#

; Since Nor and Nand are not built-in, we will define them now. Feel
; free to use them below.

(definec nor (p :bool q :bool) :bool
  (! (v p q))) ; note v is a macro that expands into or

(definec nand (p :bool q :bool) :bool
  (! (^ p q))) ; note ^ is a macro that expands into and

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Simplification of formulas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

There are many ways to represent a formula. For example:

p v (p => q)

is equivalent to

true

Note that true is simpler than p v (p => q). You will be given a set
of formulas and asked to find the simplest equivalent formulas.  By
simplest, we mean the formulas with the least number of
connectives. You can use any unary or binary connectives shown above
in the propositional logic section.

Write out an equational proof. Such proofs provide more assurance that
you have not made mistakes. An equational proof of the above is in
this week's lab assignment.

You should use ACL2s to check your answers, as follows. 

|#

(property (p :bool q :bool)
  (== (or p (=> p q)) t))


#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(1) p = q = !p = r

Equational Reasoning Proof:

{ commutivity }
p = !p = q = r

{ Equation 34. }

false = q = r

{ Equation 11 }

!q = r



|#

; The simplest equivalent formula is? Plug in your answer below using
; AC2s connectives.

(def-const *q1-fm* '(equal (! q) r))

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A1"
(property (p :bool q :bool r :bool)
          (== (= (= (= p q) (! p)) r) (equal (! q) r)))

#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(2) (!p => (q v r)) !^ p

Equational Reasoning Proof:

(!p => (q v r)) !^ p

{ Equation 18 }

(!!p v (q v r)) !^ p

{ Equation 22 }

(p v (q v r)) !^ p

!((p v (q v r)) ^ p)

{ Equation 45 }

!((p ^ p) v ( p ^ (p v r)))

{ Equation 25 }

!(p v ( p ^ (p v r)))

{ Equation 45 }

!(p v ((p ^ p) v ( p ^ r))

{ Equation 25 }

!(p v (p v (p ^ r))

{ Equation 59 }

!(p v p)

{ Equation 26 }

!p
  
|#

; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q2-fm* '(not p))

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A2"
(property (p :bool q :bool r :bool)
          (==
           (nand (=> (! p) (or q r)) p)
           (! p)))

#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(3) p !^ (q => p !v q)

Equational Reasoning Proof:

!(p ^ (q => p !v q))

!(p ^ (q => !(p v q)))

{ Equation 37 }

!(p ^ (q => !(p v q))

{ Equation 18 }

!(p ^ (!q v !(p v q))

{ Equation 37 }

!(p ^ (!q v (!p ^ !q))

{ Equation 59 }

!(p ^ !q)

{ Equation 36 }

!p v q

|#

; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q3-fm* '(or (not p) q))

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.

"Property A3"
(property (p :bool q :bool r :bool)
          (==
           (nand p (=> q (nor p q)))
           (v (! p) q)))

#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(4) (a => b) ^ (!c => a) <> (a !^ b) !v (!a ^ c)

Equational Reasoning Proof:

(a => b) ^ (!c => a) <> !(!(a ^ b) v (!a ^ c))

{ Equation 37 }

(a => b) ^ (!c => a) <> !((!a v !b) v (!a ^ c))

{ Equation 41 }

(a => b) ^ (!c => a) <> !((!a v (!a ^ c)) v !b)

{ Equation 59 }

(a => b) ^ (!c => a) <> !(!a v !b)

{ Equation 37 }

(a => b) ^ (!c => a) <> a ^ b

{ Equation 17 }

(!a v b) ^ (c v a) <> a ^ b

{ Equation 18 }

((!a v b) ^ (c v a) v (a ^ b)) ^ (!((!a v b) ^ (c v a)) v !(a ^ b))

{ Equation 53 }

((!a v b) ^ (c v a) v (a ^ b)) ^ ((!(!a v b) v !(c v a)) v (!a v !b))

{ Equation 36 }

((!a v b) ^ (c v a) v (a ^ b)) ^ (((a ^ !b) v (!c ^ !a)) v (!a v !b))

{ Equation 37 }

((!a v b) ^ (c v a) v (a ^ b)) ^ (((!a v !b) v (!c ^ !a)) v (a ^ !b))

{ Equation 13 }

((!a v b) ^ (c v a) v (a ^ b)) ^ ((!a v !b) v (a ^ !b))

{ Equation 59 }

((!a v b) ^ (c v a) v (a ^ b)) ^ (!a v !b)

{ Equation 59 }

(!a v !b) ^ ((!a v b) ^ (c v a) v (a ^ b))

{ Equation 14 }

((!a v !b) ^ (!a v b) ^ (c v a)) v ((!a v !b) ^ (a ^ b))

{ Equation 45 }

(!a ^ (c v a)) v ((!a v !b) ^ (a ^ b))

{ Equation 54 }

(!a ^ c) v ((!a v !b) ^ (a ^ b))

{ Equation 56 }

(!a ^ c) v (!(a ^ b) ^ (a ^ b))

{ Equation 36 }

(!a ^ c) v false

{ Equation 30 }

!a ^ c

{ Equation 8 }

|#
        
; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q4-fm* '(and (not a) c))

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A4"

(property (a :bool b :bool c :bool)
          (==
           (xor
            (and (=> a b) (=> (not c) a))
            (nor (nand a b) (and (not a) c)))
           (and (not a) c)))#|ACL2s-ToDo-Line|#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Complete Boolean Bases
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

 In class, we saw that {v, !} is a complete Boolean base.  In lab, we
 saw that there are complete Boolean bases that consist of only one
 operator. One example is !v, the NOR operator. Another example is !^,
 the NAND operator.

 We will use ACL2s to define a little compiler that compiles arbitrary
 formulas into formulas using only !v and we will formalize that this
 compilation step preserves the semantics of formulas.

 Why might you want to do this? You are working as an co-op student
 and were hired by NASA, who wants to implement some functionality in
 a circuit using only NOR gates. The computer that supported guidance,
 navigation and control for NASA's human spaceflight Apollo program
 was made out of NOR gates and NASA wants to recreate a version of
 this system.

|#

; This is a data definition for Boolean Formulas.  The design team is
; going to define the circuit using such formulas and the tools team
; is going to compile such formulas into formulas only using NORs.
(defdata BoolFm 
  (or bool 
      var 
      (list '! BoolFm)
      (list BoolFm (enum '(^ v => = <> !v !^)) BoolFm)))

; We define an assignment to be a list of variables.  Variables
; appearing in the list are treated as being true (t), while variables
; not appearing in the list are treated as being false (nil)
(defdata assignment (listof var))

; This function, determines the value of a variable v in assignment
; a. The function "in" is builtin.
(definec lookup (v :var a :assignment) :bool
  (in v a))

; Define the function BfEval, a function that given a BoolFm, p, and an
; assignment, a, evaluates p using assignment a. Hint: if you went to
; lab, this is easy.
(definec BfEval (p :BoolFm a :assignment) :bool
  (match p
    (:bool p)
    (:var (lookup p a))
    (('! q) (! (BfEval q a)))
    ((q '^ p) (and (BfEval q a) (BfEval p a)))
    ((q 'v p) (or (BfEval q a) (BfEval p a)))
    ((q '=> p) (=> (BfEval q a) (BfEval p a)))
    ((q '= p) (equal (BfEval q a) (BfEval p a)))
    ((q '<> p) (xor (BfEval q a) (BfEval p a)))
    ((q '!v p) (nor (BfEval q a) (BfEval p a)))
    ((q '!^ p) (nand (BfEval q a) (BfEval p a)))
    ))

; This is a data definition for Boolean expressions consisting
; of only constants, variables and NORs.
(defdata NorFm
  (or bool 
      var 
      (list NorFm '!v NorFm)))

; The following form states that NorFm is a subtype of BoolFm
(defdata-subtype NorFm BoolFm)

; Stated as a property, the above is
(property (p :NorFm)
  (BoolFmp p))

; Before you joined, the tools team decided to build a multi-pass
; compiler that starts with a BoolFm and during each pass one of the
; connectives are removed. It must happen in this order:  !^, <>, =,
; =>, v, ^, !. The tools team already built the first pass. Here it
; is.

; The first step is to define BoolFm1, the type corresponding to
; formulas coming out of pass 1. Remember that this is just like
; BoolFm, but with !^ removed.

(defdata BoolFm1
  (or bool 
      var 
      (list '! BoolFm1)
      (list BoolFm1 (enum '(^ v => = <> !v)) BoolFm1)))


;(check= (BoolFmp (append '(t v t) '('v) '(T v T))) t)
;(check= (BoolFmp '(append '(t '^ t) (list 'v) '(t 'v t))) t)
; The second step is to define BoolFm->BoolFm1, a function that
; peforms pass 1 of the compiler.

(defdata BoolOp
  (enum '(^ v => = <> !v !^)))



(definec BoolFm->BoolFm1 (p :BoolFm) :BoolFm1
  (match p
    ((q '!^ r) (list '! (list (BoolFm->BoolFm1 q) '^ (BoolFm->BoolFm1 r))))
    ((q b r) (list (BoolFm->BoolFm1 q) b (BoolFm->BoolFm1 r)))
    (('! q) (list '! (BoolFm->BoolFm1 q)))
    (& p)))

(check= (BoolFm->BoolFm1 '((p !^ q) = (p !^ q))) '((! (p ^ q)) = (! (p ^ q))))
(check= (BoolFm->BoolFm1 '((t !^ nil) !^ nil)) '(! ((! (t ^ nil)) ^ nil)))
(check= (BoolFm->BoolFm1 'xxx) 'xxx)
(check= (BoolFm->BoolFm1 '(! q)) '(! q))
(check= (BoolFm->BoolFm1 '(! (p !^ q))) '(! (! (p ^ q))))
(check= (BoolFm->BoolFm1 '(t !^ t)) '(! (t ^ t)))
; Make sure you understand the above. Why do we need the recursive
; call? Actually, the code isn't correct. Fix it. That is, modify it
; so that it does what it is supposed to. 
;
; You added check= tests, but the tools team seems to be unaware of
; property-based testing, so you are going to earn your paycheck by
; just introducing this one idea.
;
; Write a property that characterizes the correctness of BoolFm->BoolFm1
; by formalizing the claim that the formula returned by BoolFm->BoolFm1
; is equivalent to its input formula. Equivalence here means semantic
; equivalence, as determined by BfEval.

"Property 1"
(property (p :BoolFm a :assignment)
          (==
           (BfEval p a)
           (BfEval (BoolFm->BoolFm1 p) a)))
          
          
          
; The tools lead is very happy with the above property, as it captures
; functional correctness. Expect a job offer once you graduate.

; Define the compiler passes 2-7 using the above recipe, ie, start by
; defining BoolFMi, the type corresponding to the formulas coming out
; of pass i. Then define a function that given a formula of type
; BoolFMi-1, returns an equivalent formula of type BoolFMi. Then, add
; a property capturing semantic equivalence.

(defdata BoolFm2
  (or bool 
      var 
      (list '! BoolFm2)
      (list BoolFm2 (enum '(^ v => = !v)) BoolFm2)))

(definec BoolFm1->BoolFm2 (p :BoolFm1) :BoolFm2
  (match p
    ((q '<> r) (list 
                (list 
                 (list '! (BoolFm1->BoolFm2 q)) 
                 '^ 
                 (BoolFm1->BoolFm2 r))
                'v 
                (list 
                 (BoolFm1->BoolFm2 q) 
                 '^ 
                 (list '! (BoolFm1->BoolFm2 r)))))
    ((q b r) (list (BoolFm1->BoolFm2 q) b (BoolFm1->BoolFm2 r)))
    (('! q) (list '! (BoolFm1->BoolFm2 q)))
    (& p)))

(check= (BoolFm1->BoolFm2 '(T <> T)) '(((! T) ^ T) v (T ^ (! T))))
(check= (BoolFm1->BoolFm2 '((q <> r) ^ r)) '((((! q) ^ r) v (q ^ (! r))) ^ r))
(check= (BoolFm1->BoolFm2 'xxx) 'xxx)
(check= (BoolFm1->BoolFm2 '(! (T <> T))) '(! (((! T) ^ T) v (T ^ (! T)))))
(check= (BoolFm->BoolFm1 '(! q)) '(! q))

"Property 2"
(property (p :BoolFm1 a :assignment)
          (==
           (BfEval p a)
           (BfEval (BoolFm1->BoolFm2 p) a)))

(defdata BoolFm3 
  (or bool 
      var 
      (list '! BoolFm3)
      (list BoolFm3 (enum '(^ v => !v)) BoolFm3)))


(definec BoolFm2->BoolFm3 (p :BoolFm2) :BoolFm3
  (match p
    ((q '= r) (list 
               (list 
                 (BoolFm2->BoolFm3 q) 
                 '^ 
                 (BoolFm2->BoolFm3 r))
               'v
               (list 
                (list '! (BoolFm2->BoolFm3 q)) 
                '^ 
                (list '! (BoolFm2->BoolFm3 r)))))
    ((q b r) (list (BoolFm2->BoolFm3 q) b (BoolFm2->BoolFm3 r)))
    (('! q) (list '! (BoolFm2->BoolFm3 q)))
    (& p)))
(check= (BoolFm2->BoolFm3 '(T = T)) '((T ^ T) v ((! T) ^ (! T))))
(check= (BoolFm2->BoolFm3 '((q = r) ^ r)) '(((q ^ r) v ((! q) ^ (! r))) ^ r))
(check= (BoolFm2->BoolFm3 'xxx) 'xxx)
(check= (BoolFm2->BoolFm3 '(! (T = T))) '(! ((T ^ T) v ((! T) ^ (! T)))))
(check= (BoolFm2->BoolFm3 '(! q)) '(! q))
"Property 3"
(property (p :BoolFm2 a :assignment)
          (==
           (BfEval p a)
           (BfEval (BoolFm2->BoolFm3 p) a)))

(defdata BoolFm4
    (or bool 
      var 
      (list '! BoolFm4)
      (list BoolFm4 (enum '(^ v !v)) BoolFm4)))

(definec BoolFm3->BoolFm4 (p :BoolFm3) :BoolFm4
  (match p
    ((q '=> r) (list (list '! (BoolFm3->BoolFm4 q)) 'v (BoolFm3->BoolFm4 r)))
    ((q b r) (list (BoolFm3->BoolFm4 q) b (BoolFm3->BoolFm4 r)))
    (('! q) (list '! (BoolFm3->BoolFm4 q)))
    (& p)))
(check= (BoolFm3->BoolFm4 '((p => q) v (p => q))) '(((! p) v q) v ((! p) v q)))
(check= (BoolFm3->BoolFm4 '((t => nil) => nil)) '((! ((! t) v nil)) v nil))
(check= (BoolFm3->BoolFm4 'xxx) 'xxx)
(check= (BoolFm3->BoolFm4 '(! q)) '(! q))
(check= (BoolFm3->BoolFm4 '(! (p => q))) '(! ((! p) v q)))
(check= (BoolFm3->BoolFm4 '(t => t)) '((! t) v t))

"Property 4"
(property (p :BoolFm3 a :assignment)
          (==
           (BfEval p a)
           (BfEval (BoolFm3->BoolFm4 p) a)))#|ACL2s-ToDo-Line|#


(defdata BoolFm5 
  (or bool 
      var 
      (list '! BoolFm5)
      (list BoolFm5 (enum '(^ !v)) BoolFm5)))

(definec BoolFm4->BoolFm5 (p :BoolFm4) :BoolFm5
  (match p
    ((q '=> r) ;this needs to be demorgans law. Not sure if we can use it but its the only thing that is even close. IM thingking it should be !(!q^!r)
    ((q b r) (list (BoolFm4->BoolFm5 q) b (BoolFm4->BoolFm5 r)))
    (('! q) (list '! (BoolFm4->BoolFm5 q)))
    (& p)))

"Property 5"
(property XXX)

(defdata BoolFm6 XXX)

(definec BoolFm5->BoolFm6 XXX)

"Property 6"
(property XXX)

; We already defined NorFm, so no need to define BoolFm7.

(definec BoolFm6->NorFm XXX)

"Property 7"
(property XXX)

; Put all the passes together to form our compiler, which is the
; function BoolFm->7NorFm, which given a BoolFm, p, returns a NorFm by
; combining all 7 of the compiler passes we defined. If the returned
; formula is q, then p and q should be equivalent.
;
(definec BoolFm->7NorFm (p :BoolFm) :NorFm
  XXX)

; Write a property that characterizes the correctness of BoolFm->7NorFm.
"Property 7"
(property XXX)

; The design team has performed a preliminary analysis of your
; compiler. They are not done analyzing it yet, but they are
; requesting that you do this in a single pass. Your job is to write a
; single-pass compiler, by which we mean a single recursive ACL2s
; function that starting with a BoolFm returns an equivalent NorFm.
; Your function can only use functions from the ACL2s Language
; Reference and recursive calls to itself.
(definec BoolFm->NorFm (p :BoolFm) :NorFm
  XXX)

; The design team really likes properties and wants you to also write
; the functional correctness property for you single-pass compiler.
; Write a property that characterizes the correctness of BoolFm->NorFm
; by formalizing the claim that the formula returned by BoolFm->NorFm
; is equivalent to its input formula. Equivalence here means semantic
; equivalence, as determined by BfEval.
"Property 8"
(property XXX)

; The design team has found what they consider to be a show-stopping
; problem. They are not happy. They are complanining that the compiler
; is highly inefficient. They presented their analysis in a high-level
; meeting and management agrees.  By EOD Wednesday they want a
; compiler that never includes constants in its output and don't try
; to be smart by replacing constants with something even more
; complicated. See the lecture notes on constant propagation, eg see
; equations 1-12, 23-24. The compiler team is embarrassed and has
; decided to perform constant propagation. Your job is to get this
; working.  After a compiler team meeting, here is the plan.
;
; 1. Define the type of the output the compiler should generate. It is
; based on NorFm but it is more restrictive, as it does not allow
; constants nested in formulas. Here is the definition.

(defdata NorNCFm
  (or var 
      (list NorNCFm '!v NorNCFm)))

(defdata NorCPFm
  (or bool NorNCFm))

; 2. Define BoolFm->NorCPFm, a function just like BoolFm->NorFm,
; except that the output formula has no nested constants. You can do
; this anyway you like, eg, you can remove constants from the input,
; using the constant propagation rules from the lecture notes or you
; may do it in a more clever way. 

(definec BoolFm->NorCPFm (p :BoolFm) :NorCPFm
  XXX)

; 3. Write a property that characterizes the correctness of
; BoolFm->NorCPFm 
"Property 9"
(property XXX)

; 4. Management is involved, so we need to be careful. We want to
; specify performance properties. Usually, we only consider functional
; correctness properties, but performance properties are also very
; important. Define a function that counts the number of operators in
; a BoolFm. This function will be used by the performance team.

(definec NumOps (p :BoolFm) :nat
  XXX)


; EXTRA CREDIT 1
;
; The rest of this is optional. Don't even try it unless you want a
; challenge. Chances are you will get not get any credit for your
; effort. 
;
; Define a compiler that generates as simple a NorCPFm as possible.
; By simple we mean the least NumOps. The team that generates the best
; compiler will get 50 extra points. Uncomment the following if you
; want to participate in the competition. You can define any helper
; functions you want.
;
; (definec BoolFm->ENorCPFm (p :BoolFm) :NorCPFm XXX)
