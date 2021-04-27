--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-04-27 09:57:25

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

--
-- TOC entry 211 (class 1255 OID 16404)
-- Name: changestatus(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.changestatus()
    LANGUAGE sql
    AS $$
UPDATE youcoders
SET is_accepted  = true
WHERE campus  = 'Youssoufia'
$$;


ALTER PROCEDURE public.changestatus() OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16465)
-- Name: countall(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.countall() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;

BEGIN
SELECT COUNT(*) INTO n FROM youcodersv2;



return n;

END
$$;


ALTER FUNCTION public.countall() OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16411)
-- Name: emp_stamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.emp_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       UPDATE youcoders SET is_accepted = false;
	   RETURN NEW;
    END;
$$;


ALTER FUNCTION public.emp_stamp() OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 16466)
-- Name: lasttg(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.lasttg() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
       UPDATE youcodersv2 SET nbr_competence  = 15;
       RETURN NEW;
    END;
$$;


ALTER FUNCTION public.lasttg() OWNER TO postgres;

--
-- TOC entry 208 (class 1255 OID 16401)
-- Name: nbyoucoders(character varying, boolean, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;
BEGIN
SELECT COUNT(*) INTO n FROM youcoders where is_accepted=status and campus = ville;
IF n < seuil THEN
RAISE EXCEPTION 'Trop de rattrapage (%) !', n;
ELSE
RETURN n;
END IF;
END
$$;


ALTER FUNCTION public.nbyoucoders(ville character varying, status boolean, seuil integer) OWNER TO postgres;

--
-- TOC entry 209 (class 1255 OID 16402)
-- Name: percetage(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.percetage(total integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
n INTEGER;
pe NUMERIC;
BEGIN
SELECT COUNT(*) INTO n FROM youcoders where campus='Youssoufia' and classe = 'FEBE';

pe = (total * n)/100;

return pe;

END
$$;


ALTER FUNCTION public.percetage(total integer) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 16403)
-- Name: stsameref(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.stsameref(student character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
sClasse VARCHAR;
n INTEGER;

BEGIN
SELECT classe INTO sClasse FROM youcoders where full_name=student;

SELECT COUNT(*) INTO n FROM youcoders where classe=sClasse;




return n;

END
$$;


ALTER FUNCTION public.stsameref(student character varying) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16407)
-- Name: updateclasse(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.updateclasse()
    LANGUAGE sql
    AS $$
UPDATE youcoders
SET classe  = 'DATA BI'
WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;


ALTER PROCEDURE public.updateclasse() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16416)
-- Name: campus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campus (
    id integer NOT NULL,
    campusname character varying(15) NOT NULL
);


ALTER TABLE public.campus OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16414)
-- Name: campus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campus_id_seq OWNER TO postgres;

--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 201
-- Name: campus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campus_id_seq OWNED BY public.campus.id;


--
-- TOC entry 204 (class 1259 OID 16424)
-- Name: classe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classe (
    id integer NOT NULL,
    classename character varying(15) NOT NULL
);


ALTER TABLE public.classe OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16422)
-- Name: classe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classe_id_seq OWNER TO postgres;

--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 203
-- Name: classe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classe_id_seq OWNED BY public.classe.id;


--
-- TOC entry 206 (class 1259 OID 16432)
-- Name: referentiel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referentiel (
    id integer NOT NULL,
    referentielname character varying(15) NOT NULL
);


ALTER TABLE public.referentiel OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16430)
-- Name: referentiel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referentiel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.referentiel_id_seq OWNER TO postgres;

--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 205
-- Name: referentiel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referentiel_id_seq OWNED BY public.referentiel.id;


--
-- TOC entry 200 (class 1259 OID 16395)
-- Name: youcoders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.youcoders (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus character varying(15) NOT NULL,
    classe character varying(15) NOT NULL,
    referentiel character varying(15) NOT NULL,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);


ALTER TABLE public.youcoders OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16444)
-- Name: youcodersv2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.youcodersv2 (
    matricule character varying(4) NOT NULL,
    full_name character varying(15) NOT NULL,
    campus integer,
    classe integer,
    referentiel integer,
    nbr_competence numeric(5,0) DEFAULT 0,
    is_accepted boolean
);


ALTER TABLE public.youcodersv2 OWNER TO postgres;

