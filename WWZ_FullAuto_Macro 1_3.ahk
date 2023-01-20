#Persistent
#Singleinstance, Force

global AutoGun := True
global Sound := False
global cancancel := True
global cc := True
AutoShot() {
	If (AutoGun) {
		While GetKeyState("LButton","P")
            Click
	}
	Else
		Sendinput {Blind}{LButton down}
		KeyWait, LButton
		Sendinput {Blind}{LButton up}
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
}
XButton2::FlipON()
+XButton2::FlipON()
^XButton2::FlipON()
^+XButton2::FlipON()
F8::FlipON()
+F8::FlipON()
^F8::FlipON()
^+F8::FlipON()
LButton::AutoShot()
+LButton::AutoShot()
^LButton::AutoShot()
^+LButton::AutoShot()

~$R::(cc ? (cR()): )
~$+R::(cc ? (cR()): )
~$^R::(cc ? (cR()): )
~$^+R::(cc ? (cR()): )

cR() {
    if (cancancel) {
        cc := False
        BlockInput, ON
        Send {R}
        Sleep 1100
        Send {Esc}
        Sleep 100
        Send {Esc}
        BlockInput, OFF
        Sleep 300
        cc := True
    }
}

F6::cancancel := !cancancel
F7::Sound := !Sound
F9::ExitApp

















