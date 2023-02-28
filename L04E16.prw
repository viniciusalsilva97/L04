#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

User Function L04E16()
    local aArea  := getArea()
    local oDlg   := nil 
    local cAlias := GetNextAlias()
    local cTitle := "Vamos pesquisar por Estado"
    local cText1 := "Estado:"
    local cEst   := Space(20)
    local cMsg   := ""
    local cCod   := ""
    local cUf    := ""
    local cQuery := ""
    local nCont := 0

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'COM'

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cEst size 55, 11 of oDlg pixel  
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    cQuery := "SELECT A2_NOME, A2_EST FROM " + RetSqlName("SA2") + " SA2 WHERE A2_EST = '" + Upper(cEst) + "' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias) -> (!EOF())
        cCod  := &(cAlias) -> (A2_NOME)
        cUf  := &(cAlias) -> (A2_EST)

        cMsg += "Fornecedor: " + cValToChar(cCod) + CRLF + "Estado: " + cValToChar(cUf) + CRLF +"---------------------------------------" + CRLF

        nCont++
        if nOpcao == 1 .and. nCont == 10
            FwAlertInfo(cMsg, 'Resultado')
            nCont := 0
            cMsg  := ''
        elseif nOpcao == 2
            FwAlertError("Você cancelou o programa", "Cancelado")    
        endif

        &(cAlias) -> (DbSkip())
    end

    if cMsg == ""
        cMsg := "Esse código não foi cadastrado!"
    endif  
    
    if nOpcao == 1 .and. nCont > 0
        FwAlertInfo(cMsg, 'Resultado')
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif

    &(cAlias) -> (DbCloseArea())
    restArea(aArea)
Return 

