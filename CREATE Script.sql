--Jose Zapata 05.12.2017

CREATE TABLE Users
(
	userId SMALLINT NOT NULL IDENTITY,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(50) NOT NULL,
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,

	CONSTRAINT PK_User PRIMARY KEY (userId),
	CONSTRAINT UC_User UNIQUE (username),

);

CREATE TABLE Address
(
	addressId SMALLINT NOT NULL IDENTITY,
	address VARCHAR(50) NOT NULL,
	zipcode CHAR(5) NOT NULL,
	userId SMALLINT,

	CONSTRAINT PK_Address PRIMARY KEY (addressId),
	CONSTRAINT FK_UserAddress FOREIGN KEY (userId) REFERENCES Users(userId),
);


CREATE TABLE Category
(
	categoryId SMALLINT NOT NULL IDENTITY,
	categoryName VARCHAR(50) NOT NULL,


	CONSTRAINT PK_Category PRIMARY KEY (categoryId),
	CONSTRAINT UC_Category UNIQUE (categoryName),
);



CREATE TABLE Product
(
	productId SMALLINT NOT NULL IDENTITY,
	title VARCHAR(50) NOT NULL,
	quantity INTEGER NOT NULL,
	price NUMERIC(12,2) NOT NULL,
	details VARCHAR(50) NOT NULL,
	zipcode CHAR(5) NOT NULL,
	condition VARCHAR(50) NOT NULL,
	categoryId SMALLINT NOT NULL,


	CONSTRAINT PK_Product PRIMARY KEY (productId),
	CONSTRAINT FK_Product FOREIGN KEY (categoryId) REFERENCES Category(categoryId),
	CONSTRAINT CK_condition CHECK (condition = 'New' OR condition = 'Used' OR condition = 'Refurbished')
);

CREATE TABLE Orders
(
	orderId SMALLINT NOT NULL IDENTITY,
	orderDate DATE DEFAULT GETDATE() NOT NULL,
	orderShip CHAR(1) NOT NULL,
	orderStatus VARCHAR(50)NOT NULL,
	PaymentStatus CHAR(1) NOT NULL,
	userId  SMALLINT NOT NULL,
	addressId  SMALLINT NOT NULL,

	CONSTRAINT PK_Orders PRIMARY KEY (orderId),
	CONSTRAINT FK_OrdersUsers FOREIGN KEY (userId) REFERENCES users(userId),
	CONSTRAINT FK_OrdersAddress FOREIGN KEY (addressId) REFERENCES Address(addressId),
	CONSTRAINT CHK_Order_Ship CHECK(orderShip = 'Y' OR orderShip = 'N'),
	CONSTRAINT CHK_Order_PaymentStatus CHECK(PaymentStatus = 'Y' OR PaymentStatus = 'N'),
);

--DROP TABLE ORDERS;

CREATE TABLE OrderDetail
(
	orderDetailId SMALLINT NOT NULL IDENTITY,
	totalQuantity INTEGER NOT NULL,
	totalPrice NUMERIC(12,2) NOT NULL,
	orderId SMALLINT NOT NULL,
	productId SMALLINT NOT NULL,

	CONSTRAINT PK_OrderDetail PRIMARY KEY (orderDetailId),
	CONSTRAINT FK_OrderDetailOrder FOREIGN KEY (orderId) REFERENCES Orders(orderId),
	CONSTRAINT PK_OrderDetailProduct FOREIGN KEY (productId) REFERENCES Product(productId),
);


CREATE TABLE Payment
(
	PaymentNumber SMALLINT NOT NULL IDENTITY,
	orderId SMALLINT NOT NULL,
	

	CONSTRAINT PK_Payment PRIMARY KEY (PaymentNumber),
	CONSTRAINT FK_Payment_orderId FOREIGN KEY (orderId)  REFERENCES Orders(orderId),
);

--transaction logs
CREATE TABLE UserHistory
(
	userHistoryId SMALLINT NOT NULL IDENTITY,
	history_date DATE DEFAULT GETDATE() NOT NULL ,
	history_time TIME DEFAULT GETDATE() NOT NULL,
	username VARCHAR(50) NOT NULL,
	modification VARCHAR(6) NOT NULL,
	newUsername VARCHAR(50),
	oldUsername VARCHAR(50),
	newPassword VARCHAR(50),
	oldPassword VARCHAR(50),
	newFirstName VARCHAR(50),
	oldFirstName VARCHAR(50),
	newLastName VARCHAR(50),
	oldLastName VARCHAR(50),

	CONSTRAINT PK_history PRIMARY KEY(userHistoryId)
);

CREATE TABLE OrderHistory
(
	OrderHistoryId SMALLINT NOT NULL IDENTITY,
	history_date DATE DEFAULT GETDATE() NOT NULL ,
	history_time TIME DEFAULT GETDATE() NOT NULL,
	username VARCHAR(50) NOT NULL,
	modification VARCHAR(6) NOT NULL,
	newOrderDate DATE,
	oldOrderDate DATE,
	newOrderShip BIT,
	oldOrderShip BIT,
	newOrderStatus VARCHAR(50),
	oldOrderStatus VARCHAR(50),
	newUserId  SMALLINT,
	oldUserId  SMALLINT,
	newAddressId  SMALLINT,
	oldAddressId  SMALLINT,

	CONSTRAINT PK_OrderHistory PRIMARY KEY(OrderHistoryId)
);