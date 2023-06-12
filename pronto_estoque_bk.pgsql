--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15 (Ubuntu 12.15-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.15 (Ubuntu 12.15-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_produto (
    id integer NOT NULL,
    descricao character varying(100) NOT NULL,
    ativo boolean DEFAULT true
);


ALTER TABLE public.categoria_produto OWNER TO postgres;

--
-- Name: categoria_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoria_produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categoria_produto_id_seq OWNER TO postgres;

--
-- Name: categoria_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoria_produto_id_seq OWNED BY public.categoria_produto.id;


--
-- Name: cidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cidade (
    id bigint NOT NULL,
    nome character varying(250) NOT NULL,
    estado_id bigint
);


ALTER TABLE public.cidade OWNER TO postgres;

--
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    id bigint NOT NULL,
    nome character varying(250) NOT NULL,
    sigla character varying(2) NOT NULL,
    pais_id bigint
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedor (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text,
    email character varying(50) NOT NULL,
    telefone character(14) NOT NULL,
    rua character varying(200) NOT NULL,
    numero character varying(50) NOT NULL,
    complemento character varying(50),
    bairro character varying(50) NOT NULL,
    cep character(9) NOT NULL,
    ativo boolean DEFAULT true,
    cnpj character(18) NOT NULL,
    celular character(15) NOT NULL,
    cidade_id integer NOT NULL,
    estado_id integer NOT NULL
);


ALTER TABLE public.fornecedor OWNER TO postgres;

--
-- Name: fornecedor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fornecedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fornecedor_id_seq OWNER TO postgres;

--
-- Name: fornecedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.id;


--
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    id bigint NOT NULL,
    nome character varying(250) NOT NULL,
    sigla character varying(2) NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text NOT NULL,
    validade date,
    preco numeric(10,2),
    estoque_minimo integer NOT NULL,
    estoque_maximo integer,
    quantidade integer NOT NULL,
    dt_cadastro timestamp without time zone NOT NULL,
    dt_atualizacao timestamp without time zone NOT NULL,
    categoria_produto_id integer NOT NULL,
    fornecedor_id integer
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produto_id_seq OWNER TO postgres;

--
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;


--
-- Name: system_access_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_access_log (
    id integer NOT NULL,
    sessionid text,
    login text,
    login_time timestamp without time zone,
    login_year character varying(4),
    login_month character varying(2),
    login_day character varying(2),
    logout_time timestamp without time zone,
    impersonated character(1),
    access_ip character varying(45),
    impersonated_by character varying(200)
);


ALTER TABLE public.system_access_log OWNER TO postgres;

--
-- Name: system_access_notification_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_access_notification_log (
    id integer NOT NULL,
    login text,
    email text,
    ip_address text,
    login_time text
);


ALTER TABLE public.system_access_notification_log OWNER TO postgres;

--
-- Name: system_change_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_change_log (
    id integer NOT NULL,
    logdate timestamp without time zone,
    login text,
    tablename text,
    primarykey text,
    pkvalue text,
    operation text,
    columnname text,
    oldvalue text,
    newvalue text,
    access_ip text,
    transaction_id text,
    log_trace text,
    session_id text,
    class_name text,
    php_sapi text,
    log_year character varying(4),
    log_month character varying(2),
    log_day character varying(2)
);


ALTER TABLE public.system_change_log OWNER TO postgres;

--
-- Name: system_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_group (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.system_group OWNER TO postgres;

--
-- Name: system_group_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_group_program (
    id integer NOT NULL,
    system_group_id integer,
    system_program_id integer
);


ALTER TABLE public.system_group_program OWNER TO postgres;

--
-- Name: system_preference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_preference (
    id text,
    value text
);


ALTER TABLE public.system_preference OWNER TO postgres;

--
-- Name: system_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_program (
    id integer NOT NULL,
    name character varying(100),
    controller character varying(100)
);


ALTER TABLE public.system_program OWNER TO postgres;

--
-- Name: system_request_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_request_log (
    id integer NOT NULL,
    endpoint text,
    logdate text,
    log_year character varying(4),
    log_month character varying(2),
    log_day character varying(2),
    session_id text,
    login text,
    access_ip text,
    class_name text,
    http_host text,
    server_port text,
    request_uri text,
    request_method text,
    query_string text,
    request_headers text,
    request_body text,
    request_duration integer
);


ALTER TABLE public.system_request_log OWNER TO postgres;

--
-- Name: system_sql_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_sql_log (
    id integer NOT NULL,
    logdate timestamp without time zone,
    login text,
    database_name text,
    sql_command text,
    statement_type text,
    access_ip character varying(45),
    transaction_id text,
    log_trace text,
    session_id text,
    class_name text,
    php_sapi text,
    request_id text,
    log_year character varying(4),
    log_month character varying(2),
    log_day character varying(2)
);


ALTER TABLE public.system_sql_log OWNER TO postgres;

--
-- Name: system_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_unit (
    id integer NOT NULL,
    name character varying(100),
    connection_name character varying(100)
);


ALTER TABLE public.system_unit OWNER TO postgres;

--
-- Name: system_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_user (
    id integer NOT NULL,
    name character varying(100),
    login character varying(100),
    password character varying(100),
    email character varying(100),
    accepted_term_policy character(1),
    phone text,
    address text,
    function_name text,
    about text,
    accepted_term_policy_at text,
    accepted_term_policy_data text,
    frontpage_id integer,
    system_unit_id integer,
    active character(1)
);


ALTER TABLE public.system_user OWNER TO postgres;

--
-- Name: system_user_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_user_group (
    id integer NOT NULL,
    system_user_id integer,
    system_group_id integer
);


ALTER TABLE public.system_user_group OWNER TO postgres;

--
-- Name: system_user_old_password; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_user_old_password (
    id integer NOT NULL,
    system_user_id integer,
    password text,
    created_at timestamp without time zone
);


ALTER TABLE public.system_user_old_password OWNER TO postgres;

--
-- Name: system_user_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_user_program (
    id integer NOT NULL,
    system_user_id integer,
    system_program_id integer
);


ALTER TABLE public.system_user_program OWNER TO postgres;

--
-- Name: system_user_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_user_unit (
    id integer NOT NULL,
    system_user_id integer,
    system_unit_id integer
);


ALTER TABLE public.system_user_unit OWNER TO postgres;

--
-- Name: tipo_etiqueta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_etiqueta (
    id integer NOT NULL,
    value character(1) DEFAULT 'q'::bpchar NOT NULL,
    template_barcode text,
    template_qrcode text
);


ALTER TABLE public.tipo_etiqueta OWNER TO postgres;

--
-- Name: tipo_etiqueta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_etiqueta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_etiqueta_id_seq OWNER TO postgres;

--
-- Name: tipo_etiqueta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_etiqueta_id_seq OWNED BY public.tipo_etiqueta.id;


--
-- Name: categoria_produto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto ALTER COLUMN id SET DEFAULT nextval('public.categoria_produto_id_seq'::regclass);


--
-- Name: fornecedor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);


--
-- Name: produto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);


--
-- Name: tipo_etiqueta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_etiqueta ALTER COLUMN id SET DEFAULT nextval('public.tipo_etiqueta_id_seq'::regclass);


--
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria_produto (id, descricao, ativo) FROM stdin;
\.


--
-- Data for Name: cidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cidade (id, nome, estado_id) FROM stdin;
1	Acrelândia	1
2	Assis Brasil	1
3	Brasiléia	1
4	Bujari	1
5	Capixaba	1
6	Cruzeiro do Sul	1
7	Epitaciolândia	1
8	Feijó	1
9	Jordão	1
10	Mâncio Lima	1
11	Manoel Urbano	1
12	Marechal Thaumaturgo	1
13	Plácido de Castro	1
14	Porto Acre	1
15	Porto Walter	1
16	Rio Branco	1
17	Rodrigues Alves	1
18	Santa Rosa do Purus	1
19	Sena Madureira	1
20	Senador Guiomard	1
21	Tarauacá	1
22	Xapuri	1
23	Água Branca	2
24	Anadia	2
25	Arapiraca	2
26	Atalaia	2
27	Barra de Santo Antônio	2
28	Barra de São Miguel	2
29	Batalha	2
30	Belém	2
31	Belo Monte	2
32	Boca da Mata	2
33	Branquinha	2
34	Cacimbinhas	2
35	Cajueiro	2
36	Campestre	2
37	Campo Alegre	2
38	Campo Grande	2
39	Canapi	2
40	Capela	2
41	Carneiros	2
42	Chã Preta	2
43	Coité do Nóia	2
44	Colônia Leopoldina	2
45	Coqueiro Seco	2
46	Coruripe	2
47	Craíbas	2
48	Delmiro Gouveia	2
49	Dois Riachos	2
50	Estrela de Alagoas	2
51	Feira Grande	2
52	Feliz Deserto	2
53	Flexeiras	2
54	Girau do Ponciano	2
55	Ibateguara	2
56	Igaci	2
57	Igreja Nova	2
58	Inhapi	2
59	Jacaré dos Homens	2
60	Jacuípe	2
61	Japaratinga	2
62	Jaramataia	2
63	Joaquim Gomes	2
64	Jundiá	2
65	Junqueiro	2
66	Lagoa da Canoa	2
67	Limoeiro de Anadia	2
68	Maceió	2
69	Major Isidoro	2
70	Mar Vermelho	2
71	Maragogi	2
72	Maravilha	2
73	Marechal Deodoro	2
74	Maribondo	2
75	Mata Grande	2
76	Matriz de Camaragibe	2
77	Messias	2
78	Minador do Negrão	2
79	Monteirópolis	2
80	Murici	2
81	Novo Lino	2
82	Olho d`Água das Flores	2
83	Olho d`Água do Casado	2
84	Olho d`Água Grande	2
85	Olivença	2
86	Ouro Branco	2
87	Palestina	2
88	Palmeira dos Índios	2
89	Pão de Açúcar	2
90	Pariconha	2
91	Paripueira	2
92	Passo de Camaragibe	2
93	Paulo Jacinto	2
94	Penedo	2
95	Piaçabuçu	2
96	Pilar	2
97	Pindoba	2
98	Piranhas	2
99	Poço das Trincheiras	2
100	Porto Calvo	2
101	Porto de Pedras	2
102	Porto Real do Colégio	2
103	Quebrangulo	2
104	Rio Largo	2
105	Roteiro	2
106	Santa Luzia do Norte	2
107	Santana do Ipanema	2
108	Santana do Mundaú	2
109	São Brás	2
110	São José da Laje	2
111	São José da Tapera	2
112	São Luís do Quitunde	2
113	São Miguel dos Campos	2
114	São Miguel dos Milagres	2
115	São Sebastião	2
116	Satuba	2
117	Senador Rui Palmeira	2
118	Tanque d`Arca	2
119	Taquarana	2
120	Teotônio Vilela	2
121	Traipu	2
122	União dos Palmares	2
123	Viçosa	2
124	Amapá	3
125	Calçoene	3
126	Cutias	3
127	Ferreira Gomes	3
128	Itaubal	3
129	Laranjal do Jari	3
130	Macapá	3
131	Mazagão	3
132	Oiapoque	3
133	Pedra Branca do Amaparí	3
134	Porto Grande	3
135	Pracuúba	3
136	Santana	3
137	Serra do Navio	3
138	Tartarugalzinho	3
139	Vitória do Jari	3
140	Alvarães	4
141	Amaturá	4
142	namã	4
143	Anori	4
144	Apuí	4
145	Atalaia do Norte	4
146	Autazes	4
147	Barcelos	4
148	Barreirinha	4
149	Benjamin Constant	4
150	Beruri	4
151	Boa Vista do Ramos	4
152	Boca do Acre	4
153	Borba	4
154	Caapiranga	4
155	Canutama	4
156	Carauari	4
157	Careiro	4
158	Careiro da Várzea	4
159	Coari	4
160	Codajás	4
161	Eirunepé	4
162	Envira	4
163	Fonte Boa	4
164	Guajará	4
165	Humaitá	4
166	Ipixuna	4
167	Iranduba	4
168	Itacoatiara	4
169	Itamarati	4
170	Itapiranga	4
171	Japurá	4
172	Juruá	4
173	Jutaí	4
174	Lábrea	4
175	Manacapuru	4
176	Manaquiri	4
177	Manaus	4
178	Manicoré	4
179	Maraã	4
180	Maués	4
181	Nhamundá	4
182	Nova Olinda do Norte	4
183	Novo Airão	4
184	Novo Aripuanã	4
185	Parintins	4
186	Pauini	4
187	Presidente Figueiredo	4
188	Rio Preto da Eva	4
189	Santa Isabel do Rio Negro	4
190	Santo Antônio do Içá	4
191	São Gabriel da Cachoeira	4
192	São Paulo de Olivença	4
193	São Sebastião do Uatumã	4
194	Silves	4
195	Tabatinga	4
196	Tapauá	4
197	Tefé	4
198	Tonantins	4
199	Uarini	4
200	Urucará	4
201	Urucurituba	4
202	Abaíra	5
203	Abaré	5
204	Acajutiba	5
205	Adustina	5
206	Água Fria	5
207	Aiquara	5
208	Alagoinhas	5
209	Alcobaça	5
210	Almadina	5
211	Amargosa	5
212	Amélia Rodrigues	5
213	América Dourada	5
214	Anagé	5
215	Andaraí	5
216	Andorinha	5
217	Angical	5
218	Anguera	5
219	Antas	5
220	Antônio Cardoso	5
221	Antônio Gonçalves	5
222	Aporá	5
223	Apuarema	5
224	Araças	5
225	Aracatu	5
226	Araci	5
227	Aramari	5
228	Arataca	5
229	Aratuípe	5
230	Aurelino Leal	5
231	Baianópolis	5
232	Baixa Grande	5
233	Banzaê	5
234	Barra	5
235	Barra da Estiva	5
236	Barra do Choça	5
237	Barra do Mendes	5
238	Barra do Rocha	5
239	Barreiras	5
240	Barro Alto	5
241	Belmonte	5
242	Belo Campo	5
243	Biritinga	5
244	Boa Nova	5
245	Boa Vista do Tupim	5
246	Bom Jesus da Lapa	5
247	Bom Jesus da Serra	5
248	Boninal	5
249	Bonito	5
250	Boquira	5
251	Botuporã	5
252	Brejões	5
253	Brejolândia	5
254	Brotas de Macaúbas	5
255	Brumado	5
256	Buerarema	5
257	Buritirama	5
258	Caatiba	5
259	Cabaceiras do Paraguaçu	5
260	Cachoeira	5
261	Caculé	5
262	Caém	5
263	Caetanos	5
264	Caetité	5
265	Cafarnaum	5
266	Cairu	5
267	Caldeirão Grande	5
268	Camacan	5
269	Camaçari	5
270	Camamu	5
271	Campo Alegre de Lourdes	5
272	Campo Formoso	5
273	Canápolis	5
274	Canarana	5
275	Canavieiras	5
276	Candeal	5
277	Candeias	5
278	Candiba	5
279	Cândido Sales	5
280	Cansanção	5
281	Canudos	5
282	Capela do Alto Alegre	5
283	Capim Grosso	5
284	Caraíbas	5
285	Caravelas	5
286	Cardeal da Silva	5
287	Carinhanha	5
288	Casa Nova	5
289	Castro Alves	5
290	Catolândia	5
291	Catu	5
292	Caturama	5
293	Central	5
294	Chorrochó	5
295	Cícero Dantas	5
296	Cipó	5
297	Coaraci	5
298	Cocos	5
299	Conceição da Feira	5
300	Conceição do Almeida	5
301	Conceição do Coité	5
302	Conceição do Jacuípe	5
303	Conde	5
304	Condeúba	5
305	Contendas do Sincorá	5
306	Coração de Maria	5
307	Cordeiros	5
308	Coribe	5
309	Coronel João Sá	5
310	Correntina	5
311	Cotegipe	5
312	Cravolândia	5
313	Crisópolis	5
314	Cristópolis	5
315	Cruz das Almas	5
316	Curaçá	5
317	Dário Meira	5
318	Dias d`Ávila	5
319	Dom Basílio	5
320	Dom Macedo Costa	5
321	Elísio Medrado	5
322	Encruzilhada	5
323	Entre Rios	5
324	Érico Cardoso	5
325	Esplanada	5
326	Euclides da Cunha	5
327	Eunápolis	5
328	Fátima	5
329	Feira da Mata	5
330	Feira de Santana	5
331	Filadélfia	5
332	Firmino Alves	5
333	Floresta Azul	5
334	Formosa do Rio Preto	5
335	Gandu	5
336	Gavião	5
337	Gentio do Ouro	5
338	Glória	5
339	Gongogi	5
340	Governador Lomanto Júnior	5
341	Governador Mangabeira	5
342	Guajeru	5
343	Guanambi	5
344	Guaratinga	5
345	Heliópolis	5
346	Iaçu	5
347	Ibiassucê	5
348	Ibicaraí	5
349	Ibicoara	5
350	Ibicuí	5
351	Ibipeba	5
352	Ibipitanga	5
353	Ibiquera	5
354	Ibirapitanga	5
355	Ibirapuã	5
356	Ibirataia	5
357	Ibitiara	5
358	Ibititá	5
359	Ibotirama	5
360	Ichu	5
361	Igaporã	5
362	Igrapiúna	5
363	Iguaí	5
364	Ilhéus	5
365	Inhambupe	5
366	Ipecaetá	5
367	Ipiaú	5
368	Ipirá	5
369	Ipupiara	5
370	Irajuba	5
371	Iramaia	5
372	Iraquara	5
373	Irará	5
374	Irecê	5
375	Itabela	5
376	Itaberaba	5
377	Itabuna	5
378	Itacaré	5
379	Itaeté	5
380	Itagi	5
381	Itagibá	5
382	Itagimirim	5
383	Itaguaçu da Bahia	5
384	Itaju do Colônia	5
385	Itajuípe	5
386	Itamaraju	5
387	Itamari	5
388	Itambé	5
389	Itanagra	5
390	Itanhém	5
391	Itaparica	5
392	Itapé	5
393	Itapebi	5
394	Itapetinga	5
395	Itapicuru	5
396	Itapitanga	5
397	Itaquara	5
398	Itarantim	5
399	Itatim	5
400	Itiruçu	5
401	Itiúba	5
402	Itororó	5
403	Ituaçu	5
404	Ituberá	5
405	Iuiú	5
406	Jaborandi	5
407	Jacaraci	5
408	Jacobina	5
409	Jaguaquara	5
410	Jaguarari	5
411	Jaguaripe	5
412	Jandaíra	5
413	Jequié	5
414	Jeremoabo	5
415	Jiquiriçá	5
416	Jitaúna	5
417	João Dourado	5
418	Juazeiro	5
419	Jucuruçu	5
420	Jussara	5
421	Jussari	5
422	Jussiape	5
423	Lafaiete Coutinho	5
424	Lagoa Real	5
425	Laje	5
426	Lajedão	5
427	Lajedinho	5
428	Lajedo do Tabocal	5
429	Lamarão	5
430	Lapão	5
431	Lauro de Freitas	5
432	Lençóis	5
433	Licínio de Almeida	5
434	Livramento de Nossa Senhora	5
435	Macajuba	5
436	Macarani	5
437	Macaúbas	5
438	Macururé	5
439	Madre de Deus	5
440	Maetinga	5
441	Maiquinique	5
442	Mairi	5
443	Malhada	5
444	Malhada de Pedras	5
445	Manoel Vitorino	5
446	Mansidão	5
447	Maracás	5
448	Maragogipe	5
449	Maraú	5
450	Marcionílio Souza	5
451	Mascote	5
452	Mata de São João	5
453	Matina	5
454	Medeiros Neto	5
455	Miguel Calmon	5
456	Milagres	5
457	Mirangaba	5
458	Mirante	5
459	Monte Santo	5
460	Morpará	5
461	Morro do Chapéu	5
462	Mortugaba	5
463	Mucugê	5
464	Mucuri	5
465	Mulungu do Morro	5
466	Mundo Novo	5
467	Muniz Ferreira	5
468	Muquém de São Francisco	5
469	Muritiba	5
470	Mutuípe	5
471	Nazaré	5
472	Nilo Peçanha	5
473	Nordestina	5
474	Nova Canaã	5
475	Nova Fátima	5
476	Nova Ibiá	5
477	Nova Itarana	5
478	Nova Redenção	5
479	Nova Soure	5
480	Nova Viçosa	5
481	Novo Horizonte	5
482	Novo Triunfo	5
483	Olindina	5
484	Oliveira dos Brejinhos	5
485	Ouriçangas	5
486	Ourolândia	5
487	Palmas de Monte Alto	5
488	Palmeiras	5
489	Paramirim	5
490	Paratinga	5
491	Paripiranga	5
492	Pau Brasil	5
493	Paulo Afonso	5
494	Pé de Serra	5
495	Pedrão	5
496	Pedro Alexandre	5
497	Piatã	5
498	Pilão Arcado	5
499	Pindaí	5
500	Pindobaçu	5
501	Pintadas	5
502	Piraí do Norte	5
503	Piripá	5
504	Piritiba	5
505	Planaltino	5
506	Planalto	5
507	Poções	5
508	Pojuca	5
509	Ponto Novo	5
510	Porto Seguro	5
511	Potiraguá	5
512	Prado	5
513	Presidente Dutra	5
514	Presidente Jânio Quadros	5
515	Presidente Tancredo Neves	5
516	Queimadas	5
517	Quijingue	5
518	Quixabeira	5
519	Rafael Jambeiro	5
520	Remanso	5
521	Retirolândia	5
522	Riachão das Neves	5
523	Riachão do Jacuípe	5
524	Riacho de Santana	5
525	Ribeira do Amparo	5
526	Ribeira do Pombal	5
527	Ribeirão do Largo	5
528	Rio de Contas	5
529	Rio do Antônio	5
530	Rio do Pires	5
531	Rio Real	5
532	Rodelas	5
533	Ruy Barbosa	5
534	Salinas da Margarida	5
535	Salvador	5
536	Santa Bárbara	5
537	Santa Brígida	5
538	Santa Cruz Cabrália	5
539	Santa Cruz da Vitória	5
540	Santa Inês	5
541	Santa Luzia	5
542	Santa Maria da Vitória	5
543	Santa Rita de Cássia	5
544	Santa Teresinha	5
545	Santaluz	5
546	Santana	5
547	Santanópolis	5
548	Santo Amaro	5
549	Santo Antônio de Jesus	5
550	Santo Estêvão	5
551	São Desidério	5
552	São Domingos	5
553	São Felipe	5
554	São Félix	5
555	São Félix do Coribe	5
556	São Francisco do Conde	5
557	São Gabriel	5
558	São Gonçalo dos Campos	5
559	São José da Vitória	5
560	São José do Jacuípe	5
561	São Miguel das Matas	5
562	São Sebastião do Passé	5
563	Sapeaçu	5
564	Sátiro Dias	5
565	Saubara	5
566	Saúde	5
567	Seabra	5
568	Sebastião Laranjeiras	5
569	Senhor do Bonfim	5
570	Sento Sé	5
571	Serra do Ramalho	5
572	Serra Dourada	5
573	Serra Preta	5
574	Serrinha	5
575	Serrolândia	5
576	Simões Filho	5
577	Sítio do Mato	5
578	Sítio do Quinto	5
579	Sobradinho	5
580	Souto Soares	5
581	Tabocas do Brejo Velho	5
582	Tanhaçu	5
583	Tanque Novo	5
584	Tanquinho	5
585	Taperoá	5
586	Tapiramutá	5
587	Teixeira de Freitas	5
588	Teodoro Sampaio	5
589	Teofilândia	5
590	Teolândia	5
591	Terra Nova	5
592	Tremedal	5
593	Tucano	5
594	Uauá	5
595	Ubaíra	5
596	Ubaitaba	5
597	Ubatã	5
598	Uibaí	5
599	Umburanas	5
600	Una	5
601	Urandi	5
602	Uruçuca	5
603	Utinga	5
604	Valença	5
605	Valente	5
606	Várzea da Roça	5
607	Várzea do Poço	5
608	Várzea Nova	5
609	Varzedo	5
610	Vera Cruz	5
611	Vereda	5
612	Vitória da Conquista	5
613	Wagner	5
614	Wanderley	5
615	Wenceslau Guimarães	5
616	Xique-Xique	5
617	Abaiara	6
618	Acarapé	6
619	Acaraú	6
620	Acopiara	6
621	Aiuaba	6
622	Alcântaras	6
623	Altaneira	6
624	Alto Santo	6
625	Amontada	6
626	Antonina do Norte	6
627	Apuiarés	6
628	Aquiraz	6
629	Aracati	6
630	Aracoiaba	6
631	Ararendá	6
632	Araripe	6
633	Aratuba	6
634	Arneiroz	6
635	Assaré	6
636	Aurora	6
637	Baixio	6
638	Banabuiú	6
639	Barbalha	6
640	Barreira	6
641	Barro	6
642	Barroquinha	6
643	Baturité	6
644	Beberibe	6
645	Bela Cruz	6
646	Boa Viagem	6
647	Brejo Santo	6
648	Camocim	6
649	Campos Sales	6
650	Canindé	6
651	Capistrano	6
652	Caridade	6
653	Cariré	6
654	Caririaçu	6
655	Cariús	6
656	Carnaubal	6
657	Cascavel	6
658	Catarina	6
659	Catunda	6
660	Caucaia	6
661	Cedro	6
662	Chaval	6
663	Choró	6
664	Chorozinho	6
665	Coreaú	6
666	Crateús	6
667	Crato	6
668	Croatá	6
669	Cruz	6
670	Deputado Irapuan Pinheiro	6
671	Ererê	6
672	Eusébio	6
673	Farias Brito	6
674	Forquilha	6
675	Fortaleza	6
676	Fortim	6
677	Frecheirinha	6
678	General Sampaio	6
679	Graça	6
680	Granja	6
681	Granjeiro	6
682	Groaíras	6
683	Guaiúba	6
684	Guaraciaba do Norte	6
685	Guaramiranga	6
686	Hidrolândia	6
687	Horizonte	6
688	Ibaretama	6
689	Ibiapina	6
690	Ibicuitinga	6
691	Icapuí	6
692	Icó	6
693	Iguatu	6
694	Independência	6
695	Ipaporanga	6
696	Ipaumirim	6
697	Ipu	6
698	Ipueiras	6
699	Iracema	6
700	Irauçuba	6
701	Itaiçaba	6
702	Itaitinga	6
703	Itapagé	6
704	Itapipoca	6
705	Itapiúna	6
706	Itarema	6
707	Itatira	6
708	Jaguaretama	6
709	Jaguaribara	6
710	Jaguaribe	6
711	Jaguaruana	6
712	Jardim	6
713	Jati	6
714	Jijoca de Jericoacoara	6
715	Juazeiro do Norte	6
716	Jucás	6
717	Lavras da Mangabeira	6
718	Limoeiro do Norte	6
719	Madalena	6
720	Maracanaú	6
721	Maranguape	6
722	Marco	6
723	Martinópole	6
724	Massapê	6
725	Mauriti	6
726	Meruoca	6
727	Milagres	6
728	Milhã	6
729	Miraíma	6
730	Missão Velha	6
731	Mombaça	6
732	Monsenhor Tabosa	6
733	Morada Nova	6
734	Moraújo	6
735	Morrinhos	6
736	Mucambo	6
737	Mulungu	6
738	Nova Olinda	6
739	Nova Russas	6
740	Novo Oriente	6
741	Ocara	6
742	Orós	6
743	Pacajus	6
744	Pacatuba	6
745	Pacoti	6
746	Pacujá	6
747	Palhano	6
748	Palmácia	6
749	Paracuru	6
750	Paraipaba	6
751	Parambu	6
752	Paramoti	6
753	Pedra Branca	6
754	Penaforte	6
755	Pentecoste	6
756	Pereiro	6
757	Pindoretama	6
758	Piquet Carneiro	6
759	Pires Ferreira	6
760	Poranga	6
761	Porteiras	6
762	Potengi	6
763	Potiretama	6
764	Quiterianópolis	6
765	Quixadá	6
766	Quixelô	6
767	Quixeramobim	6
768	Quixeré	6
769	Redenção	6
770	Reriutaba	6
771	Russas	6
772	Saboeiro	6
773	Salitre	6
774	Santa Quitéria	6
775	Santana do Acaraú	6
776	Santana do Cariri	6
777	São Benedito	6
778	São Gonçalo do Amarante	6
779	São João do Jaguaribe	6
780	São Luís do Curu	6
781	Senador Pompeu	6
782	Senador Sá	6
783	Sobral	6
784	Solonópole	6
785	Tabuleiro do Norte	6
786	Tamboril	6
787	Tarrafas	6
788	Tauá	6
789	Tejuçuoca	6
790	Tianguá	6
791	Trairi	6
792	Tururu	6
793	Ubajara	6
794	Umari	6
795	Umirim	6
796	Uruburetama	6
797	Uruoca	6
798	Varjota	6
799	Várzea Alegre	6
800	Viçosa do Ceará	6
801	Brasília	7
802	Afonso Cláudio	8
803	Água Doce do Norte	8
804	Águia Branca	8
805	Alegre	8
806	Alfredo Chaves	8
807	Alto Rio Novo	8
808	Anchieta	8
809	Apiacá	8
810	Aracruz	8
811	Atilio Vivacqua	8
812	Baixo Guandu	8
813	Barra de São Francisco	8
814	Boa Esperança	8
815	Bom Jesus do Norte	8
816	Brejetuba	8
817	Cachoeiro de Itapemirim	8
818	Cariacica	8
819	Castelo	8
820	Colatina	8
821	Conceição da Barra	8
822	Conceição do Castelo	8
823	Divino de São Lourenço	8
824	Domingos Martins	8
825	Dores do Rio Preto	8
826	Ecoporanga	8
827	Fundão	8
828	Guaçuí	8
829	Guarapari	8
830	Ibatiba	8
831	Ibiraçu	8
832	Ibitirama	8
833	Iconha	8
834	Irupi	8
835	Itaguaçu	8
836	Itapemirim	8
837	Itarana	8
838	Iúna	8
839	Jaguaré	8
840	Jerônimo Monteiro	8
841	João Neiva	8
842	Laranja da Terra	8
843	Linhares	8
844	Mantenópolis	8
845	Marataízes	8
846	Marechal Floriano	8
847	Marilândia	8
848	Mimoso do Sul	8
849	Montanha	8
850	Mucurici	8
851	Muniz Freire	8
852	Muqui	8
853	Nova Venécia	8
854	Pancas	8
855	Pedro Canário	8
856	Pinheiros	8
857	Piúma	8
858	Ponto Belo	8
859	Presidente Kennedy	8
860	Rio Bananal	8
861	Rio Novo do Sul	8
862	Santa Leopoldina	8
863	Santa Maria de Jetibá	8
864	Santa Teresa	8
865	São Domingos do Norte	8
866	São Gabriel da Palha	8
867	São José do Calçado	8
868	São Mateus	8
869	São Roque do Canaã	8
870	Serra	8
871	Sooretama	8
872	Vargem Alta	8
873	Venda Nova do Imigrante	8
874	Viana	8
875	Vila Pavão	8
876	Vila Valério	8
877	Vila Velha	8
878	Vitória	8
879	Abadia de Goiás	9
880	Abadiânia	9
881	Acreúna	9
882	Adelândia	9
883	Água Fria de Goiás	9
884	Água Limpa	9
885	Águas Lindas de Goiás	9
886	Alexânia	9
887	Aloândia	9
888	Alto Horizonte	9
889	Alto Paraíso de Goiás	9
890	Alvorada do Norte	9
891	Amaralina	9
892	Americano do Brasil	9
893	Amorinópolis	9
894	Anápolis	9
895	Anhanguera	9
896	Anicuns	9
897	Aparecida de Goiânia	9
898	Aparecida do Rio Doce	9
899	Aporé	9
900	Araçu	9
901	Aragarças	9
902	Aragoiânia	9
903	Araguapaz	9
904	Arenópolis	9
905	Aruanã	9
906	Aurilândia	9
907	Avelinópolis	9
908	Baliza	9
909	Barro Alto	9
910	Bela Vista de Goiás	9
911	Bom Jardim de Goiás	9
912	Bom Jesus de Goiás	9
913	Bonfinópolis	9
914	Bonópolis	9
915	Brazabrantes	9
916	Britânia	9
917	Buriti Alegre	9
918	Buriti de Goiás	9
919	Buritinópolis	9
920	Cabeceiras	9
921	Cachoeira Alta	9
922	Cachoeira de Goiás	9
923	Cachoeira Dourada	9
924	Caçu	9
925	Caiapônia	9
926	Caldas Novas	9
927	Caldazinha	9
928	Campestre de Goiás	9
929	Campinaçu	9
930	Campinorte	9
931	Campo Alegre de Goiás	9
932	Campos Belos	9
933	Campos Verdes	9
934	Carmo do Rio Verde	9
935	Castelândia	9
936	Catalão	9
937	Caturaí	9
938	Cavalcante	9
939	Ceres	9
940	Cezarina	9
941	Chapadão do Céu	9
942	Cidade Ocidental	9
943	Cocalzinho de Goiás	9
944	Colinas do Sul	9
945	Córrego do Ouro	9
946	Corumbá de Goiás	9
947	Corumbaíba	9
948	Cristalina	9
949	Cristianópolis	9
950	Crixás	9
951	Cromínia	9
952	Cumari	9
953	Damianópolis	9
954	Damolândia	9
955	Davinópolis	9
956	Diorama	9
957	Divinópolis de Goiás	9
958	Doverlândia	9
959	Edealina	9
960	Edéia	9
961	Estrela do Norte	9
962	Faina	9
963	Fazenda Nova	9
964	Firminópolis	9
965	Flores de Goiás	9
966	Formosa	9
967	Formoso	9
968	Goianápolis	9
969	Goiandira	9
970	Goianésia	9
971	Goiânia	9
972	Goianira	9
973	Goiás	9
974	Goiatuba	9
975	Gouvelândia	9
976	Guapó	9
977	Guaraíta	9
978	Guarani de Goiás	9
979	Guarinos	9
980	Heitoraí	9
981	Hidrolândia	9
982	Hidrolina	9
983	Iaciara	9
984	Inaciolândia	9
985	Indiara	9
986	Inhumas	9
987	Ipameri	9
988	Iporá	9
989	Israelândia	9
990	Itaberaí	9
991	Itaguari	9
992	Itaguaru	9
993	Itajá	9
994	Itapaci	9
995	Itapirapuã	9
996	Itapuranga	9
997	Itarumã	9
998	Itauçu	9
999	Itumbiara	9
1000	Ivolândia	9
1001	Jandaia	9
1002	Jaraguá	9
1003	Jataí	9
1004	Jaupaci	9
1005	Jesúpolis	9
1006	Joviânia	9
1007	Jussara	9
1008	Leopoldo de Bulhões	9
1009	Luziânia	9
1010	Mairipotaba	9
1011	Mambaí	9
1012	Mara Rosa	9
1013	Marzagão	9
1014	Matrinchã	9
1015	Maurilândia	9
1016	Mimoso de Goiás	9
1017	Minaçu	9
1018	Mineiros	9
1019	Moiporá	9
1020	Monte Alegre de Goiás	9
1021	Montes Claros de Goiás	9
1022	Montividiu	9
1023	Montividiu do Norte	9
1024	Morrinhos	9
1025	Morro Agudo de Goiás	9
1026	Mossâmedes	9
1027	Mozarlândia	9
1028	Mundo Novo	9
1029	Mutunópolis	9
1030	Nazário	9
1031	Nerópolis	9
1032	Niquelândia	9
1033	Nova América	9
1034	Nova Aurora	9
1035	Nova Crixás	9
1036	Nova Glória	9
1037	Nova Iguaçu de Goiás	9
1038	Nova Roma	9
1039	Nova Veneza	9
1040	Novo Brasil	9
1041	Novo Gama	9
1042	Novo Planalto	9
1043	Orizona	9
1044	Ouro Verde de Goiás	9
1045	Ouvidor	9
1046	Padre Bernardo	9
1047	Palestina de Goiás	9
1048	Palmeiras de Goiás	9
1049	Palmelo	9
1050	Palminópolis	9
1051	Panamá	9
1052	Paranaiguara	9
1053	Paraúna	9
1054	Perolândia	9
1055	Petrolina de Goiás	9
1056	Pilar de Goiás	9
1057	Piracanjuba	9
1058	Piranhas	9
1059	Pirenópolis	9
1060	Pires do Rio	9
1061	Planaltina	9
1062	Pontalina	9
1063	Porangatu	9
1064	Porteirão	9
1065	Portelândia	9
1066	Posse	9
1067	Professor Jamil	9
1068	Quirinópolis	9
1069	Rialma	9
1070	Rianápolis	9
1071	Rio Quente	9
1072	Rio Verde	9
1073	Rubiataba	9
1074	Sanclerlândia	9
1075	Santa Bárbara de Goiás	9
1076	Santa Cruz de Goiás	9
1077	Santa Fé de Goiás	9
1078	Santa Helena de Goiás	9
1079	Santa Isabel	9
1080	Santa Rita do Araguaia	9
1081	Santa Rita do Novo Destino	9
1082	Santa Rosa de Goiás	9
1083	Santa Tereza de Goiás	9
1084	Santa Terezinha de Goiás	9
1085	Santo Antônio da Barra	9
1086	Santo Antônio de Goiás	9
1087	Santo Antônio do Descoberto	9
1088	São Domingos	9
1089	São Francisco de Goiás	9
1090	São João d`Aliança	9
1091	São João da Paraúna	9
1092	São Luís de Montes Belos	9
1093	São Luíz do Norte	9
1094	São Miguel do Araguaia	9
1095	São Miguel do Passa Quatro	9
1096	São Patrício	9
1097	São Simão	9
1098	Senador Canedo	9
1099	Serranópolis	9
1100	Silvânia	9
1101	Simolândia	9
1102	Sítio d`Abadia	9
1103	Taquaral de Goiás	9
1104	Teresina de Goiás	9
1105	Terezópolis de Goiás	9
1106	Três Ranchos	9
1107	Trindade	9
1108	Trombas	9
1109	Turvânia	9
1110	Turvelândia	9
1111	Uirapuru	9
1112	Uruaçu	9
1113	Uruana	9
1114	Urutaí	9
1115	Valparaíso de Goiás	9
1116	Varjão	9
1117	Vianópolis	9
1118	Vicentinópolis	9
1119	Vila Boa	9
1120	Vila Propício	9
1121	Açailândia	10
1122	Afonso Cunha	10
1123	Água Doce do Maranhão	10
1124	Alcântara	10
1125	Aldeias Altas	10
1126	Altamira do Maranhão	10
1127	Alto Alegre do Maranhão	10
1128	Alto Alegre do Pindaré	10
1129	Alto Parnaíba	10
1130	Amapá do Maranhão	10
1131	Amarante do Maranhão	10
1132	Anajatuba	10
1133	Anapurus	10
1134	Apicum-Açu	10
1135	Araguanã	10
1136	Araioses	10
1137	Arame	10
1138	Arari	10
1139	Axixá	10
1140	Bacabal	10
1141	Bacabeira	10
1142	Bacuri	10
1143	Bacurituba	10
1144	Balsas	10
1145	Barão de Grajaú	10
1146	Barra do Corda	10
1147	Barreirinhas	10
1148	Bela Vista do Maranhão	10
1149	Belágua	10
1150	Benedito Leite	10
1151	Bequimão	10
1152	Bernardo do Mearim	10
1153	Boa Vista do Gurupi	10
1154	Bom Jardim	10
1155	Bom Jesus das Selvas	10
1156	Bom Lugar	10
1157	Brejo	10
1158	Brejo de Areia	10
1159	Buriti	10
1160	Buriti Bravo	10
1161	Buriticupu	10
1162	Buritirana	10
1163	Cachoeira Grande	10
1164	Cajapió	10
1165	Cajari	10
1166	Campestre do Maranhão	10
1167	Cândido Mendes	10
1168	Cantanhede	10
1169	Capinzal do Norte	10
1170	Carolina	10
1171	Carutapera	10
1172	Caxias	10
1173	Cedral	10
1174	Central do Maranhão	10
1175	Centro do Guilherme	10
1176	Centro Novo do Maranhão	10
1177	Chapadinha	10
1178	Cidelândia	10
1179	Codó	10
1180	Coelho Neto	10
1181	Colinas	10
1182	Conceição do Lago-Açu	10
1183	Coroatá	10
1184	Cururupu	10
1185	Davinópolis	10
1186	Dom Pedro	10
1187	Duque Bacelar	10
1188	Esperantinópolis	10
1189	Estreito	10
1190	Feira Nova do Maranhão	10
1191	Fernando Falcão	10
1192	Formosa da Serra Negra	10
1193	Fortaleza dos Nogueiras	10
1194	Fortuna	10
1195	Godofredo Viana	10
1196	Gonçalves Dias	10
1197	Governador Archer	10
1198	Governador Edison Lobão	10
1199	Governador Eugênio Barros	10
1200	Governador Luiz Rocha	10
1201	Governador Newton Bello	10
1202	Governador Nunes Freire	10
1203	Graça Aranha	10
1204	Grajaú	10
1205	Guimarães	10
1206	Humberto de Campos	10
1207	Icatu	10
1208	Igarapé do Meio	10
1209	Igarapé Grande	10
1210	Imperatriz	10
1211	Itaipava do Grajaú	10
1212	Itapecuru Mirim	10
1213	Itinga do Maranhão	10
1214	Jatobá	10
1215	Jenipapo dos Vieiras	10
1216	João Lisboa	10
1217	Joselândia	10
1218	Junco do Maranhão	10
1219	Lago da Pedra	10
1220	Lago do Junco	10
1221	Lago dos Rodrigues	10
1222	Lago Verde	10
1223	Lagoa do Mato	10
1224	Lagoa Grande do Maranhão	10
1225	Lajeado Novo	10
1226	Lima Campos	10
1227	Loreto	10
1228	Luís Domingues	10
1229	Magalhães de Almeida	10
1230	Maracaçumé	10
1231	Marajá do Sena	10
1232	Maranhãozinho	10
1233	Mata Roma	10
1234	Matinha	10
1235	Matões	10
1236	Matões do Norte	10
1237	Milagres do Maranhão	10
1238	Mirador	10
1239	Miranda do Norte	10
1240	Mirinzal	10
1241	Monção	10
1242	Montes Altos	10
1243	Morros	10
1244	Nina Rodrigues	10
1245	Nova Colinas	10
1246	Nova Iorque	10
1247	Nova Olinda do Maranhão	10
1248	Olho d`Água das Cunhãs	10
1249	Olinda Nova do Maranhão	10
1250	Paço do Lumiar	10
1251	Palmeirândia	10
1252	Paraibano	10
1253	Parnarama	10
1254	Passagem Franca	10
1255	Pastos Bons	10
1256	Paulino Neves	10
1257	Paulo Ramos	10
1258	Pedreiras	10
1259	Pedro do Rosário	10
1260	Penalva	10
1261	Peri Mirim	10
1262	Peritoró	10
1263	Pindaré-Mirim	10
1264	Pinheiro	10
1265	Pio XII	10
1266	Pirapemas	10
1267	Poção de Pedras	10
1268	Porto Franco	10
1269	Porto Rico do Maranhão	10
1270	Presidente Dutra	10
1271	Presidente Juscelino	10
1272	Presidente Médici	10
1273	Presidente Sarney	10
1274	Presidente Vargas	10
1275	Primeira Cruz	10
1276	Raposa	10
1277	Riachão	10
1278	Ribamar Fiquene	10
1279	Rosário	10
1280	Sambaíba	10
1281	Santa Filomena do Maranhão	10
1282	Santa Helena	10
1283	Santa Inês	10
1284	Santa Luzia	10
1285	Santa Luzia do Paruá	10
1286	Santa Quitéria do Maranhão	10
1287	Santa Rita	10
1288	Santana do Maranhão	10
1289	Santo Amaro do Maranhão	10
1290	Santo Antônio dos Lopes	10
1291	São Benedito do Rio Preto	10
1292	São Bento	10
1293	São Bernardo	10
1294	São Domingos do Azeitão	10
1295	São Domingos do Maranhão	10
1296	São Félix de Balsas	10
1297	São Francisco do Brejão	10
1298	São Francisco do Maranhão	10
1299	São João Batista	10
1300	São João do Carú	10
1301	São João do Paraíso	10
1302	São João do Soter	10
1303	São João dos Patos	10
1304	São José de Ribamar	10
1305	São José dos Basílios	10
1306	São Luís	10
1307	São Luís Gonzaga do Maranhão	10
1308	São Mateus do Maranhão	10
1309	São Pedro da Água Branca	10
1310	São Pedro dos Crentes	10
1311	São Raimundo das Mangabeiras	10
1312	São Raimundo do Doca Bezerra	10
1313	São Roberto	10
1314	São Vicente Ferrer	10
1315	Satubinha	10
1316	Senador Alexandre Costa	10
1317	Senador La Rocque	10
1318	Serrano do Maranhão	10
1319	Sítio Novo	10
1320	Sucupira do Norte	10
1321	Sucupira do Riachão	10
1322	Tasso Fragoso	10
1323	Timbiras	10
1324	Timon	10
1325	Trizidela do Vale	10
1326	Tufilândia	10
1327	Tuntum	10
1328	Turiaçu	10
1329	Turilândia	10
1330	Tutóia	10
1331	Urbano Santos	10
1332	Vargem Grande	10
1333	Viana	10
1334	Vila Nova dos Martírios	10
1335	Vitória do Mearim	10
1336	Vitorino Freire	10
1337	Zé Doca	10
1338	Acorizal	11
1339	Água Boa	11
1340	Alta Floresta	11
1341	Alto Araguaia	11
1342	Alto Boa Vista	11
1343	Alto Garças	11
1344	Alto Paraguai	11
1345	Alto Taquari	11
1346	Apiacás	11
1347	Araguaiana	11
1348	Araguainha	11
1349	Araputanga	11
1350	Arenápolis	11
1351	Aripuanã	11
1352	Barão de Melgaço	11
1353	Barra do Bugres	11
1354	Barra do Garças	11
1355	Brasnorte	11
1356	Cáceres	11
1357	Campinápolis	11
1358	Campo Novo do Parecis	11
1359	Campo Verde	11
1360	Campos de Júlio	11
1361	Canabrava do Norte	11
1362	Canarana	11
1363	Carlinda	11
1364	Castanheira	11
1365	Chapada dos Guimarães	11
1366	Cláudia	11
1367	Cocalinho	11
1368	Colíder	11
1369	Comodoro	11
1370	Confresa	11
1371	Cotriguaçu	11
1372	Cuiabá	11
1373	Denise	11
1374	Diamantino	11
1375	Dom Aquino	11
1376	Feliz Natal	11
1377	Figueirópolis d`Oeste	11
1378	Gaúcha do Norte	11
1379	General Carneiro	11
1380	Glória d`Oeste	11
1381	Guarantã do Norte	11
1382	Guiratinga	11
1383	Indiavaí	11
1384	Itaúba	11
1385	Itiquira	11
1386	Jaciara	11
1387	Jangada	11
1388	Jauru	11
1389	Juara	11
1390	Juína	11
1391	Juruena	11
1392	Juscimeira	11
1393	Lambari d`Oeste	11
1394	Lucas do Rio Verde	11
1395	Luciára	11
1396	Marcelândia	11
1397	Matupá	11
1398	Mirassol d`Oeste	11
1399	Nobres	11
1400	Nortelândia	11
1401	Nossa Senhora do Livramento	11
1402	Nova Bandeirantes	11
1403	Nova Brasilândia	11
1404	Nova Canaã do Norte	11
1405	Nova Guarita	11
1406	Nova Lacerda	11
1407	Nova Marilândia	11
1408	Nova Maringá	11
1409	Nova Monte Verde	11
1410	Nova Mutum	11
1411	Nova Olímpia	11
1412	Nova Ubiratã	11
1413	Nova Xavantina	11
1414	Novo Horizonte do Norte	11
1415	Novo Mundo	11
1416	Novo São Joaquim	11
1417	Paranaíta	11
1418	Paranatinga	11
1419	Pedra Preta	11
1420	Peixoto de Azevedo	11
1421	Planalto da Serra	11
1422	Poconé	11
1423	Pontal do Araguaia	11
1424	Ponte Branca	11
1425	Pontes e Lacerda	11
1426	Porto Alegre do Norte	11
1427	Porto dos Gaúchos	11
1428	Porto Esperidião	11
1429	Porto Estrela	11
1430	Poxoréo	11
1431	Primavera do Leste	11
1432	Querência	11
1433	Reserva do Cabaçal	11
1434	Ribeirão Cascalheira	11
1435	Ribeirãozinho	11
1436	Rio Branco	11
1437	Rondonópolis	11
1438	Rosário Oeste	11
1439	Salto do Céu	11
1440	Santa Carmem	11
1441	Santa Terezinha	11
1442	Santo Afonso	11
1443	Santo Antônio do Leverger	11
1444	São Félix do Araguaia	11
1445	São José do Povo	11
1446	São José do Rio Claro	11
1447	São José do Xingu	11
1448	São José dos Quatro Marcos	11
1449	São Pedro da Cipa	11
1450	Sapezal	11
1451	Sinop	11
1452	Sorriso	11
1453	Tabaporã	11
1454	Tangará da Serra	11
1455	Tapurah	11
1456	Terra Nova do Norte	11
1457	Tesouro	11
1458	Torixoréu	11
1459	União do Sul	11
1460	Várzea Grande	11
1461	Vera	11
1462	Vila Bela da Santíssima Trindade	11
1463	Vila Rica	11
1464	Água Clara	12
1465	Alcinópolis	12
1466	Amambaí	12
1467	Anastácio	12
1468	Anaurilândia	12
1469	Angélica	12
1470	Antônio João	12
1471	Aparecida do Taboado	12
1472	Aquidauana	12
1473	Aral Moreira	12
1474	Bandeirantes	12
1475	Bataguassu	12
1476	Bataiporã	12
1477	Bela Vista	12
1478	Bodoquena	12
1479	Bonito	12
1480	Brasilândia	12
1481	Caarapó	12
1482	Camapuã	12
1483	Campo Grande	12
1484	Caracol	12
1485	Cassilândia	12
1486	Chapadão do Sul	12
1487	Corguinho	12
1488	Coronel Sapucaia	12
1489	Corumbá	12
1490	Costa Rica	12
1491	Coxim	12
1492	Deodápolis	12
1493	Dois Irmãos do Buriti	12
1494	Douradina	12
1495	Dourados	12
1496	Eldorado	12
1497	Fátima do Sul	12
1498	Glória de Dourados	12
1499	Guia Lopes da Laguna	12
1500	Iguatemi	12
1501	Inocência	12
1502	Itaporã	12
1503	Itaquiraí	12
1504	Ivinhema	12
1505	Japorã	12
1506	Jaraguari	12
1507	Jardim	12
1508	Jateí	12
1509	Juti	12
1510	Ladário	12
1511	Laguna Carapã	12
1512	Maracaju	12
1513	Miranda	12
1514	Mundo Novo	12
1515	Naviraí	12
1516	Nioaque	12
1517	Nova Alvorada do Sul	12
1518	Nova Andradina	12
1519	Novo Horizonte do Sul	12
1520	Paranaíba	12
1521	Paranhos	12
1522	Pedro Gomes	12
1523	Ponta Porã	12
1524	Porto Murtinho	12
1525	Ribas do Rio Pardo	12
1526	Rio Brilhante	12
1527	Rio Negro	12
1528	Rio Verde de Mato Grosso	12
1529	Rochedo	12
1530	Santa Rita do Pardo	12
1531	São Gabriel do Oeste	12
1532	Selvíria	12
1533	Sete Quedas	12
1534	Sidrolândia	12
1535	Sonora	12
1536	Tacuru	12
1537	Taquarussu	12
1538	Terenos	12
1539	Três Lagoas	12
1540	Vicentina	12
1541	Abadia dos Dourados	13
1542	Abaeté	13
1543	Abre Campo	13
1544	Acaiaca	13
1545	Açucena	13
1546	Água Boa	13
1547	Água Comprida	13
1548	Aguanil	13
1549	Águas Formosas	13
1550	Águas Vermelhas	13
1551	Aimorés	13
1552	Aiuruoca	13
1553	Alagoa	13
1554	Albertina	13
1555	Além Paraíba	13
1556	Alfenas	13
1557	Alfredo Vasconcelos	13
1558	Almenara	13
1559	Alpercata	13
1560	Alpinópolis	13
1561	Alterosa	13
1562	Alto Caparaó	13
1563	Alto Jequitibá	13
1564	Alto Rio Doce	13
1565	Alvarenga	13
1566	Alvinópolis	13
1567	Alvorada de Minas	13
1568	Amparo do Serra	13
1569	Andradas	13
1570	Andrelândia	13
1571	Angelândia	13
1572	Antônio Carlos	13
1573	Antônio Dias	13
1574	Antônio Prado de Minas	13
1575	Araçaí	13
1576	Aracitaba	13
1577	Araçuaí	13
1578	Araguari	13
1579	Arantina	13
1580	Araponga	13
1581	Araporã	13
1582	Arapuá	13
1583	Araújos	13
1584	Araxá	13
1585	Arceburgo	13
1586	Arcos	13
1587	Areado	13
1588	Argirita	13
1589	Aricanduva	13
1590	Arinos	13
1591	Astolfo Dutra	13
1592	Ataléia	13
1593	Augusto de Lima	13
1594	Baependi	13
1595	Baldim	13
1596	Bambuí	13
1597	Bandeira	13
1598	Bandeira do Sul	13
1599	Barão de Cocais	13
1600	Barão de Monte Alto	13
1601	Barbacena	13
1602	Barra Longa	13
1603	Barroso	13
1604	Bela Vista de Minas	13
1605	Belmiro Braga	13
1606	Belo Horizonte	13
1607	Belo Oriente	13
1608	Belo Vale	13
1609	Berilo	13
1610	Berizal	13
1611	Bertópolis	13
1612	Betim	13
1613	Bias Fortes	13
1614	Bicas	13
1615	Biquinhas	13
1616	Boa Esperança	13
1617	Bocaina de Minas	13
1618	Bocaiúva	13
1619	Bom Despacho	13
1620	Bom Jardim de Minas	13
1621	Bom Jesus da Penha	13
1622	Bom Jesus do Amparo	13
1623	Bom Jesus do Galho	13
1624	Bom Repouso	13
1625	Bom Sucesso	13
1626	Bonfim	13
1627	Bonfinópolis de Minas	13
1628	Bonito de Minas	13
1629	Borda da Mata	13
1630	Botelhos	13
1631	Botumirim	13
1632	Brás Pires	13
1633	Brasilândia de Minas	13
1634	Brasília de Minas	13
1635	Brasópolis	13
1636	Braúnas	13
1637	Brumadinho	13
1638	Bueno Brandão	13
1639	Buenópolis	13
1640	Bugre	13
1641	Buritis	13
1642	Buritizeiro	13
1643	Cabeceira Grande	13
1644	Cabo Verde	13
1645	Cachoeira da Prata	13
1646	Cachoeira de Minas	13
1647	Cachoeira de Pajeú	13
1648	Cachoeira Dourada	13
1649	Caetanópolis	13
1650	Caeté	13
1651	Caiana	13
1652	Cajuri	13
1653	Caldas	13
1654	Camacho	13
1655	Camanducaia	13
1656	Cambuí	13
1657	Cambuquira	13
1658	Campanário	13
1659	Campanha	13
1660	Campestre	13
1661	Campina Verde	13
1662	Campo Azul	13
1663	Campo Belo	13
1664	Campo do Meio	13
1665	Campo Florido	13
1666	Campos Altos	13
1667	Campos Gerais	13
1668	Cana Verde	13
1669	Canaã	13
1670	Canápolis	13
1671	Candeias	13
1672	Cantagalo	13
1673	Caparaó	13
1674	Capela Nova	13
1675	Capelinha	13
1676	Capetinga	13
1677	Capim Branco	13
1678	Capinópolis	13
1679	Capitão Andrade	13
1680	Capitão Enéas	13
1681	Capitólio	13
1682	Caputira	13
1683	Caraí	13
1684	Caranaíba	13
1685	Carandaí	13
1686	Carangola	13
1687	Caratinga	13
1688	Carbonita	13
1689	Careaçu	13
1690	Carlos Chagas	13
1691	Carmésia	13
1692	Carmo da Cachoeira	13
1693	Carmo da Mata	13
1694	Carmo de Minas	13
1695	Carmo do Cajuru	13
1696	Carmo do Paranaíba	13
1697	Carmo do Rio Claro	13
1698	Carmópolis de Minas	13
1699	Carneirinho	13
1700	Carrancas	13
1701	Carvalhópolis	13
1702	Carvalhos	13
1703	Casa Grande	13
1704	Cascalho Rico	13
1705	Cássia	13
1706	Cataguases	13
1707	Catas Altas	13
1708	Catas Altas da Noruega	13
1709	Catuji	13
1710	Catuti	13
1711	Caxambu	13
1712	Cedro do Abaeté	13
1713	Central de Minas	13
1714	Centralina	13
1715	Chácara	13
1716	Chalé	13
1717	Chapada do Norte	13
1718	Chapada Gaúcha	13
1719	Chiador	13
1720	Cipotânea	13
1721	Claraval	13
1722	Claro dos Poções	13
1723	Cláudio	13
1724	Coimbra	13
1725	Coluna	13
1726	Comendador Gomes	13
1727	Comercinho	13
1728	Conceição da Aparecida	13
1729	Conceição da Barra de Minas	13
1730	Conceição das Alagoas	13
1731	Conceição das Pedras	13
1732	Conceição de Ipanema	13
1733	Conceição do Mato Dentro	13
1734	Conceição do Pará	13
1735	Conceição do Rio Verde	13
1736	Conceição dos Ouros	13
1737	Cônego Marinho	13
1738	Confins	13
1739	Congonhal	13
1740	Congonhas	13
1741	Congonhas do Norte	13
1742	Conquista	13
1743	Conselheiro Lafaiete	13
1744	Conselheiro Pena	13
1745	Consolação	13
1746	Contagem	13
1747	Coqueiral	13
1748	Coração de Jesus	13
1749	Cordisburgo	13
1750	Cordislândia	13
1751	Corinto	13
1752	Coroaci	13
1753	Coromandel	13
1754	Coronel Fabriciano	13
1755	Coronel Murta	13
1756	Coronel Pacheco	13
1757	Coronel Xavier Chaves	13
1758	Córrego Danta	13
1759	Córrego do Bom Jesus	13
1760	Córrego Fundo	13
1761	Córrego Novo	13
1762	Couto de Magalhães de Minas	13
1763	Crisólita	13
1764	Cristais	13
1765	Cristália	13
1766	Cristiano Otoni	13
1767	Cristina	13
1768	Crucilândia	13
1769	Cruzeiro da Fortaleza	13
1770	Cruzília	13
1771	Cuparaque	13
1772	Curral de Dentro	13
1773	Curvelo	13
1774	Datas	13
1775	Delfim Moreira	13
1776	Delfinópolis	13
1777	Delta	13
1778	Descoberto	13
1779	Desterro de Entre Rios	13
1780	Desterro do Melo	13
1781	Diamantina	13
1782	Diogo de Vasconcelos	13
1783	Dionísio	13
1784	Divinésia	13
1785	Divino	13
1786	Divino das Laranjeiras	13
1787	Divinolândia de Minas	13
1788	Divinópolis	13
1789	Divisa Alegre	13
1790	Divisa Nova	13
1791	Divisópolis	13
1792	Dom Bosco	13
1793	Dom Cavati	13
1794	Dom Joaquim	13
1795	Dom Silvério	13
1796	Dom Viçoso	13
1797	Dona Eusébia	13
1798	Dores de Campos	13
1799	Dores de Guanhães	13
1800	Dores do Indaiá	13
1801	Dores do Turvo	13
1802	Doresópolis	13
1803	Douradoquara	13
1804	Durandé	13
1805	Elói Mendes	13
1806	Engenheiro Caldas	13
1807	Engenheiro Navarro	13
1808	Entre Folhas	13
1809	Entre Rios de Minas	13
1810	Ervália	13
1811	Esmeraldas	13
1812	Espera Feliz	13
1813	Espinosa	13
1814	Espírito Santo do Dourado	13
1815	Estiva	13
1816	Estrela Dalva	13
1817	Estrela do Indaiá	13
1818	Estrela do Sul	13
1819	Eugenópolis	13
1820	Ewbank da Câmara	13
1821	Extrema	13
1822	Fama	13
1823	Faria Lemos	13
1824	Felício dos Santos	13
1825	Felisburgo	13
1826	Felixlândia	13
1827	Fernandes Tourinho	13
1828	Ferros	13
1829	Fervedouro	13
1830	Florestal	13
1831	Formiga	13
1832	Formoso	13
1833	Fortaleza de Minas	13
1834	Fortuna de Minas	13
1835	Francisco Badaró	13
1836	Francisco Dumont	13
1837	Francisco Sá	13
1838	Franciscópolis	13
1839	Frei Gaspar	13
1840	Frei Inocêncio	13
1841	Frei Lagonegro	13
1842	Fronteira	13
1843	Fronteira dos Vales	13
1844	Fruta de Leite	13
1845	Frutal	13
1846	Funilândia	13
1847	Galiléia	13
1848	Gameleiras	13
1849	Glaucilândia	13
1850	Goiabeira	13
1851	Goianá	13
1852	Gonçalves	13
1853	Gonzaga	13
1854	Gouveia	13
1855	Governador Valadares	13
1856	Grão Mogol	13
1857	Grupiara	13
1858	Guanhães	13
1859	Guapé	13
1860	Guaraciaba	13
1861	Guaraciama	13
1862	Guaranésia	13
1863	Guarani	13
1864	Guarará	13
1865	Guarda-Mor	13
1866	Guaxupé	13
1867	Guidoval	13
1868	Guimarânia	13
1869	Guiricema	13
1870	Gurinhatã	13
1871	Heliodora	13
1872	Iapu	13
1873	Ibertioga	13
1874	Ibiá	13
1875	Ibiaí	13
1876	Ibiracatu	13
1877	Ibiraci	13
1878	Ibirité	13
1879	Ibitiúra de Minas	13
1880	Ibituruna	13
1881	Icaraí de Minas	13
1882	Igarapé	13
1883	Igaratinga	13
1884	Iguatama	13
1885	Ijaci	13
1886	Ilicínea	13
1887	Imbé de Minas	13
1888	Inconfidentes	13
1889	Indaiabira	13
1890	Indianópolis	13
1891	Ingaí	13
1892	Inhapim	13
1893	Inhaúma	13
1894	Inimutaba	13
1895	Ipaba	13
1896	Ipanema	13
1897	Ipatinga	13
1898	Ipiaçu	13
1899	Ipuiúna	13
1900	Iraí de Minas	13
1901	Itabira	13
1902	Itabirinha de Mantena	13
1903	Itabirito	13
1904	Itacambira	13
1905	Itacarambi	13
1906	Itaguara	13
1907	Itaipé	13
1908	Itajubá	13
1909	Itamarandiba	13
1910	Itamarati de Minas	13
1911	Itambacuri	13
1912	Itambé do Mato Dentro	13
1913	Itamogi	13
1914	Itamonte	13
1915	Itanhandu	13
1916	Itanhomi	13
1917	Itaobim	13
1918	Itapagipe	13
1919	Itapecerica	13
1920	Itapeva	13
1921	Itatiaiuçu	13
1922	Itaú de Minas	13
1923	Itaúna	13
1924	Itaverava	13
1925	Itinga	13
1926	Itueta	13
1927	Ituiutaba	13
1928	Itumirim	13
1929	Iturama	13
1930	Itutinga	13
1931	Jaboticatubas	13
1932	Jacinto	13
1933	Jacuí	13
1934	Jacutinga	13
1935	Jaguaraçu	13
1936	Jaíba	13
1937	Jampruca	13
1938	Janaúba	13
1939	Januária	13
1940	Japaraíba	13
1941	Japonvar	13
1942	Jeceaba	13
1943	Jenipapo de Minas	13
1944	Jequeri	13
1945	Jequitaí	13
1946	Jequitibá	13
1947	Jequitinhonha	13
1948	Jesuânia	13
1949	Joaíma	13
1950	Joanésia	13
1951	João Monlevade	13
1952	João Pinheiro	13
1953	Joaquim Felício	13
1954	Jordânia	13
1955	José Gonçalves de Minas	13
1956	José Raydan	13
1957	Josenópolis	13
1958	Juatuba	13
1959	Juiz de Fora	13
1960	Juramento	13
1961	Juruaia	13
1962	Juvenília	13
1963	Ladainha	13
1964	Lagamar	13
1965	Lagoa da Prata	13
1966	Lagoa dos Patos	13
1967	Lagoa Dourada	13
1968	Lagoa Formosa	13
1969	Lagoa Grande	13
1970	Lagoa Santa	13
1971	Lajinha	13
1972	Lambari	13
1973	Lamim	13
1974	Laranjal	13
1975	Lassance	13
1976	Lavras	13
1977	Leandro Ferreira	13
1978	Leme do Prado	13
1979	Leopoldina	13
1980	Liberdade	13
1981	Lima Duarte	13
1982	Limeira do Oeste	13
1983	Lontra	13
1984	Luisburgo	13
1985	Luislândia	13
1986	Luminárias	13
1987	Luz	13
1988	Machacalis	13
1989	Machado	13
1990	Madre de Deus de Minas	13
1991	Malacacheta	13
1992	Mamonas	13
1993	Manga	13
1994	Manhuaçu	13
1995	Manhumirim	13
1996	Mantena	13
1997	Mar de Espanha	13
1998	Maravilhas	13
1999	Maria da Fé	13
2000	Mariana	13
2001	Marilac	13
2002	Mário Campos	13
2003	Maripá de Minas	13
2004	Marliéria	13
2005	Marmelópolis	13
2006	Martinho Campos	13
2007	Martins Soares	13
2008	Mata Verde	13
2009	Materlândia	13
2010	Mateus Leme	13
2011	Mathias Lobato	13
2012	Matias Barbosa	13
2013	Matias Cardoso	13
2014	Matipó	13
2015	Mato Verde	13
2016	Matozinhos	13
2017	Matutina	13
2018	Medeiros	13
2019	Medina	13
2020	Mendes Pimentel	13
2021	Mercês	13
2022	Mesquita	13
2023	Minas Novas	13
2024	Minduri	13
2025	Mirabela	13
2026	Miradouro	13
2027	Miraí	13
2028	Miravânia	13
2029	Moeda	13
2030	Moema	13
2031	Monjolos	13
2032	Monsenhor Paulo	13
2033	Montalvânia	13
2034	Monte Alegre de Minas	13
2035	Monte Azul	13
2036	Monte Belo	13
2037	Monte Carmelo	13
2038	Monte Formoso	13
2039	Monte Santo de Minas	13
2040	Monte Sião	13
2041	Montes Claros	13
2042	Montezuma	13
2043	Morada Nova de Minas	13
2044	Morro da Garça	13
2045	Morro do Pilar	13
2046	Munhoz	13
2047	Muriaé	13
2048	Mutum	13
2049	Muzambinho	13
2050	Nacip Raydan	13
2051	Nanuque	13
2052	Naque	13
2053	Natalândia	13
2054	Natércia	13
2055	Nazareno	13
2056	Nepomuceno	13
2057	Ninheira	13
2058	Nova Belém	13
2059	Nova Era	13
2060	Nova Lima	13
2061	Nova Módica	13
2062	Nova Ponte	13
2063	Nova Porteirinha	13
2064	Nova Resende	13
2065	Nova Serrana	13
2066	Nova União	13
2067	Novo Cruzeiro	13
2068	Novo Oriente de Minas	13
2069	Novorizonte	13
2070	Olaria	13
2071	Olhos-d`Água	13
2072	Olímpio Noronha	13
2073	Oliveira	13
2074	Oliveira Fortes	13
2075	Onça de Pitangui	13
2076	Oratórios	13
2077	Orizânia	13
2078	Ouro Branco	13
2079	Ouro Fino	13
2080	Ouro Preto	13
2081	Ouro Verde de Minas	13
2082	Padre Carvalho	13
2083	Padre Paraíso	13
2084	Pai Pedro	13
2085	Paineiras	13
2086	Pains	13
2087	Paiva	13
2088	Palma	13
2089	Palmópolis	13
2090	Papagaios	13
2091	Pará de Minas	13
2092	Paracatu	13
2093	Paraguaçu	13
2094	Paraisópolis	13
2095	Paraopeba	13
2096	Passa Quatro	13
2097	Passa Tempo	13
2098	Passa-Vinte	13
2099	Passabém	13
2100	Passos	13
2101	Patis	13
2102	Patos de Minas	13
2103	Patrocínio	13
2104	Patrocínio do Muriaé	13
2105	Paula Cândido	13
2106	Paulistas	13
2107	Pavão	13
2108	Peçanha	13
2109	Pedra Azul	13
2110	Pedra Bonita	13
2111	Pedra do Anta	13
2112	Pedra do Indaiá	13
2113	Pedra Dourada	13
2114	Pedralva	13
2115	Pedras de Maria da Cruz	13
2116	Pedrinópolis	13
2117	Pedro Leopoldo	13
2118	Pedro Teixeira	13
2119	Pequeri	13
2120	Pequi	13
2121	Perdigão	13
2122	Perdizes	13
2123	Perdões	13
2124	Periquito	13
2125	Pescador	13
2126	Piau	13
2127	Piedade de Caratinga	13
2128	Piedade de Ponte Nova	13
2129	Piedade do Rio Grande	13
2130	Piedade dos Gerais	13
2131	Pimenta	13
2132	Pingo-d`Água	13
2133	Pintópolis	13
2134	Piracema	13
2135	Pirajuba	13
2136	Piranga	13
2137	Piranguçu	13
2138	Piranguinho	13
2139	Pirapetinga	13
2140	Pirapora	13
2141	Piraúba	13
2142	Pitangui	13
2143	Piumhi	13
2144	Planura	13
2145	Poço Fundo	13
2146	Poços de Caldas	13
2147	Pocrane	13
2148	Pompéu	13
2149	Ponte Nova	13
2150	Ponto Chique	13
2151	Ponto dos Volantes	13
2152	Porteirinha	13
2153	Porto Firme	13
2154	Poté	13
2155	Pouso Alegre	13
2156	Pouso Alto	13
2157	Prados	13
2158	Prata	13
2159	Pratápolis	13
2160	Pratinha	13
2161	Presidente Bernardes	13
2162	Presidente Juscelino	13
2163	Presidente Kubitschek	13
2164	Presidente Olegário	13
2165	Prudente de Morais	13
2166	Quartel Geral	13
2167	Queluzito	13
2168	Raposos	13
2169	Raul Soares	13
2170	Recreio	13
2171	Reduto	13
2172	Resende Costa	13
2173	Resplendor	13
2174	Ressaquinha	13
2175	Riachinho	13
2176	Riacho dos Machados	13
2177	Ribeirão das Neves	13
2178	Ribeirão Vermelho	13
2179	Rio Acima	13
2180	Rio Casca	13
2181	Rio do Prado	13
2182	Rio Doce	13
2183	Rio Espera	13
2184	Rio Manso	13
2185	Rio Novo	13
2186	Rio Paranaíba	13
2187	Rio Pardo de Minas	13
2188	Rio Piracicaba	13
2189	Rio Pomba	13
2190	Rio Preto	13
2191	Rio Vermelho	13
2192	Ritápolis	13
2193	Rochedo de Minas	13
2194	Rodeiro	13
2195	Romaria	13
2196	Rosário da Limeira	13
2197	Rubelita	13
2198	Rubim	13
2199	Sabará	13
2200	Sabinópolis	13
2201	Sacramento	13
2202	Salinas	13
2203	Salto da Divisa	13
2204	Santa Bárbara	13
2205	Santa Bárbara do Leste	13
2206	Santa Bárbara do Monte Verde	13
2207	Santa Bárbara do Tugúrio	13
2208	Santa Cruz de Minas	13
2209	Santa Cruz de Salinas	13
2210	Santa Cruz do Escalvado	13
2211	Santa Efigênia de Minas	13
2212	Santa Fé de Minas	13
2213	Santa Helena de Minas	13
2214	Santa Juliana	13
2215	Santa Luzia	13
2216	Santa Margarida	13
2217	Santa Maria de Itabira	13
2218	Santa Maria do Salto	13
2219	Santa Maria do Suaçuí	13
2220	Santa Rita de Caldas	13
2221	Santa Rita de Ibitipoca	13
2222	Santa Rita de Jacutinga	13
2223	Santa Rita de Minas	13
2224	Santa Rita do Itueto	13
2225	Santa Rita do Sapucaí	13
2226	Santa Rosa da Serra	13
2227	Santa Vitória	13
2228	Santana da Vargem	13
2229	Santana de Cataguases	13
2230	Santana de Pirapama	13
2231	Santana do Deserto	13
2232	Santana do Garambéu	13
2233	Santana do Jacaré	13
2234	Santana do Manhuaçu	13
2235	Santana do Paraíso	13
2236	Santana do Riacho	13
2237	Santana dos Montes	13
2238	Santo Antônio do Amparo	13
2239	Santo Antônio do Aventureiro	13
2240	Santo Antônio do Grama	13
2241	Santo Antônio do Itambé	13
2242	Santo Antônio do Jacinto	13
2243	Santo Antônio do Monte	13
2244	Santo Antônio do Retiro	13
2245	Santo Antônio do Rio Abaixo	13
2246	Santo Hipólito	13
2247	Santos Dumont	13
2248	São Bento Abade	13
2249	São Brás do Suaçuí	13
2250	São Domingos das Dores	13
2251	São Domingos do Prata	13
2252	São Félix de Minas	13
2253	São Francisco	13
2254	São Francisco de Paula	13
2255	São Francisco de Sales	13
2256	São Francisco do Glória	13
2257	São Geraldo	13
2258	São Geraldo da Piedade	13
2259	São Geraldo do Baixio	13
2260	São Gonçalo do Abaeté	13
2261	São Gonçalo do Pará	13
2262	São Gonçalo do Rio Abaixo	13
2263	São Gonçalo do Rio Preto	13
2264	São Gonçalo do Sapucaí	13
2265	São Gotardo	13
2266	São João Batista do Glória	13
2267	São João da Lagoa	13
2268	São João da Mata	13
2269	São João da Ponte	13
2270	São João das Missões	13
2271	São João del Rei	13
2272	São João do Manhuaçu	13
2273	São João do Manteninha	13
2274	São João do Oriente	13
2275	São João do Pacuí	13
2276	São João do Paraíso	13
2277	São João Evangelista	13
2278	São João Nepomuceno	13
2279	São Joaquim de Bicas	13
2280	São José da Barra	13
2281	São José da Lapa	13
2282	São José da Safira	13
2283	São José da Varginha	13
2284	São José do Alegre	13
2285	São José do Divino	13
2286	São José do Goiabal	13
2287	São José do Jacuri	13
2288	São José do Mantimento	13
2289	São Lourenço	13
2290	São Miguel do Anta	13
2291	São Pedro da União	13
2292	São Pedro do Suaçuí	13
2293	São Pedro dos Ferros	13
2294	São Romão	13
2295	São Roque de Minas	13
2296	São Sebastião da Bela Vista	13
2297	São Sebastião da Vargem Alegre	13
2298	São Sebastião do Anta	13
2299	São Sebastião do Maranhão	13
2300	São Sebastião do Oeste	13
2301	São Sebastião do Paraíso	13
2302	São Sebastião do Rio Preto	13
2303	São Sebastião do Rio Verde	13
2304	São Thomé das Letras	13
2305	São Tiago	13
2306	São Tomás de Aquino	13
2307	São Vicente de Minas	13
2308	Sapucaí-Mirim	13
2309	Sardoá	13
2310	Sarzedo	13
2311	Sem-Peixe	13
2312	Senador Amaral	13
2313	Senador Cortes	13
2314	Senador Firmino	13
2315	Senador José Bento	13
2316	Senador Modestino Gonçalves	13
2317	Senhora de Oliveira	13
2318	Senhora do Porto	13
2319	Senhora dos Remédios	13
2320	Sericita	13
2321	Seritinga	13
2322	Serra Azul de Minas	13
2323	Serra da Saudade	13
2324	Serra do Salitre	13
2325	Serra dos Aimorés	13
2326	Serrania	13
2327	Serranópolis de Minas	13
2328	Serranos	13
2329	Serro	13
2330	Sete Lagoas	13
2331	Setubinha	13
2332	Silveirânia	13
2333	Silvianópolis	13
2334	Simão Pereira	13
2335	Simonésia	13
2336	Sobrália	13
2337	Soledade de Minas	13
2338	Tabuleiro	13
2339	Taiobeiras	13
2340	Taparuba	13
2341	Tapira	13
2342	Tapiraí	13
2343	Taquaraçu de Minas	13
2344	Tarumirim	13
2345	Teixeiras	13
2346	Teófilo Otoni	13
2347	Timóteo	13
2348	Tiradentes	13
2349	Tiros	13
2350	Tocantins	13
2351	Tocos do Moji	13
2352	Toledo	13
2353	Tombos	13
2354	Três Corações	13
2355	Três Marias	13
2356	Três Pontas	13
2357	Tumiritinga	13
2358	Tupaciguara	13
2359	Turmalina	13
2360	Turvolândia	13
2361	Ubá	13
2362	Ubaí	13
2363	Ubaporanga	13
2364	Uberaba	13
2365	Uberlândia	13
2366	Umburatiba	13
2367	Unaí	13
2368	União de Minas	13
2369	Uruana de Minas	13
2370	Urucânia	13
2371	Urucuia	13
2372	Vargem Alegre	13
2373	Vargem Bonita	13
2374	Vargem Grande do Rio Pardo	13
2375	Varginha	13
2376	Varjão de Minas	13
2377	Várzea da Palma	13
2378	Varzelândia	13
2379	Vazante	13
2380	Verdelândia	13
2381	Veredinha	13
2382	Veríssimo	13
2383	Vermelho Novo	13
2384	Vespasiano	13
2385	Viçosa	13
2386	Vieiras	13
2387	Virgem da Lapa	13
2388	Virgínia	13
2389	Virginópolis	13
2390	Virgolândia	13
2391	Visconde do Rio Branco	13
2392	Volta Grande	13
2393	Wenceslau Braz	13
2394	Abaetetuba	14
2395	Abel Figueiredo	14
2396	Acará	14
2397	Afuá	14
2398	Água Azul do Norte	14
2399	Alenquer	14
2400	Almeirim	14
2401	Altamira	14
2402	Anajás	14
2403	Ananindeua	14
2404	Anapu	14
2405	Augusto Corrêa	14
2406	Aurora do Pará	14
2407	Aveiro	14
2408	Bagre	14
2409	Baião	14
2410	Bannach	14
2411	Barcarena	14
2412	Belém	14
2413	Belterra	14
2414	Benevides	14
2415	Bom Jesus do Tocantins	14
2416	Bonito	14
2417	Bragança	14
2418	Brasil Novo	14
2419	Brejo Grande do Araguaia	14
2420	Breu Branco	14
2421	Breves	14
2422	Bujaru	14
2423	Cachoeira do Arari	14
2424	Cachoeira do Piriá	14
2425	Cametá	14
2426	Canaã dos Carajás	14
2427	Capanema	14
2428	Capitão Poço	14
2429	Castanhal	14
2430	Chaves	14
2431	Colares	14
2432	Conceição do Araguaia	14
2433	Concórdia do Pará	14
2434	Cumaru do Norte	14
2435	Curionópolis	14
2436	Curralinho	14
2437	Curuá	14
2438	Curuçá	14
2439	Dom Eliseu	14
2440	Eldorado dos Carajás	14
2441	Faro	14
2442	Floresta do Araguaia	14
2443	Garrafão do Norte	14
2444	Goianésia do Pará	14
2445	Gurupá	14
2446	Igarapé-Açu	14
2447	Igarapé-Miri	14
2448	Inhangapi	14
2449	Ipixuna do Pará	14
2450	Irituia	14
2451	Itaituba	14
2452	Itupiranga	14
2453	Jacareacanga	14
2454	Jacundá	14
2455	Juruti	14
2456	Limoeiro do Ajuru	14
2457	Mãe do Rio	14
2458	Magalhães Barata	14
2459	Marabá	14
2460	Maracanã	14
2461	Marapanim	14
2462	Marituba	14
2463	Medicilândia	14
2464	Melgaço	14
2465	Mocajuba	14
2466	Moju	14
2467	Monte Alegre	14
2468	Muaná	14
2469	Nova Esperança do Piriá	14
2470	Nova Ipixuna	14
2471	Nova Timboteua	14
2472	Novo Progresso	14
2473	Novo Repartimento	14
2474	Óbidos	14
2475	Oeiras do Pará	14
2476	Oriximiná	14
2477	Ourém	14
2478	Ourilândia do Norte	14
2479	Pacajá	14
2480	Palestina do Pará	14
2481	Paragominas	14
2482	Parauapebas	14
2483	Pau d`Arco	14
2484	Peixe-Boi	14
2485	Piçarra	14
2486	Placas	14
2487	Ponta de Pedras	14
2488	Portel	14
2489	Porto de Moz	14
2490	Prainha	14
2491	Primavera	14
2492	Quatipuru	14
2493	Redenção	14
2494	Rio Maria	14
2495	Rondon do Pará	14
2496	Rurópolis	14
2497	Salinópolis	14
2498	Salvaterra	14
2499	Santa Bárbara do Pará	14
2500	Santa Cruz do Arari	14
2501	Santa Isabel do Pará	14
2502	Santa Luzia do Pará	14
2503	Santa Maria das Barreiras	14
2504	Santa Maria do Pará	14
2505	Santana do Araguaia	14
2506	Santarém	14
2507	Santarém Novo	14
2508	Santo Antônio do Tauá	14
2509	São Caetano de Odivelas	14
2510	São Domingos do Araguaia	14
2511	São Domingos do Capim	14
2512	São Félix do Xingu	14
2513	São Francisco do Pará	14
2514	São Geraldo do Araguaia	14
2515	São João da Ponta	14
2516	São João de Pirabas	14
2517	São João do Araguaia	14
2518	São Miguel do Guamá	14
2519	São Sebastião da Boa Vista	14
2520	Sapucaia	14
2521	Senador José Porfírio	14
2522	Soure	14
2523	Tailândia	14
2524	Terra Alta	14
2525	Terra Santa	14
2526	Tomé-Açu	14
2527	Tracuateua	14
2528	Trairão	14
2529	Tucumã	14
2530	Tucuruí	14
2531	Ulianópolis	14
2532	Uruará	14
2533	Vigia	14
2534	Viseu	14
2535	Vitória do Xingu	14
2536	Xinguara	14
2537	Água Branca	15
2538	Aguiar	15
2539	Alagoa Grande	15
2540	Alagoa Nova	15
2541	Alagoinha	15
2542	Alcantil	15
2543	Algodão de Jandaíra	15
2544	Alhandra	15
2545	Amparo	15
2546	Aparecida	15
2547	Araçagi	15
2548	Arara	15
2549	Araruna	15
2550	Areia	15
2551	Areia de Baraúnas	15
2552	Areial	15
2553	Aroeiras	15
2554	Assunção	15
2555	Baía da Traição	15
2556	Bananeiras	15
2557	Baraúna	15
2558	Barra de Santa Rosa	15
2559	Barra de Santana	15
2560	Barra de São Miguel	15
2561	Bayeux	15
2562	Belém	15
2563	Belém do Brejo do Cruz	15
2564	Bernardino Batista	15
2565	Boa Ventura	15
2566	Boa Vista	15
2567	Bom Jesus	15
2568	Bom Sucesso	15
2569	Bonito de Santa Fé	15
2570	Boqueirão	15
2571	Borborema	15
2572	Brejo do Cruz	15
2573	Brejo dos Santos	15
2574	Caaporã	15
2575	Cabaceiras	15
2576	Cabedelo	15
2577	Cachoeira dos Índios	15
2578	Cacimba de Areia	15
2579	Cacimba de Dentro	15
2580	Cacimbas	15
2581	Caiçara	15
2582	Cajazeiras	15
2583	Cajazeirinhas	15
2584	Caldas Brandão	15
2585	Camalaú	15
2586	Campina Grande	15
2587	Campo de Santana	15
2588	Capim	15
2589	Caraúbas	15
2590	Carrapateira	15
2591	Casserengue	15
2592	Catingueira	15
2593	Catolé do Rocha	15
2594	Caturité	15
2595	Conceição	15
2596	Condado	15
2597	Conde	15
2598	Congo	15
2599	Coremas	15
2600	Coxixola	15
2601	Cruz do Espírito Santo	15
2602	Cubati	15
2603	Cuité	15
2604	Cuité de Mamanguape	15
2605	Cuitegi	15
2606	Curral de Cima	15
2607	Curral Velho	15
2608	Damião	15
2609	Desterro	15
2610	Diamante	15
2611	Dona Inês	15
2612	Duas Estradas	15
2613	Emas	15
2614	Esperança	15
2615	Fagundes	15
2616	Frei Martinho	15
2617	Gado Bravo	15
2618	Guarabira	15
2619	Gurinhém	15
2620	Gurjão	15
2621	Ibiara	15
2622	Igaracy	15
2623	Imaculada	15
2624	Ingá	15
2625	Itabaiana	15
2626	Itaporanga	15
2627	Itapororoca	15
2628	Itatuba	15
2629	Jacaraú	15
2630	Jericó	15
2631	João Pessoa	15
2632	Juarez Távora	15
2633	Juazeirinho	15
2634	Junco do Seridó	15
2635	Juripiranga	15
2636	Juru	15
2637	Lagoa	15
2638	Lagoa de Dentro	15
2639	Lagoa Seca	15
2640	Lastro	15
2641	Livramento	15
2642	Logradouro	15
2643	Lucena	15
2644	Mãe d`Água	15
2645	Malta	15
2646	Mamanguape	15
2647	Manaíra	15
2648	Marcação	15
2649	Mari	15
2650	Marizópolis	15
2651	Massaranduba	15
2652	Mataraca	15
2653	Matinhas	15
2654	Mato Grosso	15
2655	Maturéia	15
2656	Mogeiro	15
2657	Montadas	15
2658	Monte Horebe	15
2659	Monteiro	15
2660	Mulungu	15
2661	Natuba	15
2662	Nazarezinho	15
2663	Nova Floresta	15
2664	Nova Olinda	15
2665	Nova Palmeira	15
2666	Olho d`Água	15
2667	Olivedos	15
2668	Ouro Velho	15
2669	Parari	15
2670	Passagem	15
2671	Patos	15
2672	Paulista	15
2673	Pedra Branca	15
2674	Pedra Lavrada	15
2675	Pedras de Fogo	15
2676	Pedro Régis	15
2677	Piancó	15
2678	Picuí	15
2679	Pilar	15
2680	Pilões	15
2681	Pilõezinhos	15
2682	Pirpirituba	15
2683	Pitimbu	15
2684	Pocinhos	15
2685	Poço Dantas	15
2686	Poço de José de Moura	15
2687	Pombal	15
2688	Prata	15
2689	Princesa Isabel	15
2690	Puxinanã	15
2691	Queimadas	15
2692	Quixabá	15
2693	Remígio	15
2694	Riachão	15
2695	Riachão do Bacamarte	15
2696	Riachão do Poço	15
2697	Riacho de Santo Antônio	15
2698	Riacho dos Cavalos	15
2699	Rio Tinto	15
2700	Salgadinho	15
2701	Salgado de São Félix	15
2702	Santa Cecília	15
2703	Santa Cruz	15
2704	Santa Helena	15
2705	Santa Inês	15
2706	Santa Luzia	15
2707	Santa Rita	15
2708	Santa Teresinha	15
2709	Santana de Mangueira	15
2710	Santana dos Garrotes	15
2711	Santarém	15
2712	Santo André	15
2713	São Bentinho	15
2714	São Bento	15
2715	São Domingos de Pombal	15
2716	São Domingos do Cariri	15
2717	São Francisco	15
2718	São João do Cariri	15
2719	São João do Rio do Peixe	15
2720	São João do Tigre	15
2721	São José da Lagoa Tapada	15
2722	São José de Caiana	15
2723	São José de Espinharas	15
2724	São José de Piranhas	15
2725	São José de Princesa	15
2726	São José do Bonfim	15
2727	São José do Brejo do Cruz	15
2728	São José do Sabugi	15
2729	São José dos Cordeiros	15
2730	São José dos Ramos	15
2731	São Mamede	15
2732	São Miguel de Taipu	15
2733	São Sebastião de Lagoa de Roça	15
2734	São Sebastião do Umbuzeiro	15
2735	Sapé	15
2736	Seridó	15
2737	Serra Branca	15
2738	Serra da Raiz	15
2739	Serra Grande	15
2740	Serra Redonda	15
2741	Serraria	15
2742	Sertãozinho	15
2743	Sobrado	15
2744	Solânea	15
2745	Soledade	15
2746	Sossêgo	15
2747	Sousa	15
2748	Sumé	15
2749	Taperoá	15
2750	Tavares	15
2751	Teixeira	15
2752	Tenório	15
2753	Triunfo	15
2754	Uiraúna	15
2755	Umbuzeiro	15
2756	Várzea	15
2757	Vieirópolis	15
2758	Vista Serrana	15
2759	Zabelê	15
2760	Abatiá	16
2761	Adrianópolis	16
2762	Agudos do Sul	16
2763	Almirante Tamandaré	16
2764	Altamira do Paraná	16
2765	Alto Paraná	16
2766	Alto Piquiri	16
2767	Altônia	16
2768	Alvorada do Sul	16
2769	Amaporã	16
2770	Ampére	16
2771	Anahy	16
2772	Andirá	16
2773	Ângulo	16
2774	Antonina	16
2775	Antônio Olinto	16
2776	Apucarana	16
2777	Arapongas	16
2778	Arapoti	16
2779	Arapuã	16
2780	Araruna	16
2781	Araucária	16
2782	Ariranha do Ivaí	16
2783	Assaí	16
2784	Assis Chateaubriand	16
2785	Astorga	16
2786	Atalaia	16
2787	Balsa Nova	16
2788	Bandeirantes	16
2789	Barbosa Ferraz	16
2790	Barra do Jacaré	16
2791	Barracão	16
2792	Bela Vista da Caroba	16
2793	Bela Vista do Paraíso	16
2794	Bituruna	16
2795	Boa Esperança	16
2796	Boa Esperança do Iguaçu	16
2797	Boa Ventura de São Roque	16
2798	Boa Vista da Aparecida	16
2799	Bocaiúva do Sul	16
2800	Bom Jesus do Sul	16
2801	Bom Sucesso	16
2802	Bom Sucesso do Sul	16
2803	Borrazópolis	16
2804	Braganey	16
2805	Brasilândia do Sul	16
2806	Cafeara	16
2807	Cafelândia	16
2808	Cafezal do Sul	16
2809	Califórnia	16
2810	Cambará	16
2811	Cambé	16
2812	Cambira	16
2813	Campina da Lagoa	16
2814	Campina do Simão	16
2815	Campina Grande do Sul	16
2816	Campo Bonito	16
2817	Campo do Tenente	16
2818	Campo Largo	16
2819	Campo Magro	16
2820	Campo Mourão	16
2821	Cândido de Abreu	16
2822	Candói	16
2823	Cantagalo	16
2824	Capanema	16
2825	Capitão Leônidas Marques	16
2826	Carambeí	16
2827	Carlópolis	16
2828	Cascavel	16
2829	Castro	16
2830	Catanduvas	16
2831	Centenário do Sul	16
2832	Cerro Azul	16
2833	Céu Azul	16
2834	Chopinzinho	16
2835	Cianorte	16
2836	Cidade Gaúcha	16
2837	Clevelândia	16
2838	Colombo	16
2839	Colorado	16
2840	Congonhinhas	16
2841	Conselheiro Mairinck	16
2842	Contenda	16
2843	Corbélia	16
2844	Cornélio Procópio	16
2845	Coronel Domingos Soares	16
2846	Coronel Vivida	16
2847	Corumbataí do Sul	16
2848	Cruz Machado	16
2849	Cruzeiro do Iguaçu	16
2850	Cruzeiro do Oeste	16
2851	Cruzeiro do Sul	16
2852	Cruzmaltina	16
2853	Curitiba	16
2854	Curiúva	16
2855	Diamante d`Oeste	16
2856	Diamante do Norte	16
2857	Diamante do Sul	16
2858	Dois Vizinhos	16
2859	Douradina	16
2860	Doutor Camargo	16
2861	Doutor Ulysses	16
2862	Enéas Marques	16
2863	Engenheiro Beltrão	16
2864	Entre Rios do Oeste	16
2865	Esperança Nova	16
2866	Espigão Alto do Iguaçu	16
2867	Farol	16
2868	Faxinal	16
2869	Fazenda Rio Grande	16
2870	Fênix	16
2871	Fernandes Pinheiro	16
2872	Figueira	16
2873	Flor da Serra do Sul	16
2874	Floraí	16
2875	Floresta	16
2876	Florestópolis	16
2877	Flórida	16
2878	Formosa do Oeste	16
2879	Foz do Iguaçu	16
2880	Foz do Jordão	16
2881	Francisco Alves	16
2882	Francisco Beltrão	16
2883	General Carneiro	16
2884	Godoy Moreira	16
2885	Goioerê	16
2886	Goioxim	16
2887	Grandes Rios	16
2888	Guaíra	16
2889	Guairaçá	16
2890	Guamiranga	16
2891	Guapirama	16
2892	Guaporema	16
2893	Guaraci	16
2894	Guaraniaçu	16
2895	Guarapuava	16
2896	Guaraqueçaba	16
2897	Guaratuba	16
2898	Honório Serpa	16
2899	Ibaiti	16
2900	Ibema	16
2901	Ibiporã	16
2902	Icaraíma	16
2903	Iguaraçu	16
2904	Iguatu	16
2905	Imbaú	16
2906	Imbituva	16
2907	Inácio Martins	16
2908	Inajá	16
2909	Indianópolis	16
2910	Ipiranga	16
2911	Iporã	16
2912	Iracema do Oeste	16
2913	Irati	16
2914	Iretama	16
2915	Itaguajé	16
2916	Itaipulândia	16
2917	Itambaracá	16
2918	Itambé	16
2919	Itapejara d`Oeste	16
2920	Itaperuçu	16
2921	Itaúna do Sul	16
2922	Ivaí	16
2923	Ivaiporã	16
2924	Ivaté	16
2925	Ivatuba	16
2926	Jaboti	16
2927	Jacarezinho	16
2928	Jaguapitã	16
2929	Jaguariaíva	16
2930	Jandaia do Sul	16
2931	Janiópolis	16
2932	Japira	16
2933	Japurá	16
2934	Jardim Alegre	16
2935	Jardim Olinda	16
2936	Jataizinho	16
2937	Jesuítas	16
2938	Joaquim Távora	16
2939	Jundiaí do Sul	16
2940	Juranda	16
2941	Jussara	16
2942	Kaloré	16
2943	Lapa	16
2944	Laranjal	16
2945	Laranjeiras do Sul	16
2946	Leópolis	16
2947	Lidianópolis	16
2948	Lindoeste	16
2949	Loanda	16
2950	Lobato	16
2951	Londrina	16
2952	Luiziana	16
2953	Lunardelli	16
2954	Lupionópolis	16
2955	Mallet	16
2956	Mamborê	16
2957	Mandaguaçu	16
2958	Mandaguari	16
2959	Mandirituba	16
2960	Manfrinópolis	16
2961	Mangueirinha	16
2962	Manoel Ribas	16
2963	Marechal Cândido Rondon	16
2964	Maria Helena	16
2965	Marialva	16
2966	Marilândia do Sul	16
2967	Marilena	16
2968	Mariluz	16
2969	Maringá	16
2970	Mariópolis	16
2971	Maripá	16
2972	Marmeleiro	16
2973	Marquinho	16
2974	Marumbi	16
2975	Matelândia	16
2976	Matinhos	16
2977	Mato Rico	16
2978	Mauá da Serra	16
2979	Medianeira	16
2980	Mercedes	16
2981	Mirador	16
2982	Miraselva	16
2983	Missal	16
2984	Moreira Sales	16
2985	Morretes	16
2986	Munhoz de Melo	16
2987	Nossa Senhora das Graças	16
2988	Nova Aliança do Ivaí	16
2989	Nova América da Colina	16
2990	Nova Aurora	16
2991	Nova Cantu	16
2992	Nova Esperança	16
2993	Nova Esperança do Sudoeste	16
2994	Nova Fátima	16
2995	Nova Laranjeiras	16
2996	Nova Londrina	16
2997	Nova Olímpia	16
2998	Nova Prata do Iguaçu	16
2999	Nova Santa Bárbara	16
3000	Nova Santa Rosa	16
3001	Nova Tebas	16
3002	Novo Itacolomi	16
3003	Ortigueira	16
3004	Ourizona	16
3005	Ouro Verde do Oeste	16
3006	Paiçandu	16
3007	Palmas	16
3008	Palmeira	16
3009	Palmital	16
3010	Palotina	16
3011	Paraíso do Norte	16
3012	Paranacity	16
3013	Paranaguá	16
3014	Paranapoema	16
3015	Paranavaí	16
3016	Pato Bragado	16
3017	Pato Branco	16
3018	Paula Freitas	16
3019	Paulo Frontin	16
3020	Peabiru	16
3021	Perobal	16
3022	Pérola	16
3023	Pérola d`Oeste	16
3024	Piên	16
3025	Pinhais	16
3026	Pinhal de São Bento	16
3027	Pinhalão	16
3028	Pinhão	16
3029	Piraí do Sul	16
3030	Piraquara	16
3031	Pitanga	16
3032	Pitangueiras	16
3033	Planaltina do Paraná	16
3034	Planalto	16
3035	Ponta Grossa	16
3036	Pontal do Paraná	16
3037	Porecatu	16
3038	Porto Amazonas	16
3039	Porto Barreiro	16
3040	Porto Rico	16
3041	Porto Vitória	16
3042	Prado Ferreira	16
3043	Pranchita	16
3044	Presidente Castelo Branco	16
3045	Primeiro de Maio	16
3046	Prudentópolis	16
3047	Quarto Centenário	16
3048	Quatiguá	16
3049	Quatro Barras	16
3050	Quatro Pontes	16
3051	Quedas do Iguaçu	16
3052	Querência do Norte	16
3053	Quinta do Sol	16
3054	Quitandinha	16
3055	Ramilândia	16
3056	Rancho Alegre	16
3057	Rancho Alegre d`Oeste	16
3058	Realeza	16
3059	Rebouças	16
3060	Renascença	16
3061	Reserva	16
3062	Reserva do Iguaçu	16
3063	Ribeirão Claro	16
3064	Ribeirão do Pinhal	16
3065	Rio Azul	16
3066	Rio Bom	16
3067	Rio Bonito do Iguaçu	16
3068	Rio Branco do Ivaí	16
3069	Rio Branco do Sul	16
3070	Rio Negro	16
3071	Rolândia	16
3072	Roncador	16
3073	Rondon	16
3074	Rosário do Ivaí	16
3075	Sabáudia	16
3076	Salgado Filho	16
3077	Salto do Itararé	16
3078	Salto do Lontra	16
3079	Santa Amélia	16
3080	Santa Cecília do Pavão	16
3081	Santa Cruz de Monte Castelo	16
3082	Santa Fé	16
3083	Santa Helena	16
3084	Santa Inês	16
3085	Santa Isabel do Ivaí	16
3086	Santa Izabel do Oeste	16
3087	Santa Lúcia	16
3088	Santa Maria do Oeste	16
3089	Santa Mariana	16
3090	Santa Mônica	16
3091	Santa Tereza do Oeste	16
3092	Santa Terezinha de Itaipu	16
3093	Santana do Itararé	16
3094	Santo Antônio da Platina	16
3095	Santo Antônio do Caiuá	16
3096	Santo Antônio do Paraíso	16
3097	Santo Antônio do Sudoeste	16
3098	Santo Inácio	16
3099	São Carlos do Ivaí	16
3100	São Jerônimo da Serra	16
3101	São João	16
3102	São João do Caiuá	16
3103	São João do Ivaí	16
3104	São João do Triunfo	16
3105	São Jorge d`Oeste	16
3106	São Jorge do Ivaí	16
3107	São Jorge do Patrocínio	16
3108	São José da Boa Vista	16
3109	São José das Palmeiras	16
3110	São José dos Pinhais	16
3111	São Manoel do Paraná	16
3112	São Mateus do Sul	16
3113	São Miguel do Iguaçu	16
3114	São Pedro do Iguaçu	16
3115	São Pedro do Ivaí	16
3116	São Pedro do Paraná	16
3117	São Sebastião da Amoreira	16
3118	São Tomé	16
3119	Sapopema	16
3120	Sarandi	16
3121	Saudade do Iguaçu	16
3122	Sengés	16
3123	Serranópolis do Iguaçu	16
3124	Sertaneja	16
3125	Sertanópolis	16
3126	Siqueira Campos	16
3127	Sulina	16
3128	Tamarana	16
3129	Tamboara	16
3130	Tapejara	16
3131	Tapira	16
3132	Teixeira Soares	16
3133	Telêmaco Borba	16
3134	Terra Boa	16
3135	Terra Rica	16
3136	Terra Roxa	16
3137	Tibagi	16
3138	Tijucas do Sul	16
3139	Toledo	16
3140	Tomazina	16
3141	Três Barras do Paraná	16
3142	Tunas do Paraná	16
3143	Tuneiras do Oeste	16
3144	Tupãssi	16
3145	Turvo	16
3146	Ubiratã	16
3147	Umuarama	16
3148	União da Vitória	16
3149	Uniflor	16
3150	Uraí	16
3151	Ventania	16
3152	Vera Cruz do Oeste	16
3153	Verê	16
3154	Vila Alta	16
3155	Virmond	16
3156	Vitorino	16
3157	Wenceslau Braz	16
3158	Xambrê	16
3159	Abreu e Lima	17
3160	Afogados da Ingazeira	17
3161	Afrânio	17
3162	Agrestina	17
3163	Água Preta	17
3164	Águas Belas	17
3165	Alagoinha	17
3166	Aliança	17
3167	Altinho	17
3168	Amaraji	17
3169	Angelim	17
3170	Araçoiaba	17
3171	Araripina	17
3172	Arcoverde	17
3173	Barra de Guabiraba	17
3174	Barreiros	17
3175	Belém de Maria	17
3176	Belém de São Francisco	17
3177	Belo Jardim	17
3178	Betânia	17
3179	Bezerros	17
3180	Bodocó	17
3181	Bom Conselho	17
3182	Bom Jardim	17
3183	Bonito	17
3184	Brejão	17
3185	Brejinho	17
3186	Brejo da Madre de Deus	17
3187	Buenos Aires	17
3188	Buíque	17
3189	Cabo de Santo Agostinho	17
3190	Cabrobó	17
3191	Cachoeirinha	17
3192	Caetés	17
3193	Calçado	17
3194	Calumbi	17
3195	Camaragibe	17
3196	Camocim de São Félix	17
3197	Camutanga	17
3198	Canhotinho	17
3199	Capoeiras	17
3200	Carnaíba	17
3201	Carnaubeira da Penha	17
3202	Carpina	17
3203	Caruaru	17
3204	Casinhas	17
3205	Catende	17
3206	Cedro	17
3207	Chã de Alegria	17
3208	Chã Grande	17
3209	Condado	17
3210	Correntes	17
3211	Cortês	17
3212	Cumaru	17
3213	Cupira	17
3214	Custódia	17
3215	Dormentes	17
3216	Escada	17
3217	Exu	17
3218	Feira Nova	17
3219	Fernando de Noronha	17
3220	Ferreiros	17
3221	Flores	17
3222	Floresta	17
3223	Frei Miguelinho	17
3224	Gameleira	17
3225	Garanhuns	17
3226	Glória do Goitá	17
3227	Goiana	17
3228	Granito	17
3229	Gravatá	17
3230	Iati	17
3231	Ibimirim	17
3232	Ibirajuba	17
3233	Igarassu	17
3234	Iguaraci	17
3235	Inajá	17
3236	Ingazeira	17
3237	Ipojuca	17
3238	Ipubi	17
3239	Itacuruba	17
3240	Itaíba	17
3241	Itamaracá	17
3242	Itambé	17
3243	Itapetim	17
3244	Itapissuma	17
3245	Itaquitinga	17
3246	Jaboatão dos Guararapes	17
3247	Jaqueira	17
3248	Jataúba	17
3249	Jatobá	17
3250	João Alfredo	17
3251	Joaquim Nabuco	17
3252	Jucati	17
3253	Jupi	17
3254	Jurema	17
3255	Lagoa do Carro	17
3256	Lagoa do Itaenga	17
3257	Lagoa do Ouro	17
3258	Lagoa dos Gatos	17
3259	Lagoa Grande	17
3260	Lajedo	17
3261	Limoeiro	17
3262	Macaparana	17
3263	Machados	17
3264	Manari	17
3265	Maraial	17
3266	Mirandiba	17
3267	Moreilândia	17
3268	Moreno	17
3269	Nazaré da Mata	17
3270	Olinda	17
3271	Orobó	17
3272	Orocó	17
3273	Ouricuri	17
3274	Palmares	17
3275	Palmeirina	17
3276	Panelas	17
3277	Paranatama	17
3278	Parnamirim	17
3279	Passira	17
3280	Paudalho	17
3281	Paulista	17
3282	Pedra	17
3283	Pesqueira	17
3284	Petrolândia	17
3285	Petrolina	17
3286	Poção	17
3287	Pombos	17
3288	Primavera	17
3289	Quipapá	17
3290	Quixaba	17
3291	Recife	17
3292	Riacho das Almas	17
3293	Ribeirão	17
3294	Rio Formoso	17
3295	Sairé	17
3296	Salgadinho	17
3297	Salgueiro	17
3298	Saloá	17
3299	Sanharó	17
3300	Santa Cruz	17
3301	Santa Cruz da Baixa Verde	17
3302	Santa Cruz do Capibaribe	17
3303	Santa Filomena	17
3304	Santa Maria da Boa Vista	17
3305	Santa Maria do Cambucá	17
3306	Santa Terezinha	17
3307	São Benedito do Sul	17
3308	São Bento do Una	17
3309	São Caitano	17
3310	São João	17
3311	São Joaquim do Monte	17
3312	São José da Coroa Grande	17
3313	São José do Belmonte	17
3314	São José do Egito	17
3315	São Lourenço da Mata	17
3316	São Vicente Ferrer	17
3317	Serra Talhada	17
3318	Serrita	17
3319	Sertânia	17
3320	Sirinhaém	17
3321	Solidão	17
3322	Surubim	17
3323	Tabira	17
3324	Tacaimbó	17
3325	Tacaratu	17
3326	Tamandaré	17
3327	Taquaritinga do Norte	17
3328	Terezinha	17
3329	Terra Nova	17
3330	Timbaúba	17
3331	Toritama	17
3332	Tracunhaém	17
3333	Trindade	17
3334	Triunfo	17
3335	Tupanatinga	17
3336	Tuparetama	17
3337	Venturosa	17
3338	Verdejante	17
3339	Vertente do Lério	17
3340	Vertentes	17
3341	Vicência	17
3342	Vitória de Santo Antão	17
3343	Xexéu	17
3344	Acauã	18
3345	Agricolândia	18
3346	Água Branca	18
3347	Alagoinha do Piauí	18
3348	Alegrete do Piauí	18
3349	Alto Longá	18
3350	Altos	18
3351	Alvorada do Gurguéia	18
3352	Amarante	18
3353	Angical do Piauí	18
3354	Anísio de Abreu	18
3355	Antônio Almeida	18
3356	Aroazes	18
3357	Arraial	18
3358	Assunção do Piauí	18
3359	Avelino Lopes	18
3360	Baixa Grande do Ribeiro	18
3361	Barra d`Alcântara	18
3362	Barras	18
3363	Barreiras do Piauí	18
3364	Barro Duro	18
3365	Batalha	18
3366	Bela Vista do Piauí	18
3367	Belém do Piauí	18
3368	Beneditinos	18
3369	Bertolínia	18
3370	Betânia do Piauí	18
3371	Boa Hora	18
3372	Bocaina	18
3373	Bom Jesus	18
3374	Bom Princípio do Piauí	18
3375	Bonfim do Piauí	18
3376	Boqueirão do Piauí	18
3377	Brasileira	18
3378	Brejo do Piauí	18
3379	Buriti dos Lopes	18
3380	Buriti dos Montes	18
3381	Cabeceiras do Piauí	18
3382	Cajazeiras do Piauí	18
3383	Cajueiro da Praia	18
3384	Caldeirão Grande do Piauí	18
3385	Campinas do Piauí	18
3386	Campo Alegre do Fidalgo	18
3387	Campo Grande do Piauí	18
3388	Campo Largo do Piauí	18
3389	Campo Maior	18
3390	Canavieira	18
3391	Canto do Buriti	18
3392	Capitão de Campos	18
3393	Capitão Gervásio Oliveira	18
3394	Caracol	18
3395	Caraúbas do Piauí	18
3396	Caridade do Piauí	18
3397	Castelo do Piauí	18
3398	Caxingó	18
3399	Cocal	18
3400	Cocal de Telha	18
3401	Cocal dos Alves	18
3402	Coivaras	18
3403	Colônia do Gurguéia	18
3404	Colônia do Piauí	18
3405	Conceição do Canindé	18
3406	Coronel José Dias	18
3407	Corrente	18
3408	Cristalândia do Piauí	18
3409	Cristino Castro	18
3410	Curimatá	18
3411	Currais	18
3412	Curral Novo do Piauí	18
3413	Curralinhos	18
3414	Demerval Lobão	18
3415	Dirceu Arcoverde	18
3416	Dom Expedito Lopes	18
3417	Dom Inocêncio	18
3418	Domingos Mourão	18
3419	Elesbão Veloso	18
3420	Eliseu Martins	18
3421	Esperantina	18
3422	Fartura do Piauí	18
3423	Flores do Piauí	18
3424	Floresta do Piauí	18
3425	Floriano	18
3426	Francinópolis	18
3427	Francisco Ayres	18
3428	Francisco Macedo	18
3429	Francisco Santos	18
3430	Fronteiras	18
3431	Geminiano	18
3432	Gilbués	18
3433	Guadalupe	18
3434	Guaribas	18
3435	Hugo Napoleão	18
3436	Ilha Grande	18
3437	Inhuma	18
3438	Ipiranga do Piauí	18
3439	Isaías Coelho	18
3440	Itainópolis	18
3441	Itaueira	18
3442	Jacobina do Piauí	18
3443	Jaicós	18
3444	Jardim do Mulato	18
3445	Jatobá do Piauí	18
3446	Jerumenha	18
3447	João Costa	18
3448	Joaquim Pires	18
3449	Joca Marques	18
3450	José de Freitas	18
3451	Juazeiro do Piauí	18
3452	Júlio Borges	18
3453	Jurema	18
3454	Lagoa Alegre	18
3455	Lagoa de São Francisco	18
3456	Lagoa do Barro do Piauí	18
3457	Lagoa do Piauí	18
3458	Lagoa do Sítio	18
3459	Lagoinha do Piauí	18
3460	Landri Sales	18
3461	Luís Correia	18
3462	Luzilândia	18
3463	Madeiro	18
3464	Manoel Emídio	18
3465	Marcolândia	18
3466	Marcos Parente	18
3467	Massapê do Piauí	18
3468	Matias Olímpio	18
3469	Miguel Alves	18
3470	Miguel Leão	18
3471	Milton Brandão	18
3472	Monsenhor Gil	18
3473	Monsenhor Hipólito	18
3474	Monte Alegre do Piauí	18
3475	Morro Cabeça no Tempo	18
3476	Morro do Chapéu do Piauí	18
3477	Murici dos Portelas	18
3478	Nazaré do Piauí	18
3479	Nossa Senhora de Nazaré	18
3480	Nossa Senhora dos Remédios	18
3481	Nova Santa Rita	18
3482	Novo Oriente do Piauí	18
3483	Novo Santo Antônio	18
3484	Oeiras	18
3485	Olho d`Água do Piauí	18
3486	Padre Marcos	18
3487	Paes Landim	18
3488	Pajeú do Piauí	18
3489	Palmeira do Piauí	18
3490	Palmeirais	18
3491	Paquetá	18
3492	Parnaguá	18
3493	Parnaíba	18
3494	Passagem Franca do Piauí	18
3495	Patos do Piauí	18
3496	Paulistana	18
3497	Pavussu	18
3498	Pedro II	18
3499	Pedro Laurentino	18
3500	Picos	18
3501	Pimenteiras	18
3502	Pio IX	18
3503	Piracuruca	18
3504	Piripiri	18
3505	Porto	18
3506	Porto Alegre do Piauí	18
3507	Prata do Piauí	18
3508	Queimada Nova	18
3509	Redenção do Gurguéia	18
3510	Regeneração	18
3511	Riacho Frio	18
3512	Ribeira do Piauí	18
3513	Ribeiro Gonçalves	18
3514	Rio Grande do Piauí	18
3515	Santa Cruz do Piauí	18
3516	Santa Cruz dos Milagres	18
3517	Santa Filomena	18
3518	Santa Luz	18
3519	Santa Rosa do Piauí	18
3520	Santana do Piauí	18
3521	Santo Antônio de Lisboa	18
3522	Santo Antônio dos Milagres	18
3523	Santo Inácio do Piauí	18
3524	São Braz do Piauí	18
3525	São Félix do Piauí	18
3526	São Francisco de Assis do Piauí	18
3527	São Francisco do Piauí	18
3528	São Gonçalo do Gurguéia	18
3529	São Gonçalo do Piauí	18
3530	São João da Canabrava	18
3531	São João da Fronteira	18
3532	São João da Serra	18
3533	São João da Varjota	18
3534	São João do Arraial	18
3535	São João do Piauí	18
3536	São José do Divino	18
3537	São José do Peixe	18
3538	São José do Piauí	18
3539	São Julião	18
3540	São Lourenço do Piauí	18
3541	São Luis do Piauí	18
3542	São Miguel da Baixa Grande	18
3543	São Miguel do Fidalgo	18
3544	São Miguel do Tapuio	18
3545	São Pedro do Piauí	18
3546	São Raimundo Nonato	18
3547	Sebastião Barros	18
3548	Sebastião Leal	18
3549	Sigefredo Pacheco	18
3550	Simões	18
3551	Simplício Mendes	18
3552	Socorro do Piauí	18
3553	Sussuapara	18
3554	Tamboril do Piauí	18
3555	Tanque do Piauí	18
3556	Teresina	18
3557	União	18
3558	Uruçuí	18
3559	Valença do Piauí	18
3560	Várzea Branca	18
3561	Várzea Grande	18
3562	Vera Mendes	18
3563	Vila Nova do Piauí	18
3564	Wall Ferraz	18
3565	Angra dos Reis	19
3566	Aperibé	19
3567	Araruama	19
3568	Areal	19
3569	Armação dos Búzios	19
3570	Arraial do Cabo	19
3571	Barra do Piraí	19
3572	Barra Mansa	19
3573	Belford Roxo	19
3574	Bom Jardim	19
3575	Bom Jesus do Itabapoana	19
3576	Cabo Frio	19
3577	Cachoeiras de Macacu	19
3578	Cambuci	19
3579	Campos dos Goytacazes	19
3580	Cantagalo	19
3581	Carapebus	19
3582	Cardoso Moreira	19
3583	Carmo	19
3584	Casimiro de Abreu	19
3585	Comendador Levy Gasparian	19
3586	Conceição de Macabu	19
3587	Cordeiro	19
3588	Duas Barras	19
3589	Duque de Caxias	19
3590	Engenheiro Paulo de Frontin	19
3591	Guapimirim	19
3592	Iguaba Grande	19
3593	Itaboraí	19
3594	Itaguaí	19
3595	Italva	19
3596	Itaocara	19
3597	Itaperuna	19
3598	Itatiaia	19
3599	Japeri	19
3600	Laje do Muriaé	19
3601	Macaé	19
3602	Macuco	19
3603	Magé	19
3604	Mangaratiba	19
3605	Maricá	19
3606	Mendes	19
3607	Miguel Pereira	19
3608	Miracema	19
3609	Natividade	19
3610	Nilópolis	19
3611	Niterói	19
3612	Nova Friburgo	19
3613	Nova Iguaçu	19
3614	Paracambi	19
3615	Paraíba do Sul	19
3616	Parati	19
3617	Paty do Alferes	19
3618	Petrópolis	19
3619	Pinheiral	19
3620	Piraí	19
3621	Porciúncula	19
3622	Porto Real	19
3623	Quatis	19
3624	Queimados	19
3625	Quissamã	19
3626	Resende	19
3627	Rio Bonito	19
3628	Rio Claro	19
3629	Rio das Flores	19
3630	Rio das Ostras	19
3631	Rio de Janeiro	19
3632	Santa Maria Madalena	19
3633	Santo Antônio de Pádua	19
3634	São Fidélis	19
3635	São Francisco de Itabapoana	19
3636	São Gonçalo	19
3637	São João da Barra	19
3638	São João de Meriti	19
3639	São José de Ubá	19
3640	São José do Vale do Rio Preto	19
3641	São Pedro da Aldeia	19
3642	São Sebastião do Alto	19
3643	Sapucaia	19
3644	Saquarema	19
3645	Seropédica	19
3646	Silva Jardim	19
3647	Sumidouro	19
3648	Tanguá	19
3649	Teresópolis	19
3650	Trajano de Morais	19
3651	Três Rios	19
3652	Valença	19
3653	Varre-Sai	19
3654	Vassouras	19
3655	Volta Redonda	19
3656	Acari	20
3657	Açu	20
3658	Afonso Bezerra	20
3659	Água Nova	20
3660	Alexandria	20
3661	Almino Afonso	20
3662	Alto do Rodrigues	20
3663	Angicos	20
3664	Antônio Martins	20
3665	Apodi	20
3666	Areia Branca	20
3667	Arês	20
3668	Augusto Severo	20
3669	Baía Formosa	20
3670	Baraúna	20
3671	Barcelona	20
3672	Bento Fernandes	20
3673	Bodó	20
3674	Bom Jesus	20
3675	Brejinho	20
3676	Caiçara do Norte	20
3677	Caiçara do Rio do Vento	20
3678	Caicó	20
3679	Campo Redondo	20
3680	Canguaretama	20
3681	Caraúbas	20
3682	Carnaúba dos Dantas	20
3683	Carnaubais	20
3684	Ceará-Mirim	20
3685	Cerro Corá	20
3686	Coronel Ezequiel	20
3687	Coronel João Pessoa	20
3688	Cruzeta	20
3689	Currais Novos	20
3690	Doutor Severiano	20
3691	Encanto	20
3692	Equador	20
3693	Espírito Santo	20
3694	Extremoz	20
3695	Felipe Guerra	20
3696	Fernando Pedroza	20
3697	Florânia	20
3698	Francisco Dantas	20
3699	Frutuoso Gomes	20
3700	Galinhos	20
3701	Goianinha	20
3702	Governador Dix-Sept Rosado	20
3703	Grossos	20
3704	Guamaré	20
3705	Ielmo Marinho	20
3706	Ipanguaçu	20
3707	Ipueira	20
3708	Itajá	20
3709	Itaú	20
3710	Jaçanã	20
3711	Jandaíra	20
3712	Janduís	20
3713	Januário Cicco	20
3714	Japi	20
3715	Jardim de Angicos	20
3716	Jardim de Piranhas	20
3717	Jardim do Seridó	20
3718	João Câmara	20
3719	João Dias	20
3720	José da Penha	20
3721	Jucurutu	20
3722	Lagoa d`Anta	20
3723	Lagoa de Pedras	20
3724	Lagoa de Velhos	20
3725	Lagoa Nova	20
3726	Lagoa Salgada	20
3727	Lajes	20
3728	Lajes Pintadas	20
3729	Lucrécia	20
3730	Luís Gomes	20
3731	Macaíba	20
3732	Macau	20
3733	Major Sales	20
3734	Marcelino Vieira	20
3735	Martins	20
3736	Maxaranguape	20
3737	Messias Targino	20
3738	Montanhas	20
3739	Monte Alegre	20
3740	Monte das Gameleiras	20
3741	Mossoró	20
3742	Natal	20
3743	Nísia Floresta	20
3744	Nova Cruz	20
3745	Olho-d`Água do Borges	20
3746	Ouro Branco	20
3747	Paraná	20
3748	Paraú	20
3749	Parazinho	20
3750	Parelhas	20
3751	Parnamirim	20
3752	Passa e Fica	20
3753	Passagem	20
3754	Patu	20
3755	Pau dos Ferros	20
3756	Pedra Grande	20
3757	Pedra Preta	20
3758	Pedro Avelino	20
3759	Pedro Velho	20
3760	Pendências	20
3761	Pilões	20
3762	Poço Branco	20
3763	Portalegre	20
3764	Porto do Mangue	20
3765	Presidente Juscelino	20
3766	Pureza	20
3767	Rafael Fernandes	20
3768	Rafael Godeiro	20
3769	Riacho da Cruz	20
3770	Riacho de Santana	20
3771	Riachuelo	20
3772	Rio do Fogo	20
3773	Rodolfo Fernandes	20
3774	Ruy Barbosa	20
3775	Santa Cruz	20
3776	Santa Maria	20
3777	Santana do Matos	20
3778	Santana do Seridó	20
3779	Santo Antônio	20
3780	São Bento do Norte	20
3781	São Bento do Trairí	20
3782	São Fernando	20
3783	São Francisco do Oeste	20
3784	São Gonçalo do Amarante	20
3785	São João do Sabugi	20
3786	São José de Mipibu	20
3787	São José do Campestre	20
3788	São José do Seridó	20
3789	São Miguel	20
3790	São Miguel de Touros	20
3791	São Paulo do Potengi	20
3792	São Pedro	20
3793	São Rafael	20
3794	São Tomé	20
3795	São Vicente	20
3796	Senador Elói de Souza	20
3797	Senador Georgino Avelino	20
3798	Serra de São Bento	20
3799	Serra do Mel	20
3800	Serra Negra do Norte	20
3801	Serrinha	20
3802	Serrinha dos Pintos	20
3803	Severiano Melo	20
3804	Sítio Novo	20
3805	Taboleiro Grande	20
3806	Taipu	20
3807	Tangará	20
3808	Tenente Ananias	20
3809	Tenente Laurentino Cruz	20
3810	Tibau	20
3811	Tibau do Sul	20
3812	Timbaúba dos Batistas	20
3813	Touros	20
3814	Triunfo Potiguar	20
3815	Umarizal	20
3816	Upanema	20
3817	Várzea	20
3818	Venha-Ver	20
3819	Vera Cruz	20
3820	Viçosa	20
3821	Vila Flor	20
3822	Água Santa	21
3823	Agudo	21
3824	Ajuricaba	21
3825	Alecrim	21
3826	Alegrete	21
3827	Alegria	21
3828	Alpestre	21
3829	Alto Alegre	21
3830	Alto Feliz	21
3831	Alvorada	21
3832	Amaral Ferrador	21
3833	Ametista do Sul	21
3834	André da Rocha	21
3835	Anta Gorda	21
3836	Antônio Prado	21
3837	Arambaré	21
3838	Araricá	21
3839	Aratiba	21
3840	Arroio do Meio	21
3841	Arroio do Sal	21
3842	Arroio do Tigre	21
3843	Arroio dos Ratos	21
3844	Arroio Grande	21
3845	Arvorezinha	21
3846	Augusto Pestana	21
3847	Áurea	21
3848	Bagé	21
3849	Balneário Pinhal	21
3850	Barão	21
3851	Barão de Cotegipe	21
3852	Barão do Triunfo	21
3853	Barra do Guarita	21
3854	Barra do Quaraí	21
3855	Barra do Ribeiro	21
3856	Barra do Rio Azul	21
3857	Barra Funda	21
3858	Barracão	21
3859	Barros Cassal	21
3860	Benjamin Constant do Sul	21
3861	Bento Gonçalves	21
3862	Boa Vista das Missões	21
3863	Boa Vista do Buricá	21
3864	Boa Vista do Sul	21
3865	Bom Jesus	21
3866	Bom Princípio	21
3867	Bom Progresso	21
3868	Bom Retiro do Sul	21
3869	Boqueirão do Leão	21
3870	Bossoroca	21
3871	Braga	21
3872	Brochier	21
3873	Butiá	21
3874	Caçapava do Sul	21
3875	Cacequi	21
3876	Cachoeira do Sul	21
3877	Cachoeirinha	21
3878	Cacique Doble	21
3879	Caibaté	21
3880	Caiçara	21
3881	Camaquã	21
3882	Camargo	21
3883	Cambará do Sul	21
3884	Campestre da Serra	21
3885	Campina das Missões	21
3886	Campinas do Sul	21
3887	Campo Bom	21
3888	Campo Novo	21
3889	Campos Borges	21
3890	Candelária	21
3891	Cândido Godói	21
3892	Candiota	21
3893	Canela	21
3894	Canguçu	21
3895	Canoas	21
3896	Capão da Canoa	21
3897	Capão do Leão	21
3898	Capela de Santana	21
3899	Capitão	21
3900	Capivari do Sul	21
3901	Caraá	21
3902	Carazinho	21
3903	Carlos Barbosa	21
3904	Carlos Gomes	21
3905	Casca	21
3906	Caseiros	21
3907	Catuípe	21
3908	Caxias do Sul	21
3909	Centenário	21
3910	Cerrito	21
3911	Cerro Branco	21
3912	Cerro Grande	21
3913	Cerro Grande do Sul	21
3914	Cerro Largo	21
3915	Chapada	21
3916	Charqueadas	21
3917	Charrua	21
3918	Chiapeta	21
3919	Chuí	21
3920	Chuvisca	21
3921	Cidreira	21
3922	Ciríaco	21
3923	Colinas	21
3924	Colorado	21
3925	Condor	21
3926	Constantina	21
3927	Coqueiros do Sul	21
3928	Coronel Barros	21
3929	Coronel Bicaco	21
3930	Cotiporã	21
3931	Coxilha	21
3932	Crissiumal	21
3933	Cristal	21
3934	Cristal do Sul	21
3935	Cruz Alta	21
3936	Cruzeiro do Sul	21
3937	David Canabarro	21
3938	Derrubadas	21
3939	Dezesseis de Novembro	21
3940	Dilermando de Aguiar	21
3941	Dois Irmãos	21
3942	Dois Irmãos das Missões	21
3943	Dois Lajeados	21
3944	Dom Feliciano	21
3945	Dom Pedrito	21
3946	Dom Pedro de Alcântara	21
3947	Dona Francisca	21
3948	Doutor Maurício Cardoso	21
3949	Doutor Ricardo	21
3950	Eldorado do Sul	21
3951	Encantado	21
3952	Encruzilhada do Sul	21
3953	Engenho Velho	21
3954	Entre Rios do Sul	21
3955	Entre-Ijuís	21
3956	Erebango	21
3957	Erechim	21
3958	Ernestina	21
3959	Erval Grande	21
3960	Erval Seco	21
3961	Esmeralda	21
3962	Esperança do Sul	21
3963	Espumoso	21
3964	Estação	21
3965	Estância Velha	21
3966	Esteio	21
3967	Estrela	21
3968	Estrela Velha	21
3969	Eugênio de Castro	21
3970	Fagundes Varela	21
3971	Farroupilha	21
3972	Faxinal do Soturno	21
3973	Faxinalzinho	21
3974	Fazenda Vilanova	21
3975	Feliz	21
3976	Flores da Cunha	21
3977	Floriano Peixoto	21
3978	Fontoura Xavier	21
3979	Formigueiro	21
3980	Fortaleza dos Valos	21
3981	Frederico Westphalen	21
3982	Garibaldi	21
3983	Garruchos	21
3984	Gaurama	21
3985	General Câmara	21
3986	Gentil	21
3987	Getúlio Vargas	21
3988	Giruá	21
3989	Glorinha	21
3990	Gramado	21
3991	Gramado dos Loureiros	21
3992	Gramado Xavier	21
3993	Gravataí	21
3994	Guabiju	21
3995	Guaíba	21
3996	Guaporé	21
3997	Guarani das Missões	21
3998	Harmonia	21
3999	Herval	21
4000	Herveiras	21
4001	Horizontina	21
4002	Hulha Negra	21
4003	Humaitá	21
4004	Ibarama	21
4005	Ibiaçá	21
4006	Ibiraiaras	21
4007	Ibirapuitã	21
4008	Ibirubá	21
4009	Igrejinha	21
4010	Ijuí	21
4011	Ilópolis	21
4012	Imbé	21
4013	Imigrante	21
4014	Independência	21
4015	Inhacorá	21
4016	Ipê	21
4017	Ipiranga do Sul	21
4018	Iraí	21
4019	Itaara	21
4020	Itacurubi	21
4021	Itapuca	21
4022	Itaqui	21
4023	Itatiba do Sul	21
4024	Ivorá	21
4025	Ivoti	21
4026	Jaboticaba	21
4027	Jacutinga	21
4028	Jaguarão	21
4029	Jaguari	21
4030	Jaquirana	21
4031	Jari	21
4032	Jóia	21
4033	Júlio de Castilhos	21
4034	Lagoa dos Três Cantos	21
4035	Lagoa Vermelha	21
4036	Lagoão	21
4037	Lajeado	21
4038	Lajeado do Bugre	21
4039	Lavras do Sul	21
4040	Liberato Salzano	21
4041	Lindolfo Collor	21
4042	Linha Nova	21
4043	Maçambara	21
4044	Machadinho	21
4045	Mampituba	21
4046	Manoel Viana	21
4047	Maquiné	21
4048	Maratá	21
4049	Marau	21
4050	Marcelino Ramos	21
4051	Mariana Pimentel	21
4052	Mariano Moro	21
4053	Marques de Souza	21
4054	Mata	21
4055	Mato Castelhano	21
4056	Mato Leitão	21
4057	Maximiliano de Almeida	21
4058	Minas do Leão	21
4059	Miraguaí	21
4060	Montauri	21
4061	Monte Alegre dos Campos	21
4062	Monte Belo do Sul	21
4063	Montenegro	21
4064	Mormaço	21
4065	Morrinhos do Sul	21
4066	Morro Redondo	21
4067	Morro Reuter	21
4068	Mostardas	21
4069	Muçum	21
4070	Muitos Capões	21
4071	Muliterno	21
4072	Não-Me-Toque	21
4073	Nicolau Vergueiro	21
4074	Nonoai	21
4075	Nova Alvorada	21
4076	Nova Araçá	21
4077	Nova Bassano	21
4078	Nova Boa Vista	21
4079	Nova Bréscia	21
4080	Nova Candelária	21
4081	Nova Esperança do Sul	21
4082	Nova Hartz	21
4083	Nova Pádua	21
4084	Nova Palma	21
4085	Nova Petrópolis	21
4086	Nova Prata	21
4087	Nova Ramada	21
4088	Nova Roma do Sul	21
4089	Nova Santa Rita	21
4090	Novo Barreiro	21
4091	Novo Cabrais	21
4092	Novo Hamburgo	21
4093	Novo Machado	21
4094	Novo Tiradentes	21
4095	Osório	21
4096	Paim Filho	21
4097	Palmares do Sul	21
4098	Palmeira das Missões	21
4099	Palmitinho	21
4100	Panambi	21
4101	Pantano Grande	21
4102	Paraí	21
4103	Paraíso do Sul	21
4104	Pareci Novo	21
4105	Parobé	21
4106	Passa Sete	21
4107	Passo do Sobrado	21
4108	Passo Fundo	21
4109	Paverama	21
4110	Pedro Osório	21
4111	Pejuçara	21
4112	Pelotas	21
4113	Picada Café	21
4114	Pinhal	21
4115	Pinhal Grande	21
4116	Pinheirinho do Vale	21
4117	Pinheiro Machado	21
4118	Pirapó	21
4119	Piratini	21
4120	Planalto	21
4121	Poço das Antas	21
4122	Pontão	21
4123	Ponte Preta	21
4124	Portão	21
4125	Porto Alegre	21
4126	Porto Lucena	21
4127	Porto Mauá	21
4128	Porto Vera Cruz	21
4129	Porto Xavier	21
4130	Pouso Novo	21
4131	Presidente Lucena	21
4132	Progresso	21
4133	Protásio Alves	21
4134	Putinga	21
4135	Quaraí	21
4136	Quevedos	21
4137	Quinze de Novembro	21
4138	Redentora	21
4139	Relvado	21
4140	Restinga Seca	21
4141	Rio dos Índios	21
4142	Rio Grande	21
4143	Rio Pardo	21
4144	Riozinho	21
4145	Roca Sales	21
4146	Rodeio Bonito	21
4147	Rolante	21
4148	Ronda Alta	21
4149	Rondinha	21
4150	Roque Gonzales	21
4151	Rosário do Sul	21
4152	Sagrada Família	21
4153	Saldanha Marinho	21
4154	Salto do Jacuí	21
4155	Salvador das Missões	21
4156	Salvador do Sul	21
4157	Sananduva	21
4158	Santa Bárbara do Sul	21
4159	Santa Clara do Sul	21
4160	Santa Cruz do Sul	21
4161	Santa Maria	21
4162	Santa Maria do Herval	21
4163	Santa Rosa	21
4164	Santa Tereza	21
4165	Santa Vitória do Palmar	21
4166	Santana da Boa Vista	21
4167	Santana do Livramento	21
4168	Santiago	21
4169	Santo Ângelo	21
4170	Santo Antônio da Patrulha	21
4171	Santo Antônio das Missões	21
4172	Santo Antônio do Palma	21
4173	Santo Antônio do Planalto	21
4174	Santo Augusto	21
4175	Santo Cristo	21
4176	Santo Expedito do Sul	21
4177	São Borja	21
4178	São Domingos do Sul	21
4179	São Francisco de Assis	21
4180	São Francisco de Paula	21
4181	São Gabriel	21
4182	São Jerônimo	21
4183	São João da Urtiga	21
4184	São João do Polêsine	21
4185	São Jorge	21
4186	São José das Missões	21
4187	São José do Herval	21
4188	São José do Hortêncio	21
4189	São José do Inhacorá	21
4190	São José do Norte	21
4191	São José do Ouro	21
4192	São José dos Ausentes	21
4193	São Leopoldo	21
4194	São Lourenço do Sul	21
4195	São Luiz Gonzaga	21
4196	São Marcos	21
4197	São Martinho	21
4198	São Martinho da Serra	21
4199	São Miguel das Missões	21
4200	São Nicolau	21
4201	São Paulo das Missões	21
4202	São Pedro da Serra	21
4203	São Pedro do Butiá	21
4204	São Pedro do Sul	21
4205	São Sebastião do Caí	21
4206	São Sepé	21
4207	São Valentim	21
4208	São Valentim do Sul	21
4209	São Valério do Sul	21
4210	São Vendelino	21
4211	São Vicente do Sul	21
4212	Sapiranga	21
4213	Sapucaia do Sul	21
4214	Sarandi	21
4215	Seberi	21
4216	Sede Nova	21
4217	Segredo	21
4218	Selbach	21
4219	Senador Salgado Filho	21
4220	Sentinela do Sul	21
4221	Serafina Corrêa	21
4222	Sério	21
4223	Sertão	21
4224	Sertão Santana	21
4225	Sete de Setembro	21
4226	Severiano de Almeida	21
4227	Silveira Martins	21
4228	Sinimbu	21
4229	Sobradinho	21
4230	Soledade	21
4231	Tabaí	21
4232	Tapejara	21
4233	Tapera	21
4234	Tapes	21
4235	Taquara	21
4236	Taquari	21
4237	Taquaruçu do Sul	21
4238	Tavares	21
4239	Tenente Portela	21
4240	Terra de Areia	21
4241	Teutônia	21
4242	Tiradentes do Sul	21
4243	Toropi	21
4244	Torres	21
4245	Tramandaí	21
4246	Travesseiro	21
4247	Três Arroios	21
4248	Três Cachoeiras	21
4249	Três Coroas	21
4250	Três de Maio	21
4251	Três Forquilhas	21
4252	Três Palmeiras	21
4253	Três Passos	21
4254	Trindade do Sul	21
4255	Triunfo	21
4256	Tucunduva	21
4257	Tunas	21
4258	Tupanci do Sul	21
4259	Tupanciretã	21
4260	Tupandi	21
4261	Tuparendi	21
4262	Turuçu	21
4263	Ubiretama	21
4264	União da Serra	21
4265	Unistalda	21
4266	Uruguaiana	21
4267	Vacaria	21
4268	Vale do Sol	21
4269	Vale Real	21
4270	Vale Verde	21
4271	Vanini	21
4272	Venâncio Aires	21
4273	Vera Cruz	21
4274	Veranópolis	21
4275	Vespasiano Correa	21
4276	Viadutos	21
4277	Viamão	21
4278	Vicente Dutra	21
4279	Victor Graeff	21
4280	Vila Flores	21
4281	Vila Lângaro	21
4282	Vila Maria	21
4283	Vila Nova do Sul	21
4284	Vista Alegre	21
4285	Vista Alegre do Prata	21
4286	Vista Gaúcha	21
4287	Vitória das Missões	21
4288	Xangri-lá	21
4289	Alta Floresta d`Oeste	22
4290	Alto Alegre dos Parecis	22
4291	Alto Paraíso	22
4292	Alvorada d`Oeste	22
4293	Ariquemes	22
4294	Buritis	22
4295	Cabixi	22
4296	Cacaulândia	22
4297	Cacoal	22
4298	Campo Novo de Rondônia	22
4299	Candeias do Jamari	22
4300	Castanheiras	22
4301	Cerejeiras	22
4302	Chupinguaia	22
4303	Colorado do Oeste	22
4304	Corumbiara	22
4305	Costa Marques	22
4306	Cujubim	22
4307	Espigão d`Oeste	22
4308	Governador Jorge Teixeira	22
4309	Guajará-Mirim	22
4310	Itapuã do Oeste	22
4311	Jaru	22
4312	Ji-Paraná	22
4313	Machadinho d`Oeste	22
4314	Ministro Andreazza	22
4315	Mirante da Serra	22
4316	Monte Negro	22
4317	Nova Brasilândia d`Oeste	22
4318	Nova Mamoré	22
4319	Nova União	22
4320	Novo Horizonte do Oeste	22
4321	Ouro Preto do Oeste	22
4322	Parecis	22
4323	Pimenta Bueno	22
4324	Pimenteiras do Oeste	22
4325	Porto Velho	22
4326	Presidente Médici	22
4327	Primavera de Rondônia	22
4328	Rio Crespo	22
4329	Rolim de Moura	22
4330	Santa Luzia d`Oeste	22
4331	São Felipe d`Oeste	22
4332	São Francisco do Guaporé	22
4333	São Miguel do Guaporé	22
4334	Seringueiras	22
4335	Teixeirópolis	22
4336	Theobroma	22
4337	Urupá	22
4338	Vale do Anari	22
4339	Vale do Paraíso	22
4340	Vilhena	22
4341	Alto Alegre	23
4342	Amajari	23
4343	Boa Vista	23
4344	Bonfim	23
4345	Cantá	23
4346	Caracaraí	23
4347	Caroebe	23
4348	Iracema	23
4349	Mucajaí	23
4350	Normandia	23
4351	Pacaraima	23
4352	Rorainópolis	23
4353	São João da Baliza	23
4354	São Luiz	23
4355	Uiramutã	23
4356	Abdon Batista	24
4357	Abelardo Luz	24
4358	Agrolândia	24
4359	Agronômica	24
4360	Água Doce	24
4361	Águas de Chapecó	24
4362	Águas Frias	24
4363	Águas Mornas	24
4364	Alfredo Wagner	24
4365	Alto Bela Vista	24
4366	Anchieta	24
4367	Angelina	24
4368	Anita Garibaldi	24
4369	Anitápolis	24
4370	Antônio Carlos	24
4371	Apiúna	24
4372	Arabutã	24
4373	Araquari	24
4374	Araranguá	24
4375	Armazém	24
4376	Arroio Trinta	24
4377	Arvoredo	24
4378	Ascurra	24
4379	Atalanta	24
4380	Aurora	24
4381	Balneário Arroio do Silva	24
4382	Balneário Barra do Sul	24
4383	Balneário Camboriú	24
4384	Balneário Gaivota	24
4385	Bandeirante	24
4386	Barra Bonita	24
4387	Barra Velha	24
4388	Bela Vista do Toldo	24
4389	Belmonte	24
4390	Benedito Novo	24
4391	Biguaçu	24
4392	Blumenau	24
4393	Bocaina do Sul	24
4394	Bom Jardim da Serra	24
4395	Bom Jesus	24
4396	Bom Jesus do Oeste	24
4397	Bom Retiro	24
4398	Bombinhas	24
4399	Botuverá	24
4400	Braço do Norte	24
4401	Braço do Trombudo	24
4402	Brunópolis	24
4403	Brusque	24
4404	Caçador	24
4405	Caibi	24
4406	Calmon	24
4407	Camboriú	24
4408	Campo Alegre	24
4409	Campo Belo do Sul	24
4410	Campo Erê	24
4411	Campos Novos	24
4412	Canelinha	24
4413	Canoinhas	24
4414	Capão Alto	24
4415	Capinzal	24
4416	Capivari de Baixo	24
4417	Catanduvas	24
4418	Caxambu do Sul	24
4419	Celso Ramos	24
4420	Cerro Negro	24
4421	Chapadão do Lageado	24
4422	Chapecó	24
4423	Cocal do Sul	24
4424	Concórdia	24
4425	Cordilheira Alta	24
4426	Coronel Freitas	24
4427	Coronel Martins	24
4428	Correia Pinto	24
4429	Corupá	24
4430	Criciúma	24
4431	Cunha Porã	24
4432	Cunhataí	24
4433	Curitibanos	24
4434	Descanso	24
4435	Dionísio Cerqueira	24
4436	Dona Emma	24
4437	Doutor Pedrinho	24
4438	Entre Rios	24
4439	Ermo	24
4440	Erval Velho	24
4441	Faxinal dos Guedes	24
4442	Flor do Sertão	24
4443	Florianópolis	24
4444	Formosa do Sul	24
4445	Forquilhinha	24
4446	Fraiburgo	24
4447	Frei Rogério	24
4448	Galvão	24
4449	Garopaba	24
4450	Garuva	24
4451	Gaspar	24
4452	Governador Celso Ramos	24
4453	Grão Pará	24
4454	Gravatal	24
4455	Guabiruba	24
4456	Guaraciaba	24
4457	Guaramirim	24
4458	Guarujá do Sul	24
4459	Guatambú	24
4460	Herval d`Oeste	24
4461	Ibiam	24
4462	Ibicaré	24
4463	Ibirama	24
4464	Içara	24
4465	Ilhota	24
4466	Imaruí	24
4467	Imbituba	24
4468	Imbuia	24
4469	Indaial	24
4470	Iomerê	24
4471	Ipira	24
4472	Iporã do Oeste	24
4473	Ipuaçu	24
4474	Ipumirim	24
4475	Iraceminha	24
4476	Irani	24
4477	Irati	24
4478	Irineópolis	24
4479	Itá	24
4480	Itaiópolis	24
4481	Itajaí	24
4482	Itapema	24
4483	Itapiranga	24
4484	Itapoá	24
4485	Ituporanga	24
4486	Jaborá	24
4487	Jacinto Machado	24
4488	Jaguaruna	24
4489	Jaraguá do Sul	24
4490	Jardinópolis	24
4491	Joaçaba	24
4492	Joinville	24
4493	José Boiteux	24
4494	Jupiá	24
4495	Lacerdópolis	24
4496	Lages	24
4497	Laguna	24
4498	Lajeado Grande	24
4499	Laurentino	24
4500	Lauro Muller	24
4501	Lebon Régis	24
4502	Leoberto Leal	24
4503	Lindóia do Sul	24
4504	Lontras	24
4505	Luiz Alves	24
4506	Luzerna	24
4507	Macieira	24
4508	Mafra	24
4509	Major Gercino	24
4510	Major Vieira	24
4511	Maracajá	24
4512	Maravilha	24
4513	Marema	24
4514	Massaranduba	24
4515	Matos Costa	24
4516	Meleiro	24
4517	Mirim Doce	24
4518	Modelo	24
4519	Mondaí	24
4520	Monte Carlo	24
4521	Monte Castelo	24
4522	Morro da Fumaça	24
4523	Morro Grande	24
4524	Navegantes	24
4525	Nova Erechim	24
4526	Nova Itaberaba	24
4527	Nova Trento	24
4528	Nova Veneza	24
4529	Novo Horizonte	24
4530	Orleans	24
4531	Otacílio Costa	24
4532	Ouro	24
4533	Ouro Verde	24
4534	Paial	24
4535	Painel	24
4536	Palhoça	24
4537	Palma Sola	24
4538	Palmeira	24
4539	Palmitos	24
4540	Papanduva	24
4541	Paraíso	24
4542	Passo de Torres	24
4543	Passos Maia	24
4544	Paulo Lopes	24
4545	Pedras Grandes	24
4546	Penha	24
4547	Peritiba	24
4548	Petrolândia	24
4549	Piçarras	24
4550	Pinhalzinho	24
4551	Pinheiro Preto	24
4552	Piratuba	24
4553	Planalto Alegre	24
4554	Pomerode	24
4555	Ponte Alta	24
4556	Ponte Alta do Norte	24
4557	Ponte Serrada	24
4558	Porto Belo	24
4559	Porto União	24
4560	Pouso Redondo	24
4561	Praia Grande	24
4562	Presidente Castelo Branco	24
4563	Presidente Getúlio	24
4564	Presidente Nereu	24
4565	Princesa	24
4566	Quilombo	24
4567	Rancho Queimado	24
4568	Rio das Antas	24
4569	Rio do Campo	24
4570	Rio do Oeste	24
4571	Rio do Sul	24
4572	Rio dos Cedros	24
4573	Rio Fortuna	24
4574	Rio Negrinho	24
4575	Rio Rufino	24
4576	Riqueza	24
4577	Rodeio	24
4578	Romelândia	24
4579	Salete	24
4580	Saltinho	24
4581	Salto Veloso	24
4582	Sangão	24
4583	Santa Cecília	24
4584	Santa Helena	24
4585	Santa Rosa de Lima	24
4586	Santa Rosa do Sul	24
4587	Santa Terezinha	24
4588	Santa Terezinha do Progresso	24
4589	Santiago do Sul	24
4590	Santo Amaro da Imperatriz	24
4591	São Bento do Sul	24
4592	São Bernardino	24
4593	São Bonifácio	24
4594	São Carlos	24
4595	São Cristovão do Sul	24
4596	São Domingos	24
4597	São Francisco do Sul	24
4598	São João Batista	24
4599	São João do Itaperiú	24
4600	São João do Oeste	24
4601	São João do Sul	24
4602	São Joaquim	24
4603	São José	24
4604	São José do Cedro	24
4605	São José do Cerrito	24
4606	São Lourenço do Oeste	24
4607	São Ludgero	24
4608	São Martinho	24
4609	São Miguel da Boa Vista	24
4610	São Miguel do Oeste	24
4611	São Pedro de Alcântara	24
4612	Saudades	24
4613	Schroeder	24
4614	Seara	24
4615	Serra Alta	24
4616	Siderópolis	24
4617	Sombrio	24
4618	Sul Brasil	24
4619	Taió	24
4620	Tangará	24
4621	Tigrinhos	24
4622	Tijucas	24
4623	Timbé do Sul	24
4624	Timbó	24
4625	Timbó Grande	24
4626	Três Barras	24
4627	Treviso	24
4628	Treze de Maio	24
4629	Treze Tílias	24
4630	Trombudo Central	24
4631	Tubarão	24
4632	Tunápolis	24
4633	Turvo	24
4634	União do Oeste	24
4635	Urubici	24
4636	Urupema	24
4637	Urussanga	24
4638	Vargeão	24
4639	Vargem	24
4640	Vargem Bonita	24
4641	Vidal Ramos	24
4642	Videira	24
4643	Vitor Meireles	24
4644	Witmarsum	24
4645	Xanxerê	24
4646	Xavantina	24
4647	Xaxim	24
4648	Zortéa	24
4649	Adamantina	25
4650	Adolfo	25
4651	Aguaí	25
4652	Águas da Prata	25
4653	Águas de Lindóia	25
4654	Águas de Santa Bárbara	25
4655	Águas de São Pedro	25
4656	Agudos	25
4657	Alambari	25
4658	Alfredo Marcondes	25
4659	Altair	25
4660	Altinópolis	25
4661	Alto Alegre	25
4662	Alumínio	25
4663	Álvares Florence	25
4664	Álvares Machado	25
4665	Álvaro de Carvalho	25
4666	Alvinlândia	25
4667	Americana	25
4668	Américo Brasiliense	25
4669	Américo de Campos	25
4670	Amparo	25
4671	Analândia	25
4672	Andradina	25
4673	Angatuba	25
4674	Anhembi	25
4675	Anhumas	25
4676	Aparecida	25
4677	Aparecida d`Oeste	25
4678	Apiaí	25
4679	Araçariguama	25
4680	Araçatuba	25
4681	Araçoiaba da Serra	25
4682	Aramina	25
4683	Arandu	25
4684	Arapeí	25
4685	Araraquara	25
4686	Araras	25
4687	Arco-Íris	25
4688	Arealva	25
4689	Areias	25
4690	Areiópolis	25
4691	Ariranha	25
4692	Artur Nogueira	25
4693	Arujá	25
4694	Aspásia	25
4695	Assis	25
4696	Atibaia	25
4697	Auriflama	25
4698	Avaí	25
4699	Avanhandava	25
4700	Avaré	25
4701	Bady Bassitt	25
4702	Balbinos	25
4703	Bálsamo	25
4704	Bananal	25
4705	Barão de Antonina	25
4706	Barbosa	25
4707	Bariri	25
4708	Barra Bonita	25
4709	Barra do Chapéu	25
4710	Barra do Turvo	25
4711	Barretos	25
4712	Barrinha	25
4713	Barueri	25
4714	Bastos	25
4715	Batatais	25
4716	Bauru	25
4717	Bebedouro	25
4718	Bento de Abreu	25
4719	Bernardino de Campos	25
4720	Bertioga	25
4721	Bilac	25
4722	Birigui	25
4723	Biritiba-Mirim	25
4724	Boa Esperança do Sul	25
4725	Bocaina	25
4726	Bofete	25
4727	Boituva	25
4728	Bom Jesus dos Perdões	25
4729	Bom Sucesso de Itararé	25
4730	Borá	25
4731	Boracéia	25
4732	Borborema	25
4733	Borebi	25
4734	Botucatu	25
4735	Bragança Paulista	25
4736	Braúna	25
4737	Brejo Alegre	25
4738	Brodowski	25
4739	Brotas	25
4740	Buri	25
4741	Buritama	25
4742	Buritizal	25
4743	Cabrália Paulista	25
4744	Cabreúva	25
4745	Caçapava	25
4746	Cachoeira Paulista	25
4747	Caconde	25
4748	Cafelândia	25
4749	Caiabu	25
4750	Caieiras	25
4751	Caiuá	25
4752	Cajamar	25
4753	Cajati	25
4754	Cajobi	25
4755	Cajuru	25
4756	Campina do Monte Alegre	25
4757	Campinas	25
4758	Campo Limpo Paulista	25
4759	Campos do Jordão	25
4760	Campos Novos Paulista	25
4761	Cananéia	25
4762	Canas	25
4763	Cândido Mota	25
4764	Cândido Rodrigues	25
4765	Canitar	25
4766	Capão Bonito	25
4767	Capela do Alto	25
4768	Capivari	25
4769	Caraguatatuba	25
4770	Carapicuíba	25
4771	Cardoso	25
4772	Casa Branca	25
4773	Cássia dos Coqueiros	25
4774	Castilho	25
4775	Catanduva	25
4776	Catiguá	25
4777	Cedral	25
4778	Cerqueira César	25
4779	Cerquilho	25
4780	Cesário Lange	25
4781	Charqueada	25
4782	Chavantes	25
4783	Clementina	25
4784	Colina	25
4785	Colômbia	25
4786	Conchal	25
4787	Conchas	25
4788	Cordeirópolis	25
4789	Coroados	25
4790	Coronel Macedo	25
4791	Corumbataí	25
4792	Cosmópolis	25
4793	Cosmorama	25
4794	Cotia	25
4795	Cravinhos	25
4796	Cristais Paulista	25
4797	Cruzália	25
4798	Cruzeiro	25
4799	Cubatão	25
4800	Cunha	25
4801	Descalvado	25
4802	Diadema	25
4803	Dirce Reis	25
4804	Divinolândia	25
4805	Dobrada	25
4806	Dois Córregos	25
4807	Dolcinópolis	25
4808	Dourado	25
4809	Dracena	25
4810	Duartina	25
4811	Dumont	25
4812	Echaporã	25
4813	Eldorado	25
4814	Elias Fausto	25
4815	Elisiário	25
4816	Embaúba	25
4817	Embu	25
4818	Embu-Guaçu	25
4819	Emilianópolis	25
4820	Engenheiro Coelho	25
4821	Espírito Santo do Pinhal	25
4822	Espírito Santo do Turvo	25
4823	Estiva Gerbi	25
4824	Estrela d`Oeste	25
4825	Estrela do Norte	25
4826	Euclides da Cunha Paulista	25
4827	Fartura	25
4828	Fernando Prestes	25
4829	Fernandópolis	25
4830	Fernão	25
4831	Ferraz de Vasconcelos	25
4832	Flora Rica	25
4833	Floreal	25
4834	Florínia	25
4835	Flórida Paulista	25
4836	Franca	25
4837	Francisco Morato	25
4838	Franco da Rocha	25
4839	Gabriel Monteiro	25
4840	Gália	25
4841	Garça	25
4842	Gastão Vidigal	25
4843	Gavião Peixoto	25
4844	General Salgado	25
4845	Getulina	25
4846	Glicério	25
4847	Guaiçara	25
4848	Guaimbê	25
4849	Guaíra	25
4850	Guapiaçu	25
4851	Guapiara	25
4852	Guará	25
4853	Guaraçaí	25
4854	Guaraci	25
4855	Guarani d`Oeste	25
4856	Guarantã	25
4857	Guararapes	25
4858	Guararema	25
4859	Guaratinguetá	25
4860	Guareí	25
4861	Guariba	25
4862	Guarujá	25
4863	Guarulhos	25
4864	Guatapará	25
4865	Guzolândia	25
4866	Herculândia	25
4867	Holambra	25
4868	Hortolândia	25
4869	Iacanga	25
4870	Iacri	25
4871	Iaras	25
4872	Ibaté	25
4873	Ibirá	25
4874	Ibirarema	25
4875	Ibitinga	25
4876	Ibiúna	25
4877	Icém	25
4878	Iepê	25
4879	Igaraçu do Tietê	25
4880	Igarapava	25
4881	Igaratá	25
4882	Iguape	25
4883	Ilha Comprida	25
4884	Ilha Solteira	25
4885	Ilhabela	25
4886	Indaiatuba	25
4887	Indiana	25
4888	Indiaporã	25
4889	Inúbia Paulista	25
4890	Ipauçu	25
4891	Iperó	25
4892	Ipeúna	25
4893	Ipiguá	25
4894	Iporanga	25
4895	Ipuã	25
4896	Iracemápolis	25
4897	Irapuã	25
4898	Irapuru	25
4899	Itaberá	25
4900	Itaí	25
4901	Itajobi	25
4902	Itaju	25
4903	Itanhaém	25
4904	Itaóca	25
4905	Itapecerica da Serra	25
4906	Itapetininga	25
4907	Itapeva	25
4908	Itapevi	25
4909	Itapira	25
4910	Itapirapuã Paulista	25
4911	Itápolis	25
4912	Itaporanga	25
4913	Itapuí	25
4914	Itapura	25
4915	Itaquaquecetuba	25
4916	Itararé	25
4917	Itariri	25
4918	Itatiba	25
4919	Itatinga	25
4920	Itirapina	25
4921	Itirapuã	25
4922	Itobi	25
4923	Itu	25
4924	Itupeva	25
4925	Ituverava	25
4926	Jaborandi	25
4927	Jaboticabal	25
4928	Jacareí	25
4929	Jaci	25
4930	Jacupiranga	25
4931	Jaguariúna	25
4932	Jales	25
4933	Jambeiro	25
4934	Jandira	25
4935	Jardinópolis	25
4936	Jarinu	25
4937	Jaú	25
4938	Jeriquara	25
4939	Joanópolis	25
4940	João Ramalho	25
4941	José Bonifácio	25
4942	Júlio Mesquita	25
4943	Jumirim	25
4944	Jundiaí	25
4945	Junqueirópolis	25
4946	Juquiá	25
4947	Juquitiba	25
4948	Lagoinha	25
4949	Laranjal Paulista	25
4950	Lavínia	25
4951	Lavrinhas	25
4952	Leme	25
4953	Lençóis Paulista	25
4954	Limeira	25
4955	Lindóia	25
4956	Lins	25
4957	Lorena	25
4958	Lourdes	25
4959	Louveira	25
4960	Lucélia	25
4961	Lucianópolis	25
4962	Luís Antônio	25
4963	Luiziânia	25
4964	Lupércio	25
4965	Lutécia	25
4966	Macatuba	25
4967	Macaubal	25
4968	Macedônia	25
4969	Magda	25
4970	Mairinque	25
4971	Mairiporã	25
4972	Manduri	25
4973	Marabá Paulista	25
4974	Maracaí	25
4975	Marapoama	25
4976	Mariápolis	25
4977	Marília	25
4978	Marinópolis	25
4979	Martinópolis	25
4980	Matão	25
4981	Mauá	25
4982	Mendonça	25
4983	Meridiano	25
4984	Mesópolis	25
4985	Miguelópolis	25
4986	Mineiros do Tietê	25
4987	Mira Estrela	25
4988	Miracatu	25
4989	Mirandópolis	25
4990	Mirante do Paranapanema	25
4991	Mirassol	25
4992	Mirassolândia	25
4993	Mococa	25
4994	Mogi das Cruzes	25
4995	Mogi Guaçu	25
4996	Mogi-Mirim	25
4997	Mombuca	25
4998	Monções	25
4999	Mongaguá	25
5000	Monte Alegre do Sul	25
5001	Monte Alto	25
5002	Monte Aprazível	25
5003	Monte Azul Paulista	25
5004	Monte Castelo	25
5005	Monte Mor	25
5006	Monteiro Lobato	25
5007	Morro Agudo	25
5008	Morungaba	25
5009	Motuca	25
5010	Murutinga do Sul	25
5011	Nantes	25
5012	Narandiba	25
5013	Natividade da Serra	25
5014	Nazaré Paulista	25
5015	Neves Paulista	25
5016	Nhandeara	25
5017	Nipoã	25
5018	Nova Aliança	25
5019	Nova Campina	25
5020	Nova Canaã Paulista	25
5021	Nova Castilho	25
5022	Nova Europa	25
5023	Nova Granada	25
5024	Nova Guataporanga	25
5025	Nova Independência	25
5026	Nova Luzitânia	25
5027	Nova Odessa	25
5028	Novais	25
5029	Novo Horizonte	25
5030	Nuporanga	25
5031	Ocauçu	25
5032	Óleo	25
5033	Olímpia	25
5034	Onda Verde	25
5035	Oriente	25
5036	Orindiúva	25
5037	Orlândia	25
5038	Osasco	25
5039	Oscar Bressane	25
5040	Osvaldo Cruz	25
5041	Ourinhos	25
5042	Ouro Verde	25
5043	Ouroeste	25
5044	Pacaembu	25
5045	Palestina	25
5046	Palmares Paulista	25
5047	Palmeira d`Oeste	25
5048	Palmital	25
5049	Panorama	25
5050	Paraguaçu Paulista	25
5051	Paraibuna	25
5052	Paraíso	25
5053	Paranapanema	25
5054	Paranapuã	25
5055	Parapuã	25
5056	Pardinho	25
5057	Pariquera-Açu	25
5058	Parisi	25
5059	Patrocínio Paulista	25
5060	Paulicéia	25
5061	Paulínia	25
5062	Paulistânia	25
5063	Paulo de Faria	25
5064	Pederneiras	25
5065	Pedra Bela	25
5066	Pedranópolis	25
5067	Pedregulho	25
5068	Pedreira	25
5069	Pedrinhas Paulista	25
5070	Pedro de Toledo	25
5071	Penápolis	25
5072	Pereira Barreto	25
5073	Pereiras	25
5074	Peruíbe	25
5075	Piacatu	25
5076	Piedade	25
5077	Pilar do Sul	25
5078	Pindamonhangaba	25
5079	Pindorama	25
5080	Pinhalzinho	25
5081	Piquerobi	25
5082	Piquete	25
5083	Piracaia	25
5084	Piracicaba	25
5085	Piraju	25
5086	Pirajuí	25
5087	Pirangi	25
5088	Pirapora do Bom Jesus	25
5089	Pirapozinho	25
5090	Pirassununga	25
5091	Piratininga	25
5092	Pitangueiras	25
5093	Planalto	25
5094	Platina	25
5095	Poá	25
5096	Poloni	25
5097	Pompéia	25
5098	Pongaí	25
5099	Pontal	25
5100	Pontalinda	25
5101	Pontes Gestal	25
5102	Populina	25
5103	Porangaba	25
5104	Porto Feliz	25
5105	Porto Ferreira	25
5106	Potim	25
5107	Potirendaba	25
5108	Pracinha	25
5109	Pradópolis	25
5110	Praia Grande	25
5111	Pratânia	25
5112	Presidente Alves	25
5113	Presidente Bernardes	25
5114	Presidente Epitácio	25
5115	Presidente Prudente	25
5116	Presidente Venceslau	25
5117	Promissão	25
5118	Quadra	25
5119	Quatá	25
5120	Queiroz	25
5121	Queluz	25
5122	Quintana	25
5123	Rafard	25
5124	Rancharia	25
5125	Redenção da Serra	25
5126	Regente Feijó	25
5127	Reginópolis	25
5128	Registro	25
5129	Restinga	25
5130	Ribeira	25
5131	Ribeirão Bonito	25
5132	Ribeirão Branco	25
5133	Ribeirão Corrente	25
5134	Ribeirão do Sul	25
5135	Ribeirão dos Índios	25
5136	Ribeirão Grande	25
5137	Ribeirão Pires	25
5138	Ribeirão Preto	25
5139	Rifaina	25
5140	Rincão	25
5141	Rinópolis	25
5142	Rio Claro	25
5143	Rio das Pedras	25
5144	Rio Grande da Serra	25
5145	Riolândia	25
5146	Riversul	25
5147	Rosana	25
5148	Roseira	25
5149	Rubiácea	25
5150	Rubinéia	25
5151	Sabino	25
5152	Sagres	25
5153	Sales	25
5154	Sales Oliveira	25
5155	Salesópolis	25
5156	Salmourão	25
5157	Saltinho	25
5158	Salto	25
5159	Salto de Pirapora	25
5160	Salto Grande	25
5161	Sandovalina	25
5162	Santa Adélia	25
5163	Santa Albertina	25
5164	Santa Bárbara d`Oeste	25
5165	Santa Branca	25
5166	Santa Clara d`Oeste	25
5167	Santa Cruz da Conceição	25
5168	Santa Cruz da Esperança	25
5169	Santa Cruz das Palmeiras	25
5170	Santa Cruz do Rio Pardo	25
5171	Santa Ernestina	25
5172	Santa Fé do Sul	25
5173	Santa Gertrudes	25
5174	Santa Isabel	25
5175	Santa Lúcia	25
5176	Santa Maria da Serra	25
5177	Santa Mercedes	25
5178	Santa Rita d`Oeste	25
5179	Santa Rita do Passa Quatro	25
5180	Santa Rosa de Viterbo	25
5181	Santa Salete	25
5182	Santana da Ponte Pensa	25
5183	Santana de Parnaíba	25
5184	Santo Anastácio	25
5185	Santo André	25
5186	Santo Antônio da Alegria	25
5187	Santo Antônio de Posse	25
5188	Santo Antônio do Aracanguá	25
5189	Santo Antônio do Jardim	25
5190	Santo Antônio do Pinhal	25
5191	Santo Expedito	25
5192	Santópolis do Aguapeí	25
5193	Santos	25
5194	São Bento do Sapucaí	25
5195	São Bernardo do Campo	25
5196	São Caetano do Sul	25
5197	São Carlos	25
5198	São Francisco	25
5199	São João da Boa Vista	25
5200	São João das Duas Pontes	25
5201	São João de Iracema	25
5202	São João do Pau d`Alho	25
5203	São Joaquim da Barra	25
5204	São José da Bela Vista	25
5205	São José do Barreiro	25
5206	São José do Rio Pardo	25
5207	São José do Rio Preto	25
5208	São José dos Campos	25
5209	São Lourenço da Serra	25
5210	São Luís do Paraitinga	25
5211	São Manuel	25
5212	São Miguel Arcanjo	25
5213	São Paulo	25
5214	São Pedro	25
5215	São Pedro do Turvo	25
5216	São Roque	25
5217	São Sebastião	25
5218	São Sebastião da Grama	25
5219	São Simão	25
5220	São Vicente	25
5221	Sarapuí	25
5222	Sarutaiá	25
5223	Sebastianópolis do Sul	25
5224	Serra Azul	25
5225	Serra Negra	25
5226	Serrana	25
5227	Sertãozinho	25
5228	Sete Barras	25
5229	Severínia	25
5230	Silveiras	25
5231	Socorro	25
5232	Sorocaba	25
5233	Sud Mennucci	25
5234	Sumaré	25
5235	Suzanápolis	25
5236	Suzano	25
5237	Tabapuã	25
5238	Tabatinga	25
5239	Taboão da Serra	25
5240	Taciba	25
5241	Taguaí	25
5242	Taiaçu	25
5243	Taiúva	25
5244	Tambaú	25
5245	Tanabi	25
5246	Tapiraí	25
5247	Tapiratiba	25
5248	Taquaral	25
5249	Taquaritinga	25
5250	Taquarituba	25
5251	Taquarivaí	25
5252	Tarabai	25
5253	Tarumã	25
5254	Tatuí	25
5255	Taubaté	25
5256	Tejupá	25
5257	Teodoro Sampaio	25
5258	Terra Roxa	25
5259	Tietê	25
5260	Timburi	25
5261	Torre de Pedra	25
5262	Torrinha	25
5263	Trabiju	25
5264	Tremembé	25
5265	Três Fronteiras	25
5266	Tuiuti	25
5267	Tupã	25
5268	Tupi Paulista	25
5269	Turiúba	25
5270	Turmalina	25
5271	Ubarana	25
5272	Ubatuba	25
5273	Ubirajara	25
5274	Uchoa	25
5275	União Paulista	25
5276	Urânia	25
5277	Uru	25
5278	Urupês	25
5279	Valentim Gentil	25
5280	Valinhos	25
5281	Valparaíso	25
5282	Vargem	25
5283	Vargem Grande do Sul	25
5284	Vargem Grande Paulista	25
5285	Várzea Paulista	25
5286	Vera Cruz	25
5287	Vinhedo	25
5288	Viradouro	25
5289	Vista Alegre do Alto	25
5290	Vitória Brasil	25
5291	Votorantim	25
5292	Votuporanga	25
5293	Zacarias	25
5294	Amparo de São Francisco	26
5295	Aquidabã	26
5296	Aracaju	26
5297	Arauá	26
5298	Areia Branca	26
5299	Barra dos Coqueiros	26
5300	Boquim	26
5301	Brejo Grande	26
5302	Campo do Brito	26
5303	Canhoba	26
5304	Canindé de São Francisco	26
5305	Capela	26
5306	Carira	26
5307	Carmópolis	26
5308	Cedro de São João	26
5309	Cristinápolis	26
5310	Cumbe	26
5311	Divina Pastora	26
5312	Estância	26
5313	Feira Nova	26
5314	Frei Paulo	26
5315	Gararu	26
5316	General Maynard	26
5317	Gracho Cardoso	26
5318	Ilha das Flores	26
5319	Indiaroba	26
5320	Itabaiana	26
5321	Itabaianinha	26
5322	Itabi	26
5323	Itaporanga d`Ajuda	26
5324	Japaratuba	26
5325	Japoatã	26
5326	Lagarto	26
5327	Laranjeiras	26
5328	Macambira	26
5329	Malhada dos Bois	26
5330	Malhador	26
5331	Maruim	26
5332	Moita Bonita	26
5333	Monte Alegre de Sergipe	26
5334	Muribeca	26
5335	Neópolis	26
5336	Nossa Senhora Aparecida	26
5337	Nossa Senhora da Glória	26
5338	Nossa Senhora das Dores	26
5339	Nossa Senhora de Lourdes	26
5340	Nossa Senhora do Socorro	26
5341	Pacatuba	26
5342	Pedra Mole	26
5343	Pedrinhas	26
5344	Pinhão	26
5345	Pirambu	26
5346	Poço Redondo	26
5347	Poço Verde	26
5348	Porto da Folha	26
5349	Propriá	26
5350	Riachão do Dantas	26
5351	Riachuelo	26
5352	Ribeirópolis	26
5353	Rosário do Catete	26
5354	Salgado	26
5355	Santa Luzia do Itanhy	26
5356	Santa Rosa de Lima	26
5357	Santana do São Francisco	26
5358	Santo Amaro das Brotas	26
5359	São Cristóvão	26
5360	São Domingos	26
5361	São Francisco	26
5362	São Miguel do Aleixo	26
5363	Simão Dias	26
5364	Siriri	26
5365	Telha	26
5366	Tobias Barreto	26
5367	Tomar do Geru	26
5368	Umbaúba	26
5369	Abreulândia	27
5370	Aguiarnópolis	27
5371	Aliança do Tocantins	27
5372	Almas	27
5373	Alvorada	27
5374	Ananás	27
5375	Angico	27
5376	Aparecida do Rio Negro	27
5377	Aragominas	27
5378	Araguacema	27
5379	Araguaçu	27
5380	Araguaína	27
5381	Araguanã	27
5382	Araguatins	27
5383	Arapoema	27
5384	Arraias	27
5385	Augustinópolis	27
5386	Aurora do Tocantins	27
5387	Axixá do Tocantins	27
5388	Babaçulândia	27
5389	Bandeirantes do Tocantins	27
5390	Barra do Ouro	27
5391	Barrolândia	27
5392	Bernardo Sayão	27
5393	Bom Jesus do Tocantins	27
5394	Brasilândia do Tocantins	27
5395	Brejinho de Nazaré	27
5396	Buriti do Tocantins	27
5397	Cachoeirinha	27
5398	Campos Lindos	27
5399	Cariri do Tocantins	27
5400	Carmolândia	27
5401	Carrasco Bonito	27
5402	Caseara	27
5403	Centenário	27
5404	Chapada da Natividade	27
5405	Chapada de Areia	27
5406	Colinas do Tocantins	27
5407	Colméia	27
5408	Combinado	27
5409	Conceição do Tocantins	27
5410	Couto de Magalhães	27
5411	Cristalândia	27
5412	Crixás do Tocantins	27
5413	Darcinópolis	27
5414	Dianópolis	27
5415	Divinópolis do Tocantins	27
5416	Dois Irmãos do Tocantins	27
5417	Dueré	27
5418	Esperantina	27
5419	Fátima	27
5420	Figueirópolis	27
5421	Filadélfia	27
5422	Formoso do Araguaia	27
5423	Fortaleza do Tabocão	27
5424	Goianorte	27
5425	Goiatins	27
5426	Guaraí	27
5427	Gurupi	27
5428	Ipueiras	27
5429	Itacajá	27
5430	Itaguatins	27
5431	Itapiratins	27
5432	Itaporã do Tocantins	27
5433	Jaú do Tocantins	27
5434	Juarina	27
5435	Lagoa da Confusão	27
5436	Lagoa do Tocantins	27
5437	Lajeado	27
5438	Lavandeira	27
5439	Lizarda	27
5440	Luzinópolis	27
5441	Marianópolis do Tocantins	27
5442	Mateiros	27
5443	Maurilândia do Tocantins	27
5444	Miracema do Tocantins	27
5445	Miranorte	27
5446	Monte do Carmo	27
5447	Monte Santo do Tocantins	27
5448	Muricilândia	27
5449	Natividade	27
5450	Nazaré	27
5451	Nova Olinda	27
5452	Nova Rosalândia	27
5453	Novo Acordo	27
5454	Novo Alegre	27
5455	Novo Jardim	27
5456	Oliveira de Fátima	27
5457	Palmas	27
5458	Palmeirante	27
5459	Palmeiras do Tocantins	27
5460	Palmeirópolis	27
5461	Paraíso do Tocantins	27
5462	Paranã	27
5463	Pau d`Arco	27
5464	Pedro Afonso	27
5465	Peixe	27
5466	Pequizeiro	27
5467	Pindorama do Tocantins	27
5468	Piraquê	27
5469	Pium	27
5470	Ponte Alta do Bom Jesus	27
5471	Ponte Alta do Tocantins	27
5472	Porto Alegre do Tocantins	27
5473	Porto Nacional	27
5474	Praia Norte	27
5475	Presidente Kennedy	27
5476	Pugmil	27
5477	Recursolândia	27
5478	Riachinho	27
5479	Rio da Conceição	27
5480	Rio dos Bois	27
5481	Rio Sono	27
5482	Sampaio	27
5483	Sandolândia	27
5484	Santa Fé do Araguaia	27
5485	Santa Maria do Tocantins	27
5486	Santa Rita do Tocantins	27
5487	Santa Rosa do Tocantins	27
5488	Santa Tereza do Tocantins	27
5489	Santa Terezinha do Tocantins	27
5490	São Bento do Tocantins	27
5491	São Félix do Tocantins	27
5492	São Miguel do Tocantins	27
5493	São Salvador do Tocantins	27
5494	São Sebastião do Tocantins	27
5495	São Valério da Natividade	27
5496	Silvanópolis	27
5497	Sítio Novo do Tocantins	27
5498	Sucupira	27
5499	Taguatinga	27
5500	Taipas do Tocantins	27
5501	Talismã	27
5502	Tocantínia	27
5503	Tocantinópolis	27
5504	Tupirama	27
5505	Tupiratins	27
5506	Wanderlândia	27
5507	Xambioá	27
\.


--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado (id, nome, sigla, pais_id) FROM stdin;
1	Acre	AC	1
2	Alagoas	AL	1
3	Amapá	AP	1
4	Amazonas	AM	1
5	Bahia	BA	1
6	Ceará	CE	1
7	Distrito Federal	DF	1
8	Espírito Santo	ES	1
9	Goiás	GO	1
10	Maranhão	MA	1
11	Mato Grosso	MT	1
12	Mato Grosso do Sul	MS	1
13	Minas Gerais	MG	1
14	Pará	PA	1
15	Paraíba	PB	1
16	Paraná	PR	1
17	Pernambuco	PE	1
18	Piauí	PI	1
19	Rio de Janeiro	RJ	1
20	Rio Grande do Norte	RN	1
21	Rio Grande do Sul	RS	1
22	Rondônia	RO	1
23	Roraima	RR	1
24	Santa Catarina	SC	1
25	São Paulo	SP	1
26	Sergipe	SE	1
27	Tocantins	TO	1
\.


--
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fornecedor (id, nome, descricao, email, telefone, rua, numero, complemento, bairro, cep, ativo, cnpj, celular, cidade_id, estado_id) FROM stdin;
\.


--
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (id, nome, sigla) FROM stdin;
1	Brasil	BR
\.


--
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produto (id, nome, descricao, validade, preco, estoque_minimo, estoque_maximo, quantidade, dt_cadastro, dt_atualizacao, categoria_produto_id, fornecedor_id) FROM stdin;
\.


--
-- Data for Name: system_access_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_access_log (id, sessionid, login, login_time, login_year, login_month, login_day, logout_time, impersonated, access_ip, impersonated_by) FROM stdin;
\.


--
-- Data for Name: system_access_notification_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_access_notification_log (id, login, email, ip_address, login_time) FROM stdin;
\.


--
-- Data for Name: system_change_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_change_log (id, logdate, login, tablename, primarykey, pkvalue, operation, columnname, oldvalue, newvalue, access_ip, transaction_id, log_trace, session_id, class_name, php_sapi, log_year, log_month, log_day) FROM stdin;
\.


--
-- Data for Name: system_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_group (id, name) FROM stdin;
1	Admin
2	Standard
\.


--
-- Data for Name: system_group_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_group_program (id, system_group_id, system_program_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	8
8	1	9
9	1	11
10	1	14
11	1	15
12	2	10
13	2	12
14	2	13
15	2	16
16	2	17
17	2	18
18	2	19
19	2	20
20	1	21
25	1	26
26	1	27
27	1	28
28	1	29
29	2	30
30	1	31
31	1	32
32	1	33
33	1	34
34	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
41	1	41
42	1	42
43	1	43
44	1	44
45	1	45
46	1	46
47	1	47
48	1	48
49	1	49
52	1	52
53	1	53
54	1	54
55	1	55
56	1	56
57	1	57
58	1	58
59	1	59
60	1	60
61	1	61
62	2	54
63	2	60
64	2	43
65	2	44
66	2	45
67	2	46
68	2	47
69	2	48
70	2	49
71	2	55
72	2	56
73	2	61
\.


--
-- Data for Name: system_preference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_preference (id, value) FROM stdin;
mail_from	bisolo.julia@gmail.com
smtp_auth	1
smtp_host	sandbox.smtp.mailtrap.io
smtp_port	2525
smtp_user	0072be5b6abe2e
smtp_pass	1cefd8ab71639c
mail_support	\N
term_policy	\N
\.


--
-- Data for Name: system_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_program (id, name, controller) FROM stdin;
1	System Group Form	SystemGroupForm
2	System Group List	SystemGroupList
3	System Program Form	SystemProgramForm
4	System Program List	SystemProgramList
5	System User Form	SystemUserForm
6	System User List	SystemUserList
7	Common Page	CommonPage
8	System PHP Info	SystemPHPInfoView
9	System ChangeLog View	SystemChangeLogView
10	Welcome View	WelcomeView
11	System Sql Log	SystemSqlLogList
12	System Profile View	SystemProfileView
13	System Profile Form	SystemProfileForm
14	System SQL Panel	SystemSQLPanel
15	System Access Log	SystemAccessLogList
16	System Message Form	SystemMessageForm
17	System Message List	SystemMessageList
18	System Message Form View	SystemMessageFormView
19	System Notification List	SystemNotificationList
20	System Notification Form View	SystemNotificationFormView
21	System Document Category List	SystemDocumentCategoryFormList
26	System Unit Form	SystemUnitForm
27	System Unit List	SystemUnitList
28	System Access stats	SystemAccessLogStats
29	System Preference form	SystemPreferenceForm
30	System Support form	SystemSupportForm
31	System PHP Error	SystemPHPErrorLogView
32	System Database Browser	SystemDatabaseExplorer
33	System Table List	SystemTableList
34	System Data Browser	SystemDataBrowser
35	System Menu Editor	SystemMenuEditor
36	System Request Log	SystemRequestLogList
37	System Request Log View	SystemRequestLogView
38	System Administration Dashboard	SystemAdministrationDashboard
39	System Log Dashboard	SystemLogDashboard
40	System Session dump	SystemSessionDumpView
41	System Information	SystemInformationView
42	System files diff	SystemFilesDiff
43	System Documents	SystemDriveList
44	System Folder form	SystemFolderForm
45	System Share folder	SystemFolderShareForm
46	System Share document	SystemDocumentShareForm
47	System Document properties	SystemDocumentFormWindow
48	System Folder properties	SystemFolderFormView
49	System Document upload	SystemDriveDocumentUploadForm
52	System Post list	SystemPostList
53	System Post form	SystemPostForm
54	Post View list	SystemPostFeedView
55	Post Comment form	SystemPostCommentForm
56	Post Comment list	SystemPostCommentList
57	System Contacts list	SystemContactsList
58	System Wiki list	SystemWikiList
59	System Wiki form	SystemWikiForm
60	System Wiki search	SystemWikiSearchList
61	System Wiki view	SystemWikiView
\.


--
-- Data for Name: system_request_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_request_log (id, endpoint, logdate, log_year, log_month, log_day, session_id, login, access_ip, class_name, http_host, server_port, request_uri, request_method, query_string, request_headers, request_body, request_duration) FROM stdin;
\.


--
-- Data for Name: system_sql_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_sql_log (id, logdate, login, database_name, sql_command, statement_type, access_ip, transaction_id, log_trace, session_id, class_name, php_sapi, request_id, log_year, log_month, log_day) FROM stdin;
\.


--
-- Data for Name: system_unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_unit (id, name, connection_name) FROM stdin;
1	Unit A	unit_a
2	Unit B	unit_b
\.


--
-- Data for Name: system_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_user (id, name, login, password, email, accepted_term_policy, phone, address, function_name, about, accepted_term_policy_at, accepted_term_policy_data, frontpage_id, system_unit_id, active) FROM stdin;
2	User	user	ee11cbb19052e40b07aac0ca060c23ee	user@user.net	N	+123 456 789	User Street, 123	End user	I'm the end user	\N	\N	7	\N	Y
1	admin	admin	21232f297a57a5a743894a0e4a801fc3	bisolo.julia@gmail.com	N	+123 456 789	Admin Street, 123	Administrator	I'm the administrator	\N	\N	10	\N	Y
\.


--
-- Data for Name: system_user_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_user_group (id, system_user_id, system_group_id) FROM stdin;
1	1	1
2	2	2
3	1	2
\.


--
-- Data for Name: system_user_old_password; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_user_old_password (id, system_user_id, password, created_at) FROM stdin;
\.


--
-- Data for Name: system_user_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_user_program (id, system_user_id, system_program_id) FROM stdin;
1	2	7
\.


--
-- Data for Name: system_user_unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_user_unit (id, system_user_id, system_unit_id) FROM stdin;
1	1	1
2	1	2
3	2	1
4	2	2
\.


--
-- Data for Name: tipo_etiqueta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_etiqueta (id, value, template_barcode, template_qrcode) FROM stdin;
1	q	Código: {$id}\r\n{$nome}\r\n#barcode#\r\n           {$barcode}	Código: {$id}\r\n{$nome}\r\n#qrcode#
\.


--
-- Name: categoria_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoria_produto_id_seq', 1, false);


--
-- Name: fornecedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fornecedor_id_seq', 1, false);


--
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produto_id_seq', 1, false);


--
-- Name: tipo_etiqueta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_etiqueta_id_seq', 1, false);


--
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- Name: cidade cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (id);


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id);


--
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- Name: system_access_log system_access_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_access_log
    ADD CONSTRAINT system_access_log_pkey PRIMARY KEY (id);


--
-- Name: system_access_notification_log system_access_notification_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_access_notification_log
    ADD CONSTRAINT system_access_notification_log_pkey PRIMARY KEY (id);


--
-- Name: system_change_log system_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_change_log
    ADD CONSTRAINT system_change_log_pkey PRIMARY KEY (id);


--
-- Name: system_group system_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_group
    ADD CONSTRAINT system_group_pkey PRIMARY KEY (id);


--
-- Name: system_group_program system_group_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_group_program
    ADD CONSTRAINT system_group_program_pkey PRIMARY KEY (id);


--
-- Name: system_program system_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_program
    ADD CONSTRAINT system_program_pkey PRIMARY KEY (id);


--
-- Name: system_request_log system_request_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_request_log
    ADD CONSTRAINT system_request_log_pkey PRIMARY KEY (id);


--
-- Name: system_sql_log system_sql_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_sql_log
    ADD CONSTRAINT system_sql_log_pkey PRIMARY KEY (id);


--
-- Name: system_unit system_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_unit
    ADD CONSTRAINT system_unit_pkey PRIMARY KEY (id);


--
-- Name: system_user_group system_user_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_group
    ADD CONSTRAINT system_user_group_pkey PRIMARY KEY (id);


--
-- Name: system_user_old_password system_user_old_password_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_old_password
    ADD CONSTRAINT system_user_old_password_pkey PRIMARY KEY (id);


--
-- Name: system_user system_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user
    ADD CONSTRAINT system_user_pkey PRIMARY KEY (id);


--
-- Name: system_user_program system_user_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_program
    ADD CONSTRAINT system_user_program_pkey PRIMARY KEY (id);


--
-- Name: system_user_unit system_user_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_unit
    ADD CONSTRAINT system_user_unit_pkey PRIMARY KEY (id);


--
-- Name: tipo_etiqueta tipo_etiqueta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_etiqueta
    ADD CONSTRAINT tipo_etiqueta_pkey PRIMARY KEY (id);


--
-- Name: sys_group_program_group_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_group_program_group_idx ON public.system_group_program USING btree (system_group_id);


--
-- Name: sys_group_program_program_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_group_program_program_idx ON public.system_group_program USING btree (system_program_id);


--
-- Name: sys_user_group_group_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_user_group_group_idx ON public.system_user_group USING btree (system_group_id);


--
-- Name: sys_user_group_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_user_group_user_idx ON public.system_user_group USING btree (system_user_id);


--
-- Name: sys_user_program_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_user_program_idx ON public.system_user USING btree (frontpage_id);


--
-- Name: sys_user_program_program_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_user_program_program_idx ON public.system_user_program USING btree (system_program_id);


--
-- Name: sys_user_program_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sys_user_program_user_idx ON public.system_user_program USING btree (system_user_id);


--
-- Name: cidade fkaee6572470f300d1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cidade
    ADD CONSTRAINT fkaee6572470f300d1 FOREIGN KEY (estado_id) REFERENCES public.estado(id);


--
-- Name: estado fkb2e439664e7910fb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT fkb2e439664e7910fb FOREIGN KEY (pais_id) REFERENCES public.pais(id);


--
-- Name: fornecedor fornecedor_cidade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cidade_id_fkey FOREIGN KEY (cidade_id) REFERENCES public.cidade(id);


--
-- Name: fornecedor fornecedor_estado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_estado_id_fkey FOREIGN KEY (estado_id) REFERENCES public.estado(id);


--
-- Name: produto produto_categoria_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_categoria_produto_id_fkey FOREIGN KEY (categoria_produto_id) REFERENCES public.categoria_produto(id);


--
-- Name: produto produto_fornecedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_fornecedor_id_fkey FOREIGN KEY (fornecedor_id) REFERENCES public.fornecedor(id);


--
-- Name: system_group_program system_group_program_system_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_group_program
    ADD CONSTRAINT system_group_program_system_group_id_fkey FOREIGN KEY (system_group_id) REFERENCES public.system_group(id);


--
-- Name: system_group_program system_group_program_system_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_group_program
    ADD CONSTRAINT system_group_program_system_program_id_fkey FOREIGN KEY (system_program_id) REFERENCES public.system_program(id);


--
-- Name: system_user system_user_frontpage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user
    ADD CONSTRAINT system_user_frontpage_id_fkey FOREIGN KEY (frontpage_id) REFERENCES public.system_program(id);


--
-- Name: system_user_group system_user_group_system_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_group
    ADD CONSTRAINT system_user_group_system_group_id_fkey FOREIGN KEY (system_group_id) REFERENCES public.system_group(id);


--
-- Name: system_user_group system_user_group_system_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_group
    ADD CONSTRAINT system_user_group_system_user_id_fkey FOREIGN KEY (system_user_id) REFERENCES public.system_user(id);


--
-- Name: system_user_old_password system_user_old_password_system_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_old_password
    ADD CONSTRAINT system_user_old_password_system_user_id_fkey FOREIGN KEY (system_user_id) REFERENCES public.system_user(id);


--
-- Name: system_user_program system_user_program_system_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_program
    ADD CONSTRAINT system_user_program_system_program_id_fkey FOREIGN KEY (system_program_id) REFERENCES public.system_program(id);


--
-- Name: system_user_program system_user_program_system_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_program
    ADD CONSTRAINT system_user_program_system_user_id_fkey FOREIGN KEY (system_user_id) REFERENCES public.system_user(id);


--
-- Name: system_user system_user_system_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user
    ADD CONSTRAINT system_user_system_unit_id_fkey FOREIGN KEY (system_unit_id) REFERENCES public.system_unit(id);


--
-- Name: system_user_unit system_user_unit_system_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_unit
    ADD CONSTRAINT system_user_unit_system_unit_id_fkey FOREIGN KEY (system_unit_id) REFERENCES public.system_unit(id);


--
-- Name: system_user_unit system_user_unit_system_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_user_unit
    ADD CONSTRAINT system_user_unit_system_user_id_fkey FOREIGN KEY (system_user_id) REFERENCES public.system_user(id);


--
-- PostgreSQL database dump complete
--

