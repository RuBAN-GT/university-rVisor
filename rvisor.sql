--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.10
-- Dumped by pg_dump version 9.4.0
-- Started on 2016-01-19 14:36:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 184 (class 3079 OID 11791)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2066 (class 0 OID 0)
-- Dependencies: 184
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 177 (class 1259 OID 25193)
-- Name: pages; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    title character varying,
    content character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying,
    parent_id integer
);


ALTER TABLE pages OWNER TO "rVisor";

--
-- TOC entry 176 (class 1259 OID 25191)
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: rVisor
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pages_id_seq OWNER TO "rVisor";

--
-- TOC entry 2067 (class 0 OID 0)
-- Dependencies: 176
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rVisor
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- TOC entry 183 (class 1259 OID 25332)
-- Name: passages; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE passages (
    id integer NOT NULL,
    comment character varying,
    clicks character varying[],
    test_id integer,
    participant_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE passages OWNER TO "rVisor";

--
-- TOC entry 182 (class 1259 OID 25330)
-- Name: passages_id_seq; Type: SEQUENCE; Schema: public; Owner: rVisor
--

CREATE SEQUENCE passages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE passages_id_seq OWNER TO "rVisor";

--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 182
-- Name: passages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rVisor
--

ALTER SEQUENCE passages_id_seq OWNED BY passages.id;


--
-- TOC entry 174 (class 1259 OID 25177)
-- Name: roles; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


ALTER TABLE roles OWNER TO "rVisor";

--
-- TOC entry 173 (class 1259 OID 25175)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: rVisor
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_id_seq OWNER TO "rVisor";

--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 173
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rVisor
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- TOC entry 175 (class 1259 OID 25187)
-- Name: roles_users; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE roles_users (
    role_id integer,
    user_id integer
);


ALTER TABLE roles_users OWNER TO "rVisor";

--
-- TOC entry 170 (class 1259 OID 25151)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO "rVisor";

--
-- TOC entry 179 (class 1259 OID 25276)
-- Name: services; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE services (
    id integer NOT NULL,
    slug character varying,
    name character varying,
    info character varying,
    secret_key character varying,
    public_key character varying,
    owner_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE services OWNER TO "rVisor";

--
-- TOC entry 178 (class 1259 OID 25274)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: rVisor
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE services_id_seq OWNER TO "rVisor";

--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 178
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rVisor
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- TOC entry 181 (class 1259 OID 25287)
-- Name: tests; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE tests (
    id integer NOT NULL,
    name character varying,
    info character varying,
    service_id integer,
    owner_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    picture_file_name character varying,
    picture_content_type character varying,
    picture_file_size integer,
    picture_updated_at timestamp without time zone
);


ALTER TABLE tests OWNER TO "rVisor";

--
-- TOC entry 180 (class 1259 OID 25285)
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: rVisor
--

CREATE SEQUENCE tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tests_id_seq OWNER TO "rVisor";

--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 180
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rVisor
--

ALTER SEQUENCE tests_id_seq OWNED BY tests.id;


--
-- TOC entry 172 (class 1259 OID 25160)
-- Name: users; Type: TABLE; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    author_id integer
);


ALTER TABLE users OWNER TO "rVisor";

--
-- TOC entry 171 (class 1259 OID 25158)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: rVisor
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO "rVisor";

--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 171
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rVisor
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1915 (class 2604 OID 25196)
-- Name: id; Type: DEFAULT; Schema: public; Owner: rVisor
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- TOC entry 1918 (class 2604 OID 25335)
-- Name: id; Type: DEFAULT; Schema: public; Owner: rVisor
--

ALTER TABLE ONLY passages ALTER COLUMN id SET DEFAULT nextval('passages_id_seq'::regclass);


--
-- TOC entry 1913 (class 2604 OID 25180)
-- Name: id; Type: DEFAULT; Schema: public; Owner: rVisor
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- TOC entry 1916 (class 2604 OID 25279)
-- Name: id; Type: DEFAULT; Schema: public; Owner: rVisor
--

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- TOC entry 1917 (class 2604 OID 25290)
-- Name: id; Type: DEFAULT; Schema: public; Owner: rVisor
--

ALTER TABLE ONLY tests ALTER COLUMN id SET DEFAULT nextval('tests_id_seq'::regclass);


--
-- TOC entry 1908 (class 2604 OID 25163)
-- Name: id; Type: DEFAULT; Schema: public; Owner: rVisor
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- TOC entry 2052 (class 0 OID 25193)
-- Dependencies: 177
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY pages (id, title, content, created_at, updated_at, slug, parent_id) FROM stdin;
14	О проекте	<div class="ui items">\r\n<div class="item"><img class="circular image ui" src="https://s.gravatar.com/avatar/b9131011b2f299186b07397d4979e78f?s=90" />\r\n<div class="content"><a class="header" href="https://vk.com/dkruban">Дмитрий Рубан</a>\r\n<div class="description">\r\n<p>Веб-программист</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n	2016-01-04 19:44:21.358177	2016-01-04 20:25:45.631772	about	\N
\.


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 176
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rVisor
--

SELECT pg_catalog.setval('pages_id_seq', 17, true);


--
-- TOC entry 2058 (class 0 OID 25332)
-- Dependencies: 183
-- Data for Name: passages; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY passages (id, comment, clicks, test_id, participant_id, created_at, updated_at) FROM stdin;
5	Хорошая бобросова!	{"0.512,0.451","0.512,0.451","0.503,0.454","0.503,0.454","0.3,0.567","0.3,0.567","0.797,0.639","0.797,0.639","0.894,0.335","0.894,0.335","0.376,0.177","0.376,0.177","0.481,0.254","0.481,0.254","0.509,0.356","0.509,0.356","0.511,0.461","0.511,0.461","0.511,0.461","0.511,0.461","0.511,0.461","0.511,0.461"}	1	1	2016-01-16 20:11:42.421017	2016-01-16 20:11:42.421017
6		{"0.477,0.481","0.51,0.402","0.51,0.402","0.304,0.927","0.565,0.764","0.551,0.272","0.628,0.276"}	1	12	2016-01-16 20:41:09.536663	2016-01-16 20:41:09.536663
7		{"0.517,0.473","0.622,0.474","0.565,0.509","0.562,0.545","0.596,0.58"}	3	1	2016-01-17 00:20:21.718204	2016-01-17 00:20:21.718204
8		{"0.285,0.004"}	3	1	2016-01-17 00:27:54.012446	2016-01-17 00:27:54.012446
9		{"0.586,0.5","0.586,0.5","0.586,0.5","0.586,0.5","0.586,0.5","0.586,0.5","0.586,0.5","0.586,0.5","0.585,0.501","0.585,0.501","0.572,0.515","0.572,0.515","0.567,0.526","0.567,0.526","0.567,0.526","0.567,0.526","0.543,0.482","0.543,0.482","0.543,0.482","0.543,0.482","0.54,0.478","0.54,0.478","0.54,0.478","0.54,0.478"}	3	1	2016-01-17 00:28:45.064629	2016-01-17 00:28:45.064629
10		{"0.548,0.475","0.548,0.475","0.548,0.475","0.62,0.472","0.62,0.472","0.62,0.472","0.548,0.509","0.548,0.509","0.548,0.509","0.569,0.54","0.569,0.54","0.569,0.54","0.569,0.555","0.569,0.555","0.569,0.555","0.571,0.569","0.571,0.569","0.571,0.569","0.626,0.651","0.626,0.651","0.626,0.651","0.764,0.651","0.764,0.651","0.764,0.651","0.833,0.516","0.833,0.516","0.833,0.516"}	3	1	2016-01-17 13:03:47.689286	2016-01-17 13:03:47.689286
11		{"0.528,0.477","0.601,0.472","0.578,0.499","0.58,0.572","0.651,0.517","0.519,0.518"}	3	12	2016-01-18 10:37:36.118609	2016-01-18 10:37:36.118609
\.


--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 182
-- Name: passages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rVisor
--

SELECT pg_catalog.setval('passages_id_seq', 11, true);


--
-- TOC entry 2049 (class 0 OID 25177)
-- Dependencies: 174
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY roles (id, name, created_at, updated_at) FROM stdin;
2	super_admin	2015-12-28 00:45:55.535962	\N
\.


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 173
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rVisor
--

SELECT pg_catalog.setval('roles_id_seq', 2, true);


--
-- TOC entry 2050 (class 0 OID 25187)
-- Dependencies: 175
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY roles_users (role_id, user_id) FROM stdin;
2	1
2	12
\.


--
-- TOC entry 2045 (class 0 OID 25151)
-- Dependencies: 170
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY schema_migrations (version) FROM stdin;
20151226222346
20151226231459
20151226231508
20160101132635
20160101134124
20160103001655
20160108230955
20160109225144
20160110160735
20160111150340
\.


--
-- TOC entry 2054 (class 0 OID 25276)
-- Dependencies: 179
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY services (id, slug, name, info, secret_key, public_key, owner_id, created_at, updated_at) FROM stdin;
4	test	Тестовый сервис	Сервис для всякий страшных операций.	NRCHzTDtRzLuzRhdbNNRsw	U58MBjVOKLhcQBcnATcMDw	1	2016-01-09 21:59:37.165824	2016-01-09 22:10:16.221843
\.


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 178
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rVisor
--

SELECT pg_catalog.setval('services_id_seq', 4, true);


--
-- TOC entry 2056 (class 0 OID 25287)
-- Dependencies: 181
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY tests (id, name, info, service_id, owner_id, created_at, updated_at, picture_file_name, picture_content_type, picture_file_size, picture_updated_at) FROM stdin;
3	Нахождение сообществ	Найдите раздел Сообщества с социальными ссылками.	0	1	2016-01-17 00:18:59.371559	2016-01-17 00:18:59.371559	Сайт_Факультета_компьютерных_наук_ВГУ.png	image/png	1630395	2016-01-17 00:18:59.011765
1	Главный	Найдите морду бобросовы.	4	1	2016-01-10 18:13:47.618737	2016-01-17 11:09:44.837354	Bobrosov.jpg	image/jpeg	111214	2016-01-11 12:50:43.42268
\.


--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 180
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rVisor
--

SELECT pg_catalog.setval('tests_id_seq', 3, true);


--
-- TOC entry 2047 (class 0 OID 25160)
-- Dependencies: 172
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: rVisor
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, created_at, updated_at, author_id) FROM stdin;
12	test@test.test	$2a$10$UKHvYEjsrUrANZ8A.nBWF.EXOVC4aLH7BgcM6zX2KDkqo0q4on7S2	\N	\N	\N	3	2016-01-18 10:37:09.241504	2016-01-16 20:40:31.930773	62.76.168.252	46.164.236.248	\N	2016-01-11 12:52:00.261963	\N	\N	0	\N	\N	2016-01-11 12:52:00.263586	2016-01-18 10:37:09.242408	\N
1	dkruban@gmail.com	$2a$10$gpzqL3lzvmxHRzWRs0V8w.DmJyUPtWKPRla9iS99sdU1b4Auuf8D6	9ac7cb89182d31ea8c07584c9981b307ac9ac1c0c4b17899635c7b1289ccd590	2015-12-28 17:36:40.227154	2016-01-11 12:50:26.147443	69	2016-01-19 10:26:54.802384	2016-01-18 09:54:40.221581	91.202.25.53	217.118.95.103	y6AmkJNN3UaLhytCN3tD	2015-12-26 23:58:30.145307	2015-12-26 23:44:04.483775	\N	0	\N	\N	2015-12-26 23:44:04.323865	2016-01-19 10:26:54.803314	\N
\.


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 171
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rVisor
--

