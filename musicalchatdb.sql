--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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
-- Name: emit_messages(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.emit_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 PERFORM pg_notify('new_messages',row_to_json(NEW)::text);
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.emit_messages() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id character varying NOT NULL,
    from_user_id character varying NOT NULL,
    to_user_id character varying NOT NULL,
    message character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    status character varying(10)
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: song_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.song_stats (
    user_id character varying(100),
    top_artists text[],
    top_genre text[]
);


ALTER TABLE public.song_stats OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id character varying(100) NOT NULL,
    spotify_id character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    sex character(2) NOT NULL,
    dob character varying(100) NOT NULL,
    age integer NOT NULL,
    phone_num character varying(20) NOT NULL,
    registration_date character varying(100) NOT NULL,
    profile_pic_url character varying(100),
    last_loggedin timestamp without time zone,
    last_seen timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, from_user_id, to_user_id, message, created_at, status) FROM stdin;
ce396fa326f95191d3aa	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hello mum	2023-07-28 20:37:01	read
testid	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:23:45	read
testid1	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid2	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid3	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid4	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid5	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid6	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid7	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
testid8	sdhjkhsd	hsjhas	this is a test msg	2022-08-21 11:24:45	read
kjfdkljfdfff	hjsfdhjhfjsehhdsjkhsdo	d5ef385b06c0ec9efe82	hello there	2023-07-25 22:32:39	read
236d1c2b4c4be657b1fa	2fc7cc79fba55c27fd90	680375fce4	hello	2023-07-27 20:35:50	read
cc5cb8ee7e0768003683	2fc7cc79fba55c27fd90	680375fce4	hello t	2023-07-27 20:36:35	read
12716d9b7414f0d3523a	2fc7cc79fba55c27fd90	680375fce4	tello	2023-07-27 20:47:28	read
7cc5e01e12359f018ef4	2fc7cc79fba55c27fd90	680375fce4	that	2023-07-27 20:48:14	read
1642fac3cba196856c46	2fc7cc79fba55c27fd90	92228ed03d	hello	2023-07-27 20:49:33	read
262ae268fc9fa238959c	2fc7cc79fba55c27fd90	011d8a76a0	hello	2023-07-28 08:44:18	read
sdhfjfhdsjhjhdsjk	011d8a76a0	2fc7cc79fba55c27fd90	hello	2023-07-28 08:45:50.596622	read
c13af16657e5802f8ab1	2fc7cc79fba55c27fd90	011d8a76a0	hii	2023-07-28 08:49:52	read
69fd3b29a3a5e5b62f12	2fc7cc79fba55c27fd90	011d8a76a0	hii bhai tu kaisa h all ok , all fine na how's it's going are u ok , if needed any help let me know 🙏 so even i can help u out	2023-07-28 08:51:27	read
6b8fde3fdcaa8e09f6d3	2fc7cc79fba55c27fd90	011d8a76a0	hii once again	2023-07-28 09:43:48	read
fcb6ad525a1a0d41d015	2fc7cc79fba55c27fd90	011d8a76a0	hello	2023-07-28 09:45:09	read
d45a3beb200adc69cebc	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hii	2023-07-28 09:50:03	read
431761b82dc760888e5e	cf508e88910f094bf154	2fc7cc79fba55c27fd90	hii	2023-07-28 09:56:28	read
63a8a9aba2516b7f61c7	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hii	2023-07-28 10:37:39	read
e10ca8c166969bd7bf60	2fc7cc79fba55c27fd90	cf508e88910f094bf154	how are u	2023-07-28 10:37:48	read
3f171c00502dc432ad0f	cf508e88910f094bf154	2fc7cc79fba55c27fd90	fine	2023-07-28 10:37:58	read
c6c7a99d66ea20b15638	cf508e88910f094bf154	2fc7cc79fba55c27fd90	wbu	2023-07-28 10:38:03	read
e872cdd55e048e32205c	cf508e88910f094bf154	2fc7cc79fba55c27fd90	how's it's going	2023-07-28 10:38:16	read
6dff6e00955739385aaf	2fc7cc79fba55c27fd90	cf508e88910f094bf154	cccchfjgkgkjcjfjjffjfjfbcbxfhfbcbdjdhxbcbcjgjcncbgjfcjcbhdhdbdvdhdhdhdhdhdgdgdgdvdhfchhfhfbchxhcncbchxbcbxbxbcbcncncncbcncjfjfbxbxbcbcbfbfhfbxbxbc	2023-07-28 10:40:45	read
efcd8f9ec4113e3f4f2c	cf508e88910f094bf154	2fc7cc79fba55c27fd90	gggujgvvggggggggggggujgvvggggggggggggujgvvggggggggggggujgvvggggggggggggujgvvggggggggggggujgvvggggggggggggujgvvggggggggggggujgvvggggggggggggujgvvggggggggg	2023-07-28 10:41:58	read
sdhfjfhdsjhjhdsjkdd	cf508e88910f094bf154	2fc7cc79fba55c27fd90	sjkfld	2023-07-28 17:53:33.930058	read
kjfdkljfdgvb	cf508e88910f094bf154	2fc7cc79fba55c27fd90	hello therevv	2023-07-28 17:57:50.649017	read
kjfdkljfdfffvbbvv	cf508e88910f094bf154	2fc7cc79fba55c27fd90	hellovbbbb	2023-07-28 18:14:55.413236	read
6555a3a73d8c47c39597	2fc7cc79fba55c27fd90	cf508e88910f094bf154	uum	2023-07-28 20:37:36	read
afb7a1929698cc542d82	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hiii	2023-07-28 20:30:08	read
c70a34b4a68dc26c4aca	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hii once	2023-07-28 20:31:22	read
68c3c0eacb481fbdb7ed	2fc7cc79fba55c27fd90	fea5992e4d	hii there	2023-07-28 20:36:00	pending
d5af4cc8546a6c071df2	2fc7cc79fba55c27fd90	cf508e88910f094bf154	jddj	2023-07-28 20:38:37	read
a96dc69ba3db44395c84	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hello	2023-07-28 20:36:36	read
bbc7aa05fb242800014e	2fc7cc79fba55c27fd90	cf508e88910f094bf154	tummls	2023-07-28 20:41:02	read
152129a066d700e40aa1	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hjgf	2023-07-28 21:25:19	read
6592d0dbbb25aa162df8	cf508e88910f094bf154	2fc7cc79fba55c27fd90	uts	2023-07-29 17:33:09	read
12cbf4fb8b83e0240d51	cf508e88910f094bf154	2fc7cc79fba55c27fd90	hello there	2023-07-29 17:27:17	read
88a71e628a93841aae23	cf508e88910f094bf154	2fc7cc79fba55c27fd90	how's going??	2023-07-29 17:28:25	read
2131589ec890f974efa3	cf508e88910f094bf154	2fc7cc79fba55c27fd90	tss	2023-07-29 17:34:07	read
becfcafc20b12ab40011	2fc7cc79fba55c27fd90	cf508e88910f094bf154	hmm	2023-07-29 17:39:09	read
5bceababaa20b946c044	2fc7cc79fba55c27fd90	cf508e88910f094bf154	all fine	2023-07-29 17:29:06	read
7915fca68f240dc0c3db	cf508e88910f094bf154	2fc7cc79fba55c27fd90	tere	2023-07-29 17:31:45	read
fb5e43e944f9b4dc0400	2fc7cc79fba55c27fd90	cf508e88910f094bf154	shmm	2023-07-29 17:40:24	read
\.


