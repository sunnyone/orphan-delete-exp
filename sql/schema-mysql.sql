DROP TABLE if exists pointer CASCADE;

CREATE TABLE pointer (
  id bigint NOT NULL
  , parent_id bigint NOT NULL
  , child_id bigint NOT NULL
  , CONSTRAINT pointer_PKC PRIMARY KEY (id)
) ;

DROP TABLE if exists child CASCADE;

CREATE TABLE child (
  id bigint NOT NULL
  , parent_id bigint NOT NULL
  , json_tree json NOT NULL
  , CONSTRAINT child_PKC PRIMARY KEY (id)
) ;

DROP TABLE if exists parent CASCADE;

CREATE TABLE parent (
  id bigint NOT NULL
  , CONSTRAINT parent_PKC PRIMARY KEY (id)
) ;

ALTER TABLE pointer
  ADD CONSTRAINT pointer_FK1 FOREIGN KEY (child_id) REFERENCES child(id);

ALTER TABLE child
  ADD CONSTRAINT child_FK1 FOREIGN KEY (parent_id) REFERENCES parent(id);

ALTER TABLE pointer
  ADD CONSTRAINT pointer_FK2 FOREIGN KEY (parent_id) REFERENCES parent(id);
