{-# LANGUAGE
    FlexibleContexts
  #-}

module Competition.Generic where

import Data.IntMap as IntMap
import Data.STRef

import Data.Foldable
import Data.Monoid
import Control.Monad.ST
import Control.Monad.STM
import Control.Monad.Reader
import Control.Monad.Base
import Control.Concurrent.STM.TVar


foldableToIntMap :: Foldable f => f a -> IntMap a
foldableToIntMap xs = runST $ do
  k <- newSTRef 0
  runReaderT (foldlM go mempty xs) k
  where
    go :: ( MonadReader (STRef s Int) m
          , MonadBase (ST s) m
          ) => IntMap a -> a -> m (IntMap a)
    go acc x = do
      k <- ask
      i <- liftBase $ readSTRef k
      liftBase $ modifySTRef k (+1)
      return $ IntMap.insert i x acc

foldableToIntMap' :: Foldable f => f a -> IntMap a
foldableToIntMap' xs = runST $ do
  k <- newSTRef 0
  runReaderT (foldlM go mempty xs) k
  where
    go :: ( MonadReader (STRef s Int) m
          , MonadBase (ST s) m
          ) => IntMap a -> a -> m (IntMap a)
    go acc x = do
      k <- ask
      i <- liftBase $ readSTRef k
      liftBase $ modifySTRef' k (+1)
      return $ IntMap.insert i x acc


foldableToIntMapSTM :: Foldable f => f a -> IO (IntMap a)
foldableToIntMapSTM xs = atomically $ do
  k <- newTVar 0
  runReaderT (foldlM go mempty xs) k
  where
    go :: ( MonadReader (TVar Int) m
          , MonadBase STM m
          ) => IntMap a -> a -> m (IntMap a)
    go acc x = do
      k <- ask
      i <- liftBase $ readTVar k
      liftBase $ modifyTVar' k (+1)
      return $ IntMap.insert i x acc
