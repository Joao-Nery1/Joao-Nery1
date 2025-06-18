-- 1. Popular a Dimensão de Datas (D_Date) - Gerar datas de 2022 até 2025

DECLARE @DataInicio DATE = '2022-01-01';
DECLARE @DataFim DATE = '2025-12-31';

WHILE @DataInicio <= @DataFim
BEGIN
    INSERT INTO D_Date (date_sk, date, year, quarter, month, day, week_day)
    VALUES (
        -- Chave substituta da data (formato YYYYMMDD)
        CONVERT(INT, FORMAT(@DataInicio, 'yyyyMMdd')),
        @DataInicio,                                   -- Data completa
        YEAR(@DataInicio),                             -- Ano
        DATEPART(QUARTER, @DataInicio),                -- Trimestre
        MONTH(@DataInicio),                            -- Mês
        DAY(@DataInicio),                              -- Dia do mês
        DATENAME(WEEKDAY, @DataInicio)                 -- Nome do dia da semana (Ex: Segunda-feira)
    );
    -- Avança para o dia seguinte
    SET @DataInicio = DATEADD(DAY, 1, @DataInicio);
END;


-- 2. Popular Clientes (D_Customer) - Gerar 1500 clientes

DECLARE @i INT = 1;
WHILE @i <= 1500
BEGIN
    INSERT INTO D_Customer (customer_sk, customer_id, name, email, gender, birth_date, region, is_active)
    VALUES (
        @i,                                             -- Chave substituta
        CONCAT('CUST', @i),                             -- ID fictício do cliente
        CONCAT('Cliente_', @i),                         -- Nome fictício
        CONCAT('cliente', @i, '@exemplo.com'),          -- Email fictício
        CASE WHEN RAND() < 0.5 THEN 'Masculino' ELSE 'Feminino' END,  -- Gênero aleatório
        DATEADD(DAY, FLOOR(RAND() * 36500), '1925-01-01'),            -- Data de nascimento simulada (até ~100 anos atrás, em dias)
        CASE WHEN RAND() < 0.5 THEN 'Sudeste' ELSE 'Sul' END, -- Região aleatória
        CASE WHEN RAND() < 0.8 THEN 1 ELSE 0 END        -- Status de Ativo (80% ativos, 20% inativos)
    );
    SET @i = @i + 1;
END;


-- 3. Popular Atividades (D_Activity) - Aproximadamente 4000 atividades

SET @i = 1;
WHILE @i <= 4000
BEGIN
    INSERT INTO D_Activity (activity_sk, activity_id, activity_type, device_type, activity_time)
    VALUES (
        @i,                                             -- Chave substituta
        CONCAT('ACT', @i),                              -- ID da atividade
        CASE ABS(CHECKSUM(NEWID())) % 3                -- Tipo de atividade aleatório
            WHEN 0 THEN 'Login'
            WHEN 1 THEN 'Visualização'
            ELSE 'Compra'
        END,
        CASE ABS(CHECKSUM(NEWID())) % 2                -- Tipo de dispositivo aleatório
            WHEN 0 THEN 'Mobile'
            ELSE 'Desktop'
        END,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1460, '2022-01-01') -- Data aleatória entre 2022 e 2025
    );
    SET @i = @i + 1;
END;


-- 4. Popular Assinaturas (D_Subscription) - Aproximadamente 3200 registros

SET @i = 1;
WHILE @i <= 3200
BEGIN
    INSERT INTO D_Subscription (subscription_sk, subscription_id, plan_type, start_date, end_date, is_cancelled)
    VALUES (
        @i,                                             -- Chave substituta
        CONCAT('SUB', @i),                              -- ID da assinatura
        CASE WHEN RAND() < 0.5 THEN 'Basic' ELSE 'Premium' END,  -- Tipo de plano aleatório
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1460, '2022-01-01'), -- Data de início aleatória entre 2022-2025
        NULL,                                           -- End date (pode ajustar depois se quiser)
        CASE WHEN RAND() < 0.3 THEN 1 ELSE 0 END        -- Status de cancelamento (30% canceladas)
    );
    SET @i = @i + 1;
END;

UPDATE D_Subscription
SET end_date = DATEADD(
                   DAY,  -- Estamos adicionando dias ao start_date
                   
                   -- Gera um número aleatório de dias:
                   ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, start_date, '2025-12-31'), 
                   
                   start_date  -- Soma os dias ao start_date, gerando uma data final depois do início
               )
WHERE is_cancelled = 1;  
-- Filtro: só atualiza linhas onde o end_date está vazio (NULL) e is_cancelled é 1


-- 5. Popular Fatos de Pagamento (F_Payment) - Total de 20.000 registros

SET @i = 1;
WHILE @i <= 20000
BEGIN
    INSERT INTO F_Payment (payment_sk, customer_sk, subscription_sk, date_sk, activity_sk, amount_paid, payment_status)
    VALUES (
        @i,                                             -- Chave substituta
        (ABS(CHECKSUM(NEWID())) % 1500) + 1,            -- Cliente aleatório entre 1 e 1500
        (ABS(CHECKSUM(NEWID())) % 3200) + 1,           -- Assinatura aleatória entre 1 e 3200
        (SELECT TOP 1 date_sk FROM D_Date ORDER BY NEWID()), -- Data aleatória da tabela de datas
        (ABS(CHECKSUM(NEWID())) % 4000) + 1,           -- Atividade aleatória entre 1 e 4000
        ROUND(RAND() * 500 + 20, 2),                   -- Valor pago (entre R$20 e R$520)
        CASE ABS(CHECKSUM(NEWID())) % 3                -- Status de pagamento aleatório
            WHEN 0 THEN 'Pago'
            WHEN 1 THEN 'Pendente'
            ELSE 'Falhou'
        END
    );
    SET @i = @i + 1;
END;

