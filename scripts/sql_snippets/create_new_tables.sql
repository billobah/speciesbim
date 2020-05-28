-- That table contains taxonomic data from GBIF (obtained after matches on the content of scientificname table
CREATE TABLE gbiftaxonomy (
    id serial PRIMARY KEY,  -- internal (to the DB) ID
    gbifId integer NOT NULL, -- ID at GBIF
    scientificName character varying(255), -- as returned by GBIF
    kingdom character varying(50)
);

CREATE TYPE gbifmatchtype AS ENUM ('EXACT', 'FUZZY', 'HIGHERRANK');
-- table contains scientificnames in use in the database, a link to "taxonomy" and metadata about the taxonomic match at GBIF
CREATE TABLE scientificname (
    id serial PRIMARY KEY,
    taxonomyId integer REFERENCES gbiftaxonomy(id), -- Can be null if no match
    scientificName character varying(255) NOT NULL, -- as appear in the old "taxon" table
    authorship character varying(255), -- as appear in the old "taxon" table,
    -- !! the following field are attributes of the match process !!
    lastMatch timestamp with time zone, -- when was a GBIF match last attempted?
    matchConfidence smallint,
    matchType gbifmatchtype
);