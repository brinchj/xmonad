module XMonad.Hooks.UrgencyExtra (LibNotifyUrgencyHook(..)) where

import XMonad
import XMonad.Hooks.UrgencyHook(UrgencyHook(..))
import XMonad.Util.NamedWindows(getName)
import XMonad.Util.Run(safeSpawn)
import qualified XMonad.StackSet as W

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
  urgencyHook LibNotifyUrgencyHook w = do
    name <- getName w
    ws <- gets windowset
    whenJust (W.findTag w ws) (flash name)
      where flash name index =
              if index `elem` ["irc", "im", "hangouts", "pidgin"]
              then spawn "blink || notify --urgent \"Someone is talking to you!\""
              else safeSpawn "notify" ["--urgent", index ++ ": " ++ show name]
