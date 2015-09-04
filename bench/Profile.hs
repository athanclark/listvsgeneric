module Main where


import Competition
import Data.Set as Set
import Criterion.Main



main :: IO ()
main = defaultMain
  [ bgroup "`toIntMap`"
    [ bgroup "List, Zip, Enum"
      [ bgroup "[Integer]"
        [ bench "1" $ whnf listToIntMap ([0..10] :: [Integer])
        , bench "2" $ whnf listToIntMap ([0..20] :: [Integer])
        , bench "3" $ whnf listToIntMap ([0..30] :: [Integer])
        , bench "4" $ whnf listToIntMap ([0..40] :: [Integer])
        , bench "5" $ whnf listToIntMap ([0..50] :: [Integer])
        ]
      , bgroup "[Int]"
        [ bench "1" $ whnf listToIntMap ([0..10] :: [Int])
        , bench "2" $ whnf listToIntMap ([0..20] :: [Int])
        , bench "3" $ whnf listToIntMap ([0..30] :: [Int])
        , bench "4" $ whnf listToIntMap ([0..40] :: [Int])
        , bench "5" $ whnf listToIntMap ([0..50] :: [Int])
        ]
      ]
    , bgroup "Foldable, ST"
      [ bgroup "[Integer]"
        [ bench "1" $ whnf foldableToIntMap ([0..10] :: [Integer])
        , bench "2" $ whnf foldableToIntMap ([0..20] :: [Integer])
        , bench "3" $ whnf foldableToIntMap ([0..30] :: [Integer])
        , bench "4" $ whnf foldableToIntMap ([0..40] :: [Integer])
        , bench "5" $ whnf foldableToIntMap ([0..50] :: [Integer])
        ]
      , bgroup "[Int]"
        [ bench "1" $ whnf foldableToIntMap ([0..10] :: [Int])
        , bench "2" $ whnf foldableToIntMap ([0..20] :: [Int])
        , bench "3" $ whnf foldableToIntMap ([0..30] :: [Int])
        , bench "4" $ whnf foldableToIntMap ([0..40] :: [Int])
        , bench "5" $ whnf foldableToIntMap ([0..50] :: [Int])
        ]
      , bgroup "Set Int"
        [ bench "1" $ whnf foldableToIntMap (Set.fromList ([0..10] :: [Int]))
        , bench "2" $ whnf foldableToIntMap (Set.fromList ([0..20] :: [Int]))
        , bench "3" $ whnf foldableToIntMap (Set.fromList ([0..30] :: [Int]))
        , bench "4" $ whnf foldableToIntMap (Set.fromList ([0..40] :: [Int]))
        , bench "5" $ whnf foldableToIntMap (Set.fromList ([0..50] :: [Int]))
        ]
      ]
    ]
  ]
