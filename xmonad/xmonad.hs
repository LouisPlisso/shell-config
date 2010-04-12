import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import XMonad.Util.Paste
import qualified System.IO.UTF8


import XMonad.Util.XSelection


-- | Whether focus follows the mouse pointer.
-- focusFollowsMouse :: Bool
-- focusFollowsMouse = False

-- TODO ipython floats
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Pidgin"      --> doFloat
    , className =? "Battery"      --> doFloat
    , className =? "Reminder"      --> doFloat]

-- workspaces
-- myWorkspaces = ["web", "editor", "terms"] ++ (miscs 5) ++ ["fullscreen", "im"]
--     where miscs = map (("misc" ++) . show) . (flip take) [1..]
-- isFullscreen = (== "fullscreen")

-- myKeys = M.fromList $
--     [ ((0, k), windows $ W.greedyView i)
--     | (i, k) <- zip myWorkspaces workspaceKeys
--     ] 
--     where workspaceKeys = [xK_F1 .. xK_F10]

ffConfig = defaultConfig { keys = \c -> ffKeys c `M.union` keys defaultConfig c }

ffKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (workspaces conf) workspaceKeys,
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]     
          where workspaceKeys = [xK_F1 .. xK_F10]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ffConfig
        { manageHook = manageDocks <+> myManageHook 
            <+> manageHook defaultConfig
            -- make sure to include myManageHook definition from above
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , XMonad.focusFollowsMouse  = False
        , logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , terminal           = "urxvtc"
        } `additionalKeys`
        [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") 
        , ((mod1Mask, xK_s), spawn "exe=`quicksnips` && eval \"exec $exe\"")
        -- , ((mod1Mask, xK_Return), spawn "urxvt")
        , ((mod1Mask, xK_f), spawn "firefox")
        -- search how to use: http://www.haskell.org/haskellwiki/Xmonad/Config_archive/Mntnoe%27s_xmonad.hs
        , ((mod1Mask, xK_c), spawn "hxsel")
        , ((0, xK_F8), pasteSelection)
        -- , ((mod1Mask .|. shiftMask, xK_b), getSelection )
        ]


-- xmobar exemples
-- -B white -a right -F blue -t '%memory%' -c '[Run Memory [\"-t\",\"Mem: <usedratio>%\"] 10, Run Swap [] 10]"
-- i3status | xmobar -o -t '%StdinReader%' -c \"[Run StdinReader]\" "
-- xmobar /home/louis/tomo_lp/s-alois/xmonad/xmobarrc"
-- -B white -a right -F blue -t '%LIPB%' -c '[Run Weather \"LIPB\" [] 36000]'"
-- "/usr/bin/xmobar /home/louis/tomo_lp/s-alois/xmonad/xmobarrc"
