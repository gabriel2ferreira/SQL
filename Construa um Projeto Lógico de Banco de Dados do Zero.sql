-- Tabela Cliente
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Telefone VARCHAR(15)
);

--  tabela Veículo
CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY,
    ClienteID INT,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Ano INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

--  tabela Ordem de Serviço
CREATE TABLE OrdemServico (
    OrdemServicoID INT PRIMARY KEY,
    VeiculoID INT,
    DataInicio DATE,
    DataTermino DATE,
    FOREIGN KEY (VeiculoID) REFERENCES Veiculo(VeiculoID)
);

--  tabela Serviço
CREATE TABLE Servico (
    ServicoID INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Preco DECIMAL(10, 2)
);

--  tabela Mecânico
CREATE TABLE Mecanico (
    MecanicoID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Especialidade VARCHAR(50)
);

--  tabela Peça de Reposição
CREATE TABLE PecaReposicao (
    PecaID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Preco DECIMAL(10, 2)
);

--  tabela Fornecedor
CREATE TABLE Fornecedor (
    FornecedorID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);

--  tabela OrdemServicoServico para associar serviços a ordens de serviço
CREATE TABLE OrdemServicoServico (
    OrdemServicoID INT,
    ServicoID INT,
    FOREIGN KEY (OrdemServicoID) REFERENCES OrdemServico(OrdemServicoID),
    FOREIGN KEY (ServicoID) REFERENCES Servico(ServicoID)
);

--  tabela OrdemServicoPeca para associar peças de reposição a ordens de serviço
CREATE TABLE OrdemServicoPeca (
    OrdemServicoID INT,
    PecaID INT,
    FOREIGN KEY (OrdemServicoID) REFERENCES OrdemServico(OrdemServicoID),
    FOREIGN KEY (PecaID) REFERENCES PecaReposicao(PecaID)
);

--  tabela PecaReposicaoFornecedor para associar peças de reposição a fornecedores
CREATE TABLE PecaReposicaoFornecedor (
    PecaID INT,
    FornecedorID INT,
    FOREIGN KEY (PecaID) REFERENCES PecaReposicao(PecaID),
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(FornecedorID)
);


-- Consulta para recuperar todos os clientes
SELECT * FROM Cliente;

-- Consulta para recuperar todos os veículos
SELECT * FROM Veiculo;

-- Consulta para recuperar informações de um cliente específico pelo nome
SELECT * FROM Cliente WHERE Nome = 'Nome do Cliente';

-- Consulta para recuperar veículos de um cliente específico pelo ClienteID
SELECT * FROM Veiculo WHERE ClienteID = 1;

-- Consulta para calcular a idade dos veículos
SELECT Marca, Modelo, Ano, YEAR(CURRENT_DATE()) - Ano AS Idade
FROM Veiculo;

-- Consulta para listar os serviços em ordem decrescente de preço
SELECT * FROM Servico ORDER BY Preco DESC;

-- Consulta para encontrar os mecânicos que realizaram mais de 5 ordens de serviço
SELECT MecanicoID, COUNT(*) AS TotalOrdens
FROM OrdemServico
GROUP BY MecanicoID
HAVING COUNT(*) > 5;

-- Consulta para listar todas as ordens de serviço com informações do cliente e veículo
SELECT Cliente.Nome AS NomeCliente, Veiculo.Marca, Veiculo.Modelo, OrdemServico.DataInicio, OrdemServico.DataTermino
FROM OrdemServico
INNER JOIN Veiculo ON OrdemServico.VeiculoID = Veiculo.VeiculoID
INNER JOIN Cliente ON Veiculo.ClienteID = Cliente.ClienteID;
