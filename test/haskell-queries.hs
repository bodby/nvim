module Test where

import Prelude

variable1 :: forall a. (Show a) => Maybe a
variable1 = Just a

variable2 :: forall a. Maybe a
variable2 = Just a

-- Not valid but whatever.
func1 :: forall a. Maybe a -> a
func1 = (>>=)

func2 :: Maybe a -> a
func2 = (>>=)

main :: IO ()
main = undefined

throwDecode' :: forall a m. (FromJSON a, MonadThrow m) => L.ByteString -> m a
throwDecode' = throwDecode

