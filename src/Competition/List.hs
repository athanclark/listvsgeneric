{-# LANGUAGE
    FlexibleContexts
  #-}

module Competition.List where

import qualified Data.IntMap as IntMap
import Data.Foldable
import Data.STRef
import Control.Monad.ST
import Control.Monad.Base
import Control.Monad.Reader


listToIntMap :: [a] -> IntMap.IntMap a
listToIntMap xs = IntMap.fromDistinctAscList $ [0..] `zip` xs


indexSpanL :: [Bool] -> (Maybe Int, Maybe Int)
indexSpanL xs = snd $ foldl go (0,(Nothing,Nothing)) xs
  where
    go (n,(Nothing, _))     False = (n+1, (Nothing, Nothing))
    go (n,(Nothing, _))     True  = (n+1, (Just n,  Nothing))
    go (n,(Just i,  _))     True  = (n+1, (Just i,  Just n))
    go (n,(Just i, Just j)) False = (n+1, (Just i, Just j))


indexSpanL' :: [Bool] -> (Maybe Int, Maybe Int)
indexSpanL' xs = snd $ foldl' go (0,(Nothing,Nothing)) xs
  where
    go (n,(Nothing, _))     False = (n+1, (Nothing, Nothing))
    go (n,(Nothing, _))     True  = (n+1, (Just n,  Nothing))
    go (n,(Just i,  _))     True  = (n+1, (Just i,  Just n))
    go (n,(Just i, Just j)) False = (n+1, (Just i, Just j))


indexSpanR :: [Bool] -> (Maybe Int, Maybe Int)
indexSpanR xs = snd $ foldr go (length xs,(Nothing,Nothing)) xs
  where
    go False (n,(Nothing, _))     = (n-1, (Nothing, Nothing))
    go True  (n,(Nothing, _))     = (n-1, (Just n,  Nothing))
    go True  (n,(Just i,  _))     = (n-1, (Just i,  Just n))
    go False (n,(Just i, Just j)) = (n-1, (Just i, Just j))


indexSpanR' :: [Bool] -> (Maybe Int, Maybe Int)
indexSpanR' xs = snd $ foldr' go (length xs,(Nothing,Nothing)) xs
  where
    go False (n,(Nothing, _))     = (n-1, (Nothing, Nothing))
    go True  (n,(Nothing, _))     = (n-1, (Just n,  Nothing))
    go True  (n,(Just i,  _))     = (n-1, (Just i,  Just n))
    go False (n,(Just i, Just j)) = (n-1, (Just i, Just j))

indexSpanST :: [Bool] -> (Maybe Int, Maybe Int)
indexSpanST xs = runST $ do
  k <- newSTRef 0
  runReaderT (foldlM go (Nothing,Nothing) xs) k
  where
    go (Nothing, _)     False = do
      k <- ask
      liftBase $ modifySTRef k (+1)
      return (Nothing, Nothing)
    go (mx,  _)     True  = do
      k <- ask
      n <- liftBase $ readSTRef k
      liftBase $ modifySTRef k (+1)
      case mx of
        Nothing -> return (Just n, Nothing)
        Just i  -> return (Just i, Just n)
    go a False = do
      k <- ask
      liftBase $ modifySTRef k (+1)
      return a

indexSpanST' :: [Bool] -> (Maybe Int, Maybe Int)
indexSpanST' xs = runST $ do
  k <- newSTRef 0
  runReaderT (foldlM go (Nothing,Nothing) xs) k
  where
    go (Nothing, _)     False = do
      k <- ask
      liftBase $ modifySTRef' k (+1)
      return (Nothing, Nothing)
    go (mx,  _)     True  = do
      k <- ask
      n <- liftBase $ readSTRef k
      liftBase $ modifySTRef' k (+1)
      case mx of
        Nothing -> return (Just n, Nothing)
        Just i  -> return (Just i, Just n)
    go a False = do
      k <- ask
      liftBase $ modifySTRef' k (+1)
      return a
