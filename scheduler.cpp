#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
#include <string>
#include <vector>

#include "credentials.h"

using namespace std;

vector<long int> songs;

//returns number of songs
int fill_vector(vector<long int> &songs, mysqlpp::Connection& conn) {
	mysqlpp::Query q = conn.query("select NUMBER from CART WHERE GROUP_NAME=\"MUSIC\" AND SCHED_CODES LIKE \"%S%\" AND FORCED_LENGTH < 600000");
	mysqlpp::StoreQueryResult res = q.store();
	for (unsigned i = 0; i < res.num_rows(); i++) {
		songs.push_back(res[i][0]);
	}
	return res.num_rows();
}

void output_cart(long int cart, int hour, int minute) {
	cout << setfill(' ') << setw(6);
	cout << cart;
	cout << "XXXXX" << setfill('0');
	cout << setw(2) << hour << setw(2) << minute << "00" << endl;
	return;
}

int main(int argc, char *argv[]) {
	(void) argc;
	(void) argv;
	mysqlpp::Connection conn;
	setup_connection(conn);
	vector<long int> songs;
	srand(time(NULL));
	int len = fill_vector(songs, conn);
        for (int h = 0; h < 24; h++) {
                for (int m = 0; m < 60; m=m+2) {
                        int cart = rand() % len;
                        output_cart(songs[cart], h, m);
                }
        }

	return 0;
}

