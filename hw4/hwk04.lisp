#|

 CS 2800 Homework 4 - Spring 2022

 Due on Wednesday, Feb 16 by 10:00 pm.

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
(acl2s-defaults :set cgen-timeout 1)

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

The Imitation Game Homework.

This homework is about encryption. Not the kind Turing had to deal
with, but with the kind we saw in class.

Consider a very old problem, secure communication.  This field is
called "cryptography" whose etymology originates from the Greek
words "crypto", meaning hidden, and "graphy", meaning writing.  For
example, various city-states in Ancient Greece were known to use
cryptographic methods to send secure messages in the presence of
adversaries.

We will formalize one-time pads, as described in Section of the
lecture notes entitled "The Power of Xor."  This involves writing code
for encrypting and decrypting messages, as well as formalizing and
testing properties that the code should enjoy.

One-time pads allow us to encrypt messages with "perfect" secrecy.
What this means is that if an adversary intercepts an encoded message,
they gain no information about the message, except for an upper bound
on the length of the message. 

If you look at most other types of encryption, e.g., RSA, then with
enough computational resources, an adversary can decrypt encoded
messages. The best known methods for breaking such encryption schemes
take time exponential in the size of the keys used. However, whether
this can be done in polynomial time is an open question.

Many movies have a red telephone that is used to connect the Pentagon
with the Kremlin. While there was no such red telephone, there was a
teletype-based encryption mechanism, the "Washington–Moscow Direct
Communications Link," in place between the US and USSR, which used
one-time pads. This connection was established in 1963, following the
Cuban missile crisis.

You can read more about the advantages and disadvantages of one-time
pads by searching online. We will see how to break one-time pads if
one is not careful. 

In fact, the ultimate goal of this exercise is for you to decrypt the
following intercepted secret message. 

|#

;; We intercepted this message and want to decode it. The message was
;; just a sequence of 0's and 1's but our human intelligence
;; determined the character encoding used and characters are encoded
;; using 5 bits, so we tranformed the message into a list of lists of
;; Booleans, each of length 5. 
(def-const *secret-message*
  '((NIL T NIL T NIL)
    (NIL T T T T)
    (T NIL T T T)
    (T T NIL NIL NIL)
    (T NIL NIL T NIL)
    (T NIL T T NIL)
    (T NIL NIL NIL T)
    (T T NIL T T)
    (T T NIL NIL T)
    (T T NIL NIL NIL)
    (NIL NIL NIL T T)
    (NIL NIL NIL T NIL)
    (T T T NIL T)
    (T T T T NIL)
    (NIL NIL T NIL T)
    (T T NIL NIL NIL)
    (NIL NIL T T T)
    (T T T NIL T)
    (NIL T T T NIL)
    (T T NIL NIL NIL)
    (NIL NIL NIL NIL T)
    (T NIL T T NIL)
    (T NIL T NIL T)
    (NIL T T NIL T)
    (T NIL T T T)
    (NIL T NIL T T)
    (T T NIL NIL NIL)
    (T T T NIL T)
    (NIL NIL T T NIL)
    (T NIL T T T)
    (NIL NIL NIL T NIL)
    (T T NIL NIL NIL)
    (NIL T NIL T NIL)
    (NIL T T T T)
    (T NIL T T T)
    (T T NIL NIL NIL)
    (NIL T NIL NIL T)
    (T NIL NIL T T)
    (NIL NIL NIL NIL NIL)
    (T NIL NIL NIL NIL)
    (T T NIL NIL NIL)
    (NIL T NIL T T)
    (T T T NIL T)
    (T T T T T)
    (NIL NIL T NIL NIL)
    (T T NIL T NIL)
    (T T NIL NIL NIL)
    (NIL NIL NIL T T)
    (T NIL NIL T T)
    (T T NIL T T)
    (T T NIL NIL T)))

#|

 This is a data definition for a list of Booleans. The name is
 an abbreviation for BitVector.

|#

(defdata bv (listof bool) :do-not-alias t)

; This is a data definition for a list of exactly 5 Booleans.
; The name bv5 is an abbreviation for BitVector5. 
(defdata bv5 (list bool bool bool bool bool))

