#INCLUDE 'totvs.ch'

User Function L04E20()
    local cAlias      := "ZZS"
    local aCores      := {{"ZZS -> ZZS_IDADE >= 18", "ENABLE"}, {"ZZS->ZZS_IDADE < 18", "DISABLE"}}
    private cCadastro := "Alunos"
    private aRotina   := {}

    AADD( aRotina, {'Visualizar', 'AxVisual', 0, 2} )
    AADD( aRotina, {'Cadastrar',  'AxInclui', 0, 3} )
    AADD( aRotina, {'Alterar',    'AxAltera', 0, 4} )
    AADD( aRotina, {'Excluir',    'AxDeleta', 0, 5} )
    AADD( aRotina, {'Legenda',    'U_legenda',0, 6} )

    DbSelectArea("ZZS")
    DbSetOrder(1)

    MBrowse(NIL, NIL, NIL, NIL, cAlias, NIL, NIL, NIL, NIL, NIL, aCores)

    DbCloseArea()

Return
