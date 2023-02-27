#INCLUDE 'totvs.ch'

#DEFINE NCAMBIO 5.19

User Function L04E02()
    local oDlg   := nil 
    local cTitle := "Informe quantos dólares você tem"
    local cText1 := "Dólares:"
    local cDolar := Space(5)
    local nOpcao := 0
    local nConve := 0
    local cMsg   := " "

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cDolar size 55, 11 of oDlg pixel picture valid vazio()
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    nConve := Val(cDolar) * NCAMBIO 

    cMsg := "Valor em Reais: R$ " + cValToChar(Round(nConve,2))

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Conversão de Dólares para Reais")
    else
        FwAlertError("Você cancelou a operação", "Cancelado")
    endif


Return 
