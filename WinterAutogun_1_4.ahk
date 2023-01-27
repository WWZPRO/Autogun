;This program was made by Wintersky, check my twitch channel on https://www.twitch.tv/legiox_wintersky


;================== DEFAULT CONFIGURATIONS ==================


#Persistent
#Singleinstance, Force


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


;================== SET VARIABLES FROM .INI ==================


IniRead, AutoGun, Autogun.ini, AutoGun, True
IniRead, Sound, Autogun.ini, Autogun, Sound, False
IniRead, SoundHK, Autogun.ini, Autogun, SoundHK, True
IniRead, cancancel, Autogun.ini, Autogun, cancancel, True
IniRead, ChkMouse5, Autogun.ini, Autogun, ChkMouse5, True
IniRead, ChkF8, Autogun.ini, Autogun, ChkF8, True
IniRead, cancelbyesc, Autogun.ini, Autogun, cancelbyesc, True
IniRead, melee, Autogun.ini, Autogun, melee, "F"
IniRead, rtime, Autogun.ini, Autogun, rtime, 1100
IniRead, AutoGunIni, Autogun.ini, Autogun


;================== Functions ==================


AutoShot() {
	If (AutoGun) {
		While GetKeyState("LButton","P")
            Click
	}
	Else
		Sendinput {Blind}{LButton down}
		KeyWait, LButton
		Sendinput {Blind}{LButton up}
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
    Gui, useri:New 
    Gui, Font, s20    
    Gui, Add, Link,, Check my <a href="https://www.twitch.tv/legiox_wintersky">Twitch Channel</a>
    Gui, Add, Link,, Source <a href="https://github.com/WWZPRO/Autogun">GitHub</a>
    Gui, Add, Text, y+20 , Autogun Settings:
    Gui, Add, CheckBox, x35 y+25 cBlue Checked%ChkMouse5% vChkMouse5 gSubmit_All, ` Hotkey Mouse Button 5 to Turn ON/OFF Autogun?
    Gui, Add, CheckBox, y+10 cBlue Checked%ChkF8% vChkF8 gSubmit_All, ` Hotkey F8 to Turn ON/OFF Autogun?
    Gui, Add, CheckBox, y+10 cRed Checked%AutoGun% vAutoGun gSubmit_All_Hide, ` Autogun ON/OFF State
    Gui, Add, CheckBox, y+50 cGreen Checked%Sound% vSound gSubmit_All, ` Sound for turn ON/OFF Autogun?
    Gui, Add, CheckBox, y+10 cBlue Checked%SoundHK% vSoundHK gSubmit_All, ` Hotkey F7 to Sound?
    Gui, Add, CheckBox, y+50 cGreen Checked%cancancel% vcancancel gSubmit_All, ` Reload Cancel?
    Gui, Add, CheckBox, y+10 Checked%cancelbyesc% vcancelbyesc gSubmit_All, ` Cancel by Esc (True) or Melee (False)?
    Gui, Add, Edit, r1 y+10 vmelee gSubmit_All, %melee%
    Gui, Add, Text, x+10, ` Type your Melee Keystoke
    Gui, Add, Edit, Number y+10 vrtime gSubmit_All, %rtime%
    Gui, Add, Text, x+10, ` Reload time before cancel in ms (default 1100)
    Gui, Add, Button, gSaveIni, Save to .ini
    Gui, Show
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
~$^LButton::AutoShot()
~$^+LButton::AutoShot()

~$R::(cc ? (cR()): )
~$^R::(cc ? (cR()): )

F5::useron()
F6::cancancel := !cancancel
~$F7::(SoundHK?Sound := !Sound:)
F9::ExitApp


;================== Labels ==================


Submit_All:
    Gui, Submit, NoHide
    Return

Submit_All_Hide:
    Gui, Submit
    Return

SaveIni:
    Sleep 100
    IniRead, AG, Autogun.ini
    If ([Autogun] = "ERROR") {
        IniWrite, [Autogun], Autogun.ini, AutoGun
    }
    Sleep 1000
    IniWrite, %AutoGun%, Autogun.ini, Autogun, AutoGun
    IniWrite, %Sound%, Autogun.ini, Autogun, Sound
    IniWrite, %SoundHK%, Autogun.ini, Autogun, SoundHK
    IniWrite, %cancancel%, Autogun.ini, Autogun, cancancel
    IniWrite, %ChkMouse5%, Autogun.ini, Autogun, ChkMouse5
    IniWrite, %ChkF8%, Autogun.ini, Autogun, ChkF8
    IniWrite, %cancelbyesc%, Autogun.ini, Autogun, cancelbyesc
    IniWrite, %melee%, Autogun.ini, Autogun, melee
    IniWrite, %rtime%, Autogun.ini, Autogun, rtime
    Sleep 100
    Return