SELECT pg_catalog.setval('users_id_seq', 12, true);


--
-- TOC entry 1931 (class 2606 OID 25201)
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: rVisor; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- TOC entry 1937 (class 2606 OID 25340)
-- Name: passages_pkey; Type: CONSTRAINT; Schema: public; Owner: rVisor; Tablespace: 
--

ALTER TABLE ONLY passages
    ADD CONSTRAINT passages_pkey PRIMARY KEY (id);


--
-- TOC entry 1927 (class 2606 OID 25185)
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: rVisor; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 1933 (class 2606 OID 25284)
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: rVisor; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 25295)
-- Name: tests_pkey; Type: CONSTRAINT; Schema: public; Owner: rVisor; Tablespace: 
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- TOC entry 1924 (class 2606 OID 25172)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: rVisor; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 1928 (class 1259 OID 25207)
-- Name: index_pages_on_parent_id; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE INDEX index_pages_on_parent_id ON pages USING btree (parent_id);


--
-- TOC entry 1929 (class 1259 OID 25202)
-- Name: index_pages_on_slug; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE UNIQUE INDEX index_pages_on_slug ON pages USING btree (slug);


--
-- TOC entry 1925 (class 1259 OID 25186)
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE UNIQUE INDEX index_roles_on_name ON roles USING btree (name);


--
-- TOC entry 1920 (class 1259 OID 25209)
-- Name: index_users_on_author_id; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE INDEX index_users_on_author_id ON users USING btree (author_id);


--
-- TOC entry 1921 (class 1259 OID 25173)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- TOC entry 1922 (class 1259 OID 25174)
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- TOC entry 1919 (class 1259 OID 25157)
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: rVisor; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- TOC entry 2065 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-01-19 14:36:46

--
-- PostgreSQL database dump complete
--

