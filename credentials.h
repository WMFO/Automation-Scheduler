#define MYSQLPP_MYSQL_HEADERS_BURIED
#include <mysql++/mysql++.h>

void setup_connection(mysqlpp::Connection& conn);

/* credentials.cpp

#include "credentials.h"

void setup_connection(mysqlpp::Connection& conn){
        conn.connect("Rivendell", "I.P.Add.ress", "user", "password");
}

*/
