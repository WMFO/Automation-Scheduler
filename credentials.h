#define MYSQLPP_MYSQL_HEADERS_BURIED
#include <mysql++/mysql++.h>

//calls conn.connect(credentials);
void setup_connection(mysqlpp::Connection& conn);

