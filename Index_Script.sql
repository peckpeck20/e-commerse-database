--Jose Zapata 05.12.2017
--Indexes

CREATE UNIQUE INDEX ix_username ON Users(username);

CREATE  INDEX ix_lastName ON Users(lastName);

CREATE INDEX ix_orderDate on Orders(orderDate);

CREATE INDEX ix_productTitle on Product(title);

CREATE INDEX ix_productZipcode on Product(zipcode);

CREATE INDEX ix_Category on Category(categoryName);