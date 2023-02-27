#INCLUDE 'totvs.ch'

User Function L04E09()
    local oDlg   := nil 
    local cTitle := "Vamos descobrir sua TMB"
    local cText1 := "Peso: "
    local cText2 := "Altura: "
    local cText3 := "Idade: "
    local cText4 := "[M/H]: "
    local cPeso  := Space(20)
    local cAltu  := Space(20)
    local cIdade := Space(20)
    local cEscol := Space(20)
    local nOpcao := 0
    local cMsg   := " "
    local cTmb   := 0

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cPeso size 55, 11 of oDlg pixel 
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 030 MsGet cAltu size 55, 11 of oDlg pixel 
    @ 054, 010 SAY cText3 size 55, 07 of oDlg PIXEL
    @ 050, 030 MsGet cIdade size 55, 11 of oDlg pixel 
    @ 074, 010 SAY cText4 size 55, 07 of oDlg PIXEL
    @ 070, 030 MsGet cEscol size 55, 11 of oDlg pixel 
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  
    
    if Upper(cEscol) == "M"
        cTmb := 655.1 + (9.563 * Val(cPeso)) + (1.850 * Val(cAltu)) - (4.676 * Val(cIdade))
    else
        cTmb := 66.5 + (13.75 * Val(cPeso)) + (5.003 * Val(cAltu)) - (6.75 * Val(cIdade))
    endif

    cMsg := "Esse é o valor da sua TMB: " + cValToChar(Round(cTmb,2))

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Resultado")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif
Return 
