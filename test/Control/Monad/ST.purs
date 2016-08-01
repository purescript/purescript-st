module Test.Control.Monad.ST (testST) where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Ref (readRef)
import Control.Monad.Eff.Ref.Unsafe (unsafeRunRef)
import Control.Monad.ST (ST, STRef, getRef, newSTRef, readSTRef, runST, (%%=), (%=), (.=))

import Test.Assert (ASSERT, assert)

type EffTestST h = Eff (console :: CONSOLE, assert :: ASSERT, st :: ST h) Unit

testST :: forall h. EffTestST h
testST = do
  ref <- newSTRef true
  testReadSTRef ref true
  testWriteSTRef
  testModifySTRef
  testModifySTRef'

testReadSTRef :: forall a h. Eq a => STRef h a -> a -> EffTestST h
testReadSTRef ref expected = do
  log "readSTRef"
  actual <- readSTRef ref
  assert $ actual == expected

testWriteSTRef :: forall h. EffTestST h
testWriteSTRef = do
  log "writeSTRef"
  ref <- newSTRef true
  ref .= false
  testReadSTRef ref false

testModifySTRef :: forall h. EffTestST h
testModifySTRef = do
  log "modifySTRef"
  ref <- newSTRef true
  val <- ref %= not
  assert $ val == false
  testReadSTRef ref false

testModifySTRef' :: forall h. EffTestST h
testModifySTRef' = do
  log "modifySTRef'"
  ref <- newSTRef true
  val <- ref %%= \old -> { newValue: old, returnValue: not old}
  assert $ val == false
  testReadSTRef ref true

testGetRef :: Eff (console :: CONSOLE, assert :: ASSERT) Unit
testGetRef = unsafeRunRef do
  log "getRef"
  ref <- runST do
    ref' <- newSTRef true
    getRef ref'
  val <- readRef ref
  assert $ val == true
