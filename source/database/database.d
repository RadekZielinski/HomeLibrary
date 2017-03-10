module database.database;

import ddbc;

/**
 * Database
 */
class Database {
	
	private Connection connection;

	this(string dbAddr) {
		try {
			connection = createConnection("sqlite:" + dbAddr);
			Satement stmnt = connection.createStatement();
			stmnt.executeUpdate("PRAGMA encoding = \"UTF-8\";");
			stmnt.executeUpdate("PRAGMA foreign_keys = ON;");
			stmnt.executeUpdate(
					"create table if not exists authors "
					+ "(id integer primary key autoincrement not null, "
					+ "name varchar not null);");
			stmnt.executeUpdate(
					"create table if not exists books "
					+ "(id integer primary key autoincrement not null, "
					+ "title varchar(200) not null, "
					+ "author_id int not null, "
					+ "description text, "
					+ "status tinyint not null, "
					+ "created_at date not null, "
					+ "updated_at date not null, "
					+ "foreign key (author_id) references authors(id));");
			stmnt.executeUpdate(
					"create table if not exists carrier_types "
					+ "(id integer primary key autoincrement not null, "
					+ "name varchar(7) unique not null);");
			stmnt.executeUpdate(
					"create table if not exists albums "
					+ "(id integer primary key autoincrement not null, "
					+ "title varchar not null, "
					+ "carrier_type_id not null, "
					+ "author_id int not null, "
					+ "status tinyint not null, "
					+ "foreign key (carrier_type_id) references carrier_types(id), "
					+ "foreign key (author_id) references authors(id));");
			stmnt.executeUpdate(
					"create table if not exists borrowers "
					+ "(id integer primary key autoincrement not null, "
					+ "first_name varchar(40) not null, "
					+ "last_name varchar(50) not null);");
			stmnt.executeUpdate(
					"create table if not exists books_borrowings "
					+ "(id integer primary key autoincrement not null, "
					+ "borrower_id int not null, "
					+ "book_id int not null, "
					+ "borrowed_at date not null, "
					+ "returning_at date not null, "
					+ "foreign key (borrower_id) references borrowers(id), "
					+ "foreign key (book_id) references books(id));");
			stmnt.executeUpdate(
					"create table if not exists carrier_borrowings"
					+ "(id integer primary key autoincrement not null, "
					+ "borrower_id int not null, "
					+ "carrier_id int not null, "
					+ "borrowed_at date not null, "
					+ "returning_at date not null, "
					+ "foreign key (borrower_id) references borrowers(id), "
					+ "foreign key (carrier_id) references albums(id));");
			stmnt.executeUpdate("insert into carrier_types(name) values ('CD');");
			stmnt.executeUpdate("insert into carrier_types(name) values ('DVD');");
			stmnt.executeUpdate("insert into carrier_types(name) values ('Blu-Ray');");
			stmnt.executeUpdate("insert into carrier_types(name) values ('Winyl');");
		}
		catch(Exception e) {
			writeln("Unable to connect to database.");
		}
	}
}