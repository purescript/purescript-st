module Control.Monad.ST
  ( kind Region
  , ST
  , STRef
  , newSTRef
  , readSTRef
  , modifySTRef
  , writeSTRef
  , pureST
  ) where

import Prelude

-- | `ST` is concerned with _restricted_ mutation. Mutation
-- | is restricted to a _region_ of mutable references.
-- | This kind is inhabited by phantom types which represent
-- | regions in the type system.
foreign import kind Region

-- | The `ST` type constructor allows _local mutation_, i.e.
-- | mutation which does not "escape" into the surrounding
-- | computation.
-- |
-- | An `ST` computation is parameterized by a phantom type which is used to
-- | restrict the set of reference cells it is allowed to access.
-- |
-- | The `runST` function can be used to run a computation in the
-- | `ST` monad.
foreign import data ST :: Region -> Type -> Type

foreign import mapST
  :: forall r a b
   . (a -> b)
  -> ST r a
  -> ST r b

foreign import pureST_ :: forall r a. a -> ST r a

foreign import bindST_
  :: forall r a b
   . ST r a
  -> (a -> ST r b)
  -> ST r b

instance functorST :: Functor (ST r) where
  map = mapST

instance applyST :: Apply (ST r) where
  apply = ap

instance applicativeST :: Applicative (ST r) where
  pure = pureST_

instance bindST :: Bind (ST r) where
  bind = bindST_

instance monadST :: Monad (ST r)

-- | The type `STRef r a` represents a mutable reference holding a value of
-- | type `a`, which can be used with the `ST r` effect.
foreign import data STRef :: Region -> Type -> Type

-- | Create a new mutable reference.
foreign import newSTRef :: forall a r. a -> ST r (STRef r a)

-- | Read the current value of a mutable reference.
foreign import readSTRef :: forall a r. STRef r a -> ST r a

-- | Modify the value of a mutable reference by applying a function to the
-- | current value.
foreign import modifySTRef :: forall a r. STRef r a -> (a -> a) -> ST r a

-- | Set the value of a mutable reference.
foreign import writeSTRef :: forall a r. STRef r a -> a -> ST r a

-- | Run an `ST` computation.
-- |
-- | Note: the type of `runST` uses a rank-2 type to constrain the phantom
-- | type `h`, such that the computation must not leak any mutable references
-- | to the surrounding computation.
-- |
-- | It may cause problems to apply this function using the `$` operator. The
-- | recommended approach is to use parentheses instead.
foreign import pureST :: forall a. (forall r. ST r a) -> a
