import std.stdio;

import config;
import database;


void main()
{
	/*
	 * TODO:
	 * - create UI.
	 * - make sure that it works on Windows also
	 * - add multiple loacles
	 * - add possibility to backup online
	 * - some icon will be needed
	 *
	 */
	Config config = new Config();
	Database db = new Database(config.dbFileAddr);
	writeln("Edit source/app.d to start your project.");
}
