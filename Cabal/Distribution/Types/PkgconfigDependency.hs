{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
module Distribution.Types.PkgconfigDependency
  ( PkgconfigDependency(..)
  ) where

import Prelude ()
import Distribution.Compat.Prelude

import Distribution.Version ( VersionRange, anyVersion )

import qualified Distribution.Compat.ReadP as Parse
import Distribution.Compat.ReadP
import Distribution.Pretty
import Distribution.Text
import Distribution.Types.PkgconfigName

import Text.PrettyPrint ((<+>))

-- | Describes a dependency on a pkg-config library
--
-- @since 2.0.0.2
data PkgconfigDependency = PkgconfigDependency
                           PkgconfigName
                           VersionRange
                         deriving (Generic, Read, Show, Eq, Typeable, Data)

instance Binary PkgconfigDependency
instance NFData PkgconfigDependency where rnf = genericRnf

instance Pretty PkgconfigDependency where
  pretty (PkgconfigDependency name ver) =
    pretty name <+> pretty ver

instance Text PkgconfigDependency where
  parse = do name <- parse
             Parse.skipSpaces
             ver <- parse <++ return anyVersion
             Parse.skipSpaces
             return $ PkgconfigDependency name ver
