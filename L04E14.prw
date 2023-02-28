#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

//* Deixei comentado a parte referente ao uso do TComboBox.
//* Da forma como está agora, funciona como consulta padrão.

User Function L04E14()
    local oDlg   := nil 
    local cAlias := "SC6"
    local cCodigo := Space(10)
    local cTitle := "Escolha um produto para ver o seu pedido de venda"
    local cNum   := ""
    local cMsg   := "Esses são os pedidos de venda" + CRLF + CRLF
    local cProd  := "" 
    private cCadastro := "Meus Clientes"
    Private oCmb   := nil 
    // Private cItens := '01' 
    // private aProdutos := {} 
    
    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'COM'

    DbSelectArea(cAlias)
    DbSetOrder(2)
    DbGoTop()

    // while &(cAlias) -> (!EOF())
    //     AADD(aProdutos, SC6 -> C6_PRODUTO)
    //     &(cAlias) -> (DbSkip())
    // end 

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 300, 500 PIXEL 
        @ 014, 050 MsGet cCodigo F3 "SB1" SIZE 55, 11 of oDlg PIXEL HASBUTTON
        // oCmb  := TComboBox():New(87, 118, {|u| Iif(PCount() > 0 , cItens := u, cItens)}, aProdutos, 50, 35, oDlg, , , , , , .t.,)
        DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
        DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED 

    if nOpcao == 1
        // DbGoTop()
        while &(cAlias) -> (!EOF())
            cProd := SC6 -> C6_PRODUTO
            if AllTrim(cCodigo) == AllTrim(cProd)
                cNum := SC6 -> C6_NUM
                cMsg += cValToChar(cNum) + CRLF + "---------------------------------------------" + CRLF + CRLF 
            endif
            &(cAlias) -> (DbSkip())
        end
        FwAlertInfo(cMsg)
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif  

Return 
