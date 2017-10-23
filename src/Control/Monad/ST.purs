module Control.Monad.ST where

import Control.Applicative (class Applicative, pure)
import Control.Apply (class Apply, apply)
import Control.Bind (class Bind, bind)
import Control.Monad (class Monad)
import Control.Monad.Eff (Eff, runPure)
import Control.Monad.Eff.Ref (Ref, newRef, readRef, writeRef)
import Control.Monad.Eff.Ref.Unsafe (unsafeRunRef)
import Data.Functor (class Functor, map)

-- | The `ST h a` type represents _local mutation_, i.e. mutation which does not
-- | "escape" into the surrounding computation.
-- |
-- | An `ST` computation is parameterized by a phantom type which is used to
-- | restrict the set of reference cells it is allowed to access.
-- |
-- | The `runST` function can be used to evalutate the `ST` type.
newtype ST h a = ST (forall e. Eff e a)

instance functorST :: Functor (ST h) where
  map f (ST x) = ST (map f x)

instance applyST :: Apply (ST h) where
  apply (ST f) (ST x) = ST (apply f x)

instance applicativeST :: Applicative (ST h) where
  pure x = ST (pure x)

instance bindST :: Bind (ST h) where
  bind (ST x') f = ST do
    x <- x'
    let ST y = f x
    y

instance monadST :: Monad (ST h)

-- | The type `STRef h a` represents a mutable reference holding a value of
-- | type `a`, which can be used with the `ST h` type.
newtype STRef h a = STRef (Ref a)

-- | Create a new mutable reference.
newSTRef :: forall a h. a -> ST h (STRef h a)
newSTRef x = ST (unsafeRunRef (map STRef (newRef x)))

-- | Read the current value of a mutable reference.
readSTRef :: forall a h. STRef h a -> ST h a
readSTRef (STRef x) = ST (unsafeRunRef (readRef x))

-- | Modify the value of a mutable reference by applying a function to the
-- | current value.
modifySTRef :: forall a h. STRef h a -> (a -> a) -> ST h a
modifySTRef (STRef x') f = ST (unsafeRunRef do
  x <- readRef x'
  let y = f x
  _ <- writeRef x' y
  pure y)

-- | Set the value of a mutable reference.
writeSTRef :: forall a h. STRef h a -> a -> ST h a
writeSTRef (STRef x') x = ST (unsafeRunRef do
  _ <- writeRef x' x
  pure x)

-- | Run an `ST` computation.
-- |
-- | Note: the type of `runST` uses a rank-2 type to constrain the phantom
-- | type `h`, such that the computation must not leak any mutable references
-- | to the surrounding computation.
-- |
-- | It may cause problems to apply this function using the `$` operator. The
-- | recommended approach is to use parentheses instead.
runST :: forall a. (forall h. ST h a) -> a
runST (ST x) = runPure x
