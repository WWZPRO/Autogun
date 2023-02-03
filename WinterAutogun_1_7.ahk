;This program was made by Wintersky, check my twitch channel on https://www.twitch.tv/legiox_wintersky


;================== DEFAULT CONFIGURATIONS ==================


#Persistent
#Singleinstance, Force


;================== OBJECTS ==================


global weaponlist := [{Name: "Assault Shotgun", ReloadTime: "1100", Bullets: 20, Type:"T3"},{Name: "Advanced Combat Weapon", ReloadTime: "1100", Bullets: 15, Type:"T3"},{Name: "Assault Carbine", ReloadTime: "1100", Bullets: 60, Type:"T3"},{Name: "Light Automatic Weapon", ReloadTime: "4400", Bullets: 125, Type:"T2"},{Name: "Goncho Mark II", ReloadTime: "600", Bullets: 3, Type:"T3"},{Name: "Battle Riffle", ReloadTime: "1100", Bullets: 25, Type:"T3"},{Name: "Bullpup Riffle", ReloadTime: "1100", Bullets: 45, Type:"T3"},{Name: "Sniper Riffle", ReloadTime: "1100", Bullets: 30, Type:"T2"},{Name: "Advanced SMG", ReloadTime: "1100", Bullets: 60, Type:"T3"},{Name: "Special SMG", ReloadTime: "1250", Bullets: 40, Type:"T3"},{Name: "Crossbow", ReloadTime: "1025", Bullets: 5, Type:"T3"},{Name: "Assault Rifle", ReloadTime: "1100", Bullets: 50, Type:"T2"},{Name: "Sporting Carbine", ReloadTime: "1000", Bullets: 30, Type:"T2"},{Name: "Classic Battle Rifle", ReloadTime: "1100", Bullets: 30, Type:"T2"},{Name: "Classic Bullpup Riffle", ReloadTime: "1300", Bullets: 42,Type:"T2"},{Name: "SMG", ReloadTime: "1150", Bullets: 50, Type:"T2"},{Name: "Combat Shotgun",ReloadTime: "1000", Bullets: 12, Type:"T2"},{Name: "Scout Riffle", ReloadTime: "1025", Bullets: 30, Type:"T1"},{Name: "Compact SMG", ReloadTime: "1075", Bullets: 48, Type:"T1"},{Name: "Shotgun", ReloadTime: "900", Bullets: 12, Type:"T1"},{Name: "Pistol", ReloadTime: "750", Bullets: 20, Type:"S"},{Name: "Machine Pistol", ReloadTime: "700", Bullets: 30, Type:"S"},{Name: "PDW", ReloadTime: "1000", Bullets: 40, Type:"S"},{Name: "Compact Shotgun", ReloadTime: "900", Bullets: 4, Type:"S"},{Name: "Double Barrel Shotgun", ReloadTime: "750", Bullets: 2, Type:"S"},{Name: "Revolver", ReloadTime: "1050", Bullets: 6, Type:"S"},{Name: "Grenade Launcher", ReloadTime: "675", Bullets: 1, Type:"S"}]



;================== Global Variables ==================


global AutoGun := True
global Sound := False
global SoundHK := True
global cancancel := True
global cc := True
global ChkMouse5 := True
global ChkF8 := True
global cancelbyesc := True 
global melee := "F"
global rtime := 1100
global AutoGunIni := ""
global hkweap := F10
global weapcustom := weaponlist
global restoretodefault := False
global rts := {}


;================== SET VARIABLES FROM .INI ==================


IniRead, AutoGun, Autogun.ini, Autogun, AutoGun, True
IniRead, Sound, Autogun.ini, Autogun, Sound, False
IniRead, SoundHK, Autogun.ini, Autogun, SoundHK, True
IniRead, cancancel, Autogun.ini, Autogun, cancancel, True
IniRead, ChkMouse5, Autogun.ini, Autogun, ChkMouse5, True
IniRead, ChkF8, Autogun.ini, Autogun, ChkF8, True
IniRead, cancelbyesc, Autogun.ini, Autogun, cancelbyesc, True
IniRead, melee, Autogun.ini, Autogun, melee, "F"
IniRead, rtime, Autogun.ini, Autogun, rtime, 1100
IniRead, hkweap, Autogun.ini, Autogun, hkweap, F10
IniRead, AutoGunIni, Autogun.ini, Autogun


