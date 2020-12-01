(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Unset Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Require Coq.Program.Tactics.
Require Coq.Program.Wf.

(* Preamble *)

Open Scope type_scope.

(* Converted imports: *)

Require Control.Category.
Require Data.Either.
Require GHC.Base.
Require GHC.Prim.
Require GHC.Tuple.
Import Control.Category.Notations.
Import GHC.Base.Notations.

(* Converted type declarations: *)

Inductive Kleisli (m : Type -> Type) a b : Type :=
  | Mk_Kleisli (runKleisli : a -> m b) : Kleisli m a b.

Inductive ArrowMonad (a : Type -> Type -> Type) b : Type :=
  | Mk_ArrowMonad : (a unit b) -> ArrowMonad a b.

Record Arrow__Dict (a : Type -> Type -> Type) := Arrow__Dict_Build {
  arr__ : forall {b : Type}, forall {c : Type}, (b -> c) -> a b c ;
  first__ : forall {b : Type},
  forall {c : Type},
  forall {d : Type},
  a b c -> a (GHC.Tuple.pair_type b d) (GHC.Tuple.pair_type c d) ;
  op_zazaza____ : forall {b : Type},
  forall {c : Type},
  forall {c' : Type}, a b c -> a b c' -> a b (GHC.Tuple.pair_type c c') ;
  op_ztztzt____ : forall {b : Type},
  forall {c : Type},
  forall {b' : Type},
  forall {c' : Type},
  a b c -> a b' c' -> a (GHC.Tuple.pair_type b b') (GHC.Tuple.pair_type c c') ;
  second__ : forall {b : Type},
  forall {c : Type},
  forall {d : Type},
  a b c -> a (GHC.Tuple.pair_type d b) (GHC.Tuple.pair_type d c) }.

Definition Arrow (a : Type -> Type -> Type) `{Control.Category.Category a} :=
  forall r__, (Arrow__Dict a -> r__) -> r__.
Existing Class Arrow.

Record ArrowPlus__Dict (a : Type -> Type -> Type) := ArrowPlus__Dict_Build {
  op_zlzpzg____ : forall {b : Type}, forall {c : Type}, a b c -> a b c -> a b c }.

Definition arr `{g__0__ : Arrow a}
   : forall {b : Type}, forall {c : Type}, (b -> c) -> a b c :=
  g__0__ _ (arr__ a).

Definition first `{g__0__ : Arrow a}
   : forall {b : Type},
     forall {c : Type},
     forall {d : Type},
     a b c -> a (GHC.Tuple.pair_type b d) (GHC.Tuple.pair_type c d) :=
  g__0__ _ (first__ a).

Definition op_zazaza__ `{g__0__ : Arrow a}
   : forall {b : Type},
     forall {c : Type},
     forall {c' : Type}, a b c -> a b c' -> a b (GHC.Tuple.pair_type c c') :=
  g__0__ _ (op_zazaza____ a).

Definition op_ztztzt__ `{g__0__ : Arrow a}
   : forall {b : Type},
     forall {c : Type},
     forall {b' : Type},
     forall {c' : Type},
     a b c -> a b' c' -> a (GHC.Tuple.pair_type b b') (GHC.Tuple.pair_type c c') :=
  g__0__ _ (op_ztztzt____ a).

Definition second `{g__0__ : Arrow a}
   : forall {b : Type},
     forall {c : Type},
     forall {d : Type},
     a b c -> a (GHC.Tuple.pair_type d b) (GHC.Tuple.pair_type d c) :=
  g__0__ _ (second__ a).

Notation "'_&&&_'" := (op_zazaza__).

Infix "&&&" := (_&&&_) (at level 99).

Notation "'_***_'" := (op_ztztzt__).

Infix "***" := (_***_) (at level 99).

Record ArrowApply__Dict (a : Type -> Type -> Type) := ArrowApply__Dict_Build {
  app__ : forall {b : Type},
  forall {c : Type}, a (GHC.Tuple.pair_type (a b c) b) c }.

Definition ArrowApply (a : Type -> Type -> Type) `{Arrow a} :=
  forall r__, (ArrowApply__Dict a -> r__) -> r__.
Existing Class ArrowApply.

Definition app `{g__0__ : ArrowApply a}
   : forall {b : Type}, forall {c : Type}, a (GHC.Tuple.pair_type (a b c) b) c :=
  g__0__ _ (app__ a).

Record ArrowChoice__Dict (a : Type -> Type -> Type) := ArrowChoice__Dict_Build {
  left___ : forall {b : Type},
  forall {c : Type},
  forall {d : Type},
  a b c -> a (Data.Either.Either b d) (Data.Either.Either c d) ;
  op_zbzbzb____ : forall {b : Type},
  forall {d : Type},
  forall {c : Type}, a b d -> a c d -> a (Data.Either.Either b c) d ;
  op_zpzpzp____ : forall {b : Type},
  forall {c : Type},
  forall {b' : Type},
  forall {c' : Type},
  a b c -> a b' c' -> a (Data.Either.Either b b') (Data.Either.Either c c') ;
  right___ : forall {b : Type},
  forall {c : Type},
  forall {d : Type},
  a b c -> a (Data.Either.Either d b) (Data.Either.Either d c) }.

Definition ArrowChoice (a : Type -> Type -> Type) `{Arrow a} :=
  forall r__, (ArrowChoice__Dict a -> r__) -> r__.
Existing Class ArrowChoice.

Definition left_ `{g__0__ : ArrowChoice a}
   : forall {b : Type},
     forall {c : Type},
     forall {d : Type},
     a b c -> a (Data.Either.Either b d) (Data.Either.Either c d) :=
  g__0__ _ (left___ a).

Definition op_zbzbzb__ `{g__0__ : ArrowChoice a}
   : forall {b : Type},
     forall {d : Type},
     forall {c : Type}, a b d -> a c d -> a (Data.Either.Either b c) d :=
  g__0__ _ (op_zbzbzb____ a).

Definition op_zpzpzp__ `{g__0__ : ArrowChoice a}
   : forall {b : Type},
     forall {c : Type},
     forall {b' : Type},
     forall {c' : Type},
     a b c -> a b' c' -> a (Data.Either.Either b b') (Data.Either.Either c c') :=
  g__0__ _ (op_zpzpzp____ a).

Definition right_ `{g__0__ : ArrowChoice a}
   : forall {b : Type},
     forall {c : Type},
     forall {d : Type},
     a b c -> a (Data.Either.Either d b) (Data.Either.Either d c) :=
  g__0__ _ (right___ a).

Notation "'_|||_'" := (op_zbzbzb__).

Infix "|||" := (_|||_) (at level 99).

Notation "'_+++_'" := (op_zpzpzp__).

Infix "+++" := (_+++_) (at level 99).

Record ArrowLoop__Dict (a : Type -> Type -> Type) := ArrowLoop__Dict_Build {
  loop__ : forall {b : Type},
  forall {d : Type},
  forall {c : Type},
  a (GHC.Tuple.pair_type b d) (GHC.Tuple.pair_type c d) -> a b c }.

Definition ArrowLoop (a : Type -> Type -> Type) `{Arrow a} :=
  forall r__, (ArrowLoop__Dict a -> r__) -> r__.
Existing Class ArrowLoop.

Definition loop `{g__0__ : ArrowLoop a}
   : forall {b : Type},
     forall {d : Type},
     forall {c : Type},
     a (GHC.Tuple.pair_type b d) (GHC.Tuple.pair_type c d) -> a b c :=
  g__0__ _ (loop__ a).

Record ArrowZero__Dict (a : Type -> Type -> Type) := ArrowZero__Dict_Build {
  zeroArrow__ : forall {b : Type}, forall {c : Type}, a b c }.

Definition ArrowZero (a : Type -> Type -> Type) `{Arrow a} :=
  forall r__, (ArrowZero__Dict a -> r__) -> r__.
Existing Class ArrowZero.

Definition zeroArrow `{g__0__ : ArrowZero a}
   : forall {b : Type}, forall {c : Type}, a b c :=
  g__0__ _ (zeroArrow__ a).

Definition ArrowPlus (a : Type -> Type -> Type) `{ArrowZero a} :=
  forall r__, (ArrowPlus__Dict a -> r__) -> r__.
Existing Class ArrowPlus.

Definition op_zlzpzg__ `{g__0__ : ArrowPlus a}
   : forall {b : Type}, forall {c : Type}, a b c -> a b c -> a b c :=
  g__0__ _ (op_zlzpzg____ a).

Notation "'_<+>_'" := (op_zlzpzg__).

Infix "<+>" := (_<+>_) (at level 99).

Arguments Mk_Kleisli {_} {_} {_} _.

Arguments Mk_ArrowMonad {_} {_} _.

Definition runKleisli {m : Type -> Type} {a} {b} (arg_0__ : Kleisli m a b) :=
  let 'Mk_Kleisli runKleisli := arg_0__ in
  runKleisli.

(* Midamble *)

(* Specialization of Control.Arrow.first and Control.Arrow.second to the (->) type 
   constructor. 

   Coq often has difficulty with type inference for the Arrow type class. One work 
   around is to add the following to your edit file:
     rename value Control.Arrow.first  = Control.Arrow.arrow_first
     rename value Control.Arrow.second = Control.Arrow.arrow_second

*)

Definition arrow_first {b}{c}{d} (f : (b -> c)) : (b * d)%type -> (c * d)%type :=
  fun p => match p with (x,y)=> (f x, y) end.
Definition arrow_second {b}{c}{d} (f : (b -> c)) : (d * b)%type -> (d * c)%type :=
  fun p => match p with (x,y)=> (x, f y) end.

(* Converted value declarations: *)

Local Definition Arrow__arrow_arr
   : forall {b : Type}, forall {c : Type}, (b -> c) -> GHC.Prim.arrow b c :=
  fun {b : Type} {c : Type} => fun f => f.

Local Definition Arrow__arrow_op_ztztzt__
   : forall {b : Type},
     forall {c : Type},
     forall {b' : Type},
     forall {c' : Type},
     GHC.Prim.arrow b c ->
     GHC.Prim.arrow b' c' ->
     GHC.Prim.arrow (GHC.Tuple.pair_type b b') (GHC.Tuple.pair_type c c') :=
  fun {b : Type} {c : Type} {b' : Type} {c' : Type} =>
    fun arg_0__ arg_1__ arg_2__ =>
      match arg_0__, arg_1__, arg_2__ with
      | f, g, pair x y => pair (f x) (g y)
      end.

Local Definition Arrow__arrow_first
   : forall {b : Type},
     forall {c : Type},
     forall {d : Type},
     GHC.Prim.arrow b c ->
     GHC.Prim.arrow (GHC.Tuple.pair_type b d) (GHC.Tuple.pair_type c d) :=
  fun {b : Type} {c : Type} {d : Type} =>
    (fun arg_0__ => Arrow__arrow_op_ztztzt__ arg_0__ Control.Category.id).

Local Definition Arrow__arrow_op_zazaza__
   : forall {b : Type},
     forall {c : Type},
     forall {c' : Type},
     GHC.Prim.arrow b c ->
     GHC.Prim.arrow b c' -> GHC.Prim.arrow b (GHC.Tuple.pair_type c c') :=
  fun {b : Type} {c : Type} {c' : Type} =>
    fun f g =>
      Arrow__arrow_arr (fun b => pair b b) Control.Category.>>>
      Arrow__arrow_op_ztztzt__ f g.

Local Definition Arrow__arrow_second
   : forall {b : Type},
     forall {c : Type},
     forall {d : Type},
     GHC.Prim.arrow b c ->
     GHC.Prim.arrow (GHC.Tuple.pair_type d b) (GHC.Tuple.pair_type d c) :=
  fun {b : Type} {c : Type} {d : Type} =>
    (fun arg_0__ => Arrow__arrow_op_ztztzt__ Control.Category.id arg_0__).

Program Instance Arrow__arrow : Arrow GHC.Prim.arrow :=
  fun _ k__ =>
    k__ {| arr__ := fun {b : Type} {c : Type} => Arrow__arrow_arr ;
           first__ := fun {b : Type} {c : Type} {d : Type} => Arrow__arrow_first ;
           op_zazaza____ := fun {b : Type} {c : Type} {c' : Type} =>
             Arrow__arrow_op_zazaza__ ;
           op_ztztzt____ := fun {b : Type} {c : Type} {b' : Type} {c' : Type} =>
             Arrow__arrow_op_ztztzt__ ;
           second__ := fun {b : Type} {c : Type} {d : Type} => Arrow__arrow_second |}.

(* Skipping instance `Control.Arrow.Category__Kleisli' of class
   `Control.Category.Category' *)

(* Skipping instance `Control.Arrow.Arrow__Kleisli' of class
   `Control.Arrow.Arrow' *)

(* Skipping instance `Control.Arrow.ArrowZero__Kleisli' of class
   `Control.Arrow.ArrowZero' *)

(* Skipping instance `Control.Arrow.ArrowPlus__Kleisli' of class
   `Control.Arrow.ArrowPlus' *)

(* Skipping instance `Control.Arrow.ArrowChoice__arrow' of class
   `Control.Arrow.ArrowChoice' *)

(* Skipping instance `Control.Arrow.ArrowChoice__Kleisli' of class
   `Control.Arrow.ArrowChoice' *)

Local Definition ArrowApply__arrow_app
   : forall {b : Type},
     forall {c : Type},
     GHC.Prim.arrow (GHC.Tuple.pair_type (GHC.Prim.arrow b c) b) c :=
  fun {b : Type} {c : Type} => fun '(pair f x) => f x.

Program Instance ArrowApply__arrow : ArrowApply GHC.Prim.arrow :=
  fun _ k__ =>
    k__ {| app__ := fun {b : Type} {c : Type} => ArrowApply__arrow_app |}.

(* Skipping instance `Control.Arrow.ArrowApply__Kleisli' of class
   `Control.Arrow.ArrowApply' *)

Local Definition Functor__ArrowMonad_fmap {inst_a : Type -> Type -> Type}
  `{Arrow inst_a}
   : forall {a : Type},
     forall {b : Type}, (a -> b) -> ArrowMonad inst_a a -> ArrowMonad inst_a b :=
  fun {a : Type} {b : Type} =>
    fun arg_0__ arg_1__ =>
      match arg_0__, arg_1__ with
      | f, Mk_ArrowMonad m => Mk_ArrowMonad (m Control.Category.>>> arr f)
      end.

Local Definition Functor__ArrowMonad_op_zlzd__ {inst_a : Type -> Type -> Type}
  `{Arrow inst_a}
   : forall {a : Type},
     forall {b : Type}, a -> ArrowMonad inst_a b -> ArrowMonad inst_a a :=
  fun {a : Type} {b : Type} => Functor__ArrowMonad_fmap GHC.Base.∘ GHC.Base.const.

Program Instance Functor__ArrowMonad {a : Type -> Type -> Type} `{Arrow a}
   : GHC.Base.Functor (ArrowMonad a) :=
  fun _ k__ =>
    k__ {| GHC.Base.fmap__ := fun {a : Type} {b : Type} =>
             Functor__ArrowMonad_fmap ;
           GHC.Base.op_zlzd____ := fun {a : Type} {b : Type} =>
             Functor__ArrowMonad_op_zlzd__ |}.

(* Skipping instance `Control.Arrow.Applicative__ArrowMonad' of class
   `GHC.Base.Applicative' *)

(* Skipping instance `Control.Arrow.Monad__ArrowMonad' of class
   `GHC.Base.Monad' *)

(* Skipping all instances of class `GHC.Base.Alternative', including
   `Control.Arrow.Alternative__ArrowMonad' *)

(* Skipping all instances of class `GHC.Base.MonadPlus', including
   `Control.Arrow.MonadPlus__ArrowMonad' *)

(* Skipping instance `Control.Arrow.ArrowLoop__arrow' of class
   `Control.Arrow.ArrowLoop' *)

(* Skipping instance `Control.Arrow.ArrowLoop__Kleisli' of class
   `Control.Arrow.ArrowLoop' *)

Definition returnA {a : Type -> Type -> Type} {b : Type} `{Arrow a} : a b b :=
  arr Control.Category.id.

Definition op_zczgzg__ {a : Type -> Type -> Type} {b : Type} {c : Type} {d
   : Type} `{Arrow a}
   : (b -> c) -> a c d -> a b d :=
  fun f a => arr f Control.Category.>>> a.

Notation "'_^>>_'" := (op_zczgzg__).

Infix "^>>" := (_^>>_) (at level 99).

Definition op_zgzgzc__ {a : Type -> Type -> Type} {b : Type} {c : Type} {d
   : Type} `{Arrow a}
   : a b c -> (c -> d) -> a b d :=
  fun a f => a Control.Category.>>> arr f.

Notation "'_>>^_'" := (op_zgzgzc__).

Infix ">>^" := (_>>^_) (at level 99).

Definition op_zlzlzc__ {a : Type -> Type -> Type} {c : Type} {d : Type} {b
   : Type} `{Arrow a}
   : a c d -> (b -> c) -> a b d :=
  fun a f => a Control.Category.<<< arr f.

Notation "'_<<^_'" := (op_zlzlzc__).

Infix "<<^" := (_<<^_) (at level 99).

Definition op_zczlzl__ {a : Type -> Type -> Type} {c : Type} {d : Type} {b
   : Type} `{Arrow a}
   : (c -> d) -> a b c -> a b d :=
  fun f a => arr f Control.Category.<<< a.

Notation "'_^<<_'" := (op_zczlzl__).

Infix "^<<" := (_^<<_) (at level 99).

(* Skipping definition `Control.Arrow.leftApp' *)

Module Notations.
Notation "'_Control.Arrow.&&&_'" := (op_zazaza__).
Infix "Control.Arrow.&&&" := (_&&&_) (at level 99).
Notation "'_Control.Arrow.***_'" := (op_ztztzt__).
Infix "Control.Arrow.***" := (_***_) (at level 99).
Notation "'_Control.Arrow.|||_'" := (op_zbzbzb__).
Infix "Control.Arrow.|||" := (_|||_) (at level 99).
Notation "'_Control.Arrow.+++_'" := (op_zpzpzp__).
Infix "Control.Arrow.+++" := (_+++_) (at level 99).
Notation "'_Control.Arrow.<+>_'" := (op_zlzpzg__).
Infix "Control.Arrow.<+>" := (_<+>_) (at level 99).
Notation "'_Control.Arrow.^>>_'" := (op_zczgzg__).
Infix "Control.Arrow.^>>" := (_^>>_) (at level 99).
Notation "'_Control.Arrow.>>^_'" := (op_zgzgzc__).
Infix "Control.Arrow.>>^" := (_>>^_) (at level 99).
Notation "'_Control.Arrow.<<^_'" := (op_zlzlzc__).
Infix "Control.Arrow.<<^" := (_<<^_) (at level 99).
Notation "'_Control.Arrow.^<<_'" := (op_zczlzl__).
Infix "Control.Arrow.^<<" := (_^<<_) (at level 99).
End Notations.

(* External variables:
     Type pair unit Control.Category.Category Control.Category.id
     Control.Category.op_zgzgzg__ Control.Category.op_zlzlzl__ Data.Either.Either
     GHC.Base.Functor GHC.Base.const GHC.Base.fmap__ GHC.Base.op_z2218U__
     GHC.Base.op_zlzd____ GHC.Prim.arrow GHC.Tuple.pair_type
*)
