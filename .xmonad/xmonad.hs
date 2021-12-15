import qualified XMonad.StackSet as W
import XMonad.Layout
import XMonad.Operations
import XMonad.ManageHook

import XMonad as X
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt

import System.Exit
import Control.Monad
import XMonad.Util.Dmenu

import qualified Data.Map as M 
import Data.Map (Map)


import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.TwoPane (TwoPane(..))
import XMonad.Layout.Tabbed (simpleTabbed)

import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicBars
import XMonad.Hooks.ManageDocks

import System.IO

import XMonad.Hooks.EwmhDesktops

import XMonad.Util.EZConfig(additionalKeys)

import Data.Maybe

import XMonad.Layout.IndependentScreens


main :: IO ()
main = do

    spawn "killall trayer"  -- kill current trayer on each restart
    spawn ("sleep 2 && trayer --edge top --align right --widthtype request  --SetDockType true --SetPartialStrut true --expand true  --transparent true --alpha 0 -- --height 16")



    -- xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/" ++ colorScheme ++ "-xmobarrc")
    -- xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/dracula-xmobarrc")
    xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/archXmobarrc")
    xmproc1 <- spawnPipe ("xmobar -x 1 ~/.config/xmobar/archXmobarrc")

    xmonad $  docks $ def
        {
            terminal           = myTerminal


            -- ,manageHook =  manageDocks <+> manageHook defaultConfig
            ,manageHook =  manageHook def <+> manageDocks
            , layoutHook         = avoidStruts $ myLayoutHook

            , borderWidth        = myBorderWidth
            , modMask            = myModMask

            , focusFollowsMouse  = True

            , keys               = myKeys

            , workspaces         = myWorkspaces
            , focusedBorderColor = "#f8f8f2"
            , normalBorderColor = "#282a36"


            , handleEventHook    = handleEventHook def <+> docksEventHook

            -- , logHook = dynamicLogWithPP xmobarPP
            --             { ppOutput = hPutStrLn xmproc0
            --             , ppTitle = xmobarColor "green" "" 
            --             , ppVisible = xmobarColor "#FFFFFF" "" .clickable
            --             }
            , logHook = dynamicLogWithPP  $ xmobarPP
              -- XMOBAR SETTINGS
              { ppOutput = \x -> hPutStrLn xmproc0 x   -- xmobar on monitor 1
                              >> hPutStrLn xmproc1 x
                -- Current workspace
              , ppCurrent = xmobarColor color06 "" . wrap
                            ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
                -- Visible but not current workspace
              , ppVisible = xmobarColor color06 "" . clickable
                -- Hidden workspace
              , ppHidden = xmobarColor color05 "" . wrap
                           ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor color05 ""  . clickable
                -- Title of active window
              , ppTitle = xmobarColor color16 "" . shorten 60
                -- Separator character
              , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
                -- Urgent workspace
              , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                -- Adding # of windows on current workspace to the bar
              , ppExtras  = [windowCount]
                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
              }




            -- key bindings
            -- mouseBindings      = myMouseBindings,

            -- hooks, layouts
            -- logHook            = myLogHook,
            -- , startupHook        = dynStatusBarStartup $ startupHook defaultConfig

        }

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]


-- color scheme
colorScheme = "dracula"

colorBack = "#282a36"
colorFore = "#f8f8f2"

color01="#000000"
color02="#ff5555"
color03="#50fa7b"
color04="#f1fa8c"
color05="#bd93f9"
color06="#ff79c6"
color07="#8be9fd"
color08="#bfbfbf"
color09="#4d4d4d"
color10="#ff6e67"
color11="#5af78e"
color12="#f4f99d"
color13="#caa9fa"
color14="#ff92d0"
color15="#9aedfe"
color16="#e6e6e6"

colorTrayer :: String
colorTrayer = "--tint 0x282a36"




-- myTerminal="alacritty"
myTerminal="alacrittyWow"
myModMask=mod4Mask
myBorderWidth=3
myBrowser="qutebrowser"

confirm :: String -> X () -> X ()
confirm msg f = do
    a <- dmenu [msg,"y", "n"]
    when (a=="y") f

myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {X.modMask = modMask}) = 
    -- this imports the orignal key binding from Xmonad, and then we can override them with our own bindings
    (`M.union` X.keys X.def conf) $ M.fromList $
    -- my own keybindings
    [
      ((modMask              , xK_Return), spawn $ X.terminal conf) -- %! Launch terminal
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_q), confirm "Quit?" $ io (exitWith ExitSuccess))
    -- , ((modMask, xK_r), sequence_[spawn "xmonad --recompile", spawn "xmonad --restart"])       -- Recompiles xmonad
    , ((modMask, xK_r), spawn "xmonad --recompile")       -- Recompiles xmonad
    , ((modMask .|. shiftMask, xK_r), spawn "xmonad --restart")         -- Restarts xmonad

    , ((modMask, xK_n), spawn myBrowser)         -- starts browser

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    ]
    ++
        [ ( (m .|. modMask, k), X.windows $ f i)
        | (i, k) <- zip (X.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0, xK_minus, xK_equal])
        -- , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
        , (f, m) <- 
            [ (W.view, noModMask)
            , (W.greedyView, controlMask)
            , (W.shift, shiftMask)
            ]
        ]
         -- [
         -- -- workspaces are distinct by screen
         --  ((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
         --       | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
         --       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         -- ]
         -- ++
         -- [
         -- -- swap screen order
         -- ((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
         --       | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
         --       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

                      
myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]
-- myWorkspaces = withScreens 2 ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myNormalBorderColor=undefined
myFocusedBorderColor=undefined
                      
                      
myMouseBindings=undefined
                      
                      
myLayoutHook = smartBorders $ myDefaultLayout
             where
               myDefaultLayout =    Tall 1 (3/100) (1/2) ||| Full

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)


clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- myManageHook=undefined
myEventHook=undefined
myLogHook=undefined
myStartupHook=undefined

