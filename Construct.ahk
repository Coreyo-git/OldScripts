#SingleInstance, Force
SetControlDelay 2
SetKeyDelay 24
SetMouseDelay 3
SetBatchLines 2
CoordMode, Screen

F1::ExitApp
`::Pause

f3::
Settimer, end, 12000000
;Main()
{
/*
;Screen:	1221, 469 (less often used) plankInv
;Color:	0x483719 (Red=48 Green=37 Blue=19)

;cape
;Screen:	823, 48 (less often used)
;Color:	E8E6DD (Red=E8 Green=E6 Blue=DD)
	
;Screen:	1264, 431 (less often used) plankInv2
;Color:	0x483719 (Red=48 Green=37 Blue=19)

;		PixelGetColor, PlankInv, 1221, 469, RGB
;		Random Chance, 1, 1352
;		PixelSearch, OutputVarX, OutputVarY, 763, 34, 894, 126, 0xDDE648, 1, fast
;			if errorlevel 1
;				x = 1
;			else 
;				x = 0
*/
	Loop
	{
		PixelGetColor, CapeInv, 823, 48, RGB
		If PlankInv = 0x483719
			if CapeInv = 0xE8E6DD
				Build()
				
		PixelGetColor, CapeInv, 823, 48, RGB
		if CapeInv != 0xE8E6DD
			Remove()
		
		Random afk, 13457, 126543
		Random Chance, 1, 786
		if Chance >= 785
			Sleep %afk%
		
		PixelGetColor, PlankInv, 1221, 469, RGB
		If PlankInv != 0x483719
			Withdraw()
		
		Random afk, 13457, 126543
		Random Chance, 1, 234
		if Chance >= 234
			Sleep %afk%
	}
	
	;methods
	{
		2::
		Build()
		{
			Random, Delay, 128, 242
			Random RackX, 802, 882
			Random RackY, 38, 110 ; wall rack positionsRandom, MoveSpeed, 17, 26 ; mouse move speed
			Random, MoveSpeed, 17, 26 ; mouse move speed
			MouseMove, %RackX%, %RackY%, %MoveSpeed%
			sleep %Delay%
			MouseClick, Right
			MouseGetPos, ClickX, ClickY
			Random, Delay, 128, 242
			Sleep %Delay%
			
			; 800 - 711/843 -90 + 43
			Random, rPlusX, 2, 43 ; moves option right
			Random, rMinusX, 1 ,90 ; left
			PlusX = %rPlusX%
			MinusX = %rMinusX%
			PlusX += %ClickX%
			ClickX -= %MinusX% ; minus random off click location
			;Msgbox %PlusX%, %ClickX%
			
			Random, RBuildY, 50, 60 ; drops down to option
			BuildY = %RBuildY% ; stores range
			BuildY += %ClickY% ; adds range from location
			

			Random, MoveSpeed, 17, 26 ; mouse move speed
			MouseMove, %ClickX%, %BuildY%, %MoveSpeed%
			Random, Delay, 128, 242
			Sleep %Delay%
			MouseClick
			Random, MenuDelay, 746, 854
			Sleep %MenuDelay%
			SendInput {4 Down}
			Random, Delay, 90, 140
			Sleep %Delay%
			SendInput {4 Up}
			Random CraftSleep, 1383, 1532
			sleep %CraftSleep%
			return
		}
		3::
		Remove()
		{
			Random, MoveSpeed, 17, 26 ; mouse move speed
			Random, Delay, 128, 242
			Random RackX, 802, 882
			Random RackY, 38, 110 ; wall rack positionsRandom, MoveSpeed, 17, 26 ; mouse move speed
			MouseMove, %RackX%, %RackY%, %MoveSpeed%
			sleep %Delay%
			MouseClick, Right
			MouseGetPos, ClickX, ClickY
			Random, Delay, 128, 242
			Sleep %Delay%
			
			; 830 - 757/862 -90 + 43
			Random, rPlusX, 1, 32 ; moves option right
			Random, rMinusX, 1 ,73 ; left
			PlusX = %rPlusX%
			MinusX = %rMinusX%
			PlusX += %ClickX%
			ClickX -= %MinusX% ; minus random off click location
			;Msgbox %PlusX%, %ClickX%
			
			Random, RBuildY, 65, 75 ; drops down to option
			BuildY = %RBuildY% ; stores range
			BuildY += %ClickY% ; adds range from location
			

			Random, MoveSpeed, 17, 26 ; mouse move speed
			MouseMove, %ClickX%, %BuildY%, %MoveSpeed%
			Random, Delay, 128, 242
			Sleep %Delay%
			MouseClick
			Random, MenuDelay,  746, 954
			Sleep %MenuDelay%
			SendInput {1 Down}
			Random, Delay, 90, 140
			Sleep %Delay%
			SendInput {1 Up}
			Random CraftSleep, 1383, 1532
			sleep %CraftSleep%
			
			return
		}
		5::
		Withdraw()
		{
			;Color:	451B19 (Red=45 Green=1B Blue=19)
			

			;Color:	340C03 (Red=34 Green=0C Blue=03)
			
			PixelSearch, ButlerX, ButlerY, 562, 25, 1073, 362, 0x191B45, 5, Fast
			if ErrorLevel
			{			
				PixelSearch, ButlerX, ButlerY, 562, 25, 1073, 362, 0x030C34, 5, Fast
				if ErrorLevel
					{
					Msgbox not found
					ExitApp
					}
			}
			If ButlerX < 700
			{
				Random, MoveSpeed, 17, 26 ; mouse move speed
				Random ButlerX, 620, 676
				Random ButlerY, 120, 216
				Random, Delay, 128, 242
				MouseMove, %ButlerX%, %ButlerY%, %MoveSpeed%
				sleep %Delay%
				MouseClick
				Random, MenuDelay, 646, 854
				Sleep %MenuDelay%
				SendInput {1 Down}
				Random, Delay, 90, 140
				Sleep %Delay%
				SendInput {1 Up}
				
				Random, Delay, 300, 628
				Sleep %Delay%

				Random WaitNPC, 8143, 12234
				Sleep %WaitNPC%
				return
			}
			If ButlerX < 916
			{
				Random, MoveSpeed, 17, 26 ; mouse move speed
				Random ButlerX, 810, 885
				Random ButlerY, 210, 300
				Random, Delay, 128, 242
				MouseMove, %ButlerX%, %ButlerY%, %MoveSpeed%
				sleep %Delay%
				MouseClick
				Random, MenuDelay, 646, 854
				Sleep %MenuDelay%
				SendInput {1 Down}
				Random, Delay, 90, 140
				Sleep %Delay%
				SendInput {1 Up}
				
				Random, Delay, 300, 628
				Sleep %Delay%

				Random WaitNPC, 8143, 12234
				Sleep %WaitNPC%
				return
			}
			
			If ButlerX > 927
			{
				Random, MoveSpeed, 17, 26 ; mouse move speed
				Random ButlerX, 989, 1052
				Random ButlerY, 166, 244
				Random, Delay, 128, 242
				MouseMove, %ButlerX%, %ButlerY%, %MoveSpeed%
				sleep %Delay%
				MouseClick
				Random, MenuDelay, 646, 854
				Sleep %MenuDelay%
				SendInput {1 Down}
				Random, Delay, 90, 140
				Sleep %Delay%
				SendInput {1 Up}
				
				Random, Delay, 300, 628
				Sleep %Delay%

				Random WaitNPC, 8143, 12234
				Sleep %WaitNPC%
				return
			}

		}
	}
}
end:
MsgBox Exited
ExitApp