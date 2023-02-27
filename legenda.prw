#INCLUDE 'totvs.ch'

User Function legenda()
    local aLegenda := {}

    AADD( aLegenda, {"BR_VERDE",    "Mais de 18 anos"} )
    AADD( aLegenda, {"BR_VERMELHO", "Menos de 18 anos"} )

    BrwLegenda("Informações", "Legenda", aLegenda)
Return aLegenda
