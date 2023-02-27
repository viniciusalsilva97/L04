#INCLUDE 'totvs.ch'

User Function L04E19()
    local cAlias      := "ZZC"
    private cCadastro := "Cursos"
    private aRotina   := {}

    AADD( aRotina, {'Visualizar', 'AxVisual', 0, 2} )
    AADD( aRotina, {'Cadastrar',  'AxInclui', 0, 3} )
    AADD( aRotina, {'Alterar',    'AxAltera', 0, 4} )

    DbSelectArea("ZZC")
    DbSetOrder(1)

    MBrowse(NIL, NIL, NIL, NIL, cAlias)

    DbCloseArea()

Return
