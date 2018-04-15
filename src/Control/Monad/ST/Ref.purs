module Control.Monad.ST.Ref where

import Prelude

import Control.Monad.ST (ST, kind Region)

-- | The type `STRef r a` represents a mutable reference holding a value of
-- | type `a`, which can be used with the `ST r` effect.
foreign import data STRef :: Region -> Type -> Type

-- | Create a new mutable reference.
foreign import new :: forall a r. a -> ST r (STRef r a)

-- | Read the current value of a mutable reference.
foreign import read :: forall a r. STRef r a -> ST r a

-- | Update the value of a mutable reference by applying a function
-- | to the current value, computing a new state value for the reference and
-- | a return value.
foreign import modify' :: forall r a b. (a -> { state :: a, value :: b }) -> STRef r a -> ST r b

-- | Modify the value of a mutable reference by applying a function to the
-- | current value.
modify :: forall r a. (a -> a) -> STRef r a -> ST r Unit
modify f = modify' (\s -> { state: f s, value: unit })

-- | Set the value of a mutable reference.
foreign import write :: forall a r. a -> STRef r a -> ST r a
