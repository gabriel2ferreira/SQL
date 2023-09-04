

# Projeto de Banco de Dados para Oficina

Este projeto tem como objetivo criar um banco de dados relacional para uma oficina mecânica, permitindo o gerenciamento eficiente de clientes, veículos, ordens de serviço, serviços, mecânicos, peças de reposição e fornecedores. O banco de dados foi modelado com base em um esquema conceitual e implementado em SQL para atender às necessidades da oficina.

## Esquema Lógico

O esquema lógico do banco de dados é composto pelas seguintes tabelas:

- **Cliente:** Armazena informações sobre os clientes da oficina, como nome e telefone.

- **Veículo:** Registra informações sobre os veículos de propriedade dos clientes, incluindo marca, modelo e ano.

- **Ordem de Serviço:** Mantém registros de ordens de serviço, com detalhes de datas de início e término.

- **Serviço:** Contém informações sobre os serviços oferecidos pela oficina, incluindo descrição e preço.

- **Mecânico:** Armazena dados sobre os mecânicos da oficina, como nome e especialidade.

- **Peça de Reposição:** Registra informações sobre peças de reposição disponíveis, incluindo nome e preço.

- **Fornecedor:** Mantém registros dos fornecedores de peças de reposição.

- **OrdemServicoServico:** Tabela de junção para associar serviços a ordens de serviço.

- **OrdemServicoPeca:** Tabela de junção para associar peças de reposição a ordens de serviço.

- **PecaFornecedor:** Tabela de junção para associar peças de reposição a fornecedores.

## Consultas SQL Exemplo

Aqui estão algumas consultas SQL de exemplo que podem ser executadas neste banco de dados:

1. Recuperação simples de informações de um cliente:

   ```sql
   SELECT Nome, Telefone FROM Cliente WHERE ClienteID = 1;
2. Consulta para listar as Ordens de Serviço por Cliente:

    ```sql
    SELECT Cliente.Nome, OrdemServico.OrdemServicoID, Veiculo.Marca, Veiculo.Modelo
    FROM Cliente
    JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
    JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID;
3. Consulta para calcular o valor total de uma Ordem de Serviço:

    ```sql

    SELECT OrdemServico.OrdemServicoID, SUM(Servico.Preco) AS TotalServicos, SUM(Peca.Preco) AS TotalPecas
    FROM OrdemServico
    LEFT JOIN OrdemServicoServico ON OrdemServico.OrdemServicoID = OrdemServicoServico.OrdemServicoID
    LEFT JOIN Servico ON OrdemServicoServico.ServicoID = Servico.ServicoID
    LEFT JOIN OrdemServicoPeca ON OrdemServico.OrdemServicoID = OrdemServicoPeca.OrdemServicoID
    LEFT JOIN Peca ON OrdemServicoPeca.PecaID = Peca.PecaID
    GROUP BY OrdemServico.OrdemServicoID;
4. Consulta para listar os Mecânicos e a quantidade de Ordens de Serviço que cada um realizou:

    ```sql

    SELECT Mecanico.Nome, COUNT(OrdemServico.OrdemServicoID) AS QuantidadeOrdens
    FROM Mecanico
    LEFT JOIN OrdemServico ON Mecanico.MecanicoID = OrdemServico.MecanicoID
    GROUP BY Mecanico.Nome;
5. Consulta para encontrar os Fornecedores que fornecem uma Peça de Reposição específica:

    ```sql

    SELECT Fornecedor.Nome, Peca.Nome
    FROM Fornecedor
    JOIN PecaFornecedor ON Fornecedor.FornecedorID = PecaFornecedor.FornecedorID
    JOIN Peca ON PecaFornecedor.PecaID = Peca.PecaID
    WHERE Peca.PecaID = 1;


Como Usar
Para utilizar este banco de dados em seu projeto, siga estas etapas:

Clone o repositório para o seu ambiente local:

bash

git clone https://github.com/seu-usuario/seu-repositorio.git
Importe o script SQL para criar o banco de dados e tabelas em seu sistema de gerenciamento de banco de dados preferido.

Execute consultas SQL personalizadas conforme necessário para interagir com o banco de dados da oficina.

Contribuição
Este projeto é de código aberto, e contribuições são bem-vindas. Se você deseja propor melhorias, correções ou adicionar recursos adicionais ao banco de dados da oficina, sinta-se à vontade para criar um fork deste repositório e enviar um pull request.

perl


Certifique-se de substituir "seu-usuario" e "seu-repositorio" pelos detalhes re