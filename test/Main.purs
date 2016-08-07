module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.ST (runST)

import Test.Assert (ASSERT)
import Test.Control.Monad.ST (testST)

main :: Eff (console :: CONSOLE, assert :: ASSERT) Unit
main = runST do
  log "runST"
  testST
