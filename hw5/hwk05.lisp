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

XXX

|#

; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q1-fm* XXX)

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A1"
(property XXX)

#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(2) (!p => (q v r)) !^ p

Equational Reasoning Proof:

XXX
  
|#

; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q2-fm* XXX)

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A2"
(property XXX)

#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(3) p !^ (q => p !v q)

Equational Reasoning Proof:

XXX
  
|#

; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q3-fm* XXX)

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A3"
(property XXX)

#|

Find the simplest equivalent formula corresponding to the formula
below and prove equivalence using an equational reasoning proof.

(4) (a => b) ^ (!c => a) <> (a !^ b) !v (!a ^ c)

Equational Reasoning Proof:

XXX
  
|#

; The simplest equivalent formula is? Plug in your answer below using
; ACL2s connectives.

(def-const *q4-fm* XXX)

; Check the correctness of your answer by using ACL2s to prove the
; equivalence of your answer with the given formula. Note that this
; does not mean you have the simplest formula.
"Property A4"
(property XXX)


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
    XXX))

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

; The second step is to define BoolFm->BoolFm1, a function that
; peforms pass 1 of the compiler.

(definec BoolFm->BoolFm1 (p :BoolFm) :BoolFm1
  (match p
    ((q '!^ r) (BoolFm->BoolFm1 `(! (,q ^ ,r))))
    (& p)))

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
(property XXX)

; The tools lead is very happy with the above property, as it captures
; functional correctness. Expect a job offer once you graduate.

; Define the compiler passes 2-7 using the above recipe, ie, start by
; defining BoolFMi, the type corresponding to the formulas coming out
; of pass i. Then define a function that given a formula of type
; BoolFMi-1, returns an equivalent formula of type BoolFMi. Then, add
; a property capturing semantic equivalence.

(defdata BoolFm2 XXX)

(definec BoolFm1->BoolFm2 XXX)

"Property 2"
(property XXX)

(defdata BoolFm3 XXX)

(definec BoolFm2->BoolFm3 XXX)

"Property 3"
(property XXX)

(defdata BoolFm4 XXX)

(definec BoolFm3->BoolFm4 XXX)

"Property 4"
(property XXX)

(defdata BoolFm5 XXX)

(definec BoolFm4->BoolFm5 XXX)

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

