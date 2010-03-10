{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

-----------------------------------------------------------------------------
-- |
-- Module       : XMonad.Config.dvorakFr
-- Copyright    : (c) Devin Mullins <me@twifkak.com>
-- License      : BSD
--
-- Maintainer   : Devin Mullins <me@twifkak.com>
-- Stability    : stable
-- Portability  : unportable
--
-- This module fixes some of the keybindings for the francophone among you who
-- use an dvorakFr keyboard layout. Config stolen from TeXitoi's config on the
-- wiki.

module XMonad.Config.DvorakFr (
    -- * Usage
    -- $usage
    dvorakFrConfig, dvorakFrKeys
    ) where

import XMonad
import qualified XMonad.StackSet as W

import qualified Data.Map as M

-- $usage
-- To use this module, start with the following @~\/.xmonad\/xmonad.hs@:
--
-- > import XMonad
-- > import XMonad.Config.dvorakFr
-- >
-- > main = xmonad dvorakFrConfig
--
-- If you prefer, an dvorakFrKeys function is provided which you can use as so:
--
-- > import qualified Data.Map as M
-- > main = xmonad someConfig { keys = \c -> dvorakFrKeys c `M.union` keys someConfig c }

dvorakFrConfig = defaultConfig { keys = \c -> dvorakFrKeys c `M.union` keys defaultConfig c }

dvorakFrKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [((modm, xK_semicolon), sendMessage (IncMasterN (-1)))]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (workspaces conf) [0x3d,0x2f,0x2d,0x2b,0x5c,0xfe52,0x28,0x60,0x29,0x22],
-- 0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
