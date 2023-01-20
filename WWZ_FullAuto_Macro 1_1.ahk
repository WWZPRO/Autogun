#Persistent
#Singleinstance, Force

global AutoGun := False

AutoShot() {
	If (AutoGun == True) {
		While GetKeyState("LButton","P")
			Click
	}
	Else
		Sendinput {Blind}{LButton down}
		KeyWait, LButton
		Sendinput {Blind}{LButton up}
}

XButton2::
	If (AutoGun = False) 
			AutoGun := True
	Else 
			AutoGun := False
	Return

F8::
	If (AutoGun = False) 
			AutoGun := True
	Else 
			AutoGun := False
	Return

LButton::AutoShot()
+LButton::AutoShot()
^LButton::AutoShot()
^+LButton::AutoShot()

F9::
	ExitApp
