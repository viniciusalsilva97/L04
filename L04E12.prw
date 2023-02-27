#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

User Function L04E12()
    local aArea  := getArea()
    local oDlg   := nil 
    local cAlias := GetNextAlias()
    local cTitle := "Informe as datas"
    local cText1 := "Data Inicio"
    local cText2 := "Data Fim"
    local dDatIn := Space(15)
    local dDatFi := Space(15)
    local cMsg   := ""
    local cQuery := ""
    local nCont  := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 040 MsGet dDatIn size 55, 11 of oDlg pixel picture "@E 99/99/9999" 
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 040 MsGet dDatFi size 55, 11 of oDlg pixel picture "@E 99/99/9999"
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    cQuery := "SELECT C5_NUM FROM " + RetSqlName("SC5") + " SC5 WHERE C5_EMISSAO BETWEEN '" + DTOS(CTOD(dDatIn)) + "' AND '" + DTOS(CTOD(dDatFi)) + "' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias) -> (!EOF())
        cPedidoDeVenda := &(cAlias) -> (C5_NUM)

        cMsg += "Pedidos de Venda: " + cValToChar(cPedidoDeVenda) + CRLF + "---------------------------------------" + CRLF

        nCont++
        if nOpcao == 1 .and. nCont == 10
            FwAlertInfo(cMsg, 'Pedidos do Periódo Escolhido')
            nCont := 0
            cMsg  := ''
        elseif nOpcao == 2
            FwAlertError("Você cancelou o programa", "Cancelado")    
        endif

        &(cAlias) -> (DbSkip())
    end 
    
    if nOpcao == 1 .and. nCont > 0
        FwAlertInfo(cMsg, 'Confere Código')
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif

    &(cAlias) -> (DbCloseArea())
    restArea(aArea)
Return 
