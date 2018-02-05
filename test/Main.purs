module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.ST (modifySTRef, newSTRef, readSTRef, pureST)

sumOfSquares :: Int
sumOfSquares = pureST do
  total <- newSTRef 0
  let loop 0 = readSTRef total
      loop n = do
        _ <- modifySTRef total (_ + (n * n))
        loop (n - 1)
  loop 100

main :: Eff (console :: CONSOLE) Unit
main = do
  logShow sumOfSquares
