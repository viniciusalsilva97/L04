#INCLUDE 'totvs.ch'

User Function L04E03()
    local oDlg   := nil 
    local cTitle := "Reajuste Salarial"
    local cText1 := "Salário: "
    local cText2 := "Reajuste: "
    local cSala  := Space(10)
    local cReaj  := Space(5)
    local nOpcao := 0
    local nCalc  := 0
    local cMsg   := " "

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 034 MsGet cSala size 55, 11 of oDlg pixel picture "@E 9999.99"
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 034 MsGet cReaj size 55, 11 of oDlg pixel picture "@E 9.99"
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    nCalc := Val(cSala) + (Val(cSala) * Val(cReaj))

    cMsg := "R$: " + cValToChar(Round(nCalc,2))

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Esse é o seu salário com reajuste")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif


Return 
