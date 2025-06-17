
-- Criação do Banco de Dados

CREATE DATABASE db_ProjetoSaas;
USE db_ProjetoSaas;

-- Criação das Tabelas

-- Criação da Dimensão Data
CREATE TABLE D_Date (
    date_sk INT PRIMARY KEY, -- Chave substituta (Surrogate Key), formato numérico YYYYMMDD
    date DATE NOT NULL, -- Data completa
    year INT NOT NULL, -- Ano (ex: 2025)
    quarter INT NOT NULL, -- Trimestre (1 a 4)
    month INT NOT NULL, -- Mês (1 a 12)
    day INT NOT NULL, -- Dia do mês (1 a 31)
    week_day VARCHAR(15) NOT NULL -- Nome do dia da semana (ex: 'Segunda-feira')
);

-- Criação da Dimensão Cliente
CREATE TABLE D_Customer (
    customer_sk INT PRIMARY KEY, -- Chave substituta (Surrogate Key) do cliente
    customer_id VARCHAR(50) NOT NULL, -- Identificador de origem (ID do cliente no sistema transacional)
    name VARCHAR(100) NOT NULL, -- Nome completo do cliente
    email VARCHAR(100) NOT NULL, -- Email do cliente
    gender VARCHAR(20) NOT NULL CHECK (gender IN ('Masculino', 'Feminino', 'Outro')), -- Gênero
    birth_date DATE NOT NULL, -- Data de nascimento
    region VARCHAR(50), -- Região geográfica ou localização
    is_active BIT NOT NULL CHECK (is_active IN (0, 1)) -- Status de Ativação: 1=Ativo, 0=Inativo
);

-- Criação da Dimensão Assinatura
CREATE TABLE D_Subscription (
    subscription_sk INT PRIMARY KEY, -- Chave substituta (Surrogate Key) da assinatura
    subscription_id VARCHAR(50) NOT NULL, -- ID da assinatura no sistema de origem
    plan_type VARCHAR(50) NOT NULL, -- Tipo de plano (ex: Basic, Premium)
    start_date DATE NOT NULL, -- Data de início da assinatura
    end_date DATE NULL, -- Data de término (NULL se ativa)
    is_cancelled BIT NOT NULL CHECK (is_cancelled IN (0, 1)) -- Status de cancelamento: 1=Cancelada, 0=Ativa
);

-- Criação da Dimensão Atividade
CREATE TABLE D_Activity (
    activity_sk INT PRIMARY KEY, -- Chave substituta (Surrogate Key) da atividade
    activity_id VARCHAR(50) NOT NULL, -- ID da atividade no sistema de origem
    activity_type VARCHAR(50) NOT NULL, -- Tipo de atividade (ex: Login, Acesso a Funcionalidade)
    device_type VARCHAR(50) NOT NULL, -- Tipo de dispositivo usado (ex: Mobile, Desktop)
    activity_time DATETIME NOT NULL -- Data e hora da atividade
);

-- Criação da Tabela Fato Pagamentos
CREATE TABLE F_Payment (
    payment_sk INT PRIMARY KEY, -- Chave substituta (Surrogate Key) do pagamento
    customer_sk INT NOT NULL, -- FK: Cliente relacionado
    subscription_sk INT NOT NULL, -- FK: Assinatura relacionada
    date_sk INT NOT NULL, -- FK: Data da transação (surrogate key de D_Date)
    activity_sk INT NOT NULL, -- FK: Atividade que gerou o pagamento
    amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid >= 0), -- Valor pago (ex: 99.90)
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('Pago', 'Pendente', 'Falhou')), -- Status do pagamento

    -- Definição das chaves estrangeiras
    CONSTRAINT FK_FPayment_Customer FOREIGN KEY (customer_sk) REFERENCES D_Customer(customer_sk),
    CONSTRAINT FK_FPayment_Subscription FOREIGN KEY (subscription_sk) REFERENCES D_Subscription(subscription_sk),
    CONSTRAINT FK_FPayment_Date FOREIGN KEY (date_sk) REFERENCES D_Date(date_sk),
    CONSTRAINT FK_FPayment_Activity FOREIGN KEY (activity_sk) REFERENCES D_Activity(activity_sk)
);

--Seção de Comentários

-- Comentários para tabela D_Date
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Chave substituta da data (formato YYYYMMDD)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'date_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Data completa', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'date';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Ano', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'year';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Trimestre', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'quarter';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Mês', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'month';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Dia do mês', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'day';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Dia da semana (ex: Segunda-feira)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Date', @level2type = N'COLUMN', @level2name = 'week_day';

-- Comentários para tabela D_Customer
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Chave substituta do cliente', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'customer_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'ID do cliente no sistema transacional', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'customer_id';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Nome completo do cliente', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'name';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Email do cliente', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'email';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Gênero (Masculino, Feminino ou Outro)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'gender';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Data de nascimento', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'birth_date';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Região geográfica', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'region';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Status de Ativação (1=Ativo, 0=Inativo)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Customer', @level2type = N'COLUMN', @level2name = 'is_active';

-- Comentários para tabela D_Subscription
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Chave substituta da assinatura', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Subscription', @level2type = N'COLUMN', @level2name = 'subscription_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'ID da assinatura no sistema transacional', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Subscription', @level2type = N'COLUMN', @level2name = 'subscription_id';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Tipo de plano (ex: Basic, Premium)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Subscription', @level2type = N'COLUMN', @level2name = 'plan_type';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Data de início da assinatura', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Subscription', @level2type = N'COLUMN', @level2name = 'start_date';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Data de término da assinatura', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Subscription', @level2type = N'COLUMN', @level2name = 'end_date';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Status de cancelamento (1=Cancelada, 0=Ativa)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Subscription', @level2type = N'COLUMN', @level2name = 'is_cancelled';

-- Comentários para tabela D_Activity
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Chave substituta da atividade', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Activity', @level2type = N'COLUMN', @level2name = 'activity_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'ID da atividade no sistema de origem', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Activity', @level2type = N'COLUMN', @level2name = 'activity_id';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Tipo de atividade (ex: Login, Ação no Sistema)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Activity', @level2type = N'COLUMN', @level2name = 'activity_type';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Tipo de dispositivo usado (ex: Mobile, Desktop)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Activity', @level2type = N'COLUMN', @level2name = 'device_type';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Data e hora da atividade', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'D_Activity', @level2type = N'COLUMN', @level2name = 'activity_time';

-- Comentários para tabela F_Payment
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Chave substituta do pagamento', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'payment_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'FK para o cliente', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'customer_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'FK para a assinatura', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'subscription_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'FK para a data (Surrogate Key)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'date_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'FK para a atividade', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'activity_sk';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Valor pago', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'amount_paid';
EXEC sp_addextendedproperty @name = N'MS_Description', @value = N'Status do pagamento (Pago, Pendente ou Falhou)', @level0type = N'SCHEMA', @level0name = 'dbo', @level1type = N'TABLE', @level1name = 'F_Payment', @level2type = N'COLUMN', @level2name = 'payment_status';
