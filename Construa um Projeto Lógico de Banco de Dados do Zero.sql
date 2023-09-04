/*Cliente

ClienteID (Chave Primária)
Nome
Telefone
Veículo

VeiculoID (Chave Primária)
ClienteID (Chave Estrangeira referenciando Cliente)
Marca
Modelo
Ano
Ordem de Serviço

OrdemServicoID (Chave Primária)
VeiculoID (Chave Estrangeira referenciando Veículo)
DataInicio
DataFim
Serviço

ServicoID (Chave Primária)
Descricao
Preco
Mecânico

MecanicoID (Chave Primária)
Nome
Especialidade
Peça de Reposição

PecaID (Chave Primária)
Nome
Preco
Fornecedor

FornecedorID (Chave Primária)
Nome
OrdemServicoServico (Tabela de Junção)

OrdemServicoID (Chave Estrangeira referenciando Ordem de Serviço)
ServicoID (Chave Estrangeira referenciando Serviço)
OrdemServicoPeca (Tabela de Junção)

OrdemServicoID (Chave Estrangeira referenciando Ordem de Serviço)
PecaID (Chave Estrangeira referenciando Peça de Reposição)
PecaFornecedor (Tabela de Junção)

PecaID (Chave Estrangeira referenciando Peça de Reposição)
FornecedorID (Chave Estrangeira referenciando Fornecedor)

*/

/* Informações de Cliente*/
SELECT Nome, Telefone FROM Cliente WHERE ClienteID = 1;

/* Listar as Ordens de Serviço por Cliente*/
SELECT Cliente.Nome, OrdemServico.OrdemServicoID, Veiculo.Marca, Veiculo.Modelo
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID;

/* Calcular o valor total de uma Ordem de Serviço*/
SELECT OrdemServico.OrdemServicoID, SUM(Servico.Preco) AS TotalServicos, SUM(Peca.Preco) AS TotalPecas
FROM OrdemServico
LEFT JOIN OrdemServicoServico ON OrdemServico.OrdemServicoID = OrdemServicoServico.OrdemServicoID
LEFT JOIN Servico ON OrdemServicoServico.ServicoID = Servico.ServicoID
LEFT JOIN OrdemServicoPeca ON OrdemServico.OrdemServicoID = OrdemServicoPeca.OrdemServicoID
LEFT JOIN Peca ON OrdemServicoPeca.PecaID = Peca.PecaID
GROUP BY OrdemServico.OrdemServicoID;

/*  Listar os Mecânicos e a quantidade de Ordens de Serviço que cada um realizou*/
SELECT Mecanico.Nome, COUNT(OrdemServico.OrdemServicoID) AS QuantidadeOrdens
FROM Mecanico
LEFT JOIN OrdemServico ON Mecanico.MecanicoID = OrdemServico.MecanicoID
GROUP BY Mecanico.Nome;

/* Encontrar os Fornecedores que fornecem uma Peça de Reposição específica*/
SELECT Fornecedor.Nome, Peça.Nome
FROM Fornecedor
JOIN PecaFornecedor ON Fornecedor.FornecedorID = PecaFornecedor.FornecedorID
JOIN Peca ON PecaFornecedor.PecaID = Peca.PecaID
WHERE Peça.PecaID = 1;
