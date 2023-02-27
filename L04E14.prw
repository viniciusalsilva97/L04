#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

User Function L04E14()
    local oDlg   := nil 
    local cAlias := "SC6"
    local cTitle := "Escolha um produto para ver o seu pedido de venda"
    local cNum   := ""
    local cMsg   := "Esses são os pedidos de venda" + CRLF + CRLF
    private cCadastro := "Meus Clientes"
    Private oCmb   := nil 
    Private cItens := '01' 
    Private cProd  := "" 
    private aProdutos := {} 

    DbSelectArea(cAlias)
    DbSetOrder(2)
    DbGoTop()

    while &(cAlias) -> (!EOF())
        AADD(aProdutos, SC6 -> C6_PRODUTO)
        &(cAlias) -> (DbSkip())
    end 

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 1000, 1000 PIXEL 
        oCmb  := TComboBox():New(87, 118, {|u| Iif(PCount() > 0 , cItens := u, cItens)}, aProdutos, 50, 35, oDlg, , , , , , .t.,)
        DEFINE SBUTTON FROM 62, 252 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
        DEFINE SBUTTON FROM 104, 252 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED 

    if nOpcao == 1
        DbGoTop()
        while &(cAlias) -> (!EOF())
            cProd := SC6 -> C6_PRODUTO
            if cItens == AllTrim(cProd)
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
