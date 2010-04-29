module Paths_xmonad_extras (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,9], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/louis/.cabal/bin"
libdir     = "/home/louis/.cabal/lib/xmonad-extras-0.9/ghc-6.12.1"
datadir    = "/home/louis/.cabal/share/xmonad-extras-0.9"
libexecdir = "/home/louis/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "xmonad_extras_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "xmonad_extras_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "xmonad_extras_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "xmonad_extras_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
