<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Power BI - Contoso Retail</title>
</head>
<body>
    <h1>Dashboard Power BI - Análise de Perfil e Comportamento de Clientes</h1>

    <p>Para responder ao desafio proposto pelo João Oliveira, no evento "Projeto de Natal", promovido pela Evolve Data, desenvolvi este dashboard no Power BI, para analisar o perfil e o comportamento dos clientes de uma empresa fictícia. Utilizei a base de dados Contoso Retail DW, e também utilizei os arquivos disponibilizados pelo Bruce Fonseca no final do seu curso de Power BI. Agradeço a oportunidade e a dedicação dos professores. Eis o projeto:</p>

    <h2>1) Contexto de Negócio</h2>
    <p>A Contoso Retail é uma empresa global do setor de varejo, especializada na venda de produtos como eletrônicos, utilidades domésticas e acessórios. Com operações em diversos continentes, a empresa atende a uma base de clientes diversificada em termos de idade, renda e localização. Em um mercado altamente competitivo, a Contoso busca diferenciar-se por meio de estratégias de marketing personalizadas e experiências de compra otimizadas. Apesar do alcance global e de uma base sólida de vendas, a Contoso enfrenta desafios relacionados à compreensão detalhada do perfil dos clientes e à conexão disso com o comportamento de compra. Sem uma visão clara sobre como características como gênero, faixa etária, escolaridade e renda impactam o consumo, é difícil criar campanhas direcionadas, ajustar o mix de produtos e identificar oportunidades de crescimento. Além disso, a falta de insights detalhados pode levar a decisões baseadas em suposições, aumentando os custos operacionais e reduzindo a eficiência do marketing.</p>

    <p>Com o final de ano chegando e os subsequentes diagnósticos acerca do desempenho dos negócios até aqui, a gerência solicitou uma análise para compreender o perfil de seus clientes, de modo que estratégias futuras possam ser traçadas. Deste modo, o desenvolvimento deste dashboard pretende atender diretamente a essas necessidades, permitindo identificar tendências e padrões no perfil dos clientes, além de permitir vincular estes perfis com métricas de desempenho das vendas, tais como quantidade de compras e ticket médio gasto. As perguntas que orientam o desenvolvimento deste dashboard, portanto, são as seguintes: qual o perfil dos nossos clientes? E como eles se comportam? A partir das informações geradas com este relatório, a Contoso Retail pode alinhar suas estratégias e direcionar ofertas específicas para os segmentos necessários, promovendo engajamento e fidelização de sua base de clientes.</p>

    <h2>2) Ferramentas Utilizadas</h2>
    <p>Para desenvolver este relatório, foram utilizadas as seguintes ferramentas:</p>
    <ul>
        <li>Utilizando a base de dados da Contoso Retail, inicialmente a linguagem SQL foi utilizada para a escolha adequada das tabelas e colunas que seriam utilizadas na análise. Deste modo, o banco de dados foi upado no SQL Server Management Studio e, nesta ferramenta, consultas chave foram realizadas para a escolha das tabelas, a modelagem de dados, e o filtro das colunas que seriam utilizadas posteriormente.</li>
        <li>Em seguida, o Power BI foi utilizado tanto para tratar os dados quanto para construir o dashboard com as devidas visualizações. Inicialmente, o Power Query foi utilizado para tratar os dados. Em seguida, o modelo de dados foi organizado, com o estabelecimento dos relacionamentos entre as tabelas. Por fim, a construção do dashboard foi realizada, começando com as medidas chave e, em seguida, com as distribuições e organização dos gráficos.</li>
    </ul>

    <h2>3) Tutorial do Dashboard: Passo à Passo</h2>
    <h3>Escolhendo as Tabelas e Colunas</h3>
    <p>A primeira etapa para o desenvolvimento deste dashboard foi escolher as tabelas e colunas que seriam pertinentes para a análise, a partir do banco de dados da Contoso. No SQL Management Studio, identifiquei que o banco de dados já contava com um diagrama de relacionamento entre as tabelas:</p>

    <img src="https://media.licdn.com/dms/image/v2/D4D12AQF0XYcjcWFh7Q/article-inline_image-shrink_1000_1488/article-inline_image-shrink_1000_1488/0/1733859207910?e=1744243200&v=beta&t=fxbat3GpDjxMIF6ES2TCy51Zi2pGWeQ_fZ41DG1uOro" alt="Diagrama de Relacionamento entre Tabelas">

    <p>Tendo em vista o objetivo da Contoso de otimizar o desempenho das suas estratégias de vendas, escolhi a tabela FactSales como minha tabela central de eventos. Identifiquei que as principais categorias que eu precisava para entender os clientes estavam presentes na coluna DimCustomer, com exceção das categorias geográficas, que se encontram na tabela DimGeography. Além destas duas tabelas centrais de características, também escolhi a tabela DimStore, tendo em vista o padrão de relacionamento estipulado pelo banco de dados: a tabela FactSales não possui uma coluna em comum com as tabelas DimCustomer e DimGeography, mas apenas com a tabela DimStore (ambas possuem a coluna StoreKey). Esta tabela, por sua vez, relaciona-se com a tabela DimGeography através da coluna GeographyKey, e esta se relaciona com a tabela DimCustomer através da coluna CustomerKey. Assim, antevendo como iria organizar o modelo de dados no Power BI, escolhi estas tabelas para realizar a análise.</p>

    <h3>Tratando os Dados</h3>
    <p>Com o Power BI aberto, fui em Obter Dados -> SQL Server -> digitei 'localhost' na aba Servidor, deixei marcada a categoria Importar, e dei ok -> selecionei então o banco de dados ContosoRetail e upei as tabelas acima, uma por uma. Quando fui upar a tabela DimCustomer, selecionei de antemão as colunas que me seriam úteis, com o seguinte código:</p>

    <pre><code>
    select
        CustomerKey,
        GeographyKey,
        concat(FirstName, ' ', LastName) as Nome,
        BirthDate,
        MaritalStatus,
        Gender,
        YearlyIncome,
        TotalChildren,
        NumberChildrenAtHome,
        Education,
        Occupation,
        HouseOwnerFlag,
        NumberCarsOwned,
        DateFirstPurchase,
        LoadDate,
        UpdateDate
    from DimCustomer
    </code></pre>

    <p>Com as tabelas upadas no Power BI, fui em Transformar Dados, para abrir o Power Query e tratar os dados. Comecei por limpar das tabelas as colunas que eu não precisava: na coluna FactSales, cliquei sobre a flecha e desmarquei as colunas channelKey, PromotionKey e CurrencyKey, pois entendi que não seriam utilizadas para a análise. Também excluí a coluna geometry da tabela DimGeography, e deixei na tabela DimStore apenas colunas com dados chave, como as colunas StoreyKey, GeographyKey e StoreType.</p>

    <p>Em seguida, tratei de padronizar os tipos de dados das colunas das colunas que eu iria utilizar. Clicando sobre o ícone de tipo de dado de cada coluna, padronizei todos os números como números decimais fixos, inclusive os valores monetários. Quanto às datas, padronizei todas elas no formato shortdate, para facilitar a manipulação e visualização.</p>

    <p>Antes de partir para a construção do dashboard, realizei alguns testes com distribuições simples das colunas das minhas tabelas em alguns gráficos no relatório. Percebi que havia dados nulos em algumas colunas, e que também era necessário organizar o modelo de dados adequadamente, para que os gráficos possam reproduzir os argumentos vinculando as colunas das tabelas adequadamente. Assim, desmarquei os dados nulos da coluna Gender, da tabela DimCustomer. As colunas CityName e ContinentName também da tabela DimGeography também possuíam valores nulos, e também foram excluídos.</p>

    <p>Por fim, organizei o modelo de dados, vinculando as tabelas a partir das suas colunas em comum. Estabeleci o relacionamento 1:N (um para muitas) para relacionar as tabelas DimStore e FactSales, pois trata-se de um registro de característica para vários registros de eventos na tabela de eventos, com direção única. Usei este mesmo relacionamento para vincular a tabela DimGeography com a tabela DimCustomer, mesmo sendo duas tabelas de características, pois trata-se de um registro de lugar para vários registros na tabela de clientes. O modelo de dados, no Power BI, ficou da seguinte maneira:</p>

    <img src="caminho_para_imagem" alt="Modelo de Dados no Power BI">

    <h3>Construindo o Dashboard</h3>
    <p>Para construir o dashboard, parti das diretrizes básicas de design fornecidas pelo conjunto escuro fornecido pelo curso de Power BI do Bruce Fonseca. Coloquei então a imagem fornecida como tela de fundo da página principal, com 100% de transparência. Também fui na aba Exibição, personalizar tema, e coloquei as seguintes cores como paleta de cores: #8D1397, #C501E2, #9AF7E7, #6664EF, #2B97FA, #01C4E7, #15C2A1.</p>

    <p>Para iniciar a análise, parti da compreensão de que a primeira coisa que eu precisava eram indicadores chave, ou seja, medidas que me fornecessem um panorama geral dos dados dos nossos clientes. Desse modo, criei uma nova tabela chamada Medidas, para armazenar as medidas que eu iria extrair dos dados das tabelas. A primeira medida que extraí foi a contagem total de clientes:</p>

    <pre><code>
    Total_Clientes = Count(DimCustomer[CustomerKey])
    </code></pre>

    <p>Em seguida, pensei que seria interessante apresentar um indicador da porcentagem de clientes homens e clientes mulheres. Tendo em vista que a única coluna que eu tinha informando o gênero dos clientes era a coluna Gender, da tabela DimCustomer, compreendi que era necessário primeiro criar duas novas medidas, uma para cada gênero, que retornassem a quantidade de clientes homens e a quantidade de clientes mulheres, respectivamente. Assim, criei as seguintes medidas:</p>

    <pre><code>
    Clientes_Homens = CALCULATE([Total_Clientes]; DimCustomer[Gender] = "M")
    Clientes_Mulheres = CALCULATE([Total_Clientes]; DimCustomer[Gender]="F")
    </code></pre>

    <p>Nestas duas medidas, a função Calculate() foi utilizada para mudar de contexto a contagem total de clientes, circunscrevendo-a aos respectivos filtros de gênero da coluna DimCustomer[Gender]. Com estes valores, pude calcular a porcentagem de clientes homens e a porcentagem dos clientes mulheres com as seguintes medidas:</p>

    <pre><code>
    %GenderM = DIVIDE([Clientes_Homens]; [Total_Clientes])
    %GenderF = DIVIDE([Clientes_Mulheres]; [Total_Clientes])
    </code></pre>

    <p>Neste caso, a função Divide() calcula a proporção dos clientes de cada gênero em relação aos clientes totais. Defini o formato porcentagem, e ela retornou as porcentagens adequadas. Os próximos indicadores chave que construí foram a renda total gerada para a empresa, e a quantidade total de produtos vendidos para a empresa.</p>

    <pre><code>
    Total_Receita = sum(FactSales[SalesAmount])
    Total_Quantidade = sum(FactSales[SalesQuantity])
    </code></pre>

    <p>Nestas duas medidas, assim como na medida Total_Clientes, foram utilizadas funções de agregação simples, count() e sum(). Ambas realizam uma operação simples com um conjunto de dados e retornam um único valor, como resultado da operação. Outra função de agregação simples utilizada foi a Average(), para calcular a média salarial anual dos clientes do nosso banco de dados:</p>

    <pre><code>
    Salário_Anual = AVERAGE(DimCustomer[YearlyIncome])
    </code></pre>

    <p>A próxima medida construída foi a de Ticket_Médio, pensada para dar conta da proporção que cada cliente contribuiu para as receitas da empresa. Ela calcula, assim, o valor médio gasto por cada cliente. Seu código é o seguinte:</p>

    <pre><code>
    Ticket_Médio = [Total_Receita]/distinctcount(DimCustomer[CustomerKey])
    </code></pre>

    <p>Com essas medidas construídas, comecei a pensar na arquitetura da informação do dashboard e nas análises que seriam desenvolvidas com os gráficos. Percebi que faltava um marcador-chave: a média de idade dos clientes. Para ter esse valor, contudo, era preciso primeiro construir uma coluna com a idade de cada cliente. A tabela DimCustomer me dava apenas uma coluna com a data de nascimento (coluna BirthDate) de cada cliente. Retornei ao Power Query, portanto, fui na aba Adicionar Coluna -> Coluna Personalizada -> e digitei o seguinte código:</p>

    <pre><code>
    Idade = DATEDIFF(DimCustomer[BirthDate]; DATE(2009; 12; 31); YEAR)
    </code></pre>

    <p>Este código retornou a coluna Idade, com a idade de cada um dos respectivos clientes. Percebi que seria interessante também uma coluna com as faixas etárias dos clientes. Após uma breve consulta SQL, na qual identifiquei qual era a data mínima e a data máxima de nascimento registradas no banco de dados, voltei ao Power Query -> Adicionar coluna personalizada -> e digitei o seguinte código:</p>

    <pre><code>
    FaixaEtária = 
        SWITCH(
            TRUE();
            DimCustomer[Idade] >= 60; "60+";
            DimCustomer[Idade] >= 50; "50+";
            DimCustomer[Idade] >= 40; "40+";
            DimCustomer[Idade] >= 30; "30+";
            "Menos de 30"
        )
    </code></pre>

    <p>Neste caso, a função Switch() serviu para testar várias condições sequencialmente, retornando distintos valores de acordo com tais condições. O primeiro argumento TRUE() foi utilizado para que a função realizasse uma sequência de verificações lógicas sem depender da referência para um valor inicial. Em seguida, cada uma das verificações foi realizadas a partir de operadores lógicos: se a idade for maior ou igual a 60, retorne o valor "60+"; se a idade for maior ou igual a 50, retorne o valor "50+", e assim por diante.</p>

    <p>Com a subdivisão em faixas etárias, percebi que poderia fazer isso para outros valores chave dos clientes também. Assim, construí um código semelhante para dividir os clientes de acordo com as suas faixas salariais, já que a tabela DimCustomer me forneceu uma coluna com o salário anual dos clientes (a coluna YearlyIncome). No Power Query, nova coluna personalizada, e digitei o seguinte código:</p>

    <pre><code>
    FaixaSalarial = 
        SWITCH(
            TRUE();
            DimCustomer[YearlyIncome] > 100000; "100k+";
            DimCustomer[YearlyIncome] > 60000; "60k-100k";
            DimCustomer[YearlyIncome] > 30000; "30k-60k";
            DimCustomer[YearlyIncome] > 15000; "15k-30k";
            "<15k"
        )
    </code></pre>

    <p>Com as medidas prontas, comecei as distribuições. Primeiro, tratei de colocar as medidas chaves em cartões, de modo que de antemão os gestores possam visualizar o perfil geral dos clientes de acordo com estas métricas fundamentais:</p>

    <img src="caminho_para_imagem" alt="Cartões com Medidas Chave">

    <p>Coloquei 50% de transparência nos cartões, arredondei as bordas em 5px, e coloquei uma leve sombra acinzentada, para destacar os cartões em relação ao fundo. Quanto as cores, mantive os números em branco, para ter destaque, e coloquei o verde #15C2A1 para dar um bom contraste com o fundo.</p>

    <p>Para construir a análise, realizei uma série de testes, com várias distribuições em gráficos de coluna, para ver como os dados se comportavam. Compreendi que seria interessante inicialmente distribuir a quantidade de clientes por uma série de categorias, de modo que
