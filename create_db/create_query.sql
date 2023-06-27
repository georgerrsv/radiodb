-- # CRIANDO AS TABELAS #

--TABELA OUVINTE
create table ouvinte (
    cpf varchar(11) NOT NULL,
    nome varchar(50) NOT NULL,
    endereco varchar(50) NOT NULL,
    id_premiacao integer,
    primary key (cpf)
);

--TABELA QUADRO
create table quadro (
    id serial NOT NULL,
    nome_do_quadro varchar(50) NOT NULL,
    tipo_do_quadro varchar(15) NOT NULL,
    dia varchar(50) NOT NULL,
    horario varchar(50) NOT NULL,
    telefone varchar(15) NOT NULL,
    primary key (id)
);


--TABELA APRESENTADOR
create table apresentador (
    id serial NOT NULL,
    nome varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    primary key (id)
);

--TABELA ARTISTA
create table artista (
    id serial NOT NULL,
    nome_artista varchar(50) NOT NULL,
    genero varchar(50) NOT NULL,
    email varchar(50),
    nacionalidade varchar(50),
    primary key (id)
);

--TABELA MUSICA
create table musica (
    id serial NOT NULL,
    nome_musica varchar(50) NOT NULL,
    ano_lancamento varchar(10) NOT NULL,
    album varchar(50) NOT NULL,
    genero varchar(50),
    primary key (id)
);

--TABELA MUSICA_ARTISTA
create table musica_artista (
    id_musica integer NOT NULL,
    id_artista integer NOT NULL,
    primary key (id_musica, id_artista),
    foreign key (id_musica) references musica (id),
    foreign key (id_artista) references artista (id)
);

--TABELA MUSICA_PEDIDA
create table musica_pedida (
    id_pedido serial NOT NULL,
    cpf_ouvinte varchar(11) NOT NULL,
    id_musica integer NOT NULL,
    id_artista integer NOT NULL,
    id_quadro integer NOT NULL,
    id_apresentador integer NOT NULL,
    qtd_pontos integer NOT NULL,
    primary key (id_pedido),
    foreign key (cpf_ouvinte) references ouvinte (cpf),
    foreign key (id_musica) references musica (id),
    foreign key (id_artista) references artista (id),
    foreign key (id_apresentador) references apresentador (id)
);


--TABELA OUVINTE_NOTICIA
create table ouvinte_noticia (
    cpf_ouvinte varchar(11) NOT NULL,
    id_quadro integer NOT NULL,
    id_apresentador integer NOT NULL,
    primary key (cpf_ouvinte, id_quadro, id_apresentador),
    foreign key (cpf_ouvinte) references ouvinte (cpf),
    foreign key (id_quadro) references quadro (id),
    foreign key (id_apresentador) references apresentador (id)
);

--TABELA PREMIACAO
create table premiacao (
    id serial NOT NULL,
    cpf_ouvinte varchar(11) NOT NULL,
    qtd_pontos integer,
    primary key (id),
    foreign key (cpf_ouvinte) references ouvinte (cpf)
);

--TABELA QUADRO_APRESENTADO
create table quadro_apresentado (
    id_quadro integer NOT NULL,
    id_apresentador integer NOT NULL,
    primary key (id_quadro, id_apresentador),
    foreign key (id_quadro) references quadro (id),
    foreign key (id_apresentador) references apresentador (id)
);

--TABELA TELEFONE_OUVINTE
create table telefone_ouvinte (
    telefone varchar(15) NOT NULL UNIQUE,
    cpf_ouvinte varchar(11) NOT NULL,
    primary key (telefone, cpf_ouvinte),
    foreign key (cpf_ouvinte) references ouvinte (cpf)
);