; Note that bv5 is a subtype of bv: every element of bv5 is also an
; element of bv.
(defdata-subtype bv5 bv)

; We define lobv5, a list of bv5's. Something of this type is a
; message.
(defdata lobv5 (listof bv5))

; We also define a list of bv's.
(defdata lobv (listof bv))

; Notice that lobv5 is a subtype of lobv.
(defdata-subtype lobv5 lobv)

;; Question 1
;; Use CHECK= to check that *SECRET-MESSAGE* is of type lobv5.
;; Use PROPERTY to check that *SECRET-MESSAGE* is of type lobv5.
;;
;; Notice that PROPERTY is more general than CHECK=, as we can always
;; turn a CHECK= form into a PROPERTY form, eg given the form
;;     (CHECK= exp1 exp2)
;; an equivalent PROPERTY form is:
;;     (PROPERTY () (== exp1 exp2))

(check= XXX)

"Property 1"
(property XXX)

;; Luckily, our human intelligence has learned that the encrypted
;; message is comprised of letters from the following collection
;; of characters.

(def-const *chars*
  '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N 
    #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z #\Space 
    #\: #\- #\' #\( #\)))

;; This is a data definition for the legal characters. 
(defdata char (enum *chars*)) 

;; Once decoded, a message will be a list of characters from 
;; *chars*. This is a data definition for a list whose elements are
;; legal characters.
(defdata lochar (listof char))

; We want a mapping (function) from chars to bv5s. Since char is
; finite, we will use an alist. Here is the data definition for the
; mapping.

(defdata char-bv5 (alistof char bv5))

#|

 Here is the plan for creating this mapping. 

 One option is to just define the mapping directly with a form like
 this: 

 (def-const *bv-char-map*
   '((#\A . (nil nil nil nil nil))
     (#\B . (t nil nil nil nil))
     ...))

 The option we will choose is to define the mapping algorithmically
 and in a way that can be used for bit vectors of arbitrary length,
 not just length 5. The company needs this to decrypt other messages 
 that used different encodings.

 Here is the plan.

 We will define a function, generate-char-bvn-range, that given a
 natural number, n, will generate all bit vectors of length n.  It has
 to generate them in the following order

 nil nil nil ... nil
 t   nil nil ... nil
 nil t   nil ... nil
 t   t   nil ... nil
 nil nil   t ... nil 

 which you can think of as corresponding to 0, 1, 2, 3, 4, ... .

 We will then use generate-char-bvn-range to generate 
 all bit vectors of length 5 and will pair them with the chars. 
 
 Let's flesh this out some more.

 We start with the definition of generate-char-bvn-range and here is
 the plan for doing that. generate-char-bvn-range will be a
 non-recursive function that first creates a list of n nils, using the
 function n-copies, and then calls a helper function,
 generate-char-bvn-range-aux, with the list of n nils and the number
 of bit vectors of length n. 

 We will define n-copies and generate-char-bvn-range-aux. 

 The function generate-char-bvn-range-aux is given a bit vector, v,
 and a nat, n, as input and it generates a list of n bit vectors,
 starting with v, followed by the next bit vector in the ordering
 above, and so on.  If you get to the last bitvector (t t ... t), wrap
 around and continue with (nil nil ... nil). 

 The function next-bv is responsible for computing the next bit
 vector.

|#

;; Question 2
;; Define next-bv, using the above specification.
;; Make sure to add tests and properties as described in the
;; instructions for all definitions.

(definec next-bv (b :bv) :bv
  XXX)

;; Question 3
;; Specify the property that the length (next-bv b) is the same as the
;; length of b

"Property 2"
(property 
  XXX)

;; Question 4
;; Define the function generate-char-bvn-range-aux, as specified
;; above. 
(definecd generate-char-bvn-range-aux (v :bv n :nat) :lobv
  XXX)

;; Question 5
;; Define the function n-copies, as specified above. 
(definec n-copies (x :all n :nat) :tl
  XXX)

;; Here is a property showing that calling n-copies on a bool and a nat,
;; results in an bv.
(property (x :bool n :nat)
  (bvp (n-copies x n)))

;; Question 6
;; Define the function generate-char-bvn-range, as specified above. 
(definec generate-char-bvn-range (n :nat) :lobv
  XXX)

;; Here is a free test.
(check= (generate-char-bvn-range 3)
        '((NIL NIL NIL)
          (T NIL NIL)
          (NIL T NIL)
          (T T NIL)
          (NIL NIL T)
          (T NIL T)
          (NIL T T)
          (T T T)))

