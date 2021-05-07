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
			
			Random, flaxX, 633, 658 ; flax in inventory 
			Random, flaxY, 109, 129
			
			
			
			Random, spinX, 1269, 1289 ; spinflax icon where to click
			Random, spinY, 310, 328
			
			
			
			Random bankerY, 202, 252 ; banker relative 
			Random bankerX, 681, 772
			
			
			;Screen:	1004, 307  inv flax
			;Color:	0x034905
			
			;Screen: 894, 46  ; bankOpen
			;Color:	0x494034
			
			;Screen: 646, 126 ; flaxBank
			;Color:	0x034005
			
			;Screen:	1312, 215 spellbook
			;Color:	0x3C1510
			
			;Screen:	1229, 260 , invString
			;Color:	0x685C3E
			
			PixelGetColor, flaxBank, 646, 126, RGB ; checks for flax in bank
			PixelgetColor, flaxInv, 1004, 307, RGB ; checks for flax in inv
			PixelGetColor, bankOpen, 894, 46, RGB  ; checks if bank is open
			PixelGetColor, stringInv, 1229, 260, RGB  ; checks if the flax has been spun
			
			Random, chance, 1, 125 ; rolls chance for methods 
			
			Random, _break, 7418, 18472 ; small break
			
			Random, afk, 31453, 94329 ; afk
		}
		
		{ ; //// Main Method
			; vvvv Inventory / bank chekcs
			if flaxInv != 0x034905 ; if flax is not in inventory check if bank is open
				{
				flaxInInv = x
				if bankOpen != 0x494034 ; if there's no flax in inv and bank is not open
					{	
					flaxInInv = false
					bank()
					PixelGetColor, flaxBank, 646, 126, RGB 
					
					if flaxInInv = false ; checks for withdraw
						PixelGetColor, bankOpen, 894, 46, RGB  ; checks if bank is open
						{
						if bankOpen = 0x494034 ; checks for bank open
							PixelGetColor, stringInv, 1229, 260, RGB
						if stringInv = 0x685C3E
							depo()
						if flaxBank = 0x034005  ; if there is no flax in inv but flax in bank
							withdraw()
						if flaxBank != 0x034005 ; checks also if flax is in bank if not exits
							{
							MsgBox "No flax in bank"
							Pause
							;ExitApp
							}

						}					
					}
				}
				
			PixelgetColor, flaxInv, 1004, 307, RGB
			if flaxInv = 0x034905 ;  casts based on chance
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
	
	1::
	bank()  ;  trys to open bank 5 times 
	{
		Random bankerY, 202, 252
		Random bankerX, 681, 772
		Random, smallDelay, 323, 648
		Random, waitSpace, 675, 984
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
		if bankOpen = 0x494034
				break
		}
		PixelGetColor, flaxBank, 646, 126, RGB
		return
	}
	2::
	withdraw()  ; withdraws flax
	{
		Random, delay, 1367, 2759
		Random, flaxX, 633, 658 ; flax in inventory 
		Random, flaxY, 109, 129
		Random, moveSpeed, 22, 43 ; mouse move speed
		Random, smallDelay, 323, 648
		MouseMove, %flaxX%, %flaxY%, %moveSpeed%
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
	3::
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
	4::
	cast0() ; slower clicking
	{
	Random, spinX, 1269, 1289 ; spinflax icon where to click
	Random, spinY, 310, 328
	Random, loopCount, 3, 8
	PixelgetColor, flaxInv, 1004, 307, RGB
	while flaxInv = 0x034905
	{
		Random, moveSpeed, 22, 43
		Random, delay, 1367, 2759
		Random, smallDelay, 323, 648
		MouseMove, %spinX%, %spinY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay%
		PixelgetColor, flaxInv, 1004, 307, RGB
	}
	if chance >= 122
	Loop, %loopCount%
	{
		Random, moveSpeed, 22, 43
		Random, delay1, 183 , 538 
		Random, smallDelay, 323, 648
		MouseMove, %spinX%, %spinY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay1%
	}
	return
	}
	5::
	cast() ; faster clicking
	{
	PixelgetColor, flaxInv, 1004, 307, RGB
	Random, spinX, 1269, 1289 ; spinflax icon where to click
	Random, spinY, 310, 328
	Random, loopCount, 4, 13
	While flaxInv = 0x034905
	{
		Random, moveSpeed, 22, 43
		Random, delay1, 183 , 538 
		Random, smallDelay, 323, 648
		MouseMove, %spinX%, %spinY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay1%
		PixelgetColor, flaxInv, 1004, 307, RGB
	}
	if chance >= 122
	Loop, %loopCount%
	{
		Random, moveSpeed, 22, 43
		Random, delay1, 183 , 538 
		Random, smallDelay, 323, 648
		MouseMove, %spinX%, %spinY%, %moveSpeed%
		sleep %smallDelay%
		MouseClick
		Sleep %delay1%
	}
	return
	}
}
; Screen:	523, 125 (less often used) ; flax bank
; Color:	033703 
	