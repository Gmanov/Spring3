#- Exercici 1
#La teva tasca és dissenyar i crear una taula anomenada "credit_*card" que emmagatzemi detalls 
#crucials sobre les targetes de crèdit. La nova taula ha de ser capaç d'identificar de manera única 
#cada targeta i establir una relació adequada amb les altres dues taules ("transaction" i "company"). 
#Després de crear la taula serà necessari que ingressis la informació del document denominat "dades_introduir_credit". 
#Recorda mostrar el diagrama i realitzar una breu descripció d'aquest.

CREATE TABLE credit_card (
    id VARCHAR(10),
    iban VARCHAR(50),
    pan VARCHAR(20),
    pin INT,
    cvv INT,
    expiring_date VARCHAR(15)
);

#Me dejo el drop en caso que necesite modificar algo de la tabla y prefiera comenzar de cero
#DROP TABLE credit_card;
SELECT *
FROM credit_card;
#------------------------------------------------------------------------------------------------------------------

#Exercici 2
#El departament de Recursos Humans ha identificat un error en el número de compte de l'usuari amb el: 
#IBAN CcU-2938. Es requereix actualitzar la informació que identifica un compte bancari a nivell internacional 
#(identificat com "IBAN"): TR323456312213576817699999. Recorda mostrar que el canvi es va realitzar.

SELECT *
FROM credit_card
WHERE id = "CcU-2938";

UPDATE credit_card
SET iban = 'TR323456312213576817699999'
WHERE id = "CcU-2938";

#------------------------------------------------------------------------------------------------------------------

#Exercici 3
#En la taula "transaction" ingressa un nou usuari amb la següent informació:
#Id : 108B1D1D-5B23-A76C-55EF-C568E49A99DD
#credit_card_id : CcU-9999
#company_id : b-9999
#user_id : 9999
#lat : 829.999
#longitude  : -117.999
#amount : 111.11
#declined : 0

INSERT INTO company (id)
VALUES ('b-9999');

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, 111.11, 0);

SELECT *
FROM transaction
WHERE company_id = "b-9999";

#------------------------------------------------------------------------------------------------------------------

#Exercici 4
#Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_card. Recorda mostrar el canvi realitzat.

SELECT *
FROM credit_card;

ALTER TABLE credit_card
DROP COLUMN pan;

#------------------------------------------------------------------------------------------------------------------
#NIVELL 2

#Exercici 1
#Elimina el registre amb IBAN 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.

SELECT *
FROM transaction
WHERE id = "02C6201E-D90A-1859-B4EE-88D2986D3B02";

DELETE FROM transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';
#-------------------------------------------------------------------------------------------------------------------

#Exercici 2
#La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi
#i estratègies efectives. S'ha sol·licitat crear una vista que proporcioni detalls clau sobre 
#les companyies i les seves transaccions. Serà necessària que creïs una vista anomenada VistaMarketing 
#que contingui la següent informació: Nom de la companyia. Telèfon de contacte. País de residència.
#Mitjana de compra realitzat per cada companyia. Presenta la vista creada, ordenant les dades de major 
#a menor mitjana de compra

CREATE VIEW VistaMarketing AS 
SELECT company.company_name, company.phone, company.country, AVG(transaction.amount)
FROM company
JOIN transaction ON transaction.company_id = company.id
GROUP BY company.company_name, company.phone, company.country
ORDER BY AVG(transaction.amount) DESC;

#DROP VIEW IF EXISTS vistamarketing;

SELECT *
FROM vistamarketing;
#-------------------------------------------------------------------------------------------------------------------

#Exercici 3
#Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"

SELECT *
FROM vistamarketing
WHERE country = "Germany";

#Exercici 1

#La setmana vinent tindràs una nova reunió amb els gerents de màrqueting. 
#Un company del teu equip va realitzar modificacions en la base de dades, però no recorda com les va realitzar. 
#Et demana que l'ajudis a deixar els comandos executats per a obtenir les següents modificacions (s'espera que realitzin 6 canvis): 


#Nuestra primera modificación sera en la tabla company

ALTER TABLE company
MODIFY id VARCHAR(15),
MODIFY company_name VARCHAR(255),
MODIFY phone VARCHAR(15),
MODIFY email VARCHAR(100),
MODIFY country VARCHAR(100);

#Modificamos la tabla transaction
ALTER TABLE transaction
MODIFY id VARCHAR(255),
MODIFY credit_card_id VARCHAR(15),
MODIFY company_id VARCHAR(20),
MODIFY user_id INT,
MODIFY lat FLOAT,
MODIFY longitude FLOAT,
MODIFY timestamp TIMESTAMP,
MODIFY amount DECIMAL(10,2),
MODIFY declined TINYINT(1) ;

#Modificamos la tablas credit_card
ALTER TABLE credit_card
MODIFY id VARCHAR(20),
MODIFY iban VARCHAR(50),
MODIFY pin VARCHAR(4),
MODIFY cvv INT,
MODIFY expiring_date VARCHAR(10);
ALTER TABLE credit_card
ADD COLUMN fecha_actual DATE;

#Creamos la tabla data_user
CREATE TABLE data_user (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    phone VARCHAR(150),
    personal_email VARCHAR(150),
    birth_date VARCHAR(100),
    country VARCHAR(150),
    city VARCHAR(150),
    postal_code VARCHAR(100),
    address VARCHAR(255)
);

#DROP TABLE data_user;

SELECT *
FROM user;

#-----------------------------------------------------------------------------------------------------------------------------------------


#Exercici 2
#L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:
    #ID de la transacció
    #Nom de l'usuari/ària
    #Cognom de l'usuari/ària
    #IBAN de la targeta de crèdit usada.
    #Nom de la companyia de la transacció realitzada.
    #Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.

#Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.

CREATE VIEW InformeTecnico AS
SELECT transaction.id AS id , user.name AS Nombre_usuario, user.surname AS Apellido_Usuario, credit_card.id AS IBAN, company.company_name AS Nombre_compañia
FROM transaction
JOIN user ON user.id = transaction.user_id
JOIN company ON company.id = transaction.company_id
JOIN credit_card ON credit_card.id = transaction.credit_card_id;


SELECT *
FROM InformeTecnico
ORDER BY id DESC;





