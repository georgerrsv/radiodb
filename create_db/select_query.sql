-- # CONSULTAS #


--Mostra o nome, horario e dia dos quadros da manha

select nome_do_quadro, horario, dia 
from quadro 
where horario between '05%' and '12%' 
order by horario;

--Mostra o cpf, nome e id da premiacao dos ouvintes que estao concorrendo a premiacao

select ov.nome, ov.cpf, ov.id_premiacao
from ouvinte ov
inner join premiacao pr on ov.id_premiacao = pr.id;

--Mostra o nome, cpf e a quantidade de pontos dos ouvintes concorrendo a premiacao, ordenado pelo maior numero de pontos

select ov.nome, ov.cpf, pr.qtd_pontos
from premiacao pr
join ouvinte ov on pr.cpf_ouvinte = ov.cpf
order by pr.qtd_pontos desc;

--Mostra o nome do apresentador, o quadro apresentado, horario e dia da semana, ordenado pelo horario manha ate noite

select apr.nome apresentador, qd.nome_do_quadro quadro, qd.horario, qd.dia
from quadro_apresentado qap
join apresentador apr on qap.id_apresentador = apr.id
join quadro qd on qap.id_quadro = qd.id
order by qd.horario;

--Mostra o nome do ouvinte, a musica pedida e o artista, o nome do quadro e a quantidade de pontos ordenado pela maior pontuacao

select ov.nome ouvinte, mus.nome_musica musica, art.nome_artista artista, qd.nome_do_quadro quadro, mp.qtd_pontos pontos
from musica_pedida mp
join artista art on mp.id_artista = art.id
join musica mus on mp.id_musica = mus.id
join ouvinte ov on mp.cpf_ouvinte = ov.cpf
join quadro qd on mp.id_quadro = qd.id
order by pontos desc;

--Mostra o cpf, nome do  ouvinte e o total de pontos daquele ouvinte passando o cpf como parametro de busca

select ov.cpf, ov.nome, sum(qtd_pontos) pontos 
from musica_pedida mp
join ouvinte ov on mp.cpf_ouvinte = ov.cpf
where cpf = '12312312312'
group by ov.cpf;

--Mostra a media de pontos dos participantes da premiacao

select round(avg(qtd_pontos), 2) media_de_pontos
from premiacao;

--Mostra o cpf, o nome e a quantidade de pontos dos que estao acima da media, consulta aninhada

with participante as (
select participante.cpf cpf, participante.nome nome, participante.qtd_pontos pontos
from(select ov.nome, ov.cpf, pr.qtd_pontos
from premiacao pr
join ouvinte ov on pr.cpf_ouvinte = ov.cpf
order by pr.qtd_pontos desc) participante
)
select cpf, nome, pontos
from participante
where pontos > 6;

--Mostra o nome do apresentador, o quadro e quem teve mais e menos interacoes

select apr_quadro.nome apresentador, apr_quadro.nome_do_quadro quadro, count(*)interacoes
from(select apr.nome, qd.nome_do_quadro
from musica_pedida mp
join apresentador apr on mp.id_apresentador = apr.id
join quadro qd on mp.id_quadro = qd.id)apr_quadro
group by apresentador, quadro
order by interacoes desc;

--Mostra o nome da musica e do artista cujo genero seja forro

select art.nome_artista, mus.nome_musica
from musica_artista ma
join musica mus on ma.id_musica = mus.id
join artista art on ma.id_artista = art.id
group by art.nome_artista, mus.nome_musica, mus.genero
having mus.genero = 'forro';

--Mostra o nome dos ouvintes que nao estao concorrendo a premiacao

select ov.cpf, ov.nome
from ouvinte ov
where not exists (select id from premiacao pr where ov.id_premiacao = pr.id);

--Mostra o nome dos participantes, do apresentador e o nome do quadro de noticias

select ov.cpf, ov.nome participante, qd.nome_do_quadro quadro, apr.nome apresentador
from ouvinte_noticia ovn
join apresentador apr on ovn.id_apresentador = apr.id
join quadro qd on ovn.id_quadro = qd.id
join ouvinte ov on ovn.cpf_ouvinte = ov.cpf;

--Mostra as musicas pedidas, da mais pedida a menos pedida

select mus.nome_musica musica, count(*) qtd
from musica_pedida mp
join musica mus on mp.id_musica = mus.id
group by musica
order by qtd desc;

--Mostra o artista pedido, do mais pedido ao menos pedido

select art.nome_artista artista, count(*) qtd
from musica_pedida mp
join artista art on mp.id_artista = art.id
group by artista
order by qtd desc;