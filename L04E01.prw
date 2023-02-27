#INCLUDE 'totvs.ch'

User Function L04E01()
    local oDlg   := nil 
    local cTitle := "Informe dois números"
    local cText1 := "Número: "
    local cText2 := "Número: "
    local cNum1  := Space(5)
    local cNum2  := Space(5)
    local nOpcao := 0
    local nSoma  := 0
    local nSubt  := 0
    local nProd  := 0
    local nDivi  := 0
    local cMsg   := " "

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cNum1 size 55, 11 of oDlg pixel picture valid vazio()
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 030 MsGet cNum2 size 55, 11 of oDlg pixel picture valid vazio()
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    nSoma := Val(cNum1) + Val(cNum2)
    nSubt := Val(cNum1) - Val(cNum2)
    nProd := Val(cNum1) * Val(cNum2)
    nDivi := Val(cNum1) / Val(cNum2)

    cMsg := "Soma: " + cValToChar(nSoma) + CRLF + CRLF + "Subtração: " + cValToChar(nSubt) + CRLF + CRLF + "Produção: " + cValToChar(nProd) + CRLF + CRLF + "Divisão: " + cValToChar(Round(nDivi,2))

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Resultado das operações Aritméticas")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif
Return 
