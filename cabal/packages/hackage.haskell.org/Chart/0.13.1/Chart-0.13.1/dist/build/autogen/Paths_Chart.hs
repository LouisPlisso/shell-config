module Paths_Chart (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,13,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/louis/.cabal/bin"
libdir     = "/home/louis/.cabal/lib/Chart-0.13.1/ghc-6.12.1"
datadir    = "/home/louis/.cabal/share/Chart-0.13.1"
libexecdir = "/home/louis/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "Chart_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "Chart_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "Chart_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "Chart_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
