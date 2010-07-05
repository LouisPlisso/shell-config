-- Tomasz bla Fortuna xmonad configuration file
-- Tested with xmonad 0.8 and xmonad-contrib 0.8
-- Should work with 0.7 (add import IO and remove some things)
-- Checked with dzen2 0.8.5
import XMonad

-- For dzen bar
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Util.Loggers -- for logCmd
import XMonad.Util.Run   -- for spawnPipe and hPutStrLn

import XMonad.Hooks.ManageDocks

-- Layouts
import XMonad.Layout.Named
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
-- import XMonad.Layout.Spiral
import XMonad.Layout.SimpleFloat

-- Prompts
import XMonad.Prompt
import XMonad.Prompt.DirExec
import XMonad.Prompt.Shell
import XMonad.Prompt.Workspace
import XMonad.Prompt.Window
import XMonad.Prompt.Man

-- Actions
import XMonad.Actions.CopyWindow
import XMonad.Actions.Search
import XMonad.Actions.Submap
import XMonad.Actions.CycleWS

-- Other
import XMonad.Util.Themes
import XMonad.Hooks.EwmhDesktops
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Do we have Xinerama?
myXinerama = True

-- Basic settings 
myTerminal      = "rxvt"
myBorderWidth   = 3

-- mod1Mask - left alt, mod3mask - right alt.
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- Temporary workspaces from 1 to 9 bound to keys Mod+[1..9],
-- then we've got named workspaces accessed via prompt (Mod+z, Mod+Shift+z)
myWorkspaces = map show [1..9] ++ 
               [ "web"
               , "web2"
               , "web3"
               , "im"
               , "irc"
               , "mail"
               , "dev"
               , "dev2"
               , "dev3"
               , "adm"
               , "adm2"
               , "adm3"
	       , "org"
               , "tmp"
               , "music"
               ]

-- Define ALL colors used in WM:
-- Alternate pallete:
-- #062647 Blue from deep to light
-- #0f4276
-- #386089
-- #638cb8
-- #d22233 Red urgent;


-- Main pallete
colLight = "#8a999e"
colDark = "#343d55"
colVeryDark = "#000000"
colTextLight = "#ffffff"
colTextDark = "#bbbbbb"
colBorderLight = colLight --"#77cc77"
colBorderDark = colDark

-- Same font as for a console
-- myFont = "-misc-fixed-medium-r-*-*-15-120-100-100-c-90-iso8859-2"
myFont = "-misc-fixed-medium-r-normal-*-15-140-75-75-c-90-iso8859-2"

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig {
                               font        = myFont
                             , bgColor     = colVeryDark
                             , fgColor     = colLight
                             , borderColor = colDark
}

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window 
    , ((modMask .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modMask              , xK_b     ),

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask              , xK_q     ), restart "xmonad" True)

    --
    -- Added by hand
    -- 

    -- Prompts
    , ((modMask              , xK_a     ), dirExecPrompt myXPConfig spawn "/home/bla/.xmonad/scripts")
    , ((modMask,               xK_p     ), shellPrompt myXPConfig) -- instead of dmenu
    , ((modMask              , xK_z     ), workspacePrompt myXPConfig (windows . W.view))
    , ((modMask .|. shiftMask, xK_z     ), workspacePrompt myXPConfig (windows . W.shift))
    , ((modMask              , xK_x     ), windowPromptGoto myXPConfig)
    , ((modMask .|. shiftMask, xK_x     ), windowPromptBring myXPConfig)
    , ((modMask              , xK_m     ), manPrompt myXPConfig)
    , ((modMask              , xK_s     ), submap $ searchMap $ promptSearch myXPConfig)

    -- Actions
    , ((modMask              , xK_BackSpace), toggleWS)

    -- Copy Window
    , ((modMask              , xK_v     ), workspacePrompt myXPConfig (windows . copy))
    , ((modMask .|. shiftMask, xK_v     ), killAllOtherCopies)

    ]
    ++

    -- Standard keybindings:
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    -- CopyWindow Keybindings! Turned off;
    -- mod-[1..9] @@ Switch to workspace N
    -- mod-shift-[1..9] @@ Move client to workspace N
    -- mod-control-shift-[1..9] @@ Copy client to workspace N
---    [((m .|. modMask, k), windows $ f i)
---        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
---        , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (copy, controlMask)]]

    ++


    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Keybinding map for searching