--
-- TOC entry 2879 (class 2604 OID 16419)
-- Name: campus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campus ALTER COLUMN id SET DEFAULT nextval('public.campus_id_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 16427)
-- Name: classe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classe ALTER COLUMN id SET DEFAULT nextval('public.classe_id_seq'::regclass);


--
-- TOC entry 2881 (class 2604 OID 16435)
-- Name: referentiel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referentiel ALTER COLUMN id SET DEFAULT nextval('public.referentiel_id_seq'::regclass);


--
-- TOC entry 3030 (class 0 OID 16416)
-- Dependencies: 202
-- Data for Name: campus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campus (id, campusname) FROM stdin;
1	Agadir
\.


--
-- TOC entry 3032 (class 0 OID 16424)
-- Dependencies: 204
-- Data for Name: classe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classe (id, classename) FROM stdin;
1	NodeJS /React
\.


--
-- TOC entry 3034 (class 0 OID 16432)
-- Dependencies: 206
-- Data for Name: referentiel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referentiel (id, referentielname) FROM stdin;
1	CAD
\.


--
-- TOC entry 3028 (class 0 OID 16395)
-- Dependencies: 200
-- Data for Name: youcoders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.youcoders (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
P765	Mohammed ahmed	Safi	JEE	DWWM	15	f
P980	Don Reda	Safi	JEE	DWWM	15	f
P307	Zakaria zakaria	Safi	FEBE	CDA	15	f
P199	Omar omar	Safi	JEE	AI	15	f
P387	Houssam houssam	Safi	FEBE	CDA	15	f
P400	KAMAL BHF	Youssoufia	FEBE	CDA	15	f
P543	Salma Salma	Youssoufia	C#	AI	15	f
P566	Imane imane	Youssoufia	FEBE	CDA	15	f
P122	Amine amine	Safi	DATA BI	CDA	15	f
P202	Yassine yassine	Youssoufia	DATA BI	CDA	15	f
P189	BELCAID	Youssoufia	FEBE	CDA	15	f
\.


--
-- TOC entry 3035 (class 0 OID 16444)
-- Dependencies: 207
-- Data for Name: youcodersv2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.youcodersv2 (matricule, full_name, campus, classe, referentiel, nbr_competence, is_accepted) FROM stdin;
P420	KAMAL BHF	1	1	1	15	t
P189	BELCAID	1	1	1	15	t
P129	abdo	1	1	1	15	t
\.


--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 201
-- Name: campus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.campus_id_seq', 1, false);


--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 203
-- Name: classe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classe_id_seq', 1, false);


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 205
-- Name: referentiel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referentiel_id_seq', 1, false);


--
-- TOC entry 2886 (class 2606 OID 16421)
-- Name: campus campus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campus
    ADD CONSTRAINT campus_pkey PRIMARY KEY (id);


--
-- TOC entry 2888 (class 2606 OID 16429)
-- Name: classe classe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classe
    ADD CONSTRAINT classe_pkey PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 16437)
-- Name: referentiel referentiel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referentiel
    ADD CONSTRAINT referentiel_pkey PRIMARY KEY (id);


--
-- TOC entry 2884 (class 2606 OID 16400)
-- Name: youcoders youcoders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcoders
    ADD CONSTRAINT youcoders_pkey PRIMARY KEY (matricule);


--
-- TOC entry 2892 (class 2606 OID 16449)
-- Name: youcodersv2 youcodersv2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT youcodersv2_pkey PRIMARY KEY (matricule);


--
-- TOC entry 2896 (class 2620 OID 16412)
-- Name: youcoders emp_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER emp_stamp AFTER INSERT ON public.youcoders FOR EACH ROW EXECUTE FUNCTION public.emp_stamp();


--
-- TOC entry 2897 (class 2620 OID 16467)
-- Name: youcodersv2 lasttg; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER lasttg AFTER INSERT ON public.youcodersv2 FOR EACH ROW EXECUTE FUNCTION public.lasttg();


--
-- TOC entry 2893 (class 2606 OID 16450)
-- Name: youcodersv2 fk_campus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT fk_campus FOREIGN KEY (campus) REFERENCES public.campus(id);


--
-- TOC entry 2894 (class 2606 OID 16455)
-- Name: youcodersv2 fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT fk_classe FOREIGN KEY (classe) REFERENCES public.classe(id);


--
-- TOC entry 2895 (class 2606 OID 16460)
-- Name: youcodersv2 fk_referentiel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.youcodersv2
    ADD CONSTRAINT fk_referentiel FOREIGN KEY (referentiel) REFERENCES public.referentiel(id);


-- Completed on 2021-04-27 09:57:26

--
-- PostgreSQL database dump complete
--

