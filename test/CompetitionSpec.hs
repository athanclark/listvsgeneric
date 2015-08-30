module CompetitionSpec (spec) where

import Competition

import Test.Tasty
import Test.Tasty.QuickCheck as QC
import Test.QuickCheck
import Test.QuickCheck.Instances


spec :: TestTree
spec = testGroup "# Competition"
  [ QC.testProperty "*`toIntMap` should be equivalent" toIntMap
  ]

toIntMap :: [Int] -> Bool
toIntMap xs = listToIntMap xs == foldableToIntMap xs
