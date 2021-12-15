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
import XMonad.Hooks.ManageDocks

import System.IO

main :: IO ()
main = do
    -- xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/" ++ colorScheme ++ "-xmobarrc")
    -- xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/dracula-xmobarrc")
    -- xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/archXmobarrc")

    xmproc <- spawnPipe "xmobar"
    xmonad $ docks$  def
        {
            terminal           = myTerminal
            , borderWidth        = myBorderWidth
            , modMask            = myModMask

            , focusFollowsMouse  = True

            , keys               = myKeys

            -- workspaces         = myWorkspaces,
            , focusedBorderColor = "#f8f8f2"
            , normalBorderColor = "#282a36"

            -- key bindings
            -- mouseBindings      = myMouseBindings,

            -- hooks, layouts
            , layoutHook         = myLayoutHook
            -- manageHook         = myManageHook,
            -- handleEventHook    = myEventHook,
            -- logHook            = myLogHook,
            -- startupHook        = myStartupHook
            , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }

         ,manageHook = myManageHook <+> manageHook defaultConfig -- make sure to include myManageHook definition from above
        }

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

colorScheme="dracula"
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

--myKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
--myKeys conf@(XConfig {X.modMask = modMask}) = M.fromList $
-- -- launching and killing programs
--    [ ((modMask              , xK_Return), spawn $ X.terminal conf) -- %! Launch terminal
--    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
--    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
--    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window
--
--    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
--    , ((modMask .|. shiftMask, xK_space ), setLayout $ X.layoutHook conf) -- %!  Reset the layouts on the current workspace to default
--
--    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size
--
--    -- move focus up or down the window stack
--    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
--    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
--    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
--    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
--    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window
--
--    -- modifying the window order
--    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
--    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
--    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
--
--    -- resizing the master/slave ratio
--    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
--    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area
--
--    -- floating layer support
--    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling
--
--    -- increase or decrease number of windows in the master area
--    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
--    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area
--
--    -- quit, or restart
--    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
--    , ((modMask              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
--
--    , ((modMask .|. shiftMask, xK_slash ), helpCommand) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
--    -- repeat the binding for non-American layout keyboards
--    , ((modMask              , xK_question), helpCommand) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
--    ]
--    ++
--    -- mod-[1..9] %! Switch to workspace N
--    -- mod-shift-[1..9] %! Move client to workspace N
--    [((m .|. modMask, k), windows $ f i)
--        | (i, k) <- zip (X.workspaces conf) [xK_1 .. xK_9]
--        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--    ++
--    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
--    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
--    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
--        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
--        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
--    ++
--    -- my own keybindings
--    [( (modMask .|. shiftMask, xK_q), confirm "Quit?" $ io exitSuccess)]
--  where
--    helpCommand :: X ()
--    helpCommand = spawn ("echo " ++ show help ++ " | xmessage -file -")
--
--    help=""
                      
myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]

myNormalBorderColor=undefined
myFocusedBorderColor=undefined
                      
                      
myMouseBindings=undefined
                      
                      
myLayoutHook = smartBorders $ myDefaultLayout
             where
               myDefaultLayout =    Tall 1 (3/100) (1/2) ||| Full




myManageHook=undefined
myEventHook=undefined
myLogHook=undefined
myStartupHook=undefined
