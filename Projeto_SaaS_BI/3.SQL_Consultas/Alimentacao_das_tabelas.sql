-- 1. Popular a Dimens�o de Datas (D_Date) - Gerar datas de 2022 at� 2025

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
        MONTH(@DataInicio),                            -- M�s
        DAY(@DataInicio),                              -- Dia do m�s
        DATENAME(WEEKDAY, @DataInicio)                 -- Nome do dia da semana (Ex: Segunda-feira)
    );
    -- Avan�a para o dia seguinte
    SET @DataInicio = DATEADD(DAY, 1, @DataInicio);
END;


-- 2. Popular Clientes (D_Customer) - Gerar 800 clientes

DECLARE @i INT = 1;
WHILE @i <= 800
BEGIN
    INSERT INTO D_Customer (customer_sk, customer_id, name, email, gender, birth_date, region, is_active)
    VALUES (
        @i,                                             -- Chave substituta
        CONCAT('CUST', @i),                             -- ID fict�cio do cliente
        CONCAT('Cliente_', @i),                         -- Nome fict�cio
        CONCAT('cliente', @i, '@exemplo.com'),          -- Email fict�cio
        CASE WHEN RAND() < 0.5 THEN 'Masculino' ELSE 'Feminino' END,  -- G�nero aleat�rio
        DATEADD(DAY, FLOOR(RAND() * 36500), '1925-01-01'),            -- Data de nascimento simulada (at� ~100 anos atr�s, em dias)
        CASE WHEN RAND() < 0.5 THEN 'Sudeste' ELSE 'Sul' END, -- Regi�o aleat�ria
        CASE WHEN RAND() < 0.8 THEN 1 ELSE 0 END        -- Status de Ativo (80% ativos, 20% inativos)
    );
    SET @i = @i + 1;
END;


-- 3. Popular Atividades (D_Activity) - Aproximadamente 2000 atividades

SET @i = 1;
WHILE @i <= 2000
BEGIN
    INSERT INTO D_Activity (activity_sk, activity_id, activity_type, device_type, activity_time)
    VALUES (
        @i,                                             -- Chave substituta
        CONCAT('ACT', @i),                              -- ID da atividade
        CASE ABS(CHECKSUM(NEWID())) % 3                -- Tipo de atividade aleat�rio
            WHEN 0 THEN 'Login'
            WHEN 1 THEN 'Visualiza��o'
            ELSE 'Compra'
        END,
        CASE ABS(CHECKSUM(NEWID())) % 2                -- Tipo de dispositivo aleat�rio
            WHEN 0 THEN 'Mobile'
            ELSE 'Desktop'
        END,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1095, '2022-01-01') -- Data aleat�ria entre 2022 e 2025
    );
    SET @i = @i + 1;
END;


-- 4. Popular Assinaturas (D_Subscription) - Aproximadamente 1200 registros

SET @i = 1;
WHILE @i <= 1200
BEGIN
    INSERT INTO D_Subscription (subscription_sk, subscription_id, plan_type, start_date, end_date, is_cancelled)
    VALUES (
        @i,                                             -- Chave substituta
        CONCAT('SUB', @i),                              -- ID da assinatura
        CASE WHEN RAND() < 0.5 THEN 'Basic' ELSE 'Premium' END,  -- Tipo de plano aleat�rio
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 900, '2022-01-01'), -- Data de in�cio aleat�ria entre 2022-2024
        NULL,                                           -- End date (pode ajustar depois se quiser)
        CASE WHEN RAND() < 0.3 THEN 1 ELSE 0 END        -- Status de cancelamento (30% canceladas)
    );
    SET @i = @i + 1;
END;

UPDATE D_Subscription
SET end_date = DATEADD(
                   DAY,  -- Estamos adicionando dias ao start_date
                   
                   -- Gera um n�mero aleat�rio de dias:
                   ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, start_date, '2025-12-31'), 
                   
                   start_date  -- Soma os dias ao start_date, gerando uma data final depois do in�cio
               )
WHERE end_date IS NULL;  
-- Filtro: s� atualiza linhas onde o end_date est� vazio (NULL)


-- 5. Popular Fatos de Pagamento (F_Payment) - Total de 10.000 registros

SET @i = 1;
WHILE @i <= 10000
BEGIN
    INSERT INTO F_Payment (payment_sk, customer_sk, subscription_sk, date_sk, activity_sk, amount_paid, payment_status)
    VALUES (
        @i,                                             -- Chave substituta
        (ABS(CHECKSUM(NEWID())) % 800) + 1,            -- Cliente aleat�rio entre 1 e 800
        (ABS(CHECKSUM(NEWID())) % 1200) + 1,           -- Assinatura aleat�ria entre 1 e 1200
        (SELECT TOP 1 date_sk FROM D_Date ORDER BY NEWID()), -- Data aleat�ria da tabela de datas
        (ABS(CHECKSUM(NEWID())) % 2000) + 1,           -- Atividade aleat�ria entre 1 e 2000
        ROUND(RAND() * 500 + 20, 2),                   -- Valor pago (entre R$20 e R$520)
        CASE ABS(CHECKSUM(NEWID())) % 3                -- Status de pagamento aleat�rio
            WHEN 0 THEN 'Pago'
            WHEN 1 THEN 'Pendente'
            ELSE 'Falhou'
        END
    );
    SET @i = @i + 1;
END;