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
-- import XMonad.Hooks.DynamicBars
import XMonad.Hooks.ManageDocks

import System.IO

import XMonad.Hooks.EwmhDesktops

import XMonad.Util.EZConfig(additionalKeys)

import Data.Maybe

import XMonad.Layout.IndependentScreens
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers

import qualified XMonad.Hooks.WorkspaceHistory as WH

import XMonad.Prelude (find, findIndex, isJust, isNothing, liftM2)


-- super super braindead & nice way to switch between workspaces holy
import XMonad.Actions.CycleWS


main :: IO ()
main = do

    spawn "killall trayer"  -- kill current trayer on each restart
    -- spawn ("sleep 2 && trayer --edge top --align right --widthtype request  --SetDockType true --SetPartialStrut true --expand true  --transparent true --alpha 0 --height 16")
    spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor primary --transparent true --alpha 0 --height 16")


    xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/archXmobarrc")
    xmproc1 <- spawnPipe ("xmobar -x 1 ~/.config/xmobar/archXmobarrc")

    -- xmonad $  withEasySB (mySBL <> mySBR) defToggleStrutsKey $ docks $ def
    -- xmonad $  dynamicEasySBs barSpawner  $ def
    xmonad $  ewmh $ docks $ def
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
            , focusedBorderColor = myFocusedBorderColor
            , normalBorderColor = myNormalBorderColor


            , handleEventHook    = handleEventHook def 

            -- , handleEventHook    = handleEventHook def <+> docks

            -- , logHook = dynamicLogWithPP xmobarPP
            --             { -- ppOutput = hPutStrLn xmproc0,
            --              ppTitle = xmobarColor "green" "" 
            --             , ppVisible = xmobarColor "#FFFFFF" ""
            --             }
            -- , logHook = myXmobarLogHook xmproc0 0 <+> myXmobarLogHook xmproc1 1 

            -- , logHook = let log screen handle = dynamicLogWithPP . marshallPP screen $ myPP $ handle
            --           in log 0 xmproc0 >> log 1 xmproc1

            -- , logHook = myLog 0 xmproc0 >> myLog 1 xmproc1

            , logHook =  
                         -- myXmobarLogHook 0 xmproc0 
                         -- >>
                         -- myXmobarLogHook 1 xmproc1

                    (dynamicLogWithPP . marshallPP 0 $ xmobarPP
                         -- (   dynamicLogWithPP  $ xmobarPP
                         { ppOutput = hPutStrLn xmproc0 
                          , ppTitle = \x -> "" -- will display title in ppExtras
                          -- , ppTitle = logTitles formatFocused formatUnfocused
                         , ppHidden = xmobarColor "white" "" . clickable 0
                          -- , ppExtras = [logTitleOnScreen 0]
                         , ppExtras = [logWhenActive 0 $ logTitles formatFocused formatUnfocused
                                            --,W.screen . W.current . windowset

                                        ]
                         } )
                    >>
                    (
                    dynamicLogWithPP . marshallPP 1 $ xmobarPP
                         -- (   dynamicLogWithPP  $ xmobarPP
                         { ppOutput = hPutStrLn xmproc1
                          , ppTitle = \x -> "" -- will display title in ppExtras
                          -- , ppTitle = logTitles formatFocused formatUnfocused
                         , ppHidden = xmobarColor "white" "" . clickable 1
                          -- , ppExtras = [logTitleOnScreen 0]
                         , ppExtras = [logWhenActive 1 $ logTitles formatFocused formatUnfocused]
                         } )


            -- key bindings
            -- mouseBindings      = myMouseBindings,

            -- hooks, layouts
            -- logHook            = myLogHook,
            -- , startupHook        = dynStatusBarStartup $ startupHook defaultConfig

        }
    where
    formatFocused   =  xmobarColor "green" "" . shorten 50 . xmobarStrip
    -- formatUnfocused = wrap "(" ")" . xmobarColor "#bd93f9" "" . shorten 30 . xmobarStrip
    formatUnfocused = \x -> ""


myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

-- myLog screen handle = dynamicLogWithPP . marshallPP screen $ xmobarPP
--          { ppOutput = hPutStrLn handle 
--           , ppTitle = xmobarColor "green" "" 
--          , ppVisible = xmobarColor "#FFFFFF" "" .clickable screen
--          } 
-- 

myXmobarLogHook screenNum handle =
       dynamicLogWithPP . marshallPP screenNum $ xmobarPP
                         -- (   dynamicLogWithPP  $ xmobarPP
                         { ppOutput = hPutStrLn handle 
                          , ppTitle = \x -> "" -- will display title in ppExtras
                          -- , ppTitle = logTitles formatFocused formatUnfocused
                         , ppHidden = xmobarColor "white" "" . clickable screenNum
                          -- , ppExtras = [logTitleOnScreen 0]
                         , ppExtras = [logWhenActive screenNum $ logTitles formatFocused formatUnfocused]
                         } 
    where
    formatFocused   =  xmobarColor "green" "" . shorten 50 . xmobarStrip
    -- formatUnfocused = wrap "(" ")" . xmobarColor "#bd93f9" "" . shorten 30 . xmobarStrip
    formatUnfocused = \x -> ""


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


    -- switch between adjacent workspaces
    , ((modMask .|. shiftMask, xK_l),  moveTo Next spacesOnCurrentScreen)
    , ((modMask .|. shiftMask, xK_h),  moveTo Prev spacesOnCurrentScreen)
    , ((modMask .|. controlMask .|. shiftMask, xK_l),  shiftTo Next spacesOnCurrentScreen)
    , ((modMask .|. controlMask .|. shiftMask, xK_h),  shiftTo Prev spacesOnCurrentScreen)
    -- toggle between previous workspace
    -- TODO: right now it can toggle between different screens...
    -- , ((modMask              , xK_Tab),     toggleWS)
    , ((modMask              , xK_Tab),     mytoggleWS' )
    ]
    ++
        -- [ ( (m .|. modMask, k), X.windows $ f i)
        -- | (i, k) <- zip (X.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0, xK_minus, xK_equal])
        -- -- , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
        -- , (f, m) <- 
        --     [ (W.view, noModMask)
        --     , (W.greedyView, controlMask)
        --     , (W.shift, shiftMask)
        --     ]
        -- ]
          [
          -- workspaces are distinct by screen
           ((m .|. modMask, k), windows $ onCurrentScreen f i)
                | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
                , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
          ]
          ++
          [((m .|. modMask, key), sc >>= screenWorkspace >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [(screenBy (-1)),(screenBy 1)]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
         -- ++
         -- [
         -- -- swap screen order
         --  ((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
         --        | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
         --        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

                      
myWorkspaces :: [WorkspaceId]
-- myWorkspaces = map show [1 .. 9 :: Int]
myWorkspaces = withScreens 2 ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myFocusedBorderColor="#22d661"
myNormalBorderColor="#444444"
                      
                      
                      
                      
myLayoutHook = smartBorders $ myDefaultLayout
             where
               myDefaultLayout =    Tall 1 (3/100) (1/2) ||| Full

-- myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces ([1..9] ++ [1..9]) -- (,) == \x y -> (x,y)


clickable monitorIndex ws = "<action=xdotool key super+"++show i ++">"++ws++"</action>"
-- clickable monitorIndex ws = workStr
    where 
    workStr = show monitorIndex ++"_"++ ws
    i = fromJust $ M.lookup workStr myWorkspaceIndices

-- clickable ws = "<action=xdotool key super+"++ show i++">"++ws++"</action>"
--     where i = fromJust $ M.lookup ws myWorkspaceIndices

-- windowCount :: X (Maybe String)
-- windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset



isOnScreen :: ScreenId -> WindowSpace -> Bool
isOnScreen s ws = s == unmarshallS (W.tag ws)

currentScreen :: X ScreenId
currentScreen = gets (W.screen . W.current . windowset)

spacesOnCurrentScreen :: WSType 
spacesOnCurrentScreen = 
    WSIs $ do
           s <- currentScreen
           return  $ isOnScreen s

genIndepTag i = map (\x -> str ++ show x) [1..9]
    where
    str = show i ++ "_"


{--
mylastViewedHiddenExcept :: X (Maybe WorkspaceId)
mylastViewedHiddenExcept= do
    curS <- currentScreen
    let wdfS = if curS == 0 then 1 else 0
    hs <- gets $ map W.tag . flip skipTags (genIndepTag wdfS). W.hidden . windowset
    choose hs . find (`elem` hs) <$> WH.workspaceHistory
    where choose []    _           = Nothing
          choose (h:_) Nothing     = Just h
          -- choose (h:_) Nothing     = Nothing
          choose _     vh@(Just _) = vh
--}

{--
mylastViewedHiddenExcept :: X (Maybe WorkspaceId)
mylastViewedHiddenExcept = do
    curS <- currentScreen
    hs <- gets $ map W.tag . flip skipTags [] . W.hidden . windowset
    -- hs <- gets $ map W.tag . flip skipTags (genIndepTag curS) . W.hidden . windowset
    -- choose hs . find (\(sid,a) -> if curS == sid then a `elem` hs else False) <$> WH.workspaceHistoryWithScreen 
    choose hs . find (\(sid,a) ->  a `elem` hs ) <$>   (\l ->  filter (\(sid,a) -> curS == sid) l)  <$> WH.workspaceHistoryWithScreen 
        where 
            choose []    _           = Nothing
            choose (h:_) Nothing     = Just h
            choose _     (Just (_,h)) = Just h
--}

-- {--
mylastViewedHiddenExcept :: X (Maybe WorkspaceId)
mylastViewedHiddenExcept = do
    curS <- currentScreen
    hs <- gets $ map W.tag . W.hidden . windowset
    -- hs <- gets $ map W.tag . flip skipTags (genIndepTag curS) . W.hidden . windowset
    choose curS hs . find (`elem` hs ) <$>   f curS WH.workspaceHistoryByScreen 
    -- f curS WH.workspaceHistoryByScreen 
        where 
            f :: ScreenId -> X [(ScreenId, [WorkspaceId])]  ->X [WorkspaceId]
            -- f gets the workspace Ids of the current screen
            f curS wdfl = 
                (\l ->  foldr (\(sid,l) acc -> if sid==curS then l else acc ) [] l) <$> wdfl
            choose _ []    _           = Nothing
            -- find the first physical (not virtual) workspace that is on the current screen!
            choose curS l Nothing = 
                foldl g Nothing l
                where
                g acc@(Just a) _ = acc
                g Nothing e = 
                        let (sid, e') = unmarshall e in
                        if sid == curS then Just e else Nothing
            choose _ _  (Just h) = Just h
--}


mytoggleWS' ::  X ()
mytoggleWS' = mylastViewedHiddenExcept >>= flip whenJust (windows . W.view)

-- getToggleWSList = M.map f myWorkspaceIndices
--     where
--     sid = do 
--             s <- currentScreen 
--             return s
--     workStr = show sid ++"_"
--     i = fromJust $ M.lookup workStr myWorkspaceIndices
--     f = undefined











-- myManageHook=undefined
myEventHook=undefined
myLogHook=undefined
myStartupHook=undefined
myMouseBindings=undefined

