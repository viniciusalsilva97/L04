#INCLUDE 'totvs.ch'

#DEFINE NVALORDIA 60
#DEFINE NVALORKMR 0.15

User Function L04E05()
    local oDlg   := nil 
    local cTitle := "Carro alugado"
    local cText1 := "Km Percorridos: "
    local cText2 := "Dias Alugados: "
    local cKmPer := Space(5)
    local cDiaAl := Space(5)
    local nOpcao := 0
    local nPreco := 0
    local cMsg   := " "

    DEFINE MsDialog oDlg TITLE cTitle FROM 000, 000 TO 200, 300 PIXEL 
    @ 014, 010 SAY cText1 size 55, 07 of oDlg PIXEL
    @ 010, 050 MsGet cKmPer size 55, 11 of oDlg pixel picture valid vazio()
    @ 034, 010 SAY cText2 size 55, 07 of oDlg PIXEL
    @ 030, 050 MsGet cDiaAl size 55, 11 of oDlg pixel picture valid vazio()
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpcao := 1, oDlg:END()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpcao := 2, oDlg:END()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED  

    nPreco := NVALORDIA * Val(cDiaAl) + NVALORKMR * Val(cKmPer)

    cMsg := "O preço a pagar pelo aluguel do carro é de R$" + cValToChar(nPreco) + " reais"

    if nOpcao == 1
        FwAlertSuccess(cMsg,"Resultado")
    else
        FwAlertError("Você cancelou o programa", "Cancelado")
    endif
Return 
