; #FUNCTION# ====================================================================================================================
; Name ..........: Imgloc Train System Helper functions
; Description ...:
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: TRLopes (October 2016)
; Modified ......:
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================





Func imglocTestQuickTrain($quickTrainOption=0)
	Local $currentRunState = $RunState
	$RunState = True
	SetLog(" TEST QUICK TRAIN IMGLOC START" )

	imglocOpenTrainWindow()
	If _Sleep(1000) Then Return
	Local $optBtn
	Local $QuickTrainTabArea =  "645,115,760,140"
	Local $QuickTrainTabBtn  =  isButtonVisible("QuickTrainTabBtn",@ScriptDir & "\imgxml\newtrainwindow\QuickTrain_0_0_93.xml",$QuickTrainTabArea)
	if $QuickTrainTabBtn <> "" then ClickP(decodeSingleCoord($QuickTrainTabBtn),1,300,"QuickTrainTabBtn") ; should switch to Quick Train Tab
			;now check tab area to see if tab color is white now (tab opened)
	If _Sleep(1000) Then Return
	Local $CheckTabBtn  =  isButtonVisible("CheckTabBtn",@ScriptDir & "\imgxml\newtrainwindow\CheckTab_0_0_98.xml",$QuickTrainTabArea) ;check same region for White Area when tab selected
	If $CheckTabBtn = "" Then ; not found, tab is not selected
		SetLog("COULD NOT QUICK TRAIN TAB" , $COLOR_INFO)
		ClickP($aAway, 1, 0, "#0000") ;Click Away
		Return
	EndIf
	If _Sleep(1000) Then Return
	Switch $quickTrainOption
		Case 0 ; Previous Army
			$region = "715,195,835,255"
			$optBtn  = isButtonVisible("Previous Army",@ScriptDir & "\imgxml\newtrainwindow\TrainPrevious_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Previous Army") ; should switch to Quick Train Tab
		Case 1 ; Army 1
			$region = "725,335,840,375"
			$optBtn  = isButtonVisible("Army1",@ScriptDir & "\imgxml\newtrainwindow\TrainArmy_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Army1") ; should switch to Quick Train Tab
		Case 2 ; Army 2
			$region = "725,455,840,495"
			$optBtn  = isButtonVisible("Army1",@ScriptDir & "\imgxml\newtrainwindow\TrainArmy_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Army1") ; should switch to Quick Train Tab
		Case 3 ; Army 3
			$region = "725,570,840,615"
			$optBtn  = isButtonVisible("Army1",@ScriptDir & "\imgxml\newtrainwindow\TrainArmy_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Army1") ; should switch to Quick Train Tab
	EndSwitch
	SetLog(" TEST QUICK TRAIN IMGLOC FINISH" )
	ClickP($aAway, 1, 0, "#0000") ;Click Away
		$RunState = $currentRunState
EndFunc

