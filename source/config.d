module config;

import std.stdio, std.file, std.container, std.algorithm, std.string;

/**
 * Config
 */
class Config {
	private string _dbFileAddr;
	/*
	 * TODO:
	 * when needed add missing fields;
	 */

	@property string dbFileAddr() { return this._dbFileAddr; }

	this() {
		try {
			//configuration file must be in 
			File conf = File("configuration.conf", "r");
			string[] names;
			string[] values;
			while(!conf.eof()) {
				string[] line = split(conf.readln(), ":");
				if (line.length > 1) {
					names.length += 1;
					names[names.length - 1] = line[0];
					values.length += 1;
					values[values.length - 1] = line[1];
				}
			}
		}
		catch(Exception e) {
			writeln("[Home Library Error]: Configuration file read error: ", e.msg);
			//if user deleted configuration file, or file is corrupted create new default or it is first run ;)
			createDefaultConfigurationFile();

		}
	}


	private void createDefaultConfigurationFile() {
		this._dbFileAddr = "hldatabase.db";
		try {
			File conf = File("configuration.conf", "w");
			conf.writeln("file addr: ", this.dbFileAddr);
			conf.close();
		}
		catch(Exception e) {
			writeln("Something's wrong");
		}
	}
}