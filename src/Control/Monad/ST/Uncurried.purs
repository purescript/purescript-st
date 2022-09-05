-- | This module defines types for STf uncurried functions, as well as
-- | functions for converting back and forth between them.
-- |
-- | The general naming scheme for functions and types in this module is as
-- | follows:
-- |
-- | * `STFn{N}` means, an uncurried function which accepts N arguments and
-- |   performs some STs. The first N arguments are the actual function's
-- |   argument. The last type argument is the return type.
-- | * `runSTFn{N}` takes an `STFn` of N arguments, and converts it into
-- |   the normal PureScript form: a curried function which returns an ST
-- |   action.
-- | * `mkSTFn{N}` is the inverse of `runSTFn{N}`. It can be useful for
-- |   callbacks.
-- |

module Control.Monad.ST.Uncurried where

import Control.Monad.ST.Internal (ST, Region)

foreign import data STFn1 :: Region -> Type -> Type -> Type

type role STFn1 nominal representational representational

foreign import data STFn2 :: Region -> Type -> Type -> Type -> Type

type role STFn2 nominal representational representational representational

foreign import data STFn3 :: Region -> Type -> Type -> Type -> Type -> Type

type role STFn3 nominal representational representational representational representational

foreign import data STFn4 :: Region -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn4 nominal representational representational representational representational representational

foreign import data STFn5 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn5 nominal representational representational representational representational representational representational

foreign import data STFn6 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn6 nominal representational representational representational representational representational representational representational

foreign import data STFn7 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn7 nominal representational representational representational representational representational representational representational representational

foreign import data STFn8 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn8 nominal representational representational representational representational representational representational representational representational representational

foreign import data STFn9 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn9 nominal representational representational representational representational representational representational representational representational representational representational

foreign import data STFn10 :: Region -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type -> Type

type role STFn10 nominal representational representational representational representational representational representational representational representational representational representational representational

foreign import mkSTFn1 :: forall t a r.
  (a -> ST t r) -> STFn1 t a r
foreign import mkSTFn2 :: forall t a b r.
  (a -> b -> ST t r) -> STFn2 t a b r
foreign import mkSTFn3 :: forall t a b c r.
  (a -> b -> c -> ST t r) -> STFn3 t a b c r
foreign import mkSTFn4 :: forall t a b c d r.
  (a -> b -> c -> d -> ST t r) -> STFn4 t a b c d r
foreign import mkSTFn5 :: forall t a b c d e r.
  (a -> b -> c -> d -> e -> ST t r) -> STFn5 t a b c d e r
foreign import mkSTFn6 :: forall t a b c d e f r.
  (a -> b -> c -> d -> e -> f -> ST t r) -> STFn6 t a b c d e f r
foreign import mkSTFn7 :: forall t a b c d e f g r.
  (a -> b -> c -> d -> e -> f -> g -> ST t r) -> STFn7 t a b c d e f g r
foreign import mkSTFn8 :: forall t a b c d e f g h r.
  (a -> b -> c -> d -> e -> f -> g -> h -> ST t r) -> STFn8 t a b c d e f g h r
foreign import mkSTFn9 :: forall t a b c d e f g h i r.
  (a -> b -> c -> d -> e -> f -> g -> h -> i -> ST t r) -> STFn9 t a b c d e f g h i r
foreign import mkSTFn10 :: forall t a b c d e f g h i j r.
  (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> ST t r) -> STFn10 t a b c d e f g h i j r

foreign import runSTFn1 :: forall t a r.
  STFn1 t a r -> a -> ST t r
foreign import runSTFn2 :: forall t a b r.
  STFn2 t a b r -> a -> b -> ST t r
foreign import runSTFn3 :: forall t a b c r.
  STFn3 t a b c r -> a -> b -> c -> ST t r
foreign import runSTFn4 :: forall t a b c d r.
  STFn4 t a b c d r -> a -> b -> c -> d -> ST t r
foreign import runSTFn5 :: forall t a b c d e r.
  STFn5 t a b c d e r -> a -> b -> c -> d -> e -> ST t r
foreign import runSTFn6 :: forall t a b c d e f r.
  STFn6 t a b c d e f r -> a -> b -> c -> d -> e -> f -> ST t r
foreign import runSTFn7 :: forall t a b c d e f g r.
  STFn7 t a b c d e f g r -> a -> b -> c -> d -> e -> f -> g -> ST t r
foreign import runSTFn8 :: forall t a b c d e f g h r.
  STFn8 t a b c d e f g h r -> a -> b -> c -> d -> e -> f -> g -> h -> ST t r
foreign import runSTFn9 :: forall t a b c d e f g h i r.
  STFn9 t a b c d e f g h i r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> ST t r
foreign import runSTFn10 :: forall t a b c d e f g h i j r.
  STFn10 t a b c d e f g h i j r -> a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> ST t r