Func imglocTestTrain()
	Local $currentRunState = $RunState
	$RunState = True
	SetLog(" TEST TRAIN IMGLOC START test trains archer and rage spell" )
	imglocOpenTrainWindow()
	If _Sleep(1000) Then Return
	Local $optBtn
	;Train Troops
	Local $TrainTroopTabArea = "235,115,365,140"
	Local $TroopTrainTabBtn  =  isButtonVisible("TroopTrainTabBtn",@ScriptDir & "\imgxml\newtrainwindow\TrainTroops_0_0_90.xml",$TrainTroopTabArea)
	if $TroopTrainTabBtn <> "" then
		ClickP(decodeSingleCoord($TroopTrainTabBtn),1,300,"TroopTrainTabBtn") ; should switch to Troop Train Tab
		If _Sleep(1000) Then Return
		;now check tab area to see if tab color is white now (tab opened)
		Local $CheckTabBtn  =  isButtonVisible("TroopTrainTabBtn",@ScriptDir & "\imgxml\newtrainwindow\CheckTab_0_0_98.xml",$TrainTroopTabArea) ;check same region for White Area when tab selected
		If $CheckTabBtn = "" Then ; not found, tab is not selected
			SetLog("COULD NOT FIND TROOP TAB" , $COLOR_INFO)
			ClickP($aAway, 1, 0, "#0000") ;Click Away
			Return
		EndIf
		SetLog(" >> TESTING REGULAR TROOPS 10 Archer")
		Local $RegularTroops = imglocFindAvailableToTrain("regular")
		If IsArray($RegularTroops) Then
			imglocTrainIfAvailable($eArch,10,$RegularTroops)
		Else
			SetLog("COULD NOT FIND ANY REGULAR TROOPS ")
		EndIf
		SetLog(" << TESTING REGULAR TROOPS 10 Archer")
	EndIf
	If _Sleep(1000) Then Return

	SetLog(" >> TESTING SPELS 1 rage")
	Local $SpellTroopTabArea = "435,115,555,140"
	Local $SpellTrainTabBtn  =  isButtonVisible("SpellTrainTabBtn",@ScriptDir & "\imgxml\newtrainwindow\BrewSpells_0_0_90.xml",$SpellTroopTabArea)
	If $SpellTrainTabBtn <> "" then
		ClickP(decodeSingleCoord($SpellTrainTabBtn),1,300,"SpellTrainTabBtn") ; should switch to Quick Train Tab
		If _Sleep(1000) Then Return
		;now check tab area to see if tab color is white now (tab opened)
		Local $CheckTabBtn  =  isButtonVisible("TroopTrainTabBtn",@ScriptDir & "\imgxml\newtrainwindow\CheckTab_0_0_98.xml",$SpellTroopTabArea) ;check same region for White Area when tab selected
		If $CheckTabBtn = "" Then ; not found, tab is not selected
			SetLog("COULD NOT FIND SPELL TAB" , $COLOR_INFO)
			ClickP($aAway, 1, 0, "#0000") ;Click Away
			Return
		EndIf
		Local $AllSpells = imglocFindAvailableToTrain("spells")
		If IsArray($AllSpells) Then
			imglocTrainIfAvailable($eRSpell,1,$AllSpells)
		Else
			SetLog("COULD NOT FIND ANY SPELS ")
		EndIf
		SetLog(" << TESTING SPELS 1 Rage")
	EndIF
	If _Sleep(500) Then Return

	SetLog(" TEST TRAIN IMGLOC FINISH" )
	$RunState = $currentRunState
EndFunc



Func QuickTrain($quickTrainOption, $bOpenAndClose = True)
	SetLog("Starting Quick Train", $COLOR_INFO )
	If $bOpenAndClose = True Then 
		imglocOpenTrainWindow()
		If _Sleep(1000) Then Return
	EndIf
	Local $optBtn
	Local $QuickTrainTabArea =  "645,115,760,140"
	Local $QuickTrainTabBtn  =  isButtonVisible("QuickTrainTabBtn",@ScriptDir & "\imgxml\newtrainwindow\QuickTrain_0_0_93.xml",$QuickTrainTabArea)
	if $QuickTrainTabBtn <> "" then ClickP(decodeSingleCoord($QuickTrainTabBtn),1,300,"QuickTrainTabBtn") ; should switch to Quick Train Tab
	If _Sleep(1000) Then Return
	;now check tab area to see if tab color is white now (tab opened)
	Local $CheckTabBtn  =  isButtonVisible("CheckTabBtn",@ScriptDir & "\imgxml\newtrainwindow\CheckTab_0_0_98.xml",$QuickTrainTabArea) ;check same region for White Area when tab selected
	If $CheckTabBtn = "" Then ; not found, tab is not selected
		SetLog("COULD NOT FIND QUICK TRAIN TAB" , $COLOR_RED)
		If $bOpenAndClose = True Then ClickP($aAway, 1, 0, "#0000") ;Click Away
		Return
	EndIf
	If _Sleep(1000) Then Return
	Switch $quickTrainOption
		Case 0 ; Previous Army
			$region = "715,195,835,255"
			$optBtn  = isButtonVisible("Previous Army",@ScriptDir & "\imgxml\newtrainwindow\TrainPrevious_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Previous Army") ; should switch to Quick Train Tab
		Case 1 ; Army 1
			$region = "725,335,840,375"
			$optBtn  = isButtonVisible("Army1",@ScriptDir & "\imgxml\newtrainwindow\TrainArmy_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Army1") ; should switch to Quick Train Tab
		Case 2 ; Army 2
			$region = "725,455,840,495"
			$optBtn  = isButtonVisible("Army1",@ScriptDir & "\imgxml\newtrainwindow\TrainArmy_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Army1") ; should switch to Quick Train Tab
		Case 3 ; Army 3
			$region = "725,570,840,615"
			$optBtn  = isButtonVisible("Army1",@ScriptDir & "\imgxml\newtrainwindow\TrainArmy_0_0_92.xml",$region)
			if $optBtn <> "" then ClickP(decodeSingleCoord($optBtn),1,300,"Army1") ; should switch to Quick Train Tab
	EndSwitch
	SetLog("Quick Train Finished", $COLOR_INFO )
	If $bOpenAndClose = True Then ClickP($aAway, 1, 0, "#0000") ;Click Away