;================== MAIN ==================



Gosub, AssignHK
Goto, SaveWeapIni



;================== Functions ==================


AutoShot() {
	If (AutoGun) {
		While GetKeyState("LButton","P")
            Send {LButton}
	}
	Else
		Sendinput {Blind}{~$LButton down}
        KeyWait, LButton
		Sendinput {Blind}{~$LButton up}
        Return
}

FlipON() {
    If (AutoGun) { 
        If (Sound)
            SoundBeep, 300, 120
    }
	Else { 
        If (Sound)    
            SoundBeep, 500, 120
    }
    AutoGun := !AutoGun
    Return
}

cR() {
    if (cancancel) {
        cc := False
        Send {R}
        Sleep %rtime%
        cbt()
        Sleep 100
        cbt()
        Sleep 300
        cc := True
    }
    Return
}

cbt() {
    If (cancelbyesc){
        Send {Esc} 
    }
    Else {
        Send {%melee%}
    }
}

useron() {
    If (WinExist("AutogunOptions")) {
        WinClose, AutogunOptions
    }
    Else {
        Gui, useri:New,,AutogunOptions
        Gui, Font, s12
        Gui, Add, Button, y20 x20 gExit_All, Close Autogun App
        Gui, Font, s20    
        Gui, Add, Link, x35 , Check my <a href="https://www.twitch.tv/legiox_wintersky">Twitch Channel</a>
        Gui, Add, Link, x35 , Source <a href="https://github.com/WWZPRO/Autogun">GitHub</a>
        Gui, Add, Text, y+20 , Autogun Settings:
        Gui, Add, CheckBox, x35 y+25 cBlue Checked%ChkMouse5% vChkMouse5 gSubmit_All, ` Hotkey Mouse Button 5 to Turn ON/OFF Autogun?
        Gui, Add, CheckBox, y+10 cBlue Checked%ChkF8% vChkF8 gSubmit_All, ` Hotkey F8 to Turn ON/OFF Autogun?
        Gui, Add, CheckBox, y+10 cRed Checked%AutoGun% vAutoGun gSubmit_All_Hide, ` Autogun ON/OFF State
        Gui, Add, CheckBox, y+20 cGreen Checked%Sound% vSound gSubmit_All, ` Sound for turn ON/OFF Autogun?
        Gui, Add, CheckBox, y+10 cBlue Checked%SoundHK% vSoundHK gSubmit_All, ` Hotkey F7 to Sound?
        Gui, Add, CheckBox, y+20 cGreen Checked%cancancel% vcancancel gSubmit_All, ` Reload Cancel?
        Gui, Add, CheckBox, y+10 cGreen Checked%cancelbyesc% vcancelbyesc gSubmit_All, ` Cancel by Esc (True) or Melee (False)?
        Gui, Add, Edit, w50 y+10 vmelee gSubmit_All, %melee%
        Gui, Add, Link, x+15, ` Type your Melee <a href="https://www.autohotkey.com/docs/v1/KeyList.htm">Keystoke</a>
        Gui, Add, Edit, w80 Number y+15 x35 vrtime gSubmit_All, %rtime%
        Gui, Add, Text, x+10, ` Reload time before cancel in ms (default 1100)
        Gui, Add, Button, gShowWeaps, Show Weapons
        Gui, Add, Edit, w70 h40 y+30 x35 vhkweap gAssignHK, %hkweap%
        Gui, Add, Text, x+10, ` Hotkey to open Weapon Selection
        Gui, Add, Button, y+25 x5 gRemoveHK, Delete Hotkey
        Gui, Add, Text, x+10, ` Select a Hotkey to fast select your weapons `n to get the auto time reload cancel   
        GuiControlget, vhkweap, FocusV
        Gui, Font, s10
        Gui, Add, Text, y+5 x5, ` (if this hotkey bugs, you have to close this app and open again)
        Gui, Font, s30
        Gui, Add, Button, y+5 x30 gSaveIni, Save to .ini
        ;Gui, Add, Button, y+10 gSaveWeapIni, Save Weapons
        Gui, Font, s12
        ;Gui, Add, CheckBox, x+200 cRed Checked%restoretodefault% vrestoretodefault gSubmit_All, ` Restore to default weapons?
        Gui, Show
        Return
    }
}

