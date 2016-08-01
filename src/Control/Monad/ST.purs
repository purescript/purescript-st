module Control.Monad.ST
( module Exports
, ST
, STRef
, newSTRef
, readSTRef
, writeSTRef, (.=)
, modifySTRef, (%=)
, modifySTRef', (%%=)
, runST
, pureST
, getRef
) where

import Prelude (Unit, bind, pure)

import Control.Monad.Eff (Eff, runPure)
import Control.Monad.Eff.Ref (Modified, REF, Ref, modifyRef, modifyRef', newRef, readRef, writeRef)
import Control.Monad.Eff.Ref (Modified) as Exports
import Control.Monad.Eff.Unsafe (unsafeInterleaveEff)

-- | The `ST` effect represents _local mutation_, i.e. mutation which does not
-- | "escape" into the surrounding computation.
-- |
-- | An `ST` computation is parameterized by a phantom type which is used to
-- | restrict the set of reference cells it is allowed to access.
-- |
-- | The `runST` function can be used to handle the `ST` effect.
foreign import data ST :: * -> !

-- | A value of type `STRef h a` represents a mutable reference which holds a
-- | value of type `a`, which can be used with the `ST h` effect.
newtype STRef h a = STRef (Ref a)

-- | Create a new mutable reference containing the specified value.
newSTRef :: forall a h r. a -> Eff (st :: ST h | r) (STRef h a)
newSTRef val = do
  ref <- unsafeInterleaveEff (newRef val)
  pure (STRef ref)

-- | Read the current value of a mutable reference.
readSTRef :: forall a h r. STRef h a -> Eff (st :: ST h | r) a
readSTRef ref = unsafeInterleaveEff (readRef (unsafeToRef ref))

-- | Update the value of a mutable reference to the specified value.
writeSTRef :: forall a h r. STRef h a -> a -> Eff (st :: ST h | r) Unit
writeSTRef ref val = unsafeInterleaveEff (writeRef (unsafeToRef ref) val)

-- | An infix version of `writeSTRef`.
infix 4 writeSTRef as .=

-- | Update the value of a mutable reference by applying a function to the
-- | current value.
modifySTRef :: forall a h r. STRef h a -> (a -> a) -> Eff (st :: ST h | r) a
modifySTRef ref f = unsafeInterleaveEff (modifyRef (unsafeToRef ref) f)

-- | An infix version of `modifySTRef`.
infix 4 modifySTRef as %=

-- | Update the value of a mutable reference by applying a function to the
-- | current value that yields the new value and a separate return value.
-- | Basically shorthand for `readSTRef` before `modifySTRef`.
modifySTRef' :: forall a b h r. STRef h a -> (a -> Modified a b) -> Eff (st :: ST h | r) b
modifySTRef' ref f = unsafeInterleaveEff (modifyRef' (unsafeToRef ref) f)

-- | An infix version of `modifySTRef'`.
infix 4 modifySTRef' as %%=

-- | Run an `ST` computation.
-- |
-- | Note: the type of `runST` uses a rank-2 type to constrain the phantom
-- | type `h`, such that the computation must not leak any mutable references
-- | to the surrounding computation.
-- |
-- | It may cause problems to apply this function using the `$` operator. The
-- | recommended approach is to use parentheses instead.
runST :: forall a r. (forall h. Eff (st :: ST h | r) a) -> Eff r a
runST = unsafeInterleaveEff

-- | A convenience function which combines `runST` with `runPure`, which can be
-- | used when the only required effect is `ST`.
-- |
-- | Note: since this function has a rank-2 type, it may cause problems to apply
-- | this function using the `$` operator. The recommended approach is to use
-- | parentheses instead.
pureST :: forall a. (forall h. Eff (st :: ST h) a) -> a
pureST st = runPure (runST st)

-- | Coerce a locally mutable `STRef h a` to a globally mutable `Ref a`. It's
-- | effectual because the phantom type which restricts the scope of effects in
-- | `runST` is discarded.
getRef :: forall a h r. STRef h a -> Eff (ref :: REF | r) (Ref a)
getRef ref = pure (unsafeToRef ref)

unsafeToRef :: forall a h. STRef h a -> Ref a
unsafeToRef (STRef ref) = ref
