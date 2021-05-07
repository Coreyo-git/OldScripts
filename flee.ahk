#SingleInstance, Force
SetControlDelay 2
SetKeyDelay 2
SetMouseDelay 2
SetBatchLines 2
CoordMode, Screen

F1::ExitApp
`::Pause,Toggle

F3:: 
Loop
{	
	{ ; Random Variables
		
	Random, moveSpeed, 1, 3,
	
	Random bankerY, 165, 220
	Random bankerX, 567, 680
	
	Random, bowX, 511, 541
	Random, bowY, 196, 221
	
	Random, stringX, 560, 584
	Random, stringY, 196, 223
	
	Random, ibowX, 1043, 1064
	Random, ibowY, 344, 366
	
	Random, istringX, 1086, 1109
	Random, istringY, 344, 366
	
	Random, CloseBankY, 36, 56
	Random, closeBankX, 916, 935
	
	Random, delay, 350, 700
	Random, waitCraft, 18000, 25000
	Random, waitSpace, 600, 1000

	Random depoX, 868, 893
	Random depoY, 323, 346
	
	}
	
	PixelGetColor, StringCheck, 584, 218, RGB
	if StringCheck = 0x685C3E ; checks if there's bow string before starting else breaks
	{
		Random chance, 0, 100
	}

	else
	{
		MsgBox "notfound"
		break		
	}

	if chance >= 50
	{
		MouseMove, %stringX%, %stringY%, %moveSpeed%
		sleep %delay%
		MouseClick, Left
		sleep %delay%
		MouseMove, %bowX%, %bowY%, %moveSpeed%
		MouseClick
		sleep %delay%
		SendInput {Escape down} ; closes bank
		sleep %delay%
		SendInput {Escape up}
		sleep %delay%
		PixelGetColor, invCheck, 1079, 214, RGB
	}
	if chance < 50
	{
		MouseMove, %bowX%, %bowY%, %moveSpeed%
		sleep %delay%
		MouseClick
		sleep %delay%
		MouseMove, %stringX%, %stringY%, %moveSpeed%
		sleep %delay%
		MouseClick, Left
		sleep %delay%
		SendInput {Escape down} ; closes bank
		sleep %delay%
		SendInput {Escape up}
		sleep %delay%
		PixelGetColor, invCheck, 1079, 214, RGB
	}

	if invCheck = 0x643913 ; checks if the inventory is open before comnbining bow/string in  inv else breaks
	{
		Random chance, 0, 100
	}
	else 
	{
		break
	}
	if chance >= 50 
	{
		MouseMove, %ibowX%, %ibowY%, %moveSpeed%
		MouseClick
		sleep %delay%
		MouseMove, %istringX%, %istringY%, %moveSpeed%
		MouseClick, Left
		sleep %waitSpace%
		SendInput {Space down} ; starts craft
		sleep %delay%
		SendInput {Space up}
		sleep %waitCraft%
	}
	if chance <50 
	{
		MouseMove, %istringX%, %istringY%, %moveSpeed%
		MouseClick, Left
		sleep %delay%
		MouseMove, %ibowX%, %ibowY%, %moveSpeed%
		MouseClick
		sleep %waitSpace%
		SendInput {Space down} ; starts craft
		sleep %delay%
		SendInput {Space up}
		sleep %waitCraft%
	}
PixelGetColor, bankOpen, 612, 48, RGB 
if bankOpen != 0xFF981F 
	loop, 5
	{
		MouseMove, %bankerX%, %bankerY%, %moveSpeed%
		sleep %delay%
		MouseClick, Left
		sleep %waitSpace%
		PixelGetColor, bankOpen, 612, 48, RGB 
		Random bankerY, 165, 220
		Random bankerX, 567, 680
		if bankOpen = 0xFF981F
			break
	}
	MouseMove, %depoX%, %depoY%, %moveSpeed%
	sleep %delay%
	MouseClick, Left
	sleep %delay%
}