wikiPL = searchEngine "wikipedia_pl" "http://pl.wikipedia.org/wiki/Specjalna:Szukaj?search="

searchMap method = M.fromList $
    [ ((0, xK_g), method google)
    , ((0, xK_h), method hoogle)
    , ((0, xK_w), method wikipedia)
    , ((0, xK_p), method wikiPL)
    ]


------------------------------------------------------------------------
-- Layouts:


-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.

-- Define a tab theme
myTabTheme = (theme smallClean) { activeColor = colLight
                                , inactiveColor = colDark

                                , activeBorderColor = colVeryDark
                                , inactiveBorderColor = colVeryDark

                                , activeTextColor = colTextLight
                                , inactiveTextColor = colTextDark
                                , decoHeight = 16
}

-- Define a tab layout
myTabbed = tabbed shrinkText myTabTheme
-- mySpiral = spiral (4/3)

-- Define layout list
myLayout = smartBorders $ ewmhDesktopsLayout $ avoidStruts (tiled ||| Mirror tiled ||| myTabbed ||| simpleFloat)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled      = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster    = 1

     -- Default proportion of screen occupied by master pane
     ratio      = 1/2

     -- Percent of screen to increment by when resizing panes
     delta      = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ moveToC "Firefox" "web"
    , moveToC "Claws-mail" "mail"
    , moveToC "Pidgin" "im"
    , moveToC "amarokapp" "music"
    , floatT "Save a Bookmark"

    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]
    <+> manageDocks <+> doF avoidMaster
     where
       moveToC c w = className =? c --> doF (W.shift w)
       moveToT t w = title =? t --> doF (W.shift w)
       floatC c = className =? c --> doFloat
       floatT t = title =? t --> doFloat

-- Avoiding master by floats
avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
    W.Stack t [] (r:rs) -> W.Stack t [r] rs
    otherwise           -> c


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--myStartupHook = return ()
myStartupHook = spawn "~/.xmonad/startup.sh"

-----------------------------------------------------------------------
-- Status Bar and finalization

-- My dzen pretty printer:
colDzenDark = dzenColor colTextDark colVeryDark
colDzenLight = dzenColor colTextLight colVeryDark
blaPP = dzenPP { ppCurrent = colDzenLight . wrap "<" ">"
                 -- Xinerama, second screen:
                 , ppVisible = colDzenLight . wrap "[" "]"
                 , ppHidden = colDzenDark . wrap " " " "
		 , ppUrgent = colDzenLight . wrap "!" "!"
                 , ppSep = colDzenDark " : "
                 , ppExtras = [ logCmd "~/.xmonad/membar" ]
                 , ppTitle = colDzenDark . dzenEscape . shorten 40
                 , ppLayout  = colDzenDark .
                               (\ x -> case x of
                                 "Tall"                 -> "T"
                                 "Mirror Tall"          -> "MT"
                                 "Full"                 -> "F"
                                 "Tabbed Simplest"      -> "TB"
                                 "Spiral"               -> "S"
				 "Simple Float"         -> "SF"
                                 _                      -> pad x
                               )
}

-- Create config template:
blaConfig = defaultConfig {
        terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , numlockMask        = myNumlockMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = colBorderDark
        , focusedBorderColor = colBorderLight

        , keys               = myKeys
        , mouseBindings      = myMouseBindings

        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , startupHook        = myStartupHook
}


------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

main = do
          if myXinerama
            then do
	      -- Xinerama version; 2 dzen pipes and two dynamicLogs
              dzen1Pipe <- spawnPipe "dzen2 -xs 1 -u"
              dzen2Pipe <-  spawnPipe "dzen2 -xs 2 -u"
              
              xmonad $ blaConfig {
                logHook = do
                  ewmhDesktopsLogHook
                  dynamicLogWithPP blaPP {
                    ppOutput = hPutStrLn dzen1Pipe
                  }
              
                  dynamicLogWithPP blaPP {
                    ppOutput = hPutStrLn dzen2Pipe
                  }
              }
            else do
	      -- Single display version
              dzen1Pipe <- spawnPipe "dzen2"
              
              xmonad $ blaConfig {
                logHook = do
                  ewmhDesktopsLogHook
                  dynamicLogWithPP blaPP {
                    ppOutput = hPutStrLn dzen1Pipe
                  }
              }
