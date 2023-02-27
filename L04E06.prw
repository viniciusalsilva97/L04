#INCLUDE 'totvs.ch'

#DEFINE CUSUARIO "admin"
#DEFINE CSENHA "teste123"

User Function L04E06()
    local oDlg   := nil 
    local cTitle := "Login"
    local cText1 := "Usuário: "
    local cText2 := "Senha: "
    local cUser  := Space(20)
    local cPass  := Space(20)
    local nOpcao := 0
    local cMsg   := " "

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cUser size 55, 11 of oDlg pixel picture valid vazio()
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 030 MsGet cPass size 55, 11 of oDlg pixel password
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  
    
    if alltrim(cUser) == CUSUARIO 
        if alltrim(cPass) == CSENHA
            cMsg := "Acesso permitido"
        else
            cMsg := "Usuário ou senha inválidos"
        endif
    else
        cMsg := "Usuário ou senha inválidos"
    endif

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Resultado")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif
Return 