(def-const *bv5-values*
  (generate-char-bvn-range 5))

;; Question 7
;; Define list-zip, a function that given two TL's zips them together,
;; eg, (list-zip '(a b c) '(1 2 3)) should return
;; '((a . 1) (b . 2) (c . 3))
(definec list-zip (x :tl y :tl) :tl
  :pre (= (len x) (len y))
  XXX)

(check= (list-zip '(a b c) '(1 2 3))
        '((a . 1) (b . 2) (c . 3)))

; We now have the mapping from chars to bv5s. 
(def-const *bv5-char-map*
  (list-zip *char-values* *bv5-values*))

; Let's check that *bv5-char-map* is really a char-bv5p
(check= (char-bv5p *bv5-char-map*) t)

; Here are some checks.
(check= (nth 23 *bv5-char-map*)
        '(#\X T T T NIL T)) ; which is equal to '(#\X . (T T T NIL T))

;; Question 8
;; Define a function that given an element a and an alist l returns
;; the cons that has a as its car or nil if no such cons exists.

(definec find-car (a :all l :alist) :list
  XXX)

(check= (find-car #\W *bv5-char-map*) '(#\W nil t t nil t))

;; Question 9
;; Define a function that given an element a and an alist l returns
;; the cons that has a as its cdr or nil if no such pair exists.

(definec find-cdr (a :all l :alist) :list
  XXX)

(check= (find-cdr '(nil t t nil t) *bv5-char-map*)
        '(#\W nil t t nil t))

;; Question 10
;; Next we want to define functions that given a char return the
;; corresponding bv5 and the other way around. Define these
;; functions.
(definec char->bv5 (c :char) :bv5
  XXX)
  
(check= (char->bv5 #\W) '(nil t t nil t))

(definec bv5->char (b :bv5) :char
  XXX)

(check= (bv5->char '(nil t t nil t)) #\W)

;; Question 11
;; Define a function that xor's bit vectors. Function XOR-BV takes
;; 2 BV's (b1 and b2) of the same length as input and returns a
;; BV as output. It works by xor'ing the nth bit of b1 with
;; the nth bit of b2. Note that xor is a builtin function that will be
;; useful here. 
(definec xor-bv (b1 :bv b2 :bv) :bv
  :ic (= (len b1) (len b2))
  :oc (= (len (xor-bv b1 b2)) (len b1))
  XXX)

; Next we have a property for sanity checking that claims that if we
; apply xor-bv on bv5's then we get bv5's back.
(property (b1 :bv5 b2 :bv5) 
  (bv5p (xor-bv b1 b2)))

; This property states that the length of the output of xor-bv is
; equal to the length on the inputs.
(property (b1 :bv b2 :bv)
  :hyps (= (len b1) (len b2))
  (= (len (xor-bv b1 b2))
     (len b1)))

; You can ignore this
(in-theory (disable charp bv5p xor-bv-definition-rule
                    bv5->char-definition-rule
                    char->bv5-definition-rule))

;; Question 12
;; Define a function to encrypt a single character, given a BV5.
;; Function ENCRYPT-CHAR, given a char C, and a bv5 B, which you can
;; think of as the secret, returns the bv5 obtained by turning C into
;; a bitvector and xor'ing it with B.

(definec encrypt-char 
  XXX)

(check= (encrypt-char #\B '(t nil t nil t)) '(nil nil t nil t))

; Ignore this
(in-theory (disable encrypt-char-definition-rule))

;; Question 13

;; We will now define a function that given a lochar M (our message)
;; and a lobv5 S (our secret key, a "one-time pad" represented as a
;; list of bv5s), returns a lobv5, the result of encrypting every
;; character in the message with the corresponing bit vector in S.
;; We will require that S, the secret key, is at least as long as M,
;; the message. The output contract should state that what we return
;; is of type bvlist.

(definec encrypt
  XXX)

; Make sure that this test passes.

(property (m :lochar s :lobv5)
  :hyps (<= (len m) (len s))
  (= (len (encrypt m s)) (len m)))

; Here are our (really bad!) keys.
; They are really bad because they should be a random sequence
; of bit vectors!
(def-const *secret-keys* (n-copies '(t nil nil t t) (len *secret-message*)))

;; Question 14
;; 
;; Now let's define the DECRYPT-BV5, that given a bv5 B, and a secret
;; bv5 S, returns the char obtained by xor'ing B with S and turning
;; that into a char.
(definec decrypt-bv5
  XXX)


;; Question 15
;; 
;; We will now define a function that given a lobv5 e (think of e
;; as the encrypted message, which is a list of bv5's) and a lobv5
;; s (think of s as our shared secret key, a list of bv5s), returns
;; a list of characters, the result of decrypting every element in
;; the message with the corresponing bit vector in s. We will
;; require that s, the secret key, is at least as long as e, the
;; encrypted message. The output contract should state that what we
;; return is a charlist.
(definec decrypt
  XXX)

;; Question 16
;;
;; Write a PROPERTY to make sure ENCRYPT and DECRYPT work as expected:
;; if we encrypt lochar m (the message) with lobv5 s (the secret),
;; and then use s to decrypt that, we get the original message back.
;; Add any other hypotheses you may need.

"Property 3"
(property
  XXX)


;; Question 17
;; 
;; Write a PROPERTY to see that one-time pads provide "perfect" secrecy:
;; if we have an lobv5, e, which is an encrypted message, then for every
;; lochar m, an arbitrary message of the same length, there is some
;; secret s that when used to decode e gives us m. That is, without the
;; secret, we have no information about the contents of the message.
;; We haven't seen how to say "there exists", so instead, construct
;; the secret using existing functions.
"Property 4"
(property
  XXX)

;; The above shows that even though we know that the hostile actors
;; are using one-time pads and that each sequence of 5 bits
;; corresponds to a character, then without the secret, we cannot
;; determine what the message says.
;; 
;; However... all hope is not lost, if we are the codebreakers.  Human
;; intelligence tells us that the hostile actors did not take CS 2800,
;; and weren't trained to think carefully about the correctness of
;; their code, so they did not recognize that their secret should not
;; be reused. What they are doing is using the same 5 bit secret to
;; encrypt all the characters in their message.
;;
;; Human intelligence tried, but was not able to determine what the
;; secret is, so you have to figure out how to break their encyption.

;; To make it easier to read the messages, we will convert them to
;; strings. Here is an example of how you can do that in ACL2s.

(coerce '(#\H #\e #\l #\l #\o #\, #\space #\w #\o #\r #\l #\d #\.)
	'string)

;; Question 19
;;
;; Here's the plan for breaking the encryption. You are going to
;; generate all possible secret keys (there are 2^5=32 of
;; them). Luckily, you already wrote code to do that. Then, you will
;; decode *SECRET-MESSAGE* with each of these keys. To do that, you
;; will create a list containing (LEN *SECRET-MESSAGE*) copies of the
;; potential secret and use it to decrypt the message. When you do
;; this, you'll produce gibberish 31 times, but *one* of your decrypts
;; will make sense.

;; Define GAME-OVER, a function that decrypts *SECRET-MESSAGE* using
;; all possible values for the secret key. It should return a list of
;; 32 strings. Hint: define a helper function.

(defdata lostring (listof string))

(definec game-over () :lostring
  XXX)

;; Question 20
;;
;; Well, what is the secret message?  (The answer is the one string
;; out of the 32 strings returned by game-over that makes any sense.)

(defconst *the-secret-message-is*
  XXX)

;; This is a historically relevant message. Look it up!
