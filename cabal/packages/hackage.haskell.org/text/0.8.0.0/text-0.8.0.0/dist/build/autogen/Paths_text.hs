module Paths_text (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,8,0,0], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/louis/.cabal/bin"
libdir     = "/home/louis/.cabal/lib/text-0.8.0.0/ghc-6.12.1"
datadir    = "/home/louis/.cabal/share/text-0.8.0.0"
libexecdir = "/home/louis/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "text_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "text_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "text_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "text_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
