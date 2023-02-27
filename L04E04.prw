#INCLUDE 'totvs.ch'

User Function L04E04()
    local oDlg   := nil 
    local cTitle := "Informe os valores"
    local cText1 := "Largura: "
    local cText2 := "Altura: "
    local cLarg  := Space(5)
    local cAltu  := Space(5)
    local nOpcao := 0
    local nArea  := 0
    local nTinta := 0
    local cMsg   := " "

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 034 MsGet cLarg size 55, 11 of oDlg pixel picture valid vazio()
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 034 MsGet cAltu size 55, 11 of oDlg pixel picture valid vazio()
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    nArea  := Val(cAltu) * Val(cLarg) 
    nTinta := nArea / 2

    cMsg := "A área da parede é de " + cValToChar(nArea) + "m²" + CRLF + CRLF + "A quantidade de tinta necessária para pintá-la é de " + cValToChar(nTinta) + " litros"

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Resultado")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif


Return 
