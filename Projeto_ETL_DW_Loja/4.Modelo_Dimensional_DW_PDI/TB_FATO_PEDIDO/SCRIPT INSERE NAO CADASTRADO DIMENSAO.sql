USE DW;

insert into tb_dim_categoria_produto  values (-1, -1, 'NÃO CADASTRADO',NULL,NULL,NULL);

SET IDENTITY_INSERT tb_dim_produto ON; 
insert into tb_dim_produto ([SRK_PRODUTO],[NOM_PRODUTO],[COD_PRODUTO_NK],[SRK_CATEGORIA_PRODUTO]) values (-1,'NÃO CADASTRADO',-1, -1);
SET IDENTITY_INSERT tb_dim_produto OFF; 

SET IDENTITY_INSERT dbo.tb_dim_cliente ON;  
insert into tb_dim_cliente (SRK_CLIENTE, [COD_CLIENTE_NK],[NOM_CLIENTE],[END_CLIENTE],[EML_CLIENTE],[NOM_CIDADE_CLIENTE])values(-1,-1,'NÃO CADASTRADO','NÃO CADASTRADO','NÃO CADASTRADO','NÃO CADASTRADO');
SET IDENTITY_INSERT dbo.tb_dim_cliente OFF;  

SET IDENTITY_INSERT tb_dim_estado ON; 
insert into tb_dim_estado ([SRK_ESTADO],[COD_ESTADO_NK],[NOM_ESTADO]) values (-1, '-1', 'NÃO CADASTRADO');
SET IDENTITY_INSERT tb_dim_estado OFF; 

insert into tb_dim_tipo_cliente values (-1, -1, 'NÃO CADASTRADO',NULL,NULL,NULL);

