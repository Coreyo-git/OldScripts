#SingleInstance, Force
SetControlDelay 4
SetKeyDelay 4
SetMouseDelay 5
SetBatchLines 4
CoordMode, Screen

F1::ExitApp
`::Pause

f3::
Main()
{
	Loop
	{
		{ ; //// Variable instantiations
			Random, moveSpeed, 22, 43 ; mouse move speed

			Random depoX, 989, 1012 ; Store all button
			Random depoY, 323, 346

			Random, smallDelay, 323, 648 ; delay between mouse clciks etc
			Random, delay, 1367, 2759  ; delays for casts
			Random, delay1, 183 , 538 
			Random, waitSpace, 694, 1143 ; Waits for bank open/close i think ? lol
			
			Random, hideX, 728, 755  ; Hide in bank
			Random, hideY, 111, 130
			
			
			
			Random, tanX, 1154, 1166  ; spinflax icon where to click
			Random, tanY, 340, 352
			
			
			
			Random bankerY, 202, 252 ; banker relative 
			Random bankerX, 681, 772
			
			;Screen:	977, 121 (less often used)   ; hideBank
			;Color:	0x4A4443 (Red=4A Green=44 Blue=43)
			
			;Screen:	1015, 334 (less often used) hideinv
			;Color:	0x4A4443 (Red=4A Green=44 Blue=43)
			
			;Screen:	595, 151 (less often used)  ; bank open
			;Color:	0x494034 (Red=2F Green=2B Blue=2B)
			
			;Screen:	1104, 347 (less often used)
			;Color:	0xFF00FF (Red=FF Green=00 Blue=FF)
			
			;Screen:	1104, 347 (less often used)
			;Color:	0x002A03 (Red=00 Green=2A Blue=03)   ; newest leath
			
			;Screen:	1104, 347 (less often used)
			;Color:	0x033203 (Red=03 Green=32 Blue=03)    ; leatherInv
			
			PixelGetColor, hideBank, 977, 121, RGB ; checks for hide in bank
			PixelgetColor, hideInv, 1015, 334, RGB ; checks for hide in inv
			PixelGetColor, bankOpen, 894, 46, RGB  ; checks if bank is open
			PixelGetColor, leatherInv, 1104, 347, RGB  ; checks if the hide has been tanned
			
			Random, chance, 1, 125 ; rolls chance for methods 
			
			Random, _break, 7418, 18472 ; small break
			
			Random, afk, 31453, 94329 ; afk
		}
		
		
		
		{ ; //// Main Method
			; vvvv Inventory / bank chekcs
			if hideInv != 0x4A4443 ; if flax is not in inventory check if bank is open
				{
				hideInInv = x
				if bankOpen != 0x494034 ; if there's no flax in inv and bank is not open
					{	
					hideInInv = false
					bank()
					PixelGetColor, hideBank, 977, 121, RGB ; checks for hide in bank 

					if hideInInv = false ; checks for withdraw
						PixelGetColor, bankOpen, 894, 46, RGB  ; checks if bank is open
						{
						if bankOpen = 0x494034 ; checks for bank open
							PixelGetColor, leatherInv, 1104, 347, RGB
						;if leatherInv = 0xFF00FF  ; checks for leather in inventory then banks
						ImageSearch, invX, invY, 8, 29, 1270, 703, C:\Users\XGaming Systems\Documents\ahk\r\tan\leather2.png
							if (Errorlevel = 0)
								depo()
						PixelGetColor, hideBank, 977, 121, RGB ; checks for hide in bank
						if hideBank = 0x4A4443  ; if there is no flax in inv but flax in bank
							withdraw()
						if hideBank != 0x4A4443 ; checks also if flax is in bank if not exits
							{
							MsgBox "No hide in bank"
							Pause
							;ExitApp
							}
	
						}					
					}
				}
			PixelgetColor, hideInv, 1015, 334, RGB ; checks for hide in inv
			if hideInv = 0x4A4443 ;  casts based on chance
			{
				PixelGetColor, spellBook, 1312, 215, RGB
				if spellBook = 0x3C1510 ; checks if spellbook is open before casting
				{
					Random, chance, 1, 125
					if chance <=62
						cast0()
					else if chance > 63
						cast()
				}
				if spellBook != 0x3C1510 ; checks if spellbook is open before casting
				{
					Random, bookX, 1292, 1308
					Random, bookY, 194, 218
					Random, moveSpeed, 22, 43 ; mouse move speed
					MouseMove, %bookX%, %bookY%, %moveSpeed%
					sleep %smallDelay%
					MouseClick, Left
					Random, smallDelay, 323, 648 ; delay between mouse clciks etc
					sleep %smallDelay%
				}
			}
			{ ; break/afk chance
			Random, chance, 1, 125 
			Random, sleeper, 4923, 16154
			Random, afk, 31453, 94329
			if chance > 123
				sleep %afk%
			if chance < 10
				sleep %sleeper%
			}
		}
	}
}
 
{ ; //// Methods
	

	bank()  ;  trys to open bank 5 times 
	{
		Random bankerY, 202, 252
		Random bankerX, 681, 772
		Random, smallDelay, 323, 648
		Random, waitSpace, 800, 1462
		Random, moveSpeed, 22, 43 ; mouse move speed
		loop, 5
		{
		
		MouseMove, %bankerX%, %bankerY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		sleep %waitSpace%
		PixelGetColor, bankOpen, 894, 46, RGB  ; checks if bank is open
		Random bankerY, 202, 252
		Random bankerX, 681, 772
		Random, smallDelay, 323, 648
		Random, waitSpace, 675, 984
		Random, moveSpeed, 22, 43 ; mouse move speed
		sleep %smallDelay%
		PixelGetColor, bankOpen, 894, 46, RGB  ; checks if bank is open
		if bankOpen = 0x494034
			break
		}
		PixelGetColor, hideBank, 977, 121, RGB ; checks for hide in bank
		PixelGetColor, leatherInv, 1104, 347, RGB
		return
	}

	withdraw()  ; withdraws flax
	{
		Random, delay, 1367, 2759
		Random, hideX, 972, 993  ; Hide in bank
		Random, hideY, 111, 130
		Random, moveSpeed, 22, 43 ; mouse move speed
		Random, smallDelay, 323, 648
		MouseMove, %hideX%, %hideY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick, Left
		
		Random, chance, 1, 125
		if chance <=80
		{
			Random, smallDelay, 323, 648
			Random, moveSpeed, 22, 43 ; mouse move speed
			Random, bankCloseX, 1037, 1051
			Random, bankCloseY, 37, 52
			MouseMove, %bankCloseX%, %bankCloseY%, %moveSpeed%
			sleep %smallDelay%
			MouseClick
			Random, smallDelay, 323, 648
			sleep %smallDelay%
			
		}
		else if chance > 81
		{
		Random, smallDelay, 323, 648
		sleep %delay%
		SendInput {Escape down} ; closes bank
		Random, smallDelay, 323, 648
		sleep %smallDelay%
		SendInput {Escape up}
		Random, smallDelay, 323, 648
		sleep %smallDelay%
		}
		return
	}

	depo() ; deposits strings
	{  ; deposits hitting deposit inventory
		Random, smallDelay, 323, 648 ; delay between mouse clciks etc
		Random depoX, 989, 1012 ; Store all button
		Random depoY, 323, 346
		Random, moveSpeed, 22, 43 ; mouse move speed
		MouseMove, %depoX%, %depoY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick, Left
		Random, smallDelay, 323, 648 ; delay between mouse clciks etc
		sleep %smallDelay%
		return
	}

	cast0() ; slower clicking
	{
	Random, tanX, 1154, 1166  ; spinflax icon where to click
	Random, tanY, 340, 352
	Random, loopCount, 3, 8
	PixelgetColor, hideInv, 1015, 334, RGB ; checks for hide in inv
	while hideInv = 0x4A4443
	{
		Random, moveSpeed, 22, 43
		Random, delay, 1367, 2759
		Random, smallDelay, 323, 648
		MouseMove, %tanX%, %tanY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay%
		PixelgetColor, hideInv, 1015, 334, RGB ; checks for hide in inv
	}
	Random, chance, 1, 125 
	if chance >= 122
	Loop, %loopCount%
	{
		Random, moveSpeed, 22, 43
		Random, delay1, 183 , 538 
		Random, smallDelay, 323, 648
		MouseMove, %tanX%, %tanY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay1%
	}
	return
	}

	cast() ; faster clicking
	{
	PixelgetColor, hideInv, 1015, 334, RGB ; checks for hide in inv
	Random, tanX, 1154, 1166  ; spinflax icon where to click
	Random, tanY, 340, 352
	Random, loopCount, 4, 13
	While hideInv = 0x4A4443
	{
		Random, moveSpeed, 22, 43
		Random, delay1, 563 , 947 
		Random, smallDelay, 356, 1538
		MouseMove, %tanX%, %tanY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay1%
		PixelgetColor, hideInv, 1015, 334, RGB ; checks for hide in inv
	}
	Random, chance, 1, 125 
	if chance >= 122
	Loop, %loopCount%
	{
		Random, moveSpeed, 22, 43
		Random, delay1, 563 , 947 
		Random, smallDelay, 356, 1538
		MouseMove, %tanX%, %tanY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay1%
	}
	return
	}
}	