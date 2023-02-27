#INCLUDE 'totvs.ch'

#DEFINE nINSS 0.1
#DEFINE nFGTS 0.11
User Function L04E10()
    local oDlg   := nil 
    local cTitle := "Cálculo da folha de Pagamento"
    local cText1 := "Valor da Hora"
    local cText2 := "Horas Trabalhadas"
    local cValHo := Space(20)
    local cHoTra := Space(20)
    local nOpcao := 0
    local cMsg   := " "
    local nSalarioBruto, nSalarioLiquido, nIR, nTotalDescontos, nDescIR, nDescINSS, nDescFGTS
    
    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 060 MsGet cValHo size 55, 11 of oDlg pixel 
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 060 MsGet cHoTra size 55, 11 of oDlg pixel 
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED 

    nSalarioBruto := Val(cValHo) * Val(cHoTra) 
    
    if nSalarioBruto <= 1200
        nIr := 0
    elseif nSalarioBruto > 1200 .and. nSalarioBruto <= 1800
        nIr := 0.05
    elseif nSalarioBruto > 1800 .and. nSalarioBruto <= 2500
        nIr := 0.1
    elseif nSalarioBruto > 2500
        nIr := 0.2
    endif

    nDescIR := nSalarioBruto * nIr
    nDescINSS := nSalarioBruto * nINSS
    nDescFGTS := nSalarioBruto * nFGTS

    nTotalDescontos := nDescIr + nDescINSS + nDescFGTS

    nSalarioLiquido := nSalarioBruto - nTotalDescontos

    cMsg := "Salário Bruto: R$ " + cValToChar(Round(nSalarioBruto, 2)) + CRLF + CRLF + "( - ) IR (" + cValToChar(nIr*100) + "%) :R$ " + cValToChar(Round(nDescIR, 2)) + CRLF +  CRLF + "( - ) INSS (10%): R$ " + cValToChar(Round(nDescINSS, 2)) + CRLF +  CRLF + "FGTS (11%): R$ " + cValToChar(Round(nDescFGTS, 2)) + CRLF +  CRLF + "Total de Descontos: R$ " + cValToChar(Round(nTotalDescontos, 2)) + CRLF +  CRLF + "Salário Líquido: R$ " +cValToChar(Round(nSalarioLiquido, 2))

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Folha de Pagamento")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif
Return 
