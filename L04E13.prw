#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

User Function L04E13()
    local aArea  := getArea()
    local oDlg   := nil 
    local cAlias := GetNextAlias()
    local cTitle := "Vamos pesquisar o código"
    local cText1 := "Código: "
    local cCar   := Space(20)
    local cMsg   := ""
    local cPed   := ""
    local cQuery := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cCar size 55, 11 of oDlg pixel  
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    cQuery := "SELECT C6_PRODUTO, C6_NUM FROM " + RetSqlName("SC6") + " SC6 WHERE C6_PRODUTO ='" + Upper(cCar) + "' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias) -> (!EOF())
        cPed := &(cAlias) -> (C6_NUM)

        cMsg += cValToChar(cPed) + CRLF + "---------------------------------------------" + CRLF + CRLF 

        &(cAlias) -> (DbSkip())
    end

    if cMsg == ""
        cMsg := "Esse código não foi cadastrado!"
    endif  
    
    if nOpcao == 1
        FwAlertInfo(cMsg, 'Pedidos de compra vinculados ao código')
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif

    &(cAlias) -> (DbCloseArea())
    restArea(aArea)
Return 
