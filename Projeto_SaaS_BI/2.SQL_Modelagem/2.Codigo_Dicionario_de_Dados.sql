-- Consulta para gerar um dicionário de dados (nome das tabelas, colunas, tipos, tamanhos, etc.)

SELECT 
    t.name AS Tabela,                          -- Nome da tabela
    c.name AS Coluna,                          -- Nome da coluna
    ty.name AS Tipo_Dado,                      -- Tipo de dado (ex: int, varchar)
    c.max_length AS Tamanho,                   -- Tamanho máximo da coluna (ex: 50 para varchar(50))
    CASE WHEN c.is_nullable = 1 THEN 'SIM' ELSE 'NÃO' END AS Permite_Nulo, -- Se aceita NULL
    CASE WHEN pk.column_id IS NOT NULL THEN 'PK' ELSE '' END AS Chave,     -- Indica se a coluna é chave primária
    ep.value AS Comentario                     -- Comentário descritivo da coluna (se houver)
FROM 
    sys.tables t                               -- Tabelas do banco de dados
JOIN 
    sys.columns c ON t.object_id = c.object_id -- Colunas das tabelas
JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id -- Tipos de dados das colunas
LEFT JOIN 
    sys.extended_properties ep                -- Comentários (extended properties)
    ON ep.major_id = c.object_id AND ep.minor_id = c.column_id AND ep.name = 'MS_Description'
LEFT JOIN 
    (
        -- Subquery para identificar colunas que são chave primária
        SELECT i.object_id, ic.column_id
        FROM sys.indexes i
        JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
        WHERE is_primary_key = 1
    ) pk ON c.object_id = pk.object_id AND c.column_id = pk.column_id
WHERE 
    ep.value IS NOT NULL                       -- Só traz colunas que têm comentário
ORDER BY 
    Tabela, c.column_id;                       -- Ordena por tabela e ordem das colunas
