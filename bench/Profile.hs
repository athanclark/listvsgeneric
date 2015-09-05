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
      , bgroup "[Int] Strict"
        [ bench "1" $ whnf foldableToIntMap' ([0..10] :: [Int])
        , bench "2" $ whnf foldableToIntMap' ([0..20] :: [Int])
        , bench "3" $ whnf foldableToIntMap' ([0..30] :: [Int])
        , bench "4" $ whnf foldableToIntMap' ([0..40] :: [Int])
        , bench "5" $ whnf foldableToIntMap' ([0..50] :: [Int])
        ]
      , bgroup "[Int] STM"
        [ bench "1" $ whnfIO (foldableToIntMapSTM ([0..10] :: [Int]))
        , bench "2" $ whnfIO (foldableToIntMapSTM ([0..20] :: [Int]))
        , bench "3" $ whnfIO (foldableToIntMapSTM ([0..30] :: [Int]))
        , bench "4" $ whnfIO (foldableToIntMapSTM ([0..40] :: [Int]))
        , bench "5" $ whnfIO (foldableToIntMapSTM ([0..50] :: [Int]))
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
  , bgroup "`indexSpan`"
    [ bgroup "[Bool]"
      [ bgroup "Left Fold, Lazy"
        [ bench "1" $ whnf indexSpanL (replicate 3 False ++ replicate 5 True ++ replicate 2 False)
        , bench "2" $ whnf indexSpanL (replicate 6 False ++ replicate 10 True ++ replicate 4 False)
        , bench "3" $ whnf indexSpanL (replicate 9 False ++ replicate 15 True ++ replicate 6 False)
        , bench "4" $ whnf indexSpanL (replicate 12 False ++ replicate 20 True ++ replicate 8 False)
        , bench "5" $ whnf indexSpanL (replicate 15 False ++ replicate 25 True ++ replicate 10 False)
        ]
      , bgroup "Left Fold, Strict"
        [ bench "1" $ whnf indexSpanL' (replicate 3 False ++ replicate 5 True ++ replicate 2 False)
        , bench "2" $ whnf indexSpanL' (replicate 6 False ++ replicate 10 True ++ replicate 4 False)
        , bench "3" $ whnf indexSpanL' (replicate 9 False ++ replicate 15 True ++ replicate 6 False)
        , bench "4" $ whnf indexSpanL' (replicate 12 False ++ replicate 20 True ++ replicate 8 False)
        , bench "5" $ whnf indexSpanL' (replicate 15 False ++ replicate 25 True ++ replicate 10 False)
        ]
      , bgroup "Right Fold, Lazy"
        [ bench "1" $ whnf indexSpanR (replicate 3 False ++ replicate 5 True ++ replicate 2 False)
        , bench "2" $ whnf indexSpanR (replicate 6 False ++ replicate 10 True ++ replicate 4 False)
        , bench "3" $ whnf indexSpanR (replicate 9 False ++ replicate 15 True ++ replicate 6 False)
        , bench "4" $ whnf indexSpanR (replicate 12 False ++ replicate 20 True ++ replicate 8 False)
        , bench "5" $ whnf indexSpanR (replicate 15 False ++ replicate 25 True ++ replicate 10 False)
        ]
      , bgroup "Right Fold, Strict"
        [ bench "1" $ whnf indexSpanR' (replicate 3 False ++ replicate 5 True ++ replicate 2 False)
        , bench "2" $ whnf indexSpanR' (replicate 6 False ++ replicate 10 True ++ replicate 4 False)
        , bench "3" $ whnf indexSpanR' (replicate 9 False ++ replicate 15 True ++ replicate 6 False)
        , bench "4" $ whnf indexSpanR' (replicate 12 False ++ replicate 20 True ++ replicate 8 False)
        , bench "5" $ whnf indexSpanR' (replicate 15 False ++ replicate 25 True ++ replicate 10 False)
        ]
      , bgroup "Left Monad Fold, ST"
        [ bench "1" $ whnf indexSpanST (replicate 3 False ++ replicate 5 True ++ replicate 2 False)
        , bench "2" $ whnf indexSpanST (replicate 6 False ++ replicate 10 True ++ replicate 4 False)
        , bench "3" $ whnf indexSpanST (replicate 9 False ++ replicate 15 True ++ replicate 6 False)
        , bench "4" $ whnf indexSpanST (replicate 12 False ++ replicate 20 True ++ replicate 8 False)
        , bench "5" $ whnf indexSpanST (replicate 15 False ++ replicate 25 True ++ replicate 10 False)
        ]
      , bgroup "Left Monad Fold, ST'"
        [ bench "1" $ whnf indexSpanST' (replicate 3 False ++ replicate 5 True ++ replicate 2 False)
        , bench "2" $ whnf indexSpanST' (replicate 6 False ++ replicate 10 True ++ replicate 4 False)
        , bench "3" $ whnf indexSpanST' (replicate 9 False ++ replicate 15 True ++ replicate 6 False)
        , bench "4" $ whnf indexSpanST' (replicate 12 False ++ replicate 20 True ++ replicate 8 False)
        , bench "5" $ whnf indexSpanST' (replicate 15 False ++ replicate 25 True ++ replicate 10 False)
        ]
      ]
    ]
  ]
