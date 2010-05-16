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

import XMonad.Layout.Circle
import XMonad.Layout.Grid
import XMonad.Layout.Magnifier
import Data.Ratio
import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizableTile

import XMonad.Util.XSelection

import XMonad.Actions.Volume
import XMonad.Util.Dzen
import Data.Map    (fromList)
import Data.Monoid (mappend)

--alert = dzenConfig centered . show . round
--centered =
         --onCurr (center 150 66)
     -- >=> font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*"
     -- >=> addArgs ["-fg", "#80c0ff"]
     -- >=> addArgs ["-bg", "#000040"]



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
-- Circle ||| ||| magnify Grid 
myLayoutHook = avoidStruts (layoutHints (tiled ||| Mirror tiled ||| Grid ||| Full))
            where 
                 -- default tiling algorithm partitions the screen into two panes
                 tiled   = ResizableTall nmaster delta ratio []
                 -- The default number of windows in the master pane
                 nmaster = 1
                 -- Default proportion of screen occupied by master pane
                 ratio   = 1%2
                 -- Percent of screen to increment by when resizing panes
                 delta   = 3%100
                 --
                 magnify = magnifiercz (12%10)


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ffConfig
        { manageHook = manageDocks <+> myManageHook 
            <+> manageHook defaultConfig
            -- make sure to include myManageHook definition from above
        , layoutHook = myLayoutHook
        -- avoidStruts  $  layoutHook defaultConfig
--        , XMonad.focusFollowsMouse  = False
        , logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , workspaces         = ["1:Web", "2:Term", "3:Editor", "4", "5", "6", "7", "8", "9:Mail"]
        , terminal           = "urxvtc"
        } `additionalKeys`
        [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") 
        , ((mod1Mask, xK_s), spawn "exe=`quicksnips` && eval \"exec $exe\"")
        , ((mod1Mask, xK_Return), spawn "urxvt")
        , ((mod1Mask .|. shiftMask, xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
        , ((mod1Mask, xK_f), spawn "iceweasel")
        , ((mod1Mask, xK_d), spawn "icedove")
        -- search how to use: http://www.haskell.org/haskellwiki/Xmonad/Config_archive/Mntnoe%27s_xmonad.hs
        , ((mod1Mask, xK_c), spawn "hxsel")
        , ((0, xK_F8), pasteSelection)
        -- , ((mod1Mask .|. shiftMask, xK_b), getSelection )
        , ((shiftMask, xK_F6), lowerVolume 4 >> return ())
        , ((shiftMask, xK_F7), raiseVolume 4 >> return ())
        , ((shiftMask, xK_F8), toggleMute >> return ())
        ]


-- xmobar exemples
-- -B white -a right -F blue -t '%memory%' -c '[Run Memory [\"-t\",\"Mem: <usedratio>%\"] 10, Run Swap [] 10]"
-- i3status | xmobar -o -t '%StdinReader%' -c \"[Run StdinReader]\" "
-- xmobar /home/louis/tomo_lp/s-alois/xmonad/xmobarrc"
-- -B white -a right -F blue -t '%LIPB%' -c '[Run Weather \"LIPB\" [] 36000]'"
-- "/usr/bin/xmobar /home/louis/tomo_lp/s-alois/xmonad/xmobarrc"
