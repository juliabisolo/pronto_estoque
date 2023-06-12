CREATE USER tem_estoque WITH LOGIN ENCRYPTED PASSWORD '1234';

CREATE DATABASE tem_estoque OWNER tem_estoque;

create table estado(
id serial primary key not null,
nome varchar(50) not null);

create table cidade(
id serial primary key not null,
nome varchar(100) not null);

create table categoria_produto(
id serial primary key not null,
descricao varchar(100) not null,
ativo boolean default true);

create table produto(
id serial primary key not null,
nome varchar(100) not null,
descricao text not null,
validade date,
preco decimal(10,2),
estoque_minimo integer not null,
estoque_maximo integer,
quantidade int not null,
dt_cadastro timestamp not null,
dt_atualizacao timestamp not null,
categoria_produto_id INTEGER not null references categoria_produto(id)
fornecedor_id INTEGER not null references fornecedor(id)
);

create table fornecedor(
id serial primary key not null,
nome varchar(100) not null,
descricao text not null,
email varchar(50) not null,
telefone varchar(20) not null,
rua varchar(200) not null,
numero varchar(50) not null,
complemento varchar(50),
bairro varchar(50) not null,
cep char(8) not null,
ativo boolean default true,
cnpj char(14) not null,
cidade_id integer references cidade(id),
estado_id integer references estado(id)
);

CREATE TABLE tipo_etiqueta(
    id serial primary key not null,
    value char(1) not null default 'q',
    template_qrcode text,
    template_barcode text
);

