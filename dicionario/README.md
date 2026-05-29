## O que eu preciso fazer?

* [ ] Remover uma palavra chave deve realocar as palavras do dicionário para o próximo elemento da lista de palavras chaves

  * [ ] Se for a última palavra chave, não deve ser removida
  * [ ] Se for a primeira palavra chave, pode ser removida
  * [ ] (opcional) remover uma palavra chave deve pegar a última palavra do dicionário e colocá-la como principal
* [ ] Adicionar uma palavra chave deve realocar as palavras do dicionário da próxima palavra para o dicionário da atual sendo incluída
* [ ] Se adicionar uma palavra chave, precisamos verificar se alguma palavra do dicionário pode ser realocada para o dicionário da nova palavra chave
* [ ] Cada palava chave determina que o dicionário de palavras dela deve conter palavras "menores" que a palavra chave. Ex: 1. Arroz -> Abacate, Abacaxi - 2. Beterraba -> Azazel (maior que arroz, menor que beterraba), Batata
* [ ] Adicionar uma tradução que não cabe em nenhuma palavra chave deve torná-la uma palavra chave automaticamente

