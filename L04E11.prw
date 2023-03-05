#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

User Function L04E11()
    local oDlg              := nil
    local oGetCodigoProduto := nil  
    local oBtnPesquisar     := nil  
    local cCodigo := space(20)
    local cTitulo := "Pesquise pelo código de um produto"

    oDlg := tDialog():New(180,180,550,700,cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

        oGetCodigoProduto := TGet():New(50,90,{| u | If( PCount() == 0, cCodigo, cCodigo := u )},oDlg,40,1,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,cCodigo,,,,.t.)

        oBtnPesquisar:= tButton():New(70, 90, "Pesquisar",oDlg,{||buscaSql(cCodigo)}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F.)

    oDlg:Activate(,,,.t.,,,)
Return 

Static Function buscaSql(cCodigo)
    local aArea  := getArea()
    local cAlias := getNextAlias()
    local cQuery := ""
    local cCod   := ""
    local cDesc  := ""
    local cPreco := ""

    prepare environment empresa '99' filial '01' tables 'SB1' modulo 'com'

    cQuery += "SELECT B1_COD, B1_DESC, B1_PRV1  FROM " + retSqlName("SB1") + " SB1 WHERE B1_COD = '" + cCodigo + "' AND D_E_L_E_T_ = ' '"

    tcquery cQuery alias &(cAlias) new 

    cCod   := &(cAlias) -> (B1_COD)
    cDesc  := &(cAlias) -> (B1_DESC)
    cPreco := &(cAlias) -> (B1_PRV1)

    if empty(cCod)
        fwAlertError("O código digitado não está cadastrado no sistema", "Atenção")
    else 
        fwAlertSuccess("Código: " + cValToChar(cCod) + CRLF + "Descrição: " + cValToChar(cDesc) + CRLF + "Preço de Venda: " + cValToChar(cPreco))
    endif 

    &(cAlias) -> (dbCloseArea())
    restArea(aArea) 
Return 
