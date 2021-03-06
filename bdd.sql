﻿--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

--
-- Name: fonction; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE fonction AS ENUM (
    'com',
    'tech'
);


ALTER TYPE public.fonction OWNER TO postgres;

--
-- Name: type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE type AS ENUM (
    'rep',
    'ent'
);


ALTER TYPE public.type OWNER TO postgres;

--
-- Name: check_entreprise_entretien(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION check_entreprise_entretien() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE ent type;
BEGIN

        SELECT type INTO ent
	FROM ENTREPRISE;

	IF ent != 'entretien' THEN
	RAISE EXCEPTION 'mauvaise entreprise';
        END IF;
    END;
$$;


ALTER FUNCTION public.check_entreprise_entretien() OWNER TO postgres;

--
-- Name: check_entreprise_rep(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION check_entreprise_rep() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE ent type;
BEGIN

        SELECT type INTO ent
	FROM ENTREPRISE;

	IF ent != 'reparation' THEN
	RAISE EXCEPTION 'mauvaise entreprise';
        END IF;
    END;
$$;


ALTER FUNCTION public.check_entreprise_rep() OWNER TO postgres;

--
-- Name: checkid_com(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkid_com() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE fu fonction;
BEGIN

        SELECT function INTO fu
	FROM EMPLOYE;

	IF fu != 'com' THEN
	RAISE EXCEPTION 'id-employe mauvais';
        END IF;
    END;
$$;


ALTER FUNCTION public.checkid_com() OWNER TO postgres;

--
-- Name: checkid_combis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkid_combis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE fu fonction;
BEGIN

        SELECT function INTO fu
	FROM EMPLOYE;

	IF fu != 'tech' THEN
	RAISE EXCEPTION 'id-employe mauvais';
        END IF;
    END;
$$;


ALTER FUNCTION public.checkid_combis() OWNER TO postgres;

--
-- Name: checkid_tech(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION checkid_tech() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE fu fonction;
BEGIN

        SELECT function INTO fu
	FROM EMPLOYE;

	IF fu != 'tech' THEN
	RAISE EXCEPTION 'id-employe mauvais';
        END IF;
    END;
$$;


ALTER FUNCTION public.checkid_tech() OWNER TO postgres;

--
-- Name: verif_contrat_loc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verif_contrat_loc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	IF NEW.function != 'tech' THEN
	RAISE EXCEPTION 'id-employe mauvais';
        END IF;
    END;
$$;


ALTER FUNCTION public.verif_contrat_loc() OWNER TO postgres;

--
-- Name: verif_contrat_locbis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verif_contrat_locbis() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	IF EMPLOYE.function != 'tech' THEN
	RAISE EXCEPTION 'id-employe mauvais';
        END IF;
    END;
$$;


ALTER FUNCTION public.verif_contrat_locbis() OWNER TO postgres;

--
-- Name: verif_loc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION verif_loc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	IF NEW.function != tech THEN
	RAISE EXCEPTION 'id-employe mauvais';
        END IF;
    END;
$$;


ALTER FUNCTION public.verif_loc() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agence; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE agence (
    nom_agence character varying(25) NOT NULL
);


ALTER TABLE public.agence OWNER TO postgres;

--
-- Name: apparaitre; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE apparaitre (
    id_conducteur integer NOT NULL,
    id_liste integer NOT NULL
);


ALTER TABLE public.apparaitre OWNER TO postgres;

--
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categorie (
    nom_categorie character varying(10) NOT NULL
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE client (
    id_client integer NOT NULL,
    date_inscription timestamp without time zone,
    password_gestion_compte character varying(25)
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: comporter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comporter (
    numero_immatriculation character varying(10) NOT NULL,
    nom_option character varying(25)
);


ALTER TABLE public.comporter OWNER TO postgres;

--
-- Name: conducteur; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conducteur (
    id_conducteur integer NOT NULL,
    nom character varying(25),
    prenom character varying(25),
    copie_permis integer
);


ALTER TABLE public.conducteur OWNER TO postgres;

--
-- Name: contrat_de_location; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contrat_de_location (
    num_contrat integer NOT NULL,
    date_debut_loc timestamp without time zone,
    date_fin_loc timestamp without time zone,
    degats_eventuels_initiaux text,
    km_initial integer,
    niveau_carb_initial integer,
    seuil_km integer,
    cb_presentee boolean,
    id_employe integer NOT NULL,
    id_facture integer NOT NULL
);


ALTER TABLE public.contrat_de_location OWNER TO postgres;

--
-- Name: editer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE editer (
    id_employe integer NOT NULL,
    id_facture integer NOT NULL
);


ALTER TABLE public.editer OWNER TO postgres;

--
-- Name: employe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE employe (
    id_employe integer NOT NULL,
    nom_agence character varying(25) NOT NULL,
    function fonction
);


ALTER TABLE public.employe OWNER TO postgres;

--
-- Name: entreprise; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE entreprise (
    nom_entreprise character varying(25) NOT NULL,
    type type,
    nom_agence character varying(25)
);


ALTER TABLE public.entreprise OWNER TO postgres;

--
-- Name: entretien; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE entretien (
    id_entretien integer NOT NULL,
    prix real,
    numero_immatriculation character varying(10),
    nom_entreprise character varying(25)
);


ALTER TABLE public.entretien OWNER TO postgres;

--
-- Name: facture; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE facture (
    id_facture integer NOT NULL,
    date_reglement timestamp without time zone,
    montant real,
    moyen_de_paiement character varying(25)
);


ALTER TABLE public.facture OWNER TO postgres;

--
-- Name: faire_appel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE faire_appel (
    nom_agence character varying(25) NOT NULL,
    nom_entreprise character varying(25) NOT NULL
);


ALTER TABLE public.faire_appel OWNER TO postgres;

--
-- Name: gerer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gerer (
    id_employe integer NOT NULL,
    id_location integer NOT NULL,
    validation_finale_isdone boolean
);


ALTER TABLE public.gerer OWNER TO postgres;

--
-- Name: gerer_parc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gerer_parc (
    id_employe integer NOT NULL,
    numero_immatriculation character varying(10) NOT NULL
);


ALTER TABLE public.gerer_parc OWNER TO postgres;

--
-- Name: liste_conducteurs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE liste_conducteurs (
    id_liste integer NOT NULL,
    id_pro integer NOT NULL,
    id_location integer NOT NULL
);


ALTER TABLE public.liste_conducteurs OWNER TO postgres;

--
-- Name: location; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE location (
    id_location integer NOT NULL,
    id_client integer NOT NULL,
    num_contrat integer NOT NULL,
    numero_immatriculation character varying(10) NOT NULL
);


ALTER TABLE public.location OWNER TO postgres;

--
-- Name: modele; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE modele (
    nom_modele character varying(25) NOT NULL,
    nom_categorie character varying(10) NOT NULL,
    nb_portes integer NOT NULL,
    boite_vitesse character varying(7) NOT NULL,
    puissance_fiscale integer,
    carburant character varying(10),
    taille integer
);


ALTER TABLE public.modele OWNER TO postgres;

--
-- Name: option; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE option (
    nom_option character varying(25) NOT NULL
);


ALTER TABLE public.option OWNER TO postgres;

--
-- Name: particulier; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE particulier (
    id_part integer NOT NULL,
    contrat_en_cours boolean,
    nom character varying(25) NOT NULL,
    prenom character varying(25) NOT NULL,
    adresse text NOT NULL,
    ville character varying(25) NOT NULL,
    date_naissance date NOT NULL,
    numero_tel integer NOT NULL,
    copie_permis integer NOT NULL
);


ALTER TABLE public.particulier OWNER TO postgres;

--
-- Name: professionnel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE professionnel (
    id_pro integer NOT NULL,
    nom_entreprise character varying(25)
);


ALTER TABLE public.professionnel OWNER TO postgres;

--
-- Name: reparation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reparation (
    id_reparation integer NOT NULL,
    prix real,
    nbr_jour_reparation integer,
    numero_immatriculation character varying(10),
    nom_entreprise character varying(25)
);


ALTER TABLE public.reparation OWNER TO postgres;

--
-- Name: supervise_entretien; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE supervise_entretien (
    id_employe integer NOT NULL,
    id_entretien integer NOT NULL
);


ALTER TABLE public.supervise_entretien OWNER TO postgres;

--
-- Name: supervise_reparation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE supervise_reparation (
    id_employe integer NOT NULL,
    id_reparation integer NOT NULL
);


ALTER TABLE public.supervise_reparation OWNER TO postgres;

--
-- Name: vcommercial; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vcommercial AS
 SELECT employe.id_employe,
    employe.nom_agence,
    employe.function
   FROM employe
  WHERE (employe.function = 'com'::fonction);


ALTER TABLE public.vcommercial OWNER TO postgres;

--
-- Name: vehicule; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vehicule (
    numero_immatriculation character varying(10) NOT NULL,
    nom_modele character varying(25),
    nom_categorie character varying(25),
    nom_agence character varying(25) NOT NULL,
    marque character varying(25) NOT NULL,
    date_mise_en_circulation timestamp without time zone,
    degats_eventuels text,
    km integer,
    niveau_carb integer,
    couleur character varying(25),
    est_loue boolean
);


ALTER TABLE public.vehicule OWNER TO postgres;

--
-- Name: vsociete_entretien; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vsociete_entretien AS
 SELECT entreprise.nom_entreprise,
    entreprise.type,
    entreprise.nom_agence
   FROM entreprise
  WHERE (entreprise.type = 'ent'::type);


ALTER TABLE public.vsociete_entretien OWNER TO postgres;

--
-- Name: vsociete_reparation; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vsociete_reparation AS
 SELECT entreprise.nom_entreprise,
    entreprise.type,
    entreprise.nom_agence
   FROM entreprise
  WHERE (entreprise.type = 'rep'::type);


ALTER TABLE public.vsociete_reparation OWNER TO postgres;

--
-- Name: vtechnique; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vtechnique AS
 SELECT employe.id_employe,
    employe.nom_agence,
    employe.function
   FROM employe
  WHERE (employe.function = 'tech'::fonction);


ALTER TABLE public.vtechnique OWNER TO postgres;

--
-- Data for Name: agence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY agence (nom_agence) FROM stdin;
FRANCECAR
\.


--
-- Data for Name: apparaitre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY apparaitre (id_conducteur, id_liste) FROM stdin;
\.


--
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categorie (nom_categorie) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY client (id_client, date_inscription, password_gestion_compte) FROM stdin;
\.


--
-- Data for Name: comporter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comporter (numero_immatriculation, nom_option) FROM stdin;
\.


--
-- Data for Name: conducteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY conducteur (id_conducteur, nom, prenom, copie_permis) FROM stdin;
\.


--
-- Data for Name: contrat_de_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contrat_de_location (num_contrat, date_debut_loc, date_fin_loc, degats_eventuels_initiaux, km_initial, niveau_carb_initial, seuil_km, cb_presentee, id_employe, id_facture) FROM stdin;
\.


--
-- Data for Name: editer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY editer (id_employe, id_facture) FROM stdin;
\.


--
-- Data for Name: employe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employe (id_employe, nom_agence, function) FROM stdin;
1	FRANCECAR	com
\.


--
-- Data for Name: entreprise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entreprise (nom_entreprise, type, nom_agence) FROM stdin;
\.


--
-- Data for Name: entretien; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entretien (id_entretien, prix, numero_immatriculation, nom_entreprise) FROM stdin;
\.


--
-- Data for Name: facture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY facture (id_facture, date_reglement, montant, moyen_de_paiement) FROM stdin;
1	2014-01-23 09:45:09	200	cb
\.


--
-- Data for Name: faire_appel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY faire_appel (nom_agence, nom_entreprise) FROM stdin;
\.


--
-- Data for Name: gerer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gerer (id_employe, id_location, validation_finale_isdone) FROM stdin;
\.


--
-- Data for Name: gerer_parc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gerer_parc (id_employe, numero_immatriculation) FROM stdin;
\.


--
-- Data for Name: liste_conducteurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY liste_conducteurs (id_liste, id_pro, id_location) FROM stdin;
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY location (id_location, id_client, num_contrat, numero_immatriculation) FROM stdin;
\.


--
-- Data for Name: modele; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY modele (nom_modele, nom_categorie, nb_portes, boite_vitesse, puissance_fiscale, carburant, taille) FROM stdin;
\.


--
-- Data for Name: option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY option (nom_option) FROM stdin;
\.


--
-- Data for Name: particulier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY particulier (id_part, contrat_en_cours, nom, prenom, adresse, ville, date_naissance, numero_tel, copie_permis) FROM stdin;
\.


--
-- Data for Name: professionnel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY professionnel (id_pro, nom_entreprise) FROM stdin;
\.


--
-- Data for Name: reparation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reparation (id_reparation, prix, nbr_jour_reparation, numero_immatriculation, nom_entreprise) FROM stdin;
\.


--
-- Data for Name: supervise_entretien; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY supervise_entretien (id_employe, id_entretien) FROM stdin;
\.


--
-- Data for Name: supervise_reparation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY supervise_reparation (id_employe, id_reparation) FROM stdin;
\.


--
-- Data for Name: vehicule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vehicule (numero_immatriculation, nom_modele, nom_categorie, nom_agence, marque, date_mise_en_circulation, degats_eventuels, km, niveau_carb, couleur, est_loue) FROM stdin;
\.


--
-- Name: agence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY agence
    ADD CONSTRAINT agence_pkey PRIMARY KEY (nom_agence);


--
-- Name: apparaitre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY apparaitre
    ADD CONSTRAINT apparaitre_pkey PRIMARY KEY (id_conducteur, id_liste);


--
-- Name: categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (nom_categorie);


--
-- Name: client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- Name: comporter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comporter
    ADD CONSTRAINT comporter_pkey PRIMARY KEY (numero_immatriculation);


--
-- Name: conducteur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conducteur
    ADD CONSTRAINT conducteur_pkey PRIMARY KEY (id_conducteur);


--
-- Name: contrat_de_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contrat_de_location
    ADD CONSTRAINT contrat_de_location_pkey PRIMARY KEY (num_contrat);


--
-- Name: editer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY editer
    ADD CONSTRAINT editer_pkey PRIMARY KEY (id_employe, id_facture);


--
-- Name: employe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY employe
    ADD CONSTRAINT employe_pkey PRIMARY KEY (id_employe);


--
-- Name: entreprise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entreprise
    ADD CONSTRAINT entreprise_pkey PRIMARY KEY (nom_entreprise);


--
-- Name: entretien_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entretien
    ADD CONSTRAINT entretien_pkey PRIMARY KEY (id_entretien);


--
-- Name: facture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY facture
    ADD CONSTRAINT facture_pkey PRIMARY KEY (id_facture);


--
-- Name: faire_appel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY faire_appel
    ADD CONSTRAINT faire_appel_pkey PRIMARY KEY (nom_agence, nom_entreprise);


--
-- Name: gerer_parc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gerer_parc
    ADD CONSTRAINT gerer_parc_pkey PRIMARY KEY (id_employe, numero_immatriculation);


--
-- Name: gerer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gerer
    ADD CONSTRAINT gerer_pkey PRIMARY KEY (id_employe, id_location);


--
-- Name: liste_conducteurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY liste_conducteurs
    ADD CONSTRAINT liste_conducteurs_pkey PRIMARY KEY (id_liste);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id_location);


--
-- Name: modele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modele
    ADD CONSTRAINT modele_pkey PRIMARY KEY (nom_modele);


--
-- Name: option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY option
    ADD CONSTRAINT option_pkey PRIMARY KEY (nom_option);


--
-- Name: particulier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY particulier
    ADD CONSTRAINT particulier_pkey PRIMARY KEY (id_part);


--
-- Name: professionnel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY professionnel
    ADD CONSTRAINT professionnel_pkey PRIMARY KEY (id_pro);


--
-- Name: reparation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reparation
    ADD CONSTRAINT reparation_pkey PRIMARY KEY (id_reparation);


--
-- Name: supervise_entretien_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY supervise_entretien
    ADD CONSTRAINT supervise_entretien_pkey PRIMARY KEY (id_employe, id_entretien);


--
-- Name: supervise_reparation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY supervise_reparation
    ADD CONSTRAINT supervise_reparation_pkey PRIMARY KEY (id_employe, id_reparation);


--
-- Name: vehicule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vehicule
    ADD CONSTRAINT vehicule_pkey PRIMARY KEY (numero_immatriculation);


--
-- Name: chechid_tech; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER chechid_tech BEFORE INSERT ON contrat_de_location FOR EACH ROW EXECUTE PROCEDURE checkid_tech();


--
-- Name: chechid_tech; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER chechid_tech BEFORE INSERT OR UPDATE ON supervise_entretien FOR EACH ROW EXECUTE PROCEDURE checkid_tech();


--
-- Name: chechid_tech; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER chechid_tech BEFORE INSERT OR UPDATE ON supervise_reparation FOR EACH ROW EXECUTE PROCEDURE checkid_tech();


--
-- Name: chechid_tech; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER chechid_tech BEFORE INSERT OR UPDATE ON gerer_parc FOR EACH ROW EXECUTE PROCEDURE checkid_tech();


--
-- Name: check_entreprise; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_entreprise BEFORE INSERT ON entretien FOR EACH ROW EXECUTE PROCEDURE check_entreprise_entretien();


--
-- Name: check_entreprise; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_entreprise BEFORE INSERT ON reparation FOR EACH ROW EXECUTE PROCEDURE check_entreprise_rep();


--
-- Name: check_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_id BEFORE INSERT ON employe FOR EACH ROW EXECUTE PROCEDURE checkid_combis();


--
-- Name: checkid_com; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER checkid_com BEFORE INSERT ON gerer FOR EACH ROW EXECUTE PROCEDURE checkid_com();


--
-- Name: checkid_com; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER checkid_com BEFORE INSERT ON editer FOR EACH ROW EXECUTE PROCEDURE checkid_com();


--
-- Name: apparaitre_id_liste_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY apparaitre
    ADD CONSTRAINT apparaitre_id_liste_fkey FOREIGN KEY (id_liste) REFERENCES liste_conducteurs(id_liste);


--
-- Name: comporter_nom_option_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comporter
    ADD CONSTRAINT comporter_nom_option_fkey FOREIGN KEY (nom_option) REFERENCES option(nom_option);


--
-- Name: comporter_numero_immatriculation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comporter
    ADD CONSTRAINT comporter_numero_immatriculation_fkey FOREIGN KEY (numero_immatriculation) REFERENCES vehicule(numero_immatriculation);


--
-- Name: contrat_de_location_id_employe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contrat_de_location
    ADD CONSTRAINT contrat_de_location_id_employe_fkey FOREIGN KEY (id_employe) REFERENCES employe(id_employe);


--
-- Name: contrat_de_location_id_facture_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contrat_de_location
    ADD CONSTRAINT contrat_de_location_id_facture_fkey FOREIGN KEY (id_facture) REFERENCES facture(id_facture);


--
-- Name: editer_id_employe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY editer
    ADD CONSTRAINT editer_id_employe_fkey FOREIGN KEY (id_employe) REFERENCES employe(id_employe);


--
-- Name: editer_id_facture_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY editer
    ADD CONSTRAINT editer_id_facture_fkey FOREIGN KEY (id_facture) REFERENCES facture(id_facture);


--
-- Name: employe_nom_agence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employe
    ADD CONSTRAINT employe_nom_agence_fkey FOREIGN KEY (nom_agence) REFERENCES agence(nom_agence);


--
-- Name: entreprise_nom_agence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entreprise
    ADD CONSTRAINT entreprise_nom_agence_fkey FOREIGN KEY (nom_agence) REFERENCES agence(nom_agence);


--
-- Name: entretien_nom_entreprise_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entretien
    ADD CONSTRAINT entretien_nom_entreprise_fkey FOREIGN KEY (nom_entreprise) REFERENCES entreprise(nom_entreprise);


--
-- Name: entretien_numero_immatriculation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entretien
    ADD CONSTRAINT entretien_numero_immatriculation_fkey FOREIGN KEY (numero_immatriculation) REFERENCES vehicule(numero_immatriculation);


--
-- Name: faire_appel_nom_agence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faire_appel
    ADD CONSTRAINT faire_appel_nom_agence_fkey FOREIGN KEY (nom_agence) REFERENCES agence(nom_agence);


--
-- Name: faire_appel_nom_entreprise_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faire_appel
    ADD CONSTRAINT faire_appel_nom_entreprise_fkey FOREIGN KEY (nom_entreprise) REFERENCES entreprise(nom_entreprise);


--
-- Name: gerer_id_employe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gerer
    ADD CONSTRAINT gerer_id_employe_fkey FOREIGN KEY (id_employe) REFERENCES employe(id_employe);


--
-- Name: gerer_id_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gerer
    ADD CONSTRAINT gerer_id_location_fkey FOREIGN KEY (id_location) REFERENCES location(id_location);


--
-- Name: gerer_parc_id_employe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gerer_parc
    ADD CONSTRAINT gerer_parc_id_employe_fkey FOREIGN KEY (id_employe) REFERENCES employe(id_employe);


--
-- Name: gerer_parc_numero_immatriculation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gerer_parc
    ADD CONSTRAINT gerer_parc_numero_immatriculation_fkey FOREIGN KEY (numero_immatriculation) REFERENCES vehicule(numero_immatriculation);


--
-- Name: liste_conducteurs_id_location_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY liste_conducteurs
    ADD CONSTRAINT liste_conducteurs_id_location_fkey FOREIGN KEY (id_location) REFERENCES location(id_location);


--
-- Name: liste_conducteurs_id_pro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY liste_conducteurs
    ADD CONSTRAINT liste_conducteurs_id_pro_fkey FOREIGN KEY (id_pro) REFERENCES professionnel(id_pro);


--
-- Name: location_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_id_client_fkey FOREIGN KEY (id_client) REFERENCES client(id_client);


--
-- Name: location_num_contrat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_num_contrat_fkey FOREIGN KEY (num_contrat) REFERENCES contrat_de_location(num_contrat);


--
-- Name: location_numero_immatriculation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_numero_immatriculation_fkey FOREIGN KEY (numero_immatriculation) REFERENCES vehicule(numero_immatriculation);


--
-- Name: modele_nom_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY modele
    ADD CONSTRAINT modele_nom_categorie_fkey FOREIGN KEY (nom_categorie) REFERENCES categorie(nom_categorie);


--
-- Name: particulier_id_part_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY particulier
    ADD CONSTRAINT particulier_id_part_fkey FOREIGN KEY (id_part) REFERENCES client(id_client);


--
-- Name: professionnel_id_pro_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY professionnel
    ADD CONSTRAINT professionnel_id_pro_fkey FOREIGN KEY (id_pro) REFERENCES client(id_client);


--
-- Name: reparation_nom_entreprise_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reparation
    ADD CONSTRAINT reparation_nom_entreprise_fkey FOREIGN KEY (nom_entreprise) REFERENCES entreprise(nom_entreprise);


--
-- Name: reparation_numero_immatriculation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reparation
    ADD CONSTRAINT reparation_numero_immatriculation_fkey FOREIGN KEY (numero_immatriculation) REFERENCES vehicule(numero_immatriculation);


--
-- Name: supervise_entretien_id_employe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supervise_entretien
    ADD CONSTRAINT supervise_entretien_id_employe_fkey FOREIGN KEY (id_employe) REFERENCES employe(id_employe);


--
-- Name: supervise_entretien_id_entretien_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supervise_entretien
    ADD CONSTRAINT supervise_entretien_id_entretien_fkey FOREIGN KEY (id_entretien) REFERENCES entretien(id_entretien);


--
-- Name: supervise_reparation_id_employe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supervise_reparation
    ADD CONSTRAINT supervise_reparation_id_employe_fkey FOREIGN KEY (id_employe) REFERENCES employe(id_employe);


--
-- Name: supervise_reparation_id_reparation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supervise_reparation
    ADD CONSTRAINT supervise_reparation_id_reparation_fkey FOREIGN KEY (id_reparation) REFERENCES reparation(id_reparation);


--
-- Name: vehicule_nom_agence_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicule
    ADD CONSTRAINT vehicule_nom_agence_fkey FOREIGN KEY (nom_agence) REFERENCES agence(nom_agence);


--
-- Name: vehicule_nom_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicule
    ADD CONSTRAINT vehicule_nom_categorie_fkey FOREIGN KEY (nom_categorie) REFERENCES categorie(nom_categorie);


--
-- Name: vehicule_nom_modele_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicule
    ADD CONSTRAINT vehicule_nom_modele_fkey FOREIGN KEY (nom_modele) REFERENCES modele(nom_modele);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

