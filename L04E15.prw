#INCLUDE 'totvs.ch'
#INCLUDE 'topconn.ch'
#INCLUDE 'tbiconn.ch'

User Function L04E15()
    local oDlg    := nil 
    local oMsg    := nil 
    local aArea   := getArea()
    local cAlias  := GetNextAlias()
    local cAlias2 := "SB1"
    local cTitle  := "Vamos pesquisar o código"
    local cTitl2  := "Você quer cadastrar um novo produto?"
    local cText1  := "Código: "
    local cText2  := "[S/N]"
    local cCar    := Space(20)
    local cEsco   := Space(1)
    local cMsg    := ""
    local cCod    := ""
    local cDes    := ""
    local cPrv    := ""
    local cQuery  := ""
    local nOpcao  := 0
    local nOpc    := 0
    private cCadastro := "Cadastro"
    private aRotina   := {}

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC7' MODULO 'COM'

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cCar size 55, 11 of oDlg pixel  
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    cQuery := "SELECT B1_COD, B1_DESC, B1_PRV1 FROM " + retSqlName("SB1") + " SB1 WHERE B1_COD ='" + Upper(cCar) + "' AND D_E_L_E_T_ = ' '"

    TCQUERY cQuery ALIAS &(cAlias) NEW

    while &(cAlias) -> (!EOF())
        cCod := &(cAlias) -> (B1_COD)
        cDes := &(cAlias) -> (B1_DESC)
        cPrv := &(cAlias) -> (B1_PRV1)

        cMsg += "Código: " + cValToChar(cCod) + CRLF + "Descrição: " + cValToChar(cDes) + CRLF + "Preço de Venda: " + cValToChar(cPrv) + CRLF + "--------------------------------------------" + CRLF

        &(cAlias) -> (DbSkip())
    end

    &(cAlias) -> (DbCloseArea())
    restArea(aArea)

    if cMsg == ""

        cMsg := "Esse código não existe"
        FwAlertInfo(cMsg, "Atenção!")

        DEFINE MsDialog oMsg TITLE cTitl2 FROM 000, 000 TO 200, 300 PIXEL 
        @ 014, 010 SAY cText2 size 55, 07 of oDlg PIXEL
        @ 010, 030 MsGet cEsco size 55, 11 of oDlg pixel  
        DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpc := 1, oMsg:END()) ENABLE OF oMsg
        DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpc := 2, oMsg:END()) ENABLE OF oMsg
        ACTIVATE MSDIALOG oMsg CENTERED  

        if nOpc == 1 .and. Upper(cEsco) == "S"

            AADD( aRotina, {'Cadastrar', 'AxInclui', 0, 3} )
            DbSelectArea("SB1")
            DbSetOrder(1)
            MBrowse(,,,, cAlias2)
            DbCloseArea()

            Return 
        elseif nOpc == 2  
            FwAlertError("Você cancelou o programa", "Cancelado")
            Return 
        else 
            FwAlertInfo("Você não cadastrou nenhum novo produto", "Cancelado")  
            Return 
        endif
    endif  
    
    if nOpcao == 1
        FwAlertInfo(cMsg, 'Confere Código')
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif

Return 
