module Main where

import CompetitionSpec

import Test.Tasty


main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Testing..."
  [spec]
