module Paths_QuickCheck (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [2,3], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/louis/.cabal/bin"
libdir     = "/home/louis/.cabal/lib/QuickCheck-2.3/ghc-6.12.1"
datadir    = "/home/louis/.cabal/share/QuickCheck-2.3"
libexecdir = "/home/louis/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "QuickCheck_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "QuickCheck_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "QuickCheck_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "QuickCheck_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
