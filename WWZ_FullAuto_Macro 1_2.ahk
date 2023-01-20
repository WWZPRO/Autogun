#Persistent
#Singleinstance, Force

global AutoGun := True
global Sound := False
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
F9::
	ExitApp

F7::Sound := !Sound


















