#INCLUDE 'totvs.ch'

User Function L04E07()
    local oDlg   := nil 
    local cTitle := "Login"
    local cText1 := "Usuário:"
    local cText2 := "Senha:"
    local cText3 := "Confirma Senha:"
    local cCadastro := Space(20) 
    local cSenhaR := Space(20)
    local cConfirmaSenha := Space(20)   
    local nOpcao, nI 
    local lVerificaCadastro := .t.
    local cTeste, cMsg := " "
    local lTamanhoNome, lSenhaIgual, lTamanhoSenha, lSenhaMaiuscula, lSenhaNumero, lSenhaSimbolo 

    while lVerificaCadastro
        DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
        @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
        @ 010, 050 MsGet cCadastro size 55, 11 of oDlg pixel 
        @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
        @ 030, 050 MsGet cSenhaR size 55, 11 of oDlg pixel //password
        @ 054, 010 SAY cText3 size 55, 07 of oDlg PIXEL
        @ 050, 050 MsGet cConfirmaSenha size 55, 11 of oDlg pixel //password
        DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
        DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
        ACTIVATE MSDIALOG oDlg CENTERED 

        if Len(cCadastro) < 5 
            lTamanhoNome := .f.
        elseif alltrim(cSenhaR) <> alltrim(cConfirmaSenha)
            lSenhaIgual := .f.
        elseif Len(cSenhaR) < 6
            lTamanhoSenha := .f.
        else
            lTamanhoNome  := .t.
            lSenhaIgual   := .t.
            lTamanhoSenha := .t.

            for nI := 1 to len(alltrim(cSenhaR))
                cTeste := Substr(alltrim(cSenhaR), nI, 1) 

                if IsUpper(cTeste) 
                    lSenhaMaiuscula := .t.
                elseif IsDigit(cTeste)
                    lSenhaNumero := .t.
                elseif Type(cTeste) == "U" 
                    lSenhaSimbolo := .t.
                endif
                
            next nI
        endif 

        if lTamanhoNome .and. lSenhaIgual .and. lTamanhoSenha .and. lSenhaMaiuscula .and. lSenhaNumero .and. lSenhaSimbolo .and. nOpcao == 1
            cMsg := "Seu username: "+ cValToChar(cCadastro) + CRLF + "Sua senha: " + cValToChar(cSenhaR)
            lVerificaCadastro := .f.
            FwAlertSuccess(cMsg,"Resultado")
        elseif nOpcao == 2
            FwAlertError("Você cancelou o programa", "Cancelado")
            lVerificaCadastro := .f.
        else
            FwAlertInfo("Você precisa criar o seu cadastro de acordo com as regras", "Atenção")
            cCadastro      := Space(20)
            cSenhaR        := Space(20)
            cConfirmaSenha := Space(20)
        endif
    end
Return 
