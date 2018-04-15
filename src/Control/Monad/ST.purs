module Control.Monad.ST
  ( kind Region
  , ST
  , run
  , while
  ) where

import Prelude

-- | `ST` is concerned with _restricted_ mutation. Mutation is restricted to a
-- | _region_ of mutable references. This kind is inhabited by phantom types
-- | which represent regions in the type system.
foreign import kind Region

-- | The `ST` type constructor allows _local mutation_, i.e. mutation which
-- | does not "escape" into the surrounding computation.
-- |
-- | An `ST` computation is parameterized by a phantom type which is used to
-- | restrict the set of reference cells it is allowed to access.
-- |
-- | The `run` function can be used to run a computation in the `ST` monad.
foreign import data ST :: Region -> Type -> Type

foreign import map_ :: forall r a b. (a -> b) -> ST r a -> ST r b

foreign import pure_ :: forall r a. a -> ST r a

foreign import bind_ :: forall r a b. ST r a -> (a -> ST r b) -> ST r b

instance functorST :: Functor (ST r) where
  map = map_

instance applyST :: Apply (ST r) where
  apply = ap

instance applicativeST :: Applicative (ST r) where
  pure = pure_

instance bindST :: Bind (ST r) where
  bind = bind_

instance monadST :: Monad (ST r)

-- | Run an `ST` computation.
-- |
-- | Note: the type of `run` uses a rank-2 type to constrain the phantom
-- | type `h`, such that the computation must not leak any mutable references
-- | to the surrounding computation. It may cause problems to apply this
-- | function using the `$` operator. The recommended approach is to use
-- | parentheses instead.
foreign import run :: forall a. (forall r. ST r a) -> a

-- | Loop while a condition is `true`.
-- |
-- | `while b m` is ST computation which runs the ST computation `b`. If its
-- | result is `true`, it runs the ST computation `m` and loops. If not, the
-- | computation ends.
foreign import while :: forall r a. ST r Boolean -> ST r a -> ST r Unit
