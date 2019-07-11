module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (logShow)
import Control.Monad.ST as ST
import Control.Monad.ST.Ref as STRef
import Data.Distributive (distribute)

sumOfSquares :: Int
sumOfSquares = ST.run do
  total <- STRef.new 0
  let loop 0 = STRef.read total
      loop n = do
        _ <- STRef.modify (_ + (n * n)) total
        loop (n - 1)
  loop 100

distributeAp :: Int
distributeAp = ST.run (distribute f <*> pure 1337)
  where
    f :: forall r. Int -> ST.ST r Int
    f i = do
      r <- STRef.new 42
      _ <- STRef.modify (_ + i) r
      STRef.read r

main :: Effect Unit
main = do
  logShow sumOfSquares
  logShow distributeAp