wr() {
    Gui, Submit
        For n, l in rts {
            If (WeapP%n% > 0) {
                rtime := n 
            }
        }
    Return
}

;================== BUTTONS ==================


~$XButton2::(ChkMouse5?FlipON():)
~$+XButton2::(ChkMouse5?FlipON():)
~$^XButton2::(ChkMouse5?FlipON():)
~$^+XButton2::(ChkMouse5?FlipON():)
~$F8::(ChkF8?FlipON():)
~$+F8::(ChkF8?FlipON():)
~$^F8::(ChkF8?FlipON():)
~$^+F8::(ChkF8?FlipON():)
~$LButton::AutoShot()
~$+LButton::AutoShot()
^LButton::AutoShot()
~$^+LButton::AutoShot()

~$R::(cc ? (cR()): )
~$^R::(cc ? (cR()): )

~$F5::useron()
~$F6::cancancel := !cancancel
~$F7::(SoundHK?Sound := !Sound:)
F9::ExitApp

FastHK:
    Goto ShowWeaps
    Return

ShowWeaps:
    Gui, weap:New
    Gui, Font, s12
    Gui, -Border -SysMenu +Owner -Caption +ToolWindow
    oy := 32
    py := 13
    gby := 5
    nrt := 0
    rts := {}
    For each, i in weapcustom {
        h := weapcustom[A_Index].Type
        name := weapcustom[A_Index].Name  
        rt := weapcustom[A_Index].ReloadTime
        rts[rt] .= name . "`n"
    }
    For m, n in rts {
        RegExReplace(n, "`n",, fg)    
        gbh := 35+(fg*20)
        zy := oy-py 
        Gui, Add, GroupBox, y%zy% x30 w350 h%gbh% cFF0000, 
        Gui, Add, Radio, y%oy% x50 vWeapP%m% gSubmit_Radio, %m%
        Gui, Add, Text, y%oy% x130, %n%   
        oy += 30+(20*fg)
    }
    posX := (A_ScreenWidth/2)+350
    Gui, Show, w400 x%posX%
    Return


;================== Labels ==================


Submit_All:
    Gui, Submit, NoHide
    Return

Submit_All_Hide:
    Gui, Submit
    Return

AssignHK:
    Hotkey, %hkweap%, Toggle, UseErrorLevel
    Gui, Submit, NoHide
    if (hkweap == "") {
        Return
    }
    Else{
        Hotkey, %hkweap%, FastHK
    }
    Return


RemoveHK:
    Hotkey, %hkweap%, Off, UseErrorLevel
    hkweap := ""
    Return

SaveIni:
    Sleep 100
    IniWrite, %AutoGun%, Autogun.ini, Autogun, AutoGun
    IniWrite, %Sound%, Autogun.ini, Autogun, Sound
    IniWrite, %SoundHK%, Autogun.ini, Autogun, SoundHK
    IniWrite, %cancancel%, Autogun.ini, Autogun, cancancel
    IniWrite, %ChkMouse5%, Autogun.ini, Autogun, ChkMouse5
    IniWrite, %ChkF8%, Autogun.ini, Autogun, ChkF8
    IniWrite, %cancelbyesc%, Autogun.ini, Autogun, cancelbyesc
    IniWrite, %melee%, Autogun.ini, Autogun, melee
    IniWrite, %rtime%, Autogun.ini, Autogun, rtime
    IniWrite, %hkweap%, Autogun.ini, Autogun, hkweap
    Sleep 100
    Return

SaveWeapIni:
    if (restoredefault){
        for each, item in weaponlist
        IniWrite, % weaponlist[A_Index].ReloadTime . "-" . weaponlist[A_Index].Bullets . "-" . weaponlist[A_Index].Type, Autogun.ini, Weapons, % weaponlist[A_Index].Name
    }
    else{
        for each, item in weapcustom
        IniWrite, % weapcustom[A_Index].ReloadTime . "-" . weapcustom[A_Index].Bullets . "-" . weapcustom[A_Index].Type, Autogun.ini, Weapons, % weapcustom[A_Index].Name
    }
    Return

Submit_Radio:  
    wr()
    Return

Exit_All:
    ExitApp