--
-- Data for Name: song_stats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.song_stats (user_id, top_artists, top_genre) FROM stdin;
011d8a76a0	{"Artist 1","Artist 9","Artist 10","Artist 3","Artist 5"}	{"Genre 3","Genre 1","Genre 9","Genre 2","Genre 8"}
0194084bb5	{"Artist 8","Artist 6","Artist 4","Artist 7","Artist 9"}	{"Genre 10","Genre 9","Genre 2","Genre 4","Genre 5"}
03b933b5d1	{"Artist 2","Artist 10","Artist 1","Artist 5","Artist 8"}	{"Genre 8","Genre 1","Genre 2","Genre 10","Genre 5"}
03edd6320a	{"Artist 10","Artist 6","Artist 9","Artist 7","Artist 1"}	{"Genre 5","Genre 10","Genre 1","Genre 4","Genre 2"}
0d743fa627	{"Artist 3","Artist 6","Artist 9","Artist 10","Artist 4"}	{"Genre 7","Genre 9","Genre 4","Genre 8","Genre 10"}
0f50831520	{"Artist 10","Artist 6","Artist 3","Artist 2","Artist 1"}	{"Genre 3","Genre 6","Genre 7","Genre 5","Genre 8"}
11236beecb	{"Artist 3","Artist 4","Artist 7","Artist 8","Artist 2"}	{"Genre 2","Genre 7","Genre 3","Genre 9","Genre 10"}
13db2cb188	{"Artist 2","Artist 8","Artist 3","Artist 7","Artist 6"}	{"Genre 6","Genre 4","Genre 1","Genre 2","Genre 9"}
15959652d4	{"Artist 4","Artist 1","Artist 5","Artist 2","Artist 9"}	{"Genre 5","Genre 8","Genre 9","Genre 1","Genre 3"}
1b6f405212	{"Artist 5","Artist 10","Artist 4","Artist 9","Artist 1"}	{"Genre 9","Genre 1","Genre 6","Genre 8","Genre 2"}
1c6285440b	{"Artist 2","Artist 10","Artist 8","Artist 9","Artist 7"}	{"Genre 2","Genre 5","Genre 7","Genre 10","Genre 8"}
1c9efa1ce1	{"Artist 2","Artist 10","Artist 8","Artist 9","Artist 5"}	{"Genre 2","Genre 10","Genre 1","Genre 4","Genre 7"}
1e1d3fb4cd	{"Artist 8","Artist 1","Artist 4","Artist 2","Artist 5"}	{"Genre 7","Genre 6","Genre 2","Genre 10","Genre 3"}
210e3a9317	{"Artist 10","Artist 3","Artist 7","Artist 9","Artist 5"}	{"Genre 7","Genre 3","Genre 1","Genre 5","Genre 8"}
216b38b81c	{"Artist 8","Artist 1","Artist 7","Artist 6","Artist 3"}	{"Genre 4","Genre 10","Genre 2","Genre 3","Genre 9"}
251ea35038	{"Artist 1","Artist 10","Artist 8","Artist 3","Artist 5"}	{"Genre 9","Genre 3","Genre 8","Genre 5","Genre 10"}
2621d34e03	{"Artist 8","Artist 6","Artist 5","Artist 7","Artist 3"}	{"Genre 5","Genre 3","Genre 8","Genre 1","Genre 2"}
29ead0e320	{"Artist 2","Artist 5","Artist 4","Artist 3","Artist 7"}	{"Genre 6","Genre 8","Genre 1","Genre 10","Genre 9"}
2a202467ed	{"Artist 8","Artist 5","Artist 3","Artist 10","Artist 7"}	{"Genre 10","Genre 6","Genre 8","Genre 9","Genre 3"}
2e805c658e	{"Artist 7","Artist 9","Artist 3","Artist 2","Artist 8"}	{"Genre 6","Genre 9","Genre 7","Genre 2","Genre 1"}
2f6fc00ad5	{"Artist 6","Artist 5","Artist 8","Artist 2","Artist 7"}	{"Genre 8","Genre 2","Genre 1","Genre 10","Genre 3"}
2f7894b002	{"Artist 4","Artist 10","Artist 7","Artist 9","Artist 2"}	{"Genre 4","Genre 8","Genre 9","Genre 2","Genre 1"}
318a03cb56	{"Artist 1","Artist 2","Artist 8","Artist 7","Artist 10"}	{"Genre 7","Genre 6","Genre 5","Genre 10","Genre 1"}
375cdf3841	{"Artist 1","Artist 3","Artist 8","Artist 9","Artist 4"}	{"Genre 10","Genre 1","Genre 8","Genre 9","Genre 6"}
38a114ad2b	{"Artist 1","Artist 10","Artist 9","Artist 7","Artist 8"}	{"Genre 9","Genre 7","Genre 3","Genre 6","Genre 1"}
3a7c630fc1	{"Artist 1","Artist 7","Artist 5","Artist 8","Artist 6"}	{"Genre 8","Genre 10","Genre 2","Genre 6","Genre 9"}
3bfca4e544	{"Artist 2","Artist 4","Artist 6","Artist 10","Artist 8"}	{"Genre 9","Genre 5","Genre 2","Genre 8","Genre 10"}
3ca6d53ce5	{"Artist 10","Artist 6","Artist 4","Artist 5","Artist 8"}	{"Genre 9","Genre 2","Genre 7","Genre 8","Genre 6"}
3cae61e33b	{"Artist 9","Artist 4","Artist 2","Artist 6","Artist 8"}	{"Genre 4","Genre 9","Genre 7","Genre 8","Genre 2"}
3d03f63d68	{"Artist 1","Artist 3","Artist 2","Artist 9","Artist 6"}	{"Genre 4","Genre 6","Genre 1","Genre 3","Genre 7"}
3f624e2d2f	{"Artist 7","Artist 1","Artist 3","Artist 6","Artist 9"}	{"Genre 9","Genre 4","Genre 7","Genre 3","Genre 2"}
422fdf9c6a	{"Artist 9","Artist 4","Artist 8","Artist 3","Artist 1"}	{"Genre 1","Genre 8","Genre 5","Genre 3","Genre 10"}
428ce70160	{"Artist 7","Artist 3","Artist 6","Artist 8","Artist 1"}	{"Genre 2","Genre 9","Genre 8","Genre 3","Genre 6"}
435bc2ead1	{"Artist 7","Artist 8","Artist 6","Artist 9","Artist 3"}	{"Genre 2","Genre 6","Genre 1","Genre 8","Genre 7"}
4785d44c98	{"Artist 5","Artist 1","Artist 2","Artist 8","Artist 10"}	{"Genre 8","Genre 9","Genre 3","Genre 10","Genre 1"}
496420c266	{"Artist 7","Artist 9","Artist 3","Artist 2","Artist 8"}	{"Genre 3","Genre 8","Genre 5","Genre 4","Genre 10"}
4b51cb34ee	{"Artist 10","Artist 1","Artist 8","Artist 7","Artist 3"}	{"Genre 6","Genre 1","Genre 8","Genre 2","Genre 10"}
4c9433fc14	{"Artist 2","Artist 5","Artist 7","Artist 3","Artist 1"}	{"Genre 3","Genre 2","Genre 4","Genre 1","Genre 5"}
4f274fa1a0	{"Artist 10","Artist 2","Artist 6","Artist 8","Artist 5"}	{"Genre 8","Genre 1","Genre 4","Genre 3","Genre 7"}
4f5e424eea	{"Artist 2","Artist 4","Artist 6","Artist 7","Artist 1"}	{"Genre 6","Genre 2","Genre 7","Genre 1","Genre 5"}
5176977962	{"Artist 5","Artist 6","Artist 9","Artist 7","Artist 8"}	{"Genre 2","Genre 8","Genre 1","Genre 7","Genre 9"}
5315d8a327	{"Artist 10","Artist 3","Artist 6","Artist 4","Artist 5"}	{"Genre 4","Genre 5","Genre 6","Genre 3","Genre 2"}
5744ed423f	{"Artist 3","Artist 9","Artist 4","Artist 8","Artist 6"}	{"Genre 8","Genre 1","Genre 6","Genre 3","Genre 5"}
5ece219dda	{"Artist 8","Artist 5","Artist 2","Artist 10","Artist 9"}	{"Genre 9","Genre 3","Genre 5","Genre 8","Genre 6"}
64feeca0cf	{"Artist 5","Artist 3","Artist 8","Artist 2","Artist 10"}	{"Genre 5","Genre 9","Genre 6","Genre 7","Genre 4"}
674b00fc76	{"Artist 6","Artist 1","Artist 3","Artist 5","Artist 7"}	{"Genre 2","Genre 10","Genre 6","Genre 5","Genre 8"}
680375fce4	{"Artist 10","Artist 7","Artist 3","Artist 4","Artist 1"}	{"Genre 1","Genre 7","Genre 2","Genre 8","Genre 6"}
68d4323720	{"Artist 1","Artist 9","Artist 3","Artist 4","Artist 6"}	{"Genre 2","Genre 9","Genre 8","Genre 6","Genre 7"}
6a287a3231	{"Artist 7","Artist 10","Artist 2","Artist 4","Artist 5"}	{"Genre 1","Genre 2","Genre 9","Genre 6","Genre 8"}
6bba12bb9b	{"Artist 9","Artist 5","Artist 10","Artist 6","Artist 8"}	{"Genre 2","Genre 9","Genre 8","Genre 4","Genre 6"}
6bce7747b8	{"Artist 4","Artist 3","Artist 5","Artist 1","Artist 6"}	{"Genre 2","Genre 7","Genre 10","Genre 4","Genre 9"}
79d14cb038	{"Artist 10","Artist 2","Artist 4","Artist 5","Artist 6"}	{"Genre 3","Genre 8","Genre 5","Genre 7","Genre 1"}
7db26cb186	{"Artist 5","Artist 7","Artist 1","Artist 8","Artist 9"}	{"Genre 8","Genre 4","Genre 5","Genre 7","Genre 3"}
823e251b88	{"Artist 1","Artist 8","Artist 6","Artist 7","Artist 4"}	{"Genre 1","Genre 9","Genre 8","Genre 5","Genre 6"}
82d1634a1c	{"Artist 10","Artist 8","Artist 5","Artist 7","Artist 9"}	{"Genre 6","Genre 1","Genre 8","Genre 10","Genre 5"}
84086a5196	{"Artist 9","Artist 10","Artist 7","Artist 5","Artist 8"}	{"Genre 1","Genre 9","Genre 10","Genre 2","Genre 5"}
84cc74ea8f	{"Artist 5","Artist 10","Artist 9","Artist 8","Artist 4"}	{"Genre 8","Genre 9","Genre 10","Genre 2","Genre 6"}
8dd7e2ccdf	{"Artist 4","Artist 6","Artist 10","Artist 1","Artist 7"}	{"Genre 9","Genre 5","Genre 4","Genre 3","Genre 7"}
92228ed03d	{"Artist 6","Artist 4","Artist 10","Artist 8","Artist 2"}	{"Genre 9","Genre 2","Genre 5","Genre 1","Genre 10"}
950179d584	{"Artist 10","Artist 1","Artist 9","Artist 6","Artist 5"}	{"Genre 8","Genre 1","Genre 6","Genre 5","Genre 2"}
9527cfec0e	{"Artist 8","Artist 7","Artist 3","Artist 1","Artist 9"}	{"Genre 10","Genre 1","Genre 6","Genre 7","Genre 8"}
95cfabf474	{"Artist 4","Artist 5","Artist 2","Artist 9","Artist 1"}	{"Genre 8","Genre 1","Genre 9","Genre 10","Genre 2"}
97cf6bbeb9	{"Artist 1","Artist 8","Artist 9","Artist 6","Artist 10"}	{"Genre 1","Genre 6","Genre 2","Genre 5","Genre 10"}
97db58ab53	{"Artist 2","Artist 8","Artist 9","Artist 7","Artist 5"}	{"Genre 2","Genre 5","Genre 10","Genre 8","Genre 3"}
981cb6a3bf	{"Artist 8","Artist 2","Artist 5","Artist 7","Artist 6"}	{"Genre 4","Genre 2","Genre 3","Genre 8","Genre 1"}
997867d01f	{"Artist 9","Artist 4","Artist 5","Artist 6","Artist 2"}	{"Genre 2","Genre 7","Genre 8","Genre 6","Genre 3"}
9c44f4cfee	{"Artist 10","Artist 4","Artist 9","Artist 6","Artist 3"}	{"Genre 7","Genre 3","Genre 4","Genre 2","Genre 8"}
9d52855647	{"Artist 5","Artist 1","Artist 9","Artist 7","Artist 2"}	{"Genre 10","Genre 8","Genre 2","Genre 6","Genre 5"}
a069bab80f	{"Artist 5","Artist 2","Artist 6","Artist 3","Artist 8"}	{"Genre 3","Genre 2","Genre 7","Genre 8","Genre 4"}
a6d51edf16	{"Artist 7","Artist 9","Artist 4","Artist 2","Artist 10"}	{"Genre 8","Genre 10","Genre 9","Genre 2","Genre 1"}
a8879c3b47	{"Artist 2","Artist 7","Artist 10","Artist 1","Artist 5"}	{"Genre 9","Genre 4","Genre 6","Genre 10","Genre 3"}
ab85b6ef2a	{"Artist 8","Artist 3","Artist 1","Artist 6","Artist 5"}	{"Genre 2","Genre 10","Genre 3","Genre 5","Genre 9"}
ad04dc1c8c	{"Artist 9","Artist 8","Artist 3","Artist 10","Artist 7"}	{"Genre 5","Genre 9","Genre 7","Genre 4","Genre 8"}
afcb89b6c6	{"Artist 10","Artist 1","Artist 7","Artist 2","Artist 3"}	{"Genre 6","Genre 3","Genre 9","Genre 1","Genre 10"}
b52f937876	{"Artist 8","Artist 7","Artist 4","Artist 9","Artist 3"}	{"Genre 4","Genre 7","Genre 8","Genre 5","Genre 10"}
b8dfae089f	{"Artist 6","Artist 7","Artist 10","Artist 4","Artist 1"}	{"Genre 9","Genre 5","Genre 4","Genre 2","Genre 8"}
bc930e9888	{"Artist 6","Artist 7","Artist 10","Artist 5","Artist 8"}	{"Genre 10","Genre 7","Genre 4","Genre 5","Genre 2"}
c056a363ac	{"Artist 6","Artist 9","Artist 8","Artist 3","Artist 7"}	{"Genre 8","Genre 9","Genre 2","Genre 7","Genre 1"}
c27ad333f6	{"Artist 4","Artist 2","Artist 9","Artist 7","Artist 10"}	{"Genre 1","Genre 2","Genre 9","Genre 7","Genre 3"}
c2eb4411f2	{"Artist 3","Artist 4","Artist 5","Artist 1","Artist 2"}	{"Genre 5","Genre 7","Genre 6","Genre 2","Genre 10"}
c578e35738	{"Artist 9","Artist 1","Artist 6","Artist 8","Artist 2"}	{"Genre 4","Genre 10","Genre 8","Genre 7","Genre 9"}
c73aa4cf70	{"Artist 1","Artist 9","Artist 7","Artist 3","Artist 6"}	{"Genre 10","Genre 6","Genre 1","Genre 4","Genre 7"}
cb47456ece	{"Artist 1","Artist 3","Artist 10","Artist 9","Artist 7"}	{"Genre 9","Genre 8","Genre 4","Genre 2","Genre 6"}
cc4631835b	{"Artist 6","Artist 4","Artist 10","Artist 7","Artist 1"}	{"Genre 9","Genre 1","Genre 7","Genre 5","Genre 2"}
cd9139e172	{"Artist 5","Artist 8","Artist 4","Artist 3","Artist 7"}	{"Genre 5","Genre 1","Genre 8","Genre 2","Genre 3"}
cdd5d7d745	{"Artist 4","Artist 2","Artist 3","Artist 5","Artist 9"}	{"Genre 1","Genre 5","Genre 6","Genre 10","Genre 2"}
ce3f56a9a5	{"Artist 5","Artist 1","Artist 6","Artist 4","Artist 8"}	{"Genre 6","Genre 5","Genre 9","Genre 10","Genre 7"}
cf733cc8f6	{"Artist 7","Artist 6","Artist 5","Artist 1","Artist 8"}	{"Genre 8","Genre 5","Genre 10","Genre 2","Genre 3"}
d0b1159ad4	{"Artist 6","Artist 9","Artist 3","Artist 4","Artist 2"}	{"Genre 7","Genre 4","Genre 8","Genre 9","Genre 10"}
d667655c41	{"Artist 5","Artist 8","Artist 4","Artist 3","Artist 6"}	{"Genre 8","Genre 4","Genre 3","Genre 2","Genre 9"}
d87fd90ef4	{"Artist 4","Artist 5","Artist 3","Artist 9","Artist 10"}	{"Genre 10","Genre 1","Genre 3","Genre 6","Genre 2"}
db16f85e53	{"Artist 6","Artist 3","Artist 1","Artist 10","Artist 5"}	{"Genre 1","Genre 8","Genre 4","Genre 7","Genre 10"}
dc134f203e	{"Artist 1","Artist 5","Artist 10","Artist 7","Artist 3"}	{"Genre 3","Genre 2","Genre 5","Genre 6","Genre 4"}
e66d7c1ff5	{"Artist 10","Artist 5","Artist 3","Artist 4","Artist 7"}	{"Genre 5","Genre 3","Genre 2","Genre 7","Genre 9"}
f4990feff7	{"Artist 10","Artist 9","Artist 8","Artist 5","Artist 1"}	{"Genre 2","Genre 6","Genre 10","Genre 9","Genre 3"}
f563163829	{"Artist 8","Artist 7","Artist 9","Artist 4","Artist 6"}	{"Genre 7","Genre 8","Genre 6","Genre 4","Genre 9"}
f7ad65b6cf	{"Artist 4","Artist 1","Artist 9","Artist 10","Artist 8"}	{"Genre 6","Genre 5","Genre 2","Genre 7","Genre 3"}
f836595061	{"Artist 8","Artist 2","Artist 10","Artist 5","Artist 3"}	{"Genre 10","Genre 1","Genre 5","Genre 9","Genre 3"}
faeb43bec3	{"Artist 4","Artist 6","Artist 3","Artist 8","Artist 1"}	{"Genre 9","Genre 4","Genre 7","Genre 3","Genre 10"}
fea5992e4d	{"Artist 10","Artist 4","Artist 2","Artist 1","Artist 8"}	{"Genre 5","Genre 4","Genre 8","Genre 1","Genre 7"}
cf508e88910f094bf154	{}	{}
41b5bd97651b4c643e95	{artists1}	{genre1}
8026888ab16be74b94c0	{artists1}	{genre1}
7d51dc6ba0b9314e9a7d	{artists1}	{genre1}
aa189440b60e97ea91cb	{artists1}	{genre1}
d5ef385b06c0ec9efe82	{artists1}	{genre1}
2fc7cc79fba55c27fd90	{"Talha Anjum",KR$NA,Sanam,"French The Kid",Raahi}	{"desi hip hop","hindi hip hop","pakistani hip hop","urdu hip hop","desi trap","desi pop","chill drill","melodic drill","uk hip hop"}
006de1bb9c3a39ccfee9	{artists1}	{genre1}
924d29af7272e711b415	{artists1}	{genre1}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, spotify_id, first_name, last_name, sex, dob, age, phone_num, registration_date, profile_pic_url, last_loggedin, last_seen) FROM stdin;
680375fce4	795aa86326524f5	First1	Last1	F 	1992-06-23	23	9739867237	04/11/2022	\N	\N	\N
496420c266	785e196d20f8cea	First2	Last2	F 	1998-12-25	27	9406802671	23/11/2022	\N	\N	\N
f836595061	969e2df83a68e07	First3	Last3	M 	1997-04-03	24	9068508664	04/12/2022	\N	\N	\N
84cc74ea8f	87018374c736176	First4	Last4	F 	1990-07-31	30	9082757649	17/06/2022	\N	\N	\N
cf733cc8f6	bad19414318b262	First5	Last5	M 	1991-05-02	23	9126595123	18/04/2022	\N	\N	\N
4785d44c98	91b758a13da1c2b	First6	Last6	F 	1997-08-12	25	9732699835	09/08/2022	\N	\N	\N
4f5e424eea	134f14606fc99b2	First7	Last7	M 	1993-07-25	24	9917073447	05/01/2022	\N	\N	\N
3bfca4e544	717cd348f794525	First8	Last8	M 	1994-06-29	31	9261662952	08/05/2022	\N	\N	\N
1c9efa1ce1	e74e27ed911cad1	First9	Last9	F 	1997-07-14	29	9130100264	20/12/2022	\N	\N	\N
8dd7e2ccdf	37b42f49c42dc69	First10	Last10	M 	1993-11-17	22	9680232722	26/02/2022	\N	\N	\N
dc134f203e	3e3b2fc9d5a99cd	First11	Last11	F 	1998-11-15	25	9323892792	18/05/2022	\N	\N	\N
375cdf3841	c66416cd7ed8040	First12	Last12	F 	1996-05-18	22	9211336055	01/10/2022	\N	\N	\N
216b38b81c	30ffd6dda7e91cf	First13	Last13	M 	1996-06-20	30	9308573385	28/07/2022	\N	\N	\N
f7ad65b6cf	20f88e6b4c0f489	First14	Last14	M 	1995-08-15	29	9113898407	11/10/2022	\N	\N	\N
82d1634a1c	3dc282e854de702	First15	Last15	F 	1993-05-15	30	9869315886	25/09/2022	\N	\N	\N
7db26cb186	e70da54586ea737	First16	Last16	F 	1995-08-05	25	9707059586	04/07/2022	\N	\N	\N
e66d7c1ff5	084aa709ca99ca6	First17	Last17	M 	1995-03-03	25	9773952784	12/04/2022	\N	\N	\N
c73aa4cf70	a3c8cbf22d81a68	First18	Last18	M 	1990-09-27	26	9487319167	20/07/2022	\N	\N	\N
bc930e9888	73e3e98fc893d08	First19	Last19	M 	1997-02-27	26	9344535035	15/12/2022	\N	\N	\N
5315d8a327	03eb44b5941e99d	First20	Last20	M 	1998-10-20	33	9313968238	03/07/2022	\N	\N	\N
cc4631835b	84de357c0f9c99f	First21	Last21	M 	1993-08-08	28	9206611525	15/04/2022	\N	\N	\N
674b00fc76	8f608c4903535fa	First22	Last22	F 	1996-05-06	31	9324172010	24/07/2022	\N	\N	\N
64feeca0cf	06d6d7c6b4c9a96	First23	Last23	F 	2000-05-16	24	9326004414	04/04/2022	\N	\N	\N
6bba12bb9b	2425cc2f7232e46	First24	Last24	F 	1998-06-01	27	9341032340	26/11/2022	\N	\N	\N
3ca6d53ce5	f09691f4d2703ce	First25	Last25	F 	2000-12-25	27	9467602594	02/03/2022	\N	\N	\N
251ea35038	f0594b209a46c4c	First26	Last26	F 	1997-04-18	28	9137237432	29/05/2022	\N	\N	\N
2621d34e03	4a5d8de9f742f9c	First27	Last27	F 	1999-12-10	24	9093368764	23/05/2022	\N	\N	\N
b8dfae089f	3286e1dab88f911	First28	Last28	M 	1994-11-25	26	9894646131	19/02/2022	\N	\N	\N
9527cfec0e	2e02ba2ba9b08ea	First29	Last29	M 	1992-04-28	31	9603186672	27/12/2022	\N	\N	\N
a6d51edf16	655bc0e5dca08c3	First30	Last30	F 	1999-11-08	32	9804233025	01/05/2022	\N	\N	\N
435bc2ead1	7ccd47c45fb254f	First31	Last31	F 	1998-06-02	30	9954372089	13/05/2022	\N	\N	\N
03edd6320a	b10dd7081a69276	First32	Last32	F 	1990-07-16	33	9678670859	08/07/2022	\N	\N	\N
13db2cb188	b75838626c3f7a2	First33	Last33	M 	1999-11-03	32	9342391626	20/07/2022	\N	\N	\N
a069bab80f	6fda795099c09e6	First34	Last34	F 	1995-02-17	22	9197083255	10/03/2022	\N	\N	\N
981cb6a3bf	07ce31488179c83	First35	Last35	F 	1997-03-01	27	9762143199	12/09/2022	\N	\N	\N
422fdf9c6a	13062fae373e1c9	First36	Last36	M 	1998-04-01	30	9470557676	05/11/2022	\N	\N	\N
c2eb4411f2	8b49165960da5b8	First37	Last37	F 	2000-03-23	28	9960380020	08/08/2022	\N	\N	\N
03b933b5d1	f50405ae8c51918	First38	Last38	M 	1998-11-23	25	9315405071	25/08/2022	\N	\N	\N
6a287a3231	d4f1f31f716415c	First39	Last39	M 	1998-11-26	31	9206194520	09/01/2022	\N	\N	\N
950179d584	435b2f4d60dea1f	First40	Last40	M 	1991-01-02	23	9067104668	13/03/2022	\N	\N	\N
318a03cb56	ca47d02313c0bab	First41	Last41	F 	1999-09-18	30	9255118127	04/03/2022	\N	\N	\N
d667655c41	35bb03a7cb6b463	First42	Last42	M 	1996-06-25	31	9142205461	04/01/2022	\N	\N	\N
5ece219dda	a2b86840b87d916	First43	Last43	F 	2000-10-07	28	9821873201	25/07/2022	\N	\N	\N
97db58ab53	534768694dfbd42	First44	Last44	M 	1995-10-20	26	9810802598	19/04/2022	\N	\N	\N
c578e35738	eb094b0a81ffbb0	First45	Last45	M 	1990-07-10	29	9999031076	27/07/2022	\N	\N	\N
428ce70160	6568594441cf678	First46	Last46	M 	2000-04-11	23	9809013004	29/10/2022	\N	\N	\N
2f6fc00ad5	23fe01ee9d23839	First47	Last47	M 	2000-11-11	24	9881327627	24/04/2022	\N	\N	\N
79d14cb038	5cfec9c8df28c62	First48	Last48	M 	2000-10-01	28	9903505910	02/08/2022	\N	\N	\N
d0b1159ad4	4e51c1261ac5a63	First49	Last49	F 	1994-12-05	26	9099641958	12/06/2022	\N	\N	\N
1c6285440b	998aaf780d3db58	First50	Last50	M 	1995-03-26	30	9482141566	16/10/2022	\N	\N	\N
4c9433fc14	1b9aeb1fa3083ea	First51	Last51	F 	1993-01-06	25	9924589950	15/05/2022	\N	\N	\N
97cf6bbeb9	ec3292583f541e9	First52	Last52	M 	1999-03-09	29	9441701231	12/01/2022	\N	\N	\N
84086a5196	5cb99007058fa80	First53	Last53	F 	1998-10-05	31	9329941605	29/06/2022	\N	\N	\N
2f7894b002	68a834d22c45ac4	First54	Last54	F 	1995-11-01	31	9468204368	20/11/2022	\N	\N	\N
3cae61e33b	f75fdb453d4041e	First55	Last55	F 	1995-01-03	25	9398015773	28/03/2022	\N	\N	\N
b52f937876	0890aa07bc9cb50	First56	Last56	F 	1994-12-08	24	9112345776	23/05/2022	\N	\N	\N
15959652d4	188dd16cf24b1ed	First57	Last57	F 	1994-09-18	28	9030691250	15/12/2022	\N	\N	\N
68d4323720	61d75f220f22bfc	First58	Last58	F 	1990-08-07	22	9895595291	18/01/2022	\N	\N	\N
9d52855647	9cde6cbc133e3b0	First59	Last59	F 	1996-12-21	33	9036881975	09/04/2022	\N	\N	\N
1b6f405212	af1ada095a2dda7	First60	Last60	F 	1993-12-23	25	9383367787	21/11/2022	\N	\N	\N
fea5992e4d	9243473347b2141	First61	Last61	F 	2000-09-03	26	9184438121	31/10/2022	\N	\N	\N
92228ed03d	7793575e5aa1df6	First62	Last62	M 	1990-07-24	28	9120673624	14/01/2022	\N	\N	\N
011d8a76a0	c8064e3e8be0c9c	First63	Last63	F 	1996-10-05	27	9466392094	08/04/2022	\N	\N	\N
c056a363ac	9d8f18e15f1a684	First64	Last64	M 	1995-11-29	27	9027209186	10/01/2022	\N	\N	\N
2e805c658e	192707df429b634	First65	Last65	M 	1990-06-19	23	9253814178	15/04/2022	\N	\N	\N
f563163829	4e78727001f54ca	First66	Last66	F 	1990-11-13	33	9353354154	08/02/2022	\N	\N	\N
1e1d3fb4cd	435dc23094ee29e	First67	Last67	F 	1996-12-04	31	9465094760	15/07/2022	\N	\N	\N
5744ed423f	2636bcc4c7038e5	First68	Last68	F 	1992-01-19	22	9389131963	03/05/2022	\N	\N	\N
cd9139e172	0991853adec8cee	First69	Last69	F 	1999-12-29	26	9044332212	07/10/2022	\N	\N	\N
5176977962	e77420eb6a90c3f	First70	Last70	M 	1991-06-05	28	9612328775	13/01/2022	\N	\N	\N
0d743fa627	e005aab160df5fc	First71	Last71	M 	1992-10-18	26	9176293962	13/12/2022	\N	\N	\N
95cfabf474	89c39f64176f377	First72	Last72	F 	1999-09-05	32	9344869512	03/08/2022	\N	\N	\N
afcb89b6c6	803c00a8f4485fc	First73	Last73	F 	1998-07-26	31	9296860596	04/09/2022	\N	\N	\N
ce3f56a9a5	ea715224e5a85b4	First74	Last74	M 	1991-02-10	27	9583891761	24/09/2022	\N	\N	\N
4b51cb34ee	a162747c0203e87	First75	Last75	M 	1994-05-01	33	9045688052	19/04/2022	\N	\N	\N
faeb43bec3	bc073ea9c9b5f7d	First76	Last76	F 	1996-06-22	28	9640792440	16/08/2022	\N	\N	\N
ad04dc1c8c	69c69b992d3d320	First77	Last77	F 	1999-02-24	32	9688840957	04/12/2022	\N	\N	\N
2a202467ed	53b4357f667b98d	First78	Last78	F 	1997-03-28	32	9124436118	14/01/2022	\N	\N	\N
997867d01f	a70454ffe2fc92b	First79	Last79	M 	1992-06-16	31	9592983314	27/10/2022	\N	\N	\N
0194084bb5	dfc2827700933ee	First80	Last80	F 	2000-07-07	27	9716062966	13/04/2022	\N	\N	\N
cb47456ece	b9328aa96bf7ea7	First81	Last81	F 	1995-06-30	23	9550352891	27/05/2022	\N	\N	\N
6bce7747b8	d2cc2586b198cc4	First82	Last82	F 	1992-11-15	24	9524222589	27/02/2022	\N	\N	\N
0f50831520	2f7a4486cb3361b	First83	Last83	M 	1995-01-26	24	9037161029	02/02/2022	\N	\N	\N
210e3a9317	4ee8cb6c2035dd0	First84	Last84	M 	1990-03-09	23	9743777724	19/11/2022	\N	\N	\N
3d03f63d68	498da2ae500118a	First85	Last85	M 	2000-05-16	24	9201643558	25/09/2022	\N	\N	\N
823e251b88	fd24f88ec1c6940	First86	Last86	M 	1997-01-16	28	9438649987	20/11/2022	\N	\N	\N
a8879c3b47	8e88d4a2773b1f9	First87	Last87	M 	1993-07-07	30	9323571183	14/02/2022	\N	\N	\N
11236beecb	9fe231fc72b7329	First88	Last88	M 	1992-05-15	33	9071815793	09/10/2022	\N	\N	\N
c27ad333f6	1b0061fca398b2d	First89	Last89	F 	1992-06-15	33	9380930023	27/01/2022	\N	\N	\N
db16f85e53	928d0aac885da8b	First90	Last90	F 	1994-10-07	25	9659482291	17/02/2022	\N	\N	\N
d87fd90ef4	cc1aafb6c789dde	First91	Last91	M 	1999-04-08	22	9728927442	20/01/2022	\N	\N	\N
9c44f4cfee	b45344fd8ee60a5	First92	Last92	F 	1999-09-04	32	9359657172	10/05/2022	\N	\N	\N
4f274fa1a0	4df0d3ab9f5fb38	First93	Last93	F 	1992-04-15	24	9679086707	07/08/2022	\N	\N	\N
29ead0e320	c0497caffb7e7d7	First94	Last94	F 	1992-05-23	28	9720175046	14/12/2022	\N	\N	\N
f4990feff7	b27987212e4c613	First95	Last95	F 	1990-05-10	22	9609372758	12/08/2022	\N	\N	\N
cdd5d7d745	df559822470475e	First96	Last96	F 	1996-03-27	23	9703879429	06/08/2022	\N	\N	\N
38a114ad2b	f7c667114df0de0	First97	Last97	M 	1996-12-11	33	9435362161	13/05/2022	\N	\N	\N
ab85b6ef2a	3011b2fd9a2a64a	First98	Last98	M 	1997-03-27	26	9281550141	01/09/2022	\N	\N	\N
3a7c630fc1	6510bdf58e11fd2	First99	Last99	M 	2000-12-10	23	9753896204	02/02/2022	\N	\N	\N
3f624e2d2f	71506e5cf06e1fa	First100	Last100	F 	1999-01-09	25	9269616938	30/11/2022	\N	\N	\N
41b5bd97651b4c643e95	ghdghd	vishal	pandey	M 	2003-08-15	22	7858905864	18/08/24	\N	\N	\N
8026888ab16be74b94c0	"hdjsfhjkhfsdjkhjsfdkhjksdf	vishal	pandey	M 	2003-08-15	20	64989645896	18/08/24	\N	\N	\N
7d51dc6ba0b9314e9a7d	"hdjsfhjkhfsdjkhjsfdkhjksdf	vishal	pandey	M 	2003-08-15	20	64989645896	18/08/24	\N	\N	\N
aa189440b60e97ea91cb	"hdjsfhjkhfsdjkhjsfdkhjksdf	vishal	pandey	M 	2003-08-15	20	64989645896	18/08/24	uploads\\profile_pic\\profile_pic-1689438377271.png	\N	\N
006de1bb9c3a39ccfee9	"hdjsfhjkhfsdjkhjsfdkhjksdf	vishal	pandey	M 	15/08/2003	20	64989645896	18/08/24	http://192.168.0.105:9000/uploads\\profile_pic\\profile_pic-1689865892480.png	\N	\N
924d29af7272e711b415	"hdjsfhjkhfsdjkhjsfdkhjksdf	vishal	pandey	M 	15/08/2003	20	64989645896	18/08/24	https://192.168.0.105:9000/uploads\\profile_pic\\updated_profile_pic-1689867881489.png	\N	\N
cf508e88910f094bf154	31y4kygx6eisxhctycpz2u7hlpxq	sunita	pandey	F 	7/11/1980	42	9464648434	28/7/2023	http://192.168.0.105:9000/uploads\\profile_pic\\profile_pic-1690516765965.jpeg	2023-07-29 17:35:23	2023-07-29 17:41:22
2fc7cc79fba55c27fd90	31im3yhurv5d235cwokq6qq7b3hu	vishal	gg	M 	15/8/2003	19	9739867233	20/7/2023	http://192.168.0.105:9000/uploads\\profile_pic\\updated_profile_pic-1689870920108.png	2023-07-29 18:04:08	2023-07-29 18:11:23
d5ef385b06c0ec9efe82	"hdjsfhjkhfsdjkhjsfdkhjksdf	vishal	pandey	M 	2003-08-15	20	64989645896	18/08/24	http://192.168.0.105:9000/uploads\\profile_pic\\profile_pic-1689503051677.png	\N	2023-07-25 22:34:51
\.


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: users users_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id UNIQUE (id);


--
-- Name: messages emit_new_message; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER emit_new_message AFTER INSERT ON public.messages FOR EACH ROW EXECUTE FUNCTION public.emit_messages();


--
-- Name: messages emit_new_messages; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER emit_new_messages AFTER INSERT ON public.messages FOR EACH ROW EXECUTE FUNCTION public.emit_messages();


--
-- Name: song_stats fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song_stats
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