EndFunc



Func imglocTrainIfAvailable($nTroopEnum,$iQuantity, $imglocFoundArray)
	Local $sTroopName = decodeTroopEnum($nTroopEnum)
	If $debugsetlog = 1 Then SetLog($sTroopName & " / " & $nTroopEnum & " training if available!", $COLOR_DEBUG)
	Local $aLineValue
	For $iFA = 0 to ubound($imglocFoundArray) -1
		$aLineValue = $imglocFoundArray[$iFA] ; this should be an array of objectname,objectpoints,filename
		If $aLineValue[0] = $sTroopName Then ; found troop/spell to click
			If $debugsetlog = 1 Then SetLog($sTroopName & " / " & $nTroopEnum & " found. Checking availability!", $COLOR_DEBUG)
			;lets recheck if button is still available for clicking
			Local $tmpRectArea = GetDummyRectangle($aLineValue[1],20) ; get diamond from coords string using 20px distance
			Local $tmpTileName = $aLineValue[2] ; holds file path needed to recheck if still available for click
			Local $troopBtn =  isButtonVisible($aLineValue[1],$tmpTileName,$tmpRectArea)
			If $troopBtn <> "" then ClickP(decodeSingleCoord($troopBtn),$iQuantity,300,"$aLineValue[1]") ; should click $iQuantity of times

		EndIf
	Next
EndFunc


Func imglocFindAvailableToTrain($sTrainType)
    ;accepts "regular,dark,spells"
	;returns array with all found objects
	Local $sCocDiamond = "15,360|840,365|840,585|15,585" ; diamond of troops / spells in train window
	Local $redLines = $sCocDiamond ; search own village overrride redline
	Local $minLevel=0   ; We only support TH6+
	Local $maxLevel=1000
	Local $maxReturnPoints = 1 ; only need one match for each image
	Local $returnProps="objectname,objectpoints,filepath"
	Local $sDirectory = @ScriptDir & "\imgxml\newtrainwindow\" & $sTrainType & "\"
	If $debugsetlog = 1 Then SetLog("imgloc Searching Regular Troops :  in " & $sCocDiamond & " using "&  $sDirectory, $COLOR_INFO)
	Local $bForceCapture = True ; force CaptureScreen
	;aux data
	If $debugsetlog = 1 Then SetLog("imgloc train search : " & $sTrainType, $COLOR_DEBUG)
	Local $hTimer = TimerInit()
	Local $result = findMultiple($sDirectory ,$sCocDiamond ,$redLines, $minLevel, $maxLevel, $maxReturnPoints , $returnProps, $bForceCapture )
	Return $result

EndFunc