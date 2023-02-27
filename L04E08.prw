#INCLUDE 'totvs.ch'

User Function L04E08()
    local oDlg   := nil 
    local cTitle := "Vamos descobrir o seu IMC"
    local cText1 := "Peso: "
    local cText2 := "Altura: "
    local cPeso  := Space(20)
    local cAltu  := Space(20)
    local nOpcao := 0
    local cMsg   := " "
    local cImc   := 0

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 030 MsGet cPeso size 55, 11 of oDlg pixel 
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 030 MsGet cAltu size 55, 11 of oDlg pixel 
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  
    
    cImc := Val(cPeso) / (Val(cAltu) * Val(cAltu))

    if cImc < 18.5
        cMsg := "Seu IMC: " + cValToChar(Round(cImc,2)) + CRLF + CRLF + "Magreza - Obesidade grau 0" 
    elseif cImc > 18 .and. cImc < 24.9
        cMsg := "Seu IMC: " + cValToChar(Round(cImc,2)) + CRLF + CRLF + "Normal - Obesidade grau 0"
    elseif cImc >= 25 .and. cImc < 29.9
        cMsg := "Seu IMC: " + cValToChar(Round(cImc,2)) + CRLF + CRLF + "Sobrepeso - Obesidade grau I"
    elseif cImc >= 30 .and. cImc < 39.9
        cMsg := "Seu IMC: " + cValToChar(Round(cImc,2)) + CRLF + CRLF + "Obesidade - Obesidade grau II"
    else
        cMsg := "Seu IMC: " + cValToChar(Round(cImc,2)) + CRLF + CRLF + "Obesidade Grave - Obesidade grau III" 
    endif

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Resultado")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif
Return 
