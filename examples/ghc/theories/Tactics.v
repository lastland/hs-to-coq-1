Require Import Coq.Bool.Bool.

(** Tactics *)

Ltac expand_pairs :=
match goal with
  |- context[let (_,_) := ?e in _] =>
  rewrite (surjective_pairing e)
end.

Ltac expand_pairs_ctx :=
match goal with
  H : context[let (_,_) := ?e in _] |- _ =>
  rewrite (surjective_pairing e) in H
end.

Ltac simpl_bool :=
  rewrite ?orb_true_l, ?orb_true_r, ?orb_false_l, ?orb_false_r,
          ?andb_true_l, ?andb_true_r, ?andb_false_l, ?andb_false_r,
          ?orb_true_iff, ?andb_true_iff,
          ?orb_false_iff, ?andb_false_iff
          in *.

Ltac destruct_match :=
  match goal with
  | [ H :context[match ?a with _ => _ end] |- _] =>
    let Heq := fresh "Heq" in
    destruct a eqn:Heq
  | [ |- context[match ?a with _ => _ end]] =>
    let Heq := fresh "Heq" in
    destruct a eqn:Heq
  end.


(** Removes all unused local definitions (but not assumptions) from the context *)
Ltac cleardefs := repeat (multimatch goal with [ x := _  |- _ ] => clear x end).

(** This tactic finds a [let x := rhs in body] anywhere in the goal,
    and moves it into the context, without zeta-reducing it. *)
Ltac find_let e k :=
  lazymatch e with 
    | let x := ?rhs in ?body => k x rhs body
    | ?e1 ?e2 =>
      find_let e1 ltac:(fun x rhs body => k x rhs uconstr:(body e2)) ||
      find_let e2 ltac:(fun x rhs body => k x rhs uconstr:(e1 body))
    | _ => fail
  end.
Ltac float_let :=
  lazymatch goal with |- ?goal =>
    find_let goal ltac:(fun x rhs body =>
      let goal' := uconstr:(let x := rhs in body) in
      (change goal'; intro) || fail 1000 "Failed to change to" goal'
    )
  end.

(* NB, this does not work:
Ltac float_let :=
  lazymatch goal with |-  context C [let x := ?rhs in ?body] =>
    let goal' := context C[body] in
    change (let x := rhs in goal'); intro
  end.
*)

(** Common subexpression elimination *)
Ltac cse_let :=
      repeat lazymatch goal with
        [ x := ?rhs, x0 := ?rhs |- _ ] =>
          change x0 with x in *;clear x0
        end.

(** zeta-reduces exactly one (the outermost) [let] *)
Ltac zeta_one :=
  lazymatch goal with |- context A [let x := ?rhs in @?body x] =>
     let e' := eval cbv beta in (body rhs) in
     let e'' := context A [e'] in
     change e''
  end.

(** Changes the outermost [let x := rhs in body] with [body[rhs'/x]] *)
  Ltac zeta_with rhs' :=
    lazymatch goal with |- context A [let x := ?rhs in @?body x] =>
       let e' := eval cbv beta in (body rhs') in
       let e'' := context A [e'] in
       change e''
    end.

