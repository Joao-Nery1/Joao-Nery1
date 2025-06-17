
--Cria��o das Views

-- VIEW 1: Receita Mensal + Receita por Plano (MRR)

CREATE VIEW vw_Faturamento_Mensal_Por_Plano AS
SELECT
    YEAR(CONVERT(DATE, CAST(F_Payment.date_sk AS CHAR(8)), 112)) AS Ano,       -- Ano do pagamento
    MONTH(CONVERT(DATE, CAST(F_Payment.date_sk AS CHAR(8)), 112)) AS Mes,      -- M�s do pagamento
    D_Subscription.plan_type,                                 -- Tipo de plano (Ex: Basic, Premium)
    COUNT(DISTINCT F_Payment.customer_sk) AS Total_Clientes_Pagantes,  -- Total de clientes que pagaram no m�s
    SUM(F_Payment.amount_paid) AS Receita_Total               -- Soma total das receitas no m�s
FROM F_Payment
JOIN D_Subscription ON F_Payment.subscription_sk = D_Subscription.subscription_sk  -- Relaciona pagamento com a assinatura
WHERE F_Payment.payment_status = 'Pago'                      -- Considera apenas pagamentos efetivamente pagos
GROUP BY   YEAR(CONVERT(DATE, CAST(F_Payment.date_sk AS CHAR(8)), 112)), 
		   MONTH(CONVERT(DATE, CAST(F_Payment.date_sk AS CHAR(8)), 112)),  
		   D_Subscription.plan_type;  -- Agrupa por ano, m�s e tipo de plano


-- VIEW 2: Evolu��o de Clientes (Novos Clientes por M�s)

CREATE VIEW vw_Evolucao_Clientes AS
SELECT
    YEAR(D_Subscription.start_date) AS Ano,                   -- Ano de in�cio da assinatura
    MONTH(D_Subscription.start_date) AS Mes,                  -- M�s de in�cio
    COUNT(DISTINCT D_Subscription.subscription_sk) AS Novos_Clientes  -- N�mero de novos clientes no m�s
FROM D_Subscription
GROUP BY YEAR(D_Subscription.start_date), MONTH(D_Subscription.start_date);  -- Agrupa por ano e m�s


-- VIEW 3: Churn Mensal (Cancelamentos e Taxa de Cancelamento)

CREATE VIEW vw_Churn_Mensal AS
SELECT
    -- Ano e m�s do cancelamento
    YEAR(D_Subscription.end_date) AS Ano,
    MONTH(D_Subscription.end_date) AS Mes,

    -- Total de cancelamentos no m�s
    COUNT(DISTINCT D_Subscription.subscription_sk) AS Cancelamentos,

    -- Total de clientes ativos no in�cio do m�s (base de clientes)
    (
        SELECT COUNT(DISTINCT D_Subscription.subscription_sk)
        FROM D_Subscription
        WHERE D_Subscription.start_date <= DATEFROMPARTS(YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date), 1)
          AND (D_Subscription.end_date IS NULL OR D_Subscription.end_date >= DATEFROMPARTS(YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date), 1))
    ) AS Base_Clientes_Mes,

    -- C�lculo da taxa de churn percentual
    CASE 
        WHEN (
            SELECT COUNT(DISTINCT D_Subscription.subscription_sk)
            FROM D_Subscription
            WHERE D_Subscription.start_date <= DATEFROMPARTS(YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date), 1)
              AND (D_Subscription.end_date IS NULL OR D_Subscription.end_date >= DATEFROMPARTS(YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date), 1))
        ) > 0
        THEN
            CAST(
                COUNT(DISTINCT D_Subscription.subscription_sk) * 100.0 /
                (
                    SELECT COUNT(DISTINCT D_Subscription.subscription_sk)
                    FROM D_Subscription
                    WHERE D_Subscription.start_date <= DATEFROMPARTS(YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date), 1)
                      AND (D_Subscription.end_date IS NULL OR D_Subscription.end_date >= DATEFROMPARTS(YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date), 1))
                ) AS DECIMAL(5,2)
            )
        ELSE 0
    END AS Churn_Rate_Percentual

FROM D_Subscription
WHERE D_Subscription.is_cancelled = 1
GROUP BY YEAR(D_Subscription.end_date), MONTH(D_Subscription.end_date);


-- VIEW 4: Engajamento Mensal por Cliente (Atividades por M�s)

CREATE VIEW vw_Engajamento_Mensal AS
SELECT
    D_Activity.activity_type,                              -- Tipo de Atividade
	D_Activity.device_type,								   -- Tipo de Dispositivo
    YEAR(D_Activity.activity_time) AS Ano,                 -- Ano da atividade
    MONTH(D_Activity.activity_time) AS Mes,                -- M�s da atividade
    COUNT(*) AS Total_Atividades                           -- Total de atividades feitas no m�s
FROM D_Activity
GROUP BY D_Activity.activity_type,D_Activity.device_type, YEAR(D_Activity.activity_time), MONTH(D_Activity.activity_time);  -- Agrupa por cliente, ano e m�s


-- Visualiza��o das Views

SELECT * FROM vw_Churn_Mensal
SELECT * FROM vw_Engajamento_Mensal
SELECT * FROM vw_Faturamento_Mensal_Por_Plano
SELECT * FROM vw_Evolucao_Clientes