module Paths_gtk2hs_buildtools (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,9], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/usr/local/bin"
libdir     = "/usr/local/lib/gtk2hs-buildtools-0.9/ghc-6.12.1"
datadir    = "/usr/local/share/gtk2hs-buildtools-0.9"
libexecdir = "/usr/local/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "gtk2hs_buildtools_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "gtk2hs_buildtools_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "gtk2hs_buildtools_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "gtk2hs_buildtools_